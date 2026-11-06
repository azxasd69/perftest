// Кокпит «ПерфТест»: страница панели целиком в HTML по шаблону index-v3.
//
// Сверено с референсом поэлементно: бренд с пульсом и чипом версии, хлебные крошки,
// поля «стенд» и «×», кнопка командной палитры, кнопки primary/danger, bento-сетка
// 12 колонок с четырьмя KPI, карточки с индексом/кодом/бейджем/единицей/полосой
// состояния, журнал таблицей на 8 колонок и палитра по Ctrl+K.
//
// Ограничения движка HTML-поля 1С (измерены): нет flex-gap, sticky без префикса,
// backdrop-filter, oklch, color-mix, clamp, aspect-ratio. Поэтому: отступы через
// margin, sticky через -webkit-sticky, цвета в hex, шрифты по фиксированным размерам.
//
// Мост: 1С зовет функции JS через Элементы.ШапкаHTML.Документ.defaultView,
// команды из HTML забираются таймером через PF1C.take().

Функция СтилиКокпита() Экспорт
	// База токенов и компонентов - из ПерфUI; ниже только кокпит-специфика.
	Возврат ПерфUI.Стили() + "<style>"
		+ "html,body{margin:0;background:#0E0F13;color:#ECEEF3;"
		+ "font:14px/1.5 'Segoe UI',Arial,sans-serif;"
		+ "background-image:radial-gradient(90% 60% at 15% -10%,rgba(58,72,110,.45),rgba(14,15,19,0)),"
		+ "radial-gradient(70% 50% at 90% 0%,rgba(48,84,58,.28),rgba(14,15,19,0));"
		+ "background-repeat:no-repeat}"
		+ ".wrap{max-width:1500px;width:100%;margin:0 auto;padding:14px 18px 70px;"
		+ "box-sizing:border-box}"
		+ ".bar{position:-webkit-sticky;top:0;z-index:40;background:#1A1D24;"
		+ "border:1px solid #26292F;border-radius:16px;padding:9px 12px;margin-bottom:14px;"
		+ "-webkit-flex-wrap:wrap;flex-wrap:wrap;gap:8px 6px}"
		+ ".bar,.brand,.crumbles,.field,.c-foot,.c-top,.log-head{display:-webkit-flex;"
		+ "display:flex;-webkit-align-items:center;align-items:center}"
		+ ".brand{font-weight:650;letter-spacing:-.01em}"
		+ ".brand .pulse{width:7px;height:7px;border-radius:50%;background:#C4F252;"
		+ "margin-right:8px;box-shadow:0 0 0 4px #2B332A}"
		+ ".brand .ver{font-size:12px;font-weight:600;color:#767A84;border:1px solid #2F333A;"
		+ "border-radius:5px;padding:0 4px;margin-left:8px}"
		+ ".crumbles{font-size:13px;color:#767A84;margin-left:12px}"
		+ ".crumbles span{margin-right:14px}"
		+ ".grow{-webkit-flex:1 1 auto;flex:1 1 auto}"
		+ ".field{font-size:13px;color:#767A84;margin-right:10px}"
		+ ".field span{margin-right:6px}"
		+ ".field input{font:14px 'Segoe UI',Arial,sans-serif;color:#ECEEF3;background:#1F2228;"
		+ "border:1px solid #2F333A;border-radius:9px;padding:5px 9px;outline:none}"
		+ ".field .stand-input{width:132px}"
		+ ".field .rep-input{width:52px;text-align:center}"
		+ ".field input:focus{border-color:#C4F252}"
		+ ".btn{font:600 14px 'Segoe UI',Arial,sans-serif;border-radius:9px;cursor:pointer;"
		+ "padding:6px 12px;border:1px solid #2F333A;background:#1F2228;color:#ECEEF3;"
		+ "margin-left:8px}"
		+ ".btn:hover:not(:disabled){background:#282B33;border-color:#424853}"
		+ ".btn:disabled{opacity:.4;cursor:default}"
		+ ".btn.primary{background:#C4F252;color:#111900;border-color:transparent}"
		+ ".btn.primary:hover:not(:disabled){background:#D1FF61}"
		+ ".btn.danger{color:#FF7E70;border-color:#5A3A37}"
		+ ".btn.danger:hover:not(:disabled){background:#2A1F1E}"
		+ ".btn.kbd{font-size:13px;color:#A0A5AE;padding:5px 9px}"
		+ ".btn.kbd kbd{font-family:Consolas,'Courier New',monospace;font-size:10px;"
		+ "background:#2B2E34;border:1px solid #3A3F47;border-radius:4px;padding:0 4px;"
		+ "margin-left:6px}"
		+ ".span-2{grid-column:span 2}.span-3{grid-column:span 3}"
		+ ".span-4{grid-column:span 4}.span-6{grid-column:span 6}.span-12{grid-column:span 12}"
		+ "@media (max-width:1500px){.card.span-4{grid-column:span 6}}"
		+ "@media (max-width:1100px){.card.span-4,.card.span-6{grid-column:span 12}}"
		+ ".bento{display:grid;grid-template-columns:repeat(12,minmax(0,1fr));"
		+ "grid-column-gap:12px}"
		+ ".tile{background:#17191F;border:1px solid #26292F;border-radius:16px;"
		+ "padding:14px 15px;margin-bottom:12px;position:relative;overflow:hidden;"
		+ "min-width:0;box-sizing:border-box}"
		+ ".span-2{grid-column:span 2}.span-3{grid-column:span 3}.span-4{grid-column:span 4}"
		+ ".span-6{grid-column:span 6}.span-12{grid-column:span 12}"
		+ ".lbl{font-size:11.5px;letter-spacing:.12em;text-transform:uppercase;color:#767A84;"
		+ "font-weight:650}"
		+ ".big{font-size:32px;font-weight:680;letter-spacing:-.03em;line-height:1.1;"
		+ "margin-top:7px;font-family:Consolas,'Courier New',monospace}"
		+ ".big small{font-size:14px;color:#767A84;font-weight:500;letter-spacing:0;"
		+ "font-family:'Segoe UI',Arial,sans-serif}"
		+ ".sub{font-size:13px;color:#A0A5AE;margin-top:4px;overflow:hidden;"
		+ "text-overflow:ellipsis;white-space:nowrap}"
		+ ".track{height:4px;border-radius:99px;background:#2B2E34;margin-top:10px;overflow:hidden}"
		+ ".track i{display:block;height:100%;width:0;background:#C4F252}"
		+ ".card{display:-webkit-flex;display:flex;-webkit-flex-direction:column;"
		+ "flex-direction:column}"
		+ ".edge{position:absolute;left:0;top:14px;bottom:14px;width:2px;border-radius:2px;"
		+ "background:transparent}"
		+ ".card.state-run .edge{background:#73BDFF}"
		+ ".card.state-ok .edge{background:#76E699}"
		+ ".card.state-err .edge{background:#FF7E70}"
		+ ".card.state-cancel .edge{background:#F5C25F}"
		+ ".c-top{margin-bottom:8px}"
		+ ".idx{font-family:Consolas,'Courier New',monospace;font-size:12px;color:#C4F252;"
		+ "background:#2B332A;border-radius:5px;padding:1px 5px;margin-right:8px}"
		+ ".code{font-family:Consolas,'Courier New',monospace;font-size:11.5px;color:#767A84;"
		+ "overflow:hidden;text-overflow:ellipsis;white-space:nowrap}"
		+ ".badge{margin-left:auto;font-size:11.5px;font-weight:650;border-radius:99px;"
		+ "padding:2px 8px;background:#2B2E34;color:#A0A5AE;white-space:nowrap}"
		+ ".badge.run{background:#283646;color:#73BDFF}"
		+ ".badge.ok{background:#283933;color:#76E699}"
		+ ".badge.err{background:#402D2F;color:#FF7E70}"
		+ ".badge.cancel{background:#3D372E;color:#F5C25F}"
		+ ".card h3{margin:0 0 8px;font-size:17px;font-weight:640;letter-spacing:-.012em;"
		+ "line-height:1.35}"
		+ ".p{margin:0 0 6px;font-size:14px;line-height:1.55;color:#A0A5AE}"
		+ ".p b{color:#E4E7EC;font-weight:600}"
		+ ".c-foot{margin-top:auto;padding-top:10px}"
		+ ".unit{font-family:Consolas,'Courier New',monospace;font-size:12px;color:#767A84;"
		+ "border:1px solid #26292F;border-radius:5px;padding:1px 6px;white-space:nowrap}"
		+ ".c-foot .btn{margin-left:auto;padding:7px 14px;font-size:14px}"
		+ ".status{display:none;margin-top:8px;font-size:12.5px;color:#A0A5AE}"
		+ ".state-run .status,.state-ok .status,.state-err .status,.state-cancel .status{display:block}"
		+ ".state-run .status{color:#73BDFF}"
		+ ".result{display:none;margin:8px 0 0;font-size:13.5px;font-weight:600;"
		+ "line-height:1.5;padding:6px 9px;border-radius:8px}"
		+ ".result.ok{display:block;color:#76E699;background:#283933}"
		+ ".result.err{display:block;color:#FF7E70;background:#402D2F}"
		+ ".result.cancel{display:block;color:#F5C25F;background:#3D372E}"
		+ ".cbar{position:absolute;left:0;right:0;bottom:0;height:2px;background:transparent}"
		+ ".cbar i{display:block;height:100%;width:0;background:#C4F252}"
		+ ".state-ok .cbar i{background:#76E699}"
		+ ".state-err .cbar i{background:#FF7E70}"
		+ ".state-cancel .cbar i{background:#F5C25F}"
		+ ".log-head{margin-bottom:10px}"
		+ ".log-head h2{margin:0;font-size:16px;font-weight:640;letter-spacing:-.01em}"
		+ ".log-head span{font-size:13px;color:#767A84;margin-left:10px}"
		+ "table{width:100%;border-collapse:collapse;font-size:13.5px}"
		+ "th,td{padding:7px 10px;text-align:left;border-bottom:1px solid #26292F}"
		+ "thead th{font-size:11px;letter-spacing:.1em;text-transform:uppercase;"
		+ "color:#767A84;font-weight:650}"
		+ "tbody tr:hover{background:#1F2228}"
		+ "td.n,th.n{text-align:right;white-space:nowrap;"
		+ "font-family:Consolas,'Courier New',monospace;font-size:13px}"
		+ ".empty{color:#767A84;font-size:13.5px;padding:10px 2px}"
		+ ".foot{margin-top:16px;font-size:12.5px;color:#767A84}"
		+ ".scrim{position:fixed;left:0;top:0;right:0;bottom:0;background:rgba(6,7,10,.72);"
		+ "z-index:90;padding-top:12vh}"
		+ ".pal{width:560px;max-width:92%;margin:0 auto;background:#17191F;"
		+ "border:1px solid #2F333A;border-radius:14px;overflow:hidden}"
		+ ".pal input{width:100%;box-sizing:border-box;border:0;background:transparent;"
		+ "color:#ECEEF3;font:16px 'Segoe UI',Arial,sans-serif;padding:15px 16px;"
		+ "border-bottom:1px solid #26292F;outline:none}"
		+ ".pal ul{list-style:none;margin:0;padding:6px;max-height:46vh;overflow:auto}"
		+ ".pal li{padding:9px 10px;border-radius:8px;font-size:14px;cursor:pointer;"
		+ "color:#A0A5AE}"
		+ ".pal li.sel{background:#2B332A;color:#ECEEF3}"
		+ ".pal .tip{font-size:12px;color:#767A84;padding:8px 16px;"
		+ "border-top:1px solid #26292F}"
		+ ".stat{position:fixed;left:0;right:0;bottom:0;background:#17191F;"
		+ "border-top:1px solid #2F333A;padding:7px 18px;font-size:13px;color:#A0A5AE;z-index:30}"
		+ ".stat b{color:#ECEEF3}"
		+ "</style>";
КонецФункции

// Карточка сценария: индекс, код, бейдж, суть, реализация, единица, кнопка, полосы.
Функция КарточкаHTML(Номер, Сценарий, Ширина)
	Порция = Формат(Сценарий.Порция, "ЧГ=");
	Возврат "<section class='tile card span-" + Ширина + " state-idle' id='card"
		+ Номер + "'>"
		+ "<i class='edge'></i>"
		+ "<div class='c-top'><span class='idx'>" + Формат(Номер, "ЧЦ=2; ЧВН=; ЧГ=") + "</span>"
		+ "<span class='code' title='" + Экранировать(Сценарий.Имя) + "'>"
		+ Экранировать(Сценарий.Имя) + "</span>"
		+ "<span class='badge'>&mdash;</span></div>"
		+ "<h3>" + Экранировать(Сценарий.Представление) + "</h3>"
		+ "<p class='p'><b>Суть:</b> " + Экранировать(Сценарий.Описание) + "</p>"
		+ "<p class='p'><b>Реализация:</b> " + " " + Порция + " " + Экранировать(Сценарий.Единица)
		+ ", повторов " + Формат(Сценарий.Повторов, "ЧН=0; ЧГ=") + "</p>"
		+ "<div class='c-foot'><span class='unit'>" + Порция + " "
		+ Экранировать(Сценарий.Единица) + "</span>"
		+ "<button class='btn primary' onclick='PF1C.run(" + Номер + ")'>Запустить</button></div>"
		+ "<div class='status'>&mdash;</div>"
		+ "<p class='result'></p>"
		+ "<div class='cbar'><i></i></div></section>";
КонецФункции

// Полная страница кокпита.
Функция Страница(СтендСтрокой, Повторов, Сценарии, ПлатформаСтрокой, КонфигурацияСтрокой,
	Настройки = Неопределено) Экспорт
	// Каркас страницы (head, общие стили, боковая панель, тема) собирает
	// ПерфUI.Документ: здесь остаётся только контент кокпита.
	Части = Новый Массив;

	// Верхняя панель: бренд, крошки, поля, палитра, пуск и стоп.
	Части.Добавить("<header class='bar'>");
	Части.Добавить("<div class='brand'><span class='pulse'></span>ПерфТест"
		+ "<span class='ver'>" + Экранировать(КонфигурацияСтрокой) + "</span></div>");
	Части.Добавить("<div class='crumbles'><span>обзор</span><span>сценарии</span>"
		+ "<span>журнал</span></div>");
	Части.Добавить("<button class='btn kbd' onclick='PF1C.send(""open:ПерфДашборд"")'>Дашборд</button>");
	Части.Добавить("<button class='btn kbd' onclick='PF1C.send(""open:ПерфТопКонфигураций"")'>Топ-100</button>");
	Части.Добавить("<button class='btn kbd' onclick='PF1C.send(""open:ПерфСравнениеСтендов"")'>Сравнение</button>");
	Части.Добавить("<button class='btn kbd' onclick='PF1C.send(""open:ПерфИсторияЗамеров"")'>История</button>");
	Части.Добавить("<span class='grow'></span>");
	Части.Добавить("<label class='field'><span>стенд</span>"
		+ "<input class='stand-input' id='stand' value='" + Экранировать(СтендСтрокой) + "'"
		+ " spellcheck='false' onchange='PF1C.send(""stand:""+this.value)'></label>");
	Части.Добавить("<label class='field'><span>×</span>"
		+ "<input class='rep-input' type='number' id='repeats' min='1' max='9' value='"
		+ Формат(Повторов, "ЧН=0; ЧГ=") + "' onchange='PF1C.send(""rep:""+this.value)'></label>");
	Части.Добавить("<button class='btn kbd' id='openPal' onclick='PF1C.openPal()'>"
		+ "K<kbd>Ctrl+K</kbd></button>");
	// Подпись сразу по текущей теме: без промежуточного «Тема» до выполнения скрипта.
	// Подпись кнопки берётся из того же снимка, что и каркас: без второго запроса
	// к константе и без риска показать не то состояние, что уже отрисовано.
	СнимокТемы = ПерфUI.ДополнитьНастройки(Настройки);
	ПодписьТемы = ?(СнимокТемы.Тема = "light", "Тёмная тема", "Светлая тема");
	Части.Добавить("<button class='btn kbd' id='pfThemeBtn' onclick='PFThemeToggle(this)'>"
		+ ПодписьТемы + "</button>");
	Части.Добавить("<button class='btn primary' id='runAll' onclick='PF1C.send(""all"")'>"
		+ "Запустить все</button>");
	Части.Добавить("<button class='btn danger' id='stop' disabled "
		+ "onclick='PF1C.send(""stop"")'>Стоп</button>");
	Части.Добавить("</header>");

	// Bento: четыре KPI
	Части.Добавить("<main class='bento'>");
	Части.Добавить("<section class='tile span-4'><div class='lbl'>Выполнено сценариев</div>"
		+ "<div class='big'><span id='kDone'>0</span><small> / " + Строка(Сценарии.Количество())
		+ "</small></div><div class='sub' id='kDoneHint'>еще не запускали</div>"
		+ "<div class='track'><i id='kDoneBar'></i></div></section>");
	Части.Добавить("<section class='tile span-3'><div class='lbl'>Средняя медиана</div>"
		+ "<div class='big'><span id='kMedian'>&mdash;</span><small> мс</small></div>"
		+ "<div class='sub' id='kMedianHint'>по завершенным</div></section>");
	Части.Добавить("<section class='tile span-3'><div class='lbl'>Самый медленный</div>"
		+ "<div class='big big-lg' id='kSlow'>&mdash;</div>"
		+ "<div class='sub' id='kSlowHint'>наибольшая медиана</div></section>");
	Части.Добавить("<section class='tile span-2'><div class='lbl'>Последний</div>"
		+ "<div class='big big-md' id='kLast'>&mdash;</div>"
		+ "<div class='sub'>время замера</div></section>");

	// Карточки: первые две шире, как в шаблоне
	Номер = 0;
	Для Каждого Сценарий Из Сценарии Цикл
		Номер = Номер + 1;
		Ширина = 4; // одинаковая ширина: ровная сетка по три карточки в ряд
		Части.Добавить(КарточкаHTML(Номер, Сценарий, Ширина));
	КонецЦикла;

	// Журнал таблицей на 8 колонок
	Части.Добавить("<section class='tile span-12' id='logTile'>"
		+ "<div class='log-head'><h2>Журнал замеров</h2>"
		+ "<span id='logState'>стенд x сценарий</span></div>"
		+ "<table><thead><tr><th class='n'>№</th><th>Сценарий</th><th>Стенд</th>"
		+ "<th class='n'>Медиана, мс</th><th class='n'>мс/тыс.</th><th class='n'>Повторов</th>"
		+ "<th class='n'>Мин...Макс</th><th>Дата</th></tr></thead>"
		+ "<tbody id='logBody'><tr><td colspan='8' class='empty'>"
		+ "- пока нет завершенных карточек -</td></tr></tbody></table>"
		+ "<div class='foot'>Платформа " + Экранировать(ПлатформаСтрокой)
		+ "; Ctrl+K - командная палитра, стрелки и Enter - навигация.</div></section>");
	Части.Добавить("</main>");

	// Палитра команд
	Части.Добавить("<div class='scrim hidden' id='scrim'>"
		+ "<div class='pal'><input id='palInput' placeholder='Сценарий или действие...'"
		+ " autocomplete='off'><ul id='palList'></ul>"
		+ "<div class='tip'>стрелки - выбор, Enter - выполнить, Esc - закрыть</div>"
		+ "</div></div>");

	Части.Добавить("<div class='stat' id='stat'>Готов к работе. Стенд: <b>"
		+ Экранировать(СтендСтрокой) + "</b></div>");
	Части.Добавить(СкриптКокпита(Сценарии.Количество()));
	Возврат ПерфUI.Документ("НачальнаяСтраница", "ПерфТест - кокпит",
		СтрСоединить(Части, ""), СтилиКокпита(), Истина, "wrap", КонфигурацияСтрокой, Настройки);
КонецФункции

// JS: очередь команд для 1С, обновление карточек и KPI, журнал, палитра.
Функция СкриптКокпита(ВсегоСценариев) Экспорт
	Возврат "<scr" + "ipt>"
		// Базовый мост (send/take/clear) уже создан каркасом в head: свой объект
		// строится поверх него, иначе clear терялся при переходе по меню.
		+ "var PF1Cbase=window.PF1C||{};"
		+ "var PF1C={q:[],total:" + Формат(ВсегоСценариев, "ЧН=0; ЧГ=") + ","
		+ "send:function(c){this.q.push(c);},take:function(){"
		+ "if(!this.q.length){return '';}var s=this.q.join('|');this.q=[];return s;},"
		+ "run:function(n){this.send('run:'+n);},"
		+ "openPal:function(){var s=document.getElementById('scrim');"
		+ "if(s){s.classList.remove('hidden');}var i=document.getElementById('palInput');"
		+ "if(i){i.focus();}PF1C.palRefresh();},"
		+ "closePal:function(){var s=document.getElementById('scrim');if(s){s.classList.add('hidden');}},"
		+ "palIdx:0,palItems:[],"
		+ "palActions:function(){var a=[{t:'Запустить все последовательно',k:'action',c:'all'},"
		+ "{t:'Остановить текущий прогон',k:'action',c:'stop'}];"
		+ "var cards=document.querySelectorAll('.card');"
		+ "for(var i=0;i<cards.length;i++){var n=cards[i].id.replace('card','');"
		+ "var h=cards[i].querySelector('h3');"
		+ "a.push({t:(n.length<2?'0'+n:n)+' - '+(h?h.innerHTML:''),k:'scenario',c:'run:'+n});}"
		+ "return a;},"
		+ "palRefresh:function(){var inp=document.getElementById('palInput');"
		+ "var q=inp?inp.value.toLowerCase():'';"
		+ "PF1C.palItems=PF1C.palActions().filter(function(x){"
		+ "return x.t.toLowerCase().indexOf(q)>=0;});"
		+ "if(PF1C.palIdx>PF1C.palItems.length-1){PF1C.palIdx=Math.max(0,PF1C.palItems.length-1);}"
		+ "var html='';for(var i=0;i<PF1C.palItems.length;i++){var it=PF1C.palItems[i];"
		+ "html+=""<li class='""+(i===PF1C.palIdx?'sel':'')+""' onclick='PF1C.palPick(""+i+"")'>""+it.t+'</li>';}"
		+ "var ul=document.getElementById('palList');if(ul){ul.innerHTML=html;}},"
		+ "palPick:function(i){var it=PF1C.palItems[i];if(!it){return;}PF1C.closePal();PF1C.send(it.c);},"
		+ "palRun:function(){PF1C.palPick(PF1C.palIdx);},"
		+ "state:function(n,st){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "var sp='',arr=c.className.split(' ');"
		+ "for(var i=0;i<arr.length;i++){if(arr[i].indexOf('span-')===0){sp=arr[i];}}"
		+ "c.className='tile card'+(sp?' '+sp:'')+' state-'+st;"
		+ "var b=c.querySelector('.badge');if(b){b.className='badge '+st;"
		+ "b.innerHTML=(st==='run'?'выполняется':st==='ok'?'готово':st==='err'?'ошибка':"
		+ "st==='cancel'?'отменено':'-');}},"
		+ "progress:function(n,p,txt){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "var b=c.querySelector('.cbar i');if(b){b.style.width=(p<0?0:(p>99?99:p))+'%';}"
		+ "var s=c.querySelector('.status');if(s&&txt){s.innerHTML=txt;}},"
		+ "result:function(n,cls,txt){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "var r=c.querySelector('.result');if(r){r.className='result '+(cls||'');"
		+ "r.innerHTML=txt||'';}},"
		+ "kpi:function(done,avg,slow,slowTitle,last){var e;"
		+ "e=document.getElementById('kDone');if(e){e.innerHTML=done;}"
		+ "e=document.getElementById('kDoneBar');if(e){e.style.width=(done/PF1C.total*100)+'%';}"
		+ "e=document.getElementById('kDoneHint');if(e){e.innerHTML=done>=PF1C.total?"
		+ "'все сценарии выполнены':'осталось '+(PF1C.total-done);}"
		+ "e=document.getElementById('kMedian');if(e){e.innerHTML=avg;}"
		+ "e=document.getElementById('kMedianHint');if(e){e.innerHTML=done?('по '+done):'по завершенным';}"
		+ "e=document.getElementById('kSlow');if(e){e.innerHTML=slow;}"
		+ "e=document.getElementById('kSlowHint');if(e){e.innerHTML=slowTitle||'наибольшая медиана';}"
		+ "e=document.getElementById('kLast');if(e){e.innerHTML=last;}},"
		+ "logRow:function(n,title,stand,median,perK,reps,mm,date){"
		+ "var tb=document.getElementById('logBody');if(!tb){return;}"
		+ "var emp=tb.querySelector('td[colspan]');if(emp){emp.parentNode.parentNode.removeChild(emp.parentNode);}"
		+ "var tr=null,rows=tb.rows;for(var i=0;i<rows.length;i++){"
		+ "if(rows[i].getAttribute('data-n')===String(n)){tr=rows[i];}}"
		+ "var cells='<td class=\'n\'>'+n+'</td><td>'+title+'</td><td>'+stand+'</td>"
		+ "<td class=\'n\'>'+median+'</td><td class=\'n\'>'+perK+'</td>"
		+ "<td class=\'n\'>'+reps+'</td><td class=\'n\'>'+mm+'</td><td>'+date+'</td>';"
		+ "if(tr){tr.innerHTML=cells;}else{tr=document.createElement('tr');"
		+ "tr.setAttribute('data-n',n);tr.innerHTML=cells;tb.appendChild(tr);}},"
		+ "done:function(n,res,txt,median){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "if(res==='ok'){PF1C.state(n,'ok');PF1C.result(n,'ok',txt);PF1C.progress(n,100,'100%');}"
		+ "else{PF1C.state(n,res);PF1C.result(n,res,txt);}"
		+ "c.setAttribute('data-median',median||0);PF1C.refreshKpi();PF1C.lock(false);},"
		+ "refreshKpi:function(){var cards=document.querySelectorAll('.card');"
		+ "var ok=0,sum=0,slow=0,slowTitle='',last='';"
		+ "for(var i=0;i<cards.length;i++){var c=cards[i];"
		+ "if(c.className.indexOf('state-ok')>=0){ok++;var m=parseFloat(c.getAttribute('data-median')||'0');"
		+ "sum+=m;if(m>slow){slow=m;var h=c.querySelector('h3');slowTitle=h?h.innerHTML:'';}}}"
		+ "var avg=ok?Math.round(sum/ok):0;var t=new Date();"
		+ "last=('0'+t.getHours()).slice(-2)+':'+('0'+t.getMinutes()).slice(-2)+':'+('0'+t.getSeconds()).slice(-2);"
		+ "PF1C.kpi(ok,ok?avg:'\u2014',ok?slow+' \u043c\u0441':'\u2014',slowTitle,ok?last:'\u2014');},"
		+ "lock:function(on){var b=document.querySelectorAll('.card .btn');"
		+ "for(var i=0;i<b.length;i++){b[i].disabled=!!on;}"
		+ "var a=document.getElementById('runAll');if(a){a.disabled=!!on;}"
		+ "var s=document.getElementById('stop');if(s){s.disabled=!on;}},"
		+ "status:function(txt){var s=document.getElementById('stat');if(s){s.innerHTML=txt;}},"
		+ "stand:function(v){var s=document.getElementById('stand');if(s){s.value=v;}"
		+ "var t=document.getElementById('stat');if(t){t.innerHTML='Готов к работе. Стенд: <b>'+v+'</b>';}}};"
		+ "if(PF1Cbase.clear){PF1C.clear=PF1Cbase.clear;}"
		+ "if(PF1Cbase.send){PF1C.send=PF1C.send||PF1Cbase.send;}"
		+ "window.PF1C=PF1C;"
		+ "window.SetProgress=function(n,p,t){PF1C.progress(n,p,t);};"
		+ "window.SetGlobalStatus=function(t){PF1C.status(t);};"
		+ "window.SetStandChip=function(v){PF1C.stand(v);};"
		+ "window.AddSummaryRow=function(n,title,stand,median,perK,reps,mm,date){"
		+ "PF1C.logRow(n,title,stand,median,perK,reps,mm,date);};"
		+ "window.ResetSummary=function(){var tb=document.getElementById('logBody');"
		+ "if(tb){tb.innerHTML=""<tr><td colspan='8' class='empty'>"
		+ "- пока нет завершенных карточек -</td></tr>"";}};"
		+ "document.addEventListener('keydown',function(e){"
		+ "if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='k'){e.preventDefault();"
		+ "var s=document.getElementById('scrim');"
		+ "if(s&&s.style.display==='block'){PF1C.closePal();}else{PF1C.openPal();}}"
		+ "else if(e.key==='Escape'){PF1C.closePal();}"
		+ "else if(s2open()){if(e.key==='ArrowDown'){e.preventDefault();PF1C.palIdx++;PF1C.palRefresh();}"
		+ "else if(e.key==='ArrowUp'){e.preventDefault();PF1C.palIdx=Math.max(0,PF1C.palIdx-1);PF1C.palRefresh();}"
		+ "else if(e.key==='Enter'){e.preventDefault();PF1C.palRun();}}});"
		+ "function s2open(){var s=document.getElementById('scrim');return s&&!s.classList.contains('hidden');}"
		+ "var pi=document.getElementById('palInput');"
		+ "if(pi){pi.addEventListener('input',function(){PF1C.palIdx=0;PF1C.palRefresh();});}"
		+ "var sc=document.getElementById('scrim');"
		+ "if(sc){sc.addEventListener('click',function(e){if(e.target===sc){PF1C.closePal();}});}"
		+ "</scr" + "ipt>";
КонецФункции

// Экранирование текста для HTML.
Функция Экранировать(Значение) Экспорт
	Результат = СтрЗаменить(Строка(Значение), "&", "&amp;");
	Результат = СтрЗаменить(Результат, "<", "&lt;");
	Результат = СтрЗаменить(Результат, ">", "&gt;");
	Возврат СтрЗаменить(Результат, """", "&quot;");
КонецФункции
