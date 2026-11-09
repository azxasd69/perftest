// Проверка JS-моста внутри BSL-модулей ПерфТеста.
//
// Зачем: 08.11.2026 кнопка «Запустить все» на кокпите «не запускала тесты».
// Причина - лишняя закрывающая скобка в конце СкриптКокпита: весь <script>
// не компилировался, window.PF1C оставался базовым (send/take из каркаса),
// и ни одна функция моста (state/progress/result/kpi/lock/logRow/status/
// SetStandChip/SetGlobalStatus/AddSummaryRow/ResetSummary) не появлялась.
// Тесты при этом шли, а интерфейс не перерисовывался: 0/11, «Готов к работе».
// BSL Language Server этого не видит - проверка только здесь.
//
// Использование:
//   node tools/check-html-bridge.mjs "src/CommonModules/ПерфКокпит/Ext/Module.bsl" ...
//
// Код возврата: 0 - чисто, 1 - ошибка в JS, 2 - не найден блок/файл.
import fs from 'node:fs';
import path from 'node:path';
import vm from 'node:vm';

// Строки BSL склеиваются через «+», внутри литерала "" == ". Поэтому идём
// посимвольно: на " открываем литерал, "" внутри - экранирование.
function literalsOf(line) {
  const out = [];
  let i = 0;
  let cur = null;
  while (i < line.length) {
    const ch = line[i];
    if (cur === null) {
      if (ch === '"') cur = '';
      i += 1;
      continue;
    }
    if (ch === '"') {
      if (line[i + 1] === '"') {
        cur += '"';
        i += 2;
        continue;
      }
      out.push(cur);
      cur = null;
      i += 1;
      continue;
    }
    cur += ch;
    i += 1;
  }
  return out;
}

// Формат(...) - вызов BSL, а не JS: подставляем число 0 как плейсхолдер.
function stripBslCalls(js) {
  return js.replace(/ЧН=[^;]*; ЧГ=/g, '0');
}

function extractJs(src, startMarker) {
  const start = src.indexOf(startMarker);
  if (start < 0) return null;
  const tail = src.slice(start);
  // Блок заканчивается на закрывающем </scr" + "ipt> или на следующем //-комментарии верхнего уровня
  const endMatch = tail.match(/\+\s*"<\/scr"\s*\+\s*"ipt>"/);
  const end = endMatch ? endMatch.index + endMatch[0].length : tail.length;
  const block = tail.slice(0, end);

  let js = '';
  for (const rawLine of block.split(/\r?\n/)) {
    const t = rawLine.trim();
    if (!t.startsWith('+') && !t.startsWith('Возврат')) continue;
    for (const s of literalsOf(t)) js += s;
  }
  return stripBslCalls(js)
    .split('<scr' + 'ipt>').join('')
    .split('</scr' + 'ipt>').join('');
}

function checkBalanced(js) {
  let depth = 0;
  for (let i = 0; i < js.length; i += 1) {
    if (js[i] === '{') depth += 1;
    else if (js[i] === '}') {
      depth -= 1;
      if (depth < 0) return { ok: false, at: i, depth };
    }
  }
  return { ok: depth === 0, at: js.length, depth };
}

const targets = [
  { file: 'CommonModules/ПерфКокпит/Ext/Module.bsl', marker: 'Возврат "<scr"' },
  { file: 'CommonModules/ПерфUI/Ext/Module.bsl', marker: 'Функция СкриптМоста() Экспорт' },
];
void targets;

let failed = 0;
const files = process.argv.slice(2);

for (const file of files) {
  const src = fs.readFileSync(file, 'utf8');
  // Тип блока определяем по содержимому, а не по имени файла:
  // оба модуля начинаются с «Возврат "<scr"», но кокпит содержит СкриптКокпита.
  const isCockpit = src.includes('Функция СкриптКокпита');
  const marker = isCockpit ? 'Возврат "<scr"' : 'Функция СкриптМоста() Экспорт';
  const js = extractJs(src, marker);
  if (js === null || js.trim() === '') {
    console.error(`[skip] ${file}: блок скрипта не найден`);
    failed = failed === 0 ? 2 : failed;
    continue;
  }

  const bal = checkBalanced(js);
  let syntax = 'ok';
  try {
    // Проверка синтаксиса без исполнения: компиляция в контексте.
    new vm.Script(js, { filename: path.basename(file) + '.js' });
  } catch (e) {
    syntax = e.message;
  }

  const problems = [];
  if (!bal.ok) problems.push(`дисбаланс скобок: глубина ${bal.depth} в позиции ${bal.at}`);
  if (syntax !== 'ok') problems.push(`синтаксис: ${syntax}`);
  if (isCockpit) {
    // Функции, без которых интерфейс кокпита «мертвый»: их ищут 1С и страница.
    const required = ['window.PF1C=PF1C', 'window.SetProgress', 'window.SetGlobalStatus',
      'window.SetStandChip', 'window.AddSummaryRow', 'window.ResetSummary',
      'state:function', 'progress:function', 'result:function', 'kpi:function',
      'lock:function', 'logRow:function', 'status:function', 'stand:function', 'pfFit'];
    for (const name of required) {
      if (!js.includes(name)) problems.push(`нет ${name}`);
    }
  }

  if (problems.length) {
    failed = 1;
    console.error(`[fail] ${file} (${js.length} симв.):`);
    for (const p of problems) console.error(`       - ${p}`);
  } else {
    console.log(`[ok]   ${file} (${js.length} симв., скобки сбалансированы)`);
  }
}

process.exit(failed);
