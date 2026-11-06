// ПерфUI - единая библиотека оформления кокпита.
//
// Один источник правды по токенам и компонентам шаблона index-v3:
// палитра, типографика 1080p (база 16 px), сетка bento, шапка, плитки KPI,
// карточки, таблицы, поля, кнопки, состояния и палитра команд.
//
// Все потребители (панель, отчёты, списки, формы) собирают страницу так:
//   ПерфUI.Страница(Заголовок, ПерфUI.Стили() + Тело)
// чтобы не дублировать CSS в каждом модуле.
//
// Ограничения движка HTML-поля 1С: нет flex-gap, oklch, color-mix, clamp,
// backdrop-filter; sticky только с префиксом -webkit-.

Функция Стили() Экспорт
	Возврат "<style>"
		+ "html{--pf-bg:#0E0F13;--pf-sunken:#11161D;--pf-surface:#17191F;--pf-raised:#1F2228;--pf-line:#26292F;--pf-lin"
		+ "e-strong:#616A7C;--pf-fg:#ECEEF3;--pf-fg-2:#A0A5AE;--pf-fg-3:#868A94;--pf-accent:#C4F252;--pf-accent-bg:#2B3"
		+ "32A;--pf-on-accent:#111900;--pf-ok:#76E699;--pf-ok-bg:#283933;--pf-ok-line:#31C48D;--pf-warn:#F5C25F;--pf-wa"
		+ "rn-bg:#3D372E;--pf-bad:#FF7E70;--pf-bad-bg:#402D2F;--pf-bad-line:#5A3A37;--pf-info:#73BDFF;--pf-info-bg:#283"
		+ "646;--pf-hover:#1B1E25;--pf-side-bg:#0D1117;--pf-side-fg:#C6CFDD}html,body{margin:0;background:var(--pf-bg);"
		+ "color:var(--pf-fg);font:14px/1.5 'Segoe UI',Arial,sans-serif;background-image:radial-gradient(90% 60% at 15%"
		+ " -10%,rgba(58,72,110,.45),rgba(14,15,19,0)),radial-gradient(70% 50% at 90% 0%,rgba(48,84,58,.28),rgba(14,15,"
		+ "19,0));background-repeat:no-repeat}body{padding-left:232px;overflow-x:hidden;max-width:100%}.wrap{max-width:"
		+ "1500px;width:100%;margin:0 auto;padding:14px 18px 70px;box-sizing:border-box}.bar{position:relative;z-index:"
		+ "40;font-size:14px;background:var(--pf-surface);border:1px solid var(--pf-line);border-radius:16px;padding:8p"
		+ "x 12px;margin-bottom:14px;-webkit-flex-wrap:wrap;flex-wrap:wrap;gap:8px 6px}.bar,.brand,.crumbles,.field,.c-"
		+ "foot,.c-top,.log-head{display:-webkit-flex;display:flex;-webkit-align-items:center;align-items:center}.brand"
		+ "{font-weight:650;letter-spacing:-.01em}.brand .pulse{width:7px;height:7px;border-radius:50%;background:var(-"
		+ "-pf-accent);margin-right:8px;box-shadow:0 0 0 4px var(--pf-accent-bg)}.brand .ver{font-size:12px;font-weight"
		+ ":600;color:var(--pf-fg-2);border:1px solid var(--pf-line);border-radius:5px;padding:0 4px;margin-left:8px}.c"
		+ "rumbles{font-size:14px;color:var(--pf-fg-2);margin-left:12px}.crumbles span{margin-right:14px}.grow{-webkit-"
		+ "flex:1 1 auto;flex:1 1 auto}.field{font-size:14px;color:var(--pf-fg-2);margin-right:10px}.field span{margin-"
		+ "right:6px}.field input{font:14px 'Segoe UI',Arial,sans-serif;color:var(--pf-fg);background:var(--pf-raised);"
		+ "border:1px solid var(--pf-line);border-radius:9px;padding:4px 8px;outline:none}.field .stand-input{width:132"
		+ "px}.field .rep-input{width:52px;text-align:center}.field input:focus{border-color:var(--pf-accent)}.btn{font"
		+ ":600 14px 'Segoe UI',Arial,sans-serif;border-radius:9px;cursor:pointer;padding:6px 12px;border:1px solid var"
		+ "(--pf-line);background:var(--pf-raised);color:var(--pf-fg);margin-left:8px}.btn:hover:not(:disabled){backgro"
		+ "und:var(--pf-raised);border-color:var(--pf-line)}.btn:disabled{opacity:.4;cursor:default}.btn.primary{backgr"
		+ "ound:var(--pf-accent);color:var(--pf-on-accent);border-color:transparent}.btn.primary:hover:not(:disabled){b"
		+ "ackground:var(--pf-accent)}.btn.danger{color:var(--pf-bad);border-color:var(--pf-bad-line)}.btn.danger:hover"
		+ ":not(:disabled){background:var(--pf-bad-bg)}.btn.kbd{font-size:14px;color:var(--pf-fg-2);padding:4px 8px}.bt"
		+ "n.kbd kbd{font-family:Consolas,'Courier New',monospace;font-size:12px;background:var(--pf-raised);border:1px"
		+ " solid var(--pf-line);border-radius:4px;padding:0 4px;margin-left:6px}.span-2{grid-column:span 2}.span-3{gri"
		+ "d-column:span 3}.span-4{grid-column:span 4}.span-6{grid-column:span 6}.span-12{grid-column:span 12}.bento{di"
		+ "splay:grid;grid-template-columns:repeat(12,minmax(0,1fr));grid-column-gap:12px}.tile{background:var(--pf-sur"
		+ "face);border:1px solid var(--pf-line);border-radius:16px;padding:14px 16px;margin-bottom:12px;position:relat"
		+ "ive;overflow:hidden;min-width:0;box-sizing:border-box}.lbl{font-size:12px;letter-spacing:.12em;text-transfor"
		+ "m:uppercase;color:var(--pf-fg-2);font-weight:650}.big{font-size:32px;font-weight:680;letter-spacing:-.03em;l"
		+ "ine-height:1.1;margin-top:8px;font-family:Consolas,'Courier New',monospace}.big small{font-size:14px;color:v"
		+ "ar(--pf-fg-2);font-weight:500;letter-spacing:0;font-family:'Segoe UI',Arial,sans-serif}.sub{font-size:14px;c"
		+ "olor:var(--pf-fg-2);margin-top:4px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.track{height:4"
		+ "px;border-radius:99px;background:var(--pf-raised);margin-top:10px;overflow:hidden}.track i{display:block;hei"
		+ "ght:100%;width:0;background:var(--pf-accent)}.card{display:-webkit-flex;display:flex;-webkit-flex-direction:"
		+ "column;flex-direction:column}.edge{position:absolute;left:0;top:14px;bottom:14px;width:2px;border-radius:2px"
		+ ";background:transparent}.card.state-run .edge{background:var(--pf-info)}.card.state-ok .edge{background:var("
		+ "--pf-ok)}.card.state-err .edge{background:var(--pf-bad)}.card.state-cancel .edge{background:var(--pf-warn)}."
		+ "c-top{margin-bottom:8px}.idx{font-family:Consolas,'Courier New',monospace;font-size:12px;color:var(--pf-acce"
		+ "nt);background:var(--pf-accent-bg);border-radius:5px;padding:0px 4px;margin-right:8px}.code{font-family:Cons"
		+ "olas,'Courier New',monospace;font-size:12px;color:var(--pf-fg-2);overflow:hidden;text-overflow:ellipsis;whit"
		+ "e-space:nowrap}.badge{margin-left:auto;font-size:12px;font-weight:650;border-radius:99px;padding:2px 8px;bac"
		+ "kground:var(--pf-raised);color:var(--pf-fg-2);white-space:nowrap}.badge.run{background:var(--pf-info-bg);col"
		+ "or:var(--pf-info)}.badge.ok{background:var(--pf-ok-bg);color:var(--pf-ok)}.badge.err{background:var(--pf-bad"
		+ "-bg);color:var(--pf-bad)}.badge.cancel{background:var(--pf-warn-bg);color:var(--pf-warn)}.card h3{margin:0 0"
		+ " 8px;font-size:18px;font-weight:640;letter-spacing:-.012em;line-height:1.35}.p{margin:0 0 6px;font-size:14px"
		+ ";line-height:1.55;color:var(--pf-fg-2)}.p b{color:var(--pf-fg-2);font-weight:600}.c-foot{margin-top:auto;pad"
		+ "ding-top:10px}.unit{font-family:Consolas,'Courier New',monospace;font-size:12px;color:var(--pf-fg-2);border:"
		+ "1px solid var(--pf-line);border-radius:5px;padding:0px 6px;white-space:nowrap}.c-foot .btn{margin-left:auto;"
		+ "padding:8px 14px;font-size:14px}.status{display:none;margin-top:8px;font-size:14px;color:var(--pf-fg-2)}.sta"
		+ "te-run .status,.state-ok .status,.state-err .status,.state-cancel .status{display:block}.state-run .status{c"
		+ "olor:var(--pf-info)}.result{display:none;margin:8px 0 0;font-size:14px;font-weight:600;line-height:1.5;paddi"
		+ "ng:6px 8px;border-radius:8px}.result.ok{display:block;color:var(--pf-ok);background:var(--pf-ok-bg)}.result."
		+ "err{display:block;color:var(--pf-bad);background:var(--pf-bad-bg)}.result.cancel{display:block;color:var(--p"
		+ "f-warn);background:var(--pf-warn-bg)}.cbar{position:absolute;left:0;right:0;bottom:0;height:2px;background:t"
		+ "ransparent}.cbar i{display:block;height:100%;width:0;background:var(--pf-accent)}.state-ok .cbar i{backgroun"
		+ "d:var(--pf-ok)}.state-err .cbar i{background:var(--pf-bad)}.state-cancel .cbar i{background:var(--pf-warn)}."
		+ "log-head{margin-bottom:10px}.log-head h2{margin:0;font-size:26px;font-weight:640;letter-spacing:-.01em}.log-"
		+ "head span{font-size:14px;color:var(--pf-fg-2);margin-left:10px}table{width:100%;border-collapse:collapse;fon"
		+ "t-size:14px}th,td{padding:8px 10px;text-align:left;border-bottom:1px solid var(--pf-line)}thead th{font-size"
		+ ":12px;letter-spacing:.1em;text-transform:uppercase;color:var(--pf-fg-2);font-weight:650}tbody tr:hover{backg"
		+ "round:var(--pf-raised)}td.n,th.n{text-align:right;white-space:nowrap;font-family:Consolas,'Courier New',mono"
		+ "space;font-size:14px}.empty{color:var(--pf-fg-2);font-size:14px;padding:10px 2px}.foot{margin-top:16px;font-"
		+ "size:14px;color:var(--pf-fg-2)}.scrim{position:fixed;left:0;top:0;right:0;bottom:0;background:rgba(6,7,10,.7"
		+ "2);z-index:90;padding-top:12vh}.pal{width:560px;max-width:92%;margin:0 auto;background:var(--pf-surface);bor"
		+ "der:1px solid var(--pf-line);border-radius:14px;overflow:hidden}.pal input{width:100%;box-sizing:border-box;"
		+ "border:0;background:transparent;color:var(--pf-fg);font:16px 'Segoe UI',Arial,sans-serif;padding:16px 16px;b"
		+ "order-bottom:1px solid var(--pf-line);outline:none}.pal ul{list-style:none;margin:0;padding:6px;max-height:4"
		+ "6vh;overflow:auto}.pal li{padding:8px 10px;border-radius:8px;font-size:14px;cursor:pointer;color:var(--pf-fg"
		+ "-2)}.pal li.sel{background:var(--pf-accent-bg);color:var(--pf-fg)}.pal .tip{font-size:12px;color:var(--pf-fg"
		+ "-2);padding:8px 16px;border-top:1px solid var(--pf-line)}.stat{position:fixed;left:0;right:0;bottom:0;backgr"
		+ "ound:var(--pf-surface);border-top:1px solid var(--pf-line);padding:8px 18px;font-size:14px;color:var(--pf-fg"
		+ "-2);z-index:30}.stat b{color:var(--pf-fg)}.xs{font-size:12px}.big-lg{font-size:26px}.big-md{font-size:26px}."
		+ "hidden{display:none}.side{position:fixed;left:0;top:0;bottom:0;width:220px;background:var(--pf-side-bg);colo"
		+ "r:var(--pf-side-fg);padding:16px 12px;box-sizing:border-box;z-index:50;overflow:auto;font:14px/18px 'Segoe U"
		+ "I',Arial,sans-serif}.side .logo{display:-webkit-flex;display:flex;-webkit-align-items:center;align-items:cen"
		+ "ter;padding:6px 8px 18px}.side .mark{width:28px;height:28px;border-radius:8px;margin-right:10px;background:v"
		+ "ar(--pf-accent)}.side .logo b{color:var(--pf-fg);font-size:14px;font-weight:650;display:block}.side .logo sp"
		+ "an{font-size:12px;color:var(--pf-fg-2);letter-spacing:.06em;text-transform:uppercase}.nav-label{font-size:12"
		+ "px;letter-spacing:.1em;text-transform:uppercase;color:var(--pf-fg-2);padding:12px 10px 6px}.side a{display:-"
		+ "webkit-flex;display:flex;-webkit-align-items:center;align-items:center;color:var(--pf-side-fg);text-decorati"
		+ "on:none;font-size:14px;line-height:20px;padding:8px 10px;border-radius:8px;margin-bottom:2px}.side a:hover{b"
		+ "ackground:var(--pf-hover);color:var(--pf-fg)}.side a.active{background:var(--pf-raised);color:var(--pf-accen"
		+ "t);box-shadow:inset 2px 0 0 var(--pf-accent)}.side-foot{margin-top:18px;border-top:1px solid var(--pf-sunken"
		+ ");padding:12px 10px 4px;font-size:12px;color:var(--pf-fg-2)}.side-foot .dot{width:6px;height:6px;border-radi"
		+ "us:50%;background:var(--pf-ok-line);display:inline-block;margin-right:6px}.nav-i svg{width:15px;height:15px;"
		+ "margin-right:9px;flex:0 0 15px;display:block;color:var(--pf-fg-2)}.nav-i:hover svg{color:var(--pf-side-fg)}."
		+ "nav-i.active svg{color:var(--pf-accent)}.nav-i .nm{overflow:hidden;text-overflow:ellipsis;white-space:nowrap"
		+ "}.side-stand{margin:6px 8px 0;padding:10px;border:1px solid var(--pf-line);border-radius:10px;background:var"
		+ "(--pf-sunken)}.ss-h{font-size:12px;color:var(--pf-fg-2);font-weight:600;margin-bottom:8px;overflow:hidden;te"
		+ "xt-overflow:ellipsis;white-space:nowrap}.ss-r{display:-webkit-flex;display:flex;justify-content:space-betwee"
		+ "n;gap:8px;font-size:12px;line-height:16px}.ss-r span{color:var(--pf-fg-2);text-transform:uppercase;letter-sp"
		+ "acing:.05em;flex:0 0 auto}.ss-r b{color:var(--pf-side-fg);font-weight:500;text-align:right;line-height:14px;"
		+ "word-wrap:break-word;overflow:hidden}body.pf-collapsed{padding-left:76px !important}body.pf-collapsed .side{"
		+ "width:60px !important;padding:16px 8px !important}body.pf-collapsed .nav-label, body.pf-collapsed .side .log"
		+ "o b, body.pf-collapsed .side .logo span, body.pf-collapsed .side-foot, body.pf-collapsed .side-stand{display"
		+ ":none !important}body.pf-collapsed .side .logo{-webkit-justify-content:center;justify-content:center;padding"
		+ ":6px 0 14px}body.pf-collapsed .side a{font-size:0 !important;padding:0 !important;width:34px;height:34px;mar"
		+ "gin:0 auto 6px;-webkit-justify-content:center;justify-content:center}body.pf-collapsed .side a .nm{display:n"
		+ "one !important}body.pf-collapsed .side a svg{width:17px;height:17px;margin:0 auto !important}.side a .dot-n{"
		+ "width:8px;height:8px;border-radius:50%;background:var(--pf-fg-3);display:inline-block;margin-right:9px}body."
		+ "pf-collapsed .side a .dot-n{display:none}.side a.active .dot-n{background:var(--pf-accent)}.nav-btn{position"
		+ ":absolute;top:12px;right:-12px;width:24px;height:24px;border-radius:50%;background:var(--pf-raised);color:va"
		+ "r(--pf-side-fg);border:1px solid var(--pf-line);cursor:pointer;font:600 12px 'Segoe UI',Arial,sans-serif;pad"
		+ "ding:0;z-index:51}.nav-btn:hover{background:var(--pf-hover);color:var(--pf-fg)}.card:hover{border-color:var("
		+ "--pf-line-strong);background:var(--pf-hover)}.btn:active:not(:disabled){transform:translateY(1px)}tbody tr{-"
		+ "webkit-transition:background .12s;transition:background .12s}0%,100%{opacity:1}50%{opacity:.45}0%,100%{opaci"
		+ "ty:1}.brand .pulse{-webkit-animation:pfPulse 2.4s infinite;animation:pfPulse 2.4s infinite}0%{box-shadow:0 0"
		+ " 0 0 rgba(196,242,82,.35)}70%{box-shadow:0 0 0 8px rgba(196,242,82,0)}100%{box-shadow:0 0 0 0 rgba(196,242,8"
		+ "2,0)}0%{box-shadow:0 0 0 0 rgba(196,242,82,.35)}.state-run .idx{-webkit-animation:pfGlow 1.8s infinite;anima"
		+ "tion:pfGlow 1.8s infinite}"
		+ "</style>";
КонецФункции

// Полная страница: заголовок вкладки и готовое тело.
Функция Страница(Заголовок, Тело) Экспорт
	Возврат "<!DOCTYPE html><html><head><meta charset='utf-8'><title>"
		+ Экранировать(Заголовок) + "</title>" + Стили() + "</head><body>"
		+ Тело + "</body></html>";
КонецФункции

// Плитка KPI: подпись, крупное число, единица, пояснение, опциональная полоса.
Функция Плитка(Подпись, Значение, Единица, Пояснение, Идентификатор = "") Экспорт
	Возврат "<section class='tile span-3'><div class='lbl'>" + Экранировать(Подпись) + "</div>"
		+ "<div class='big'><span id='" + Идентификатор + "'>" + Экранировать(Значение) + "</span>"
		+ "<small> " + Экранировать(Единица) + "</small></div>"
		+ "<div class='sub'>" + Экранировать(Пояснение) + "</div></section>";
КонецФункции

// Бейдж состояния: ok / err / "" (нейтральный).
Функция Бейдж(Текст, Состояние = "") Экспорт
	Возврат "<span class='badge " + Состояние + "'>" + Экранировать(Текст) + "</span>";
КонецФункции

// Таблица с заголовками: Заголовки - массив, Строки - массив массивов HTML,
// Право - массив индексов числовых колонок (выравнивание вправо, моно-шрифт).
Функция Таблица(Заголовки, Строки, Право = Неопределено) Экспорт
	Если Право = Неопределено Тогда
		Право = Новый Массив;
	КонецЕсли;
	Части = Новый Массив;
	Части.Добавить("<table><thead><tr>");
	Для Индекс = 0 По Заголовки.Количество() - 1 Цикл
		Класс = ?(Право.Найти(Индекс) = Неопределено, "", " class='n'");
		Части.Добавить("<th" + Класс + ">" + Экранировать(Заголовки[Индекс]) + "</th>");
	КонецЦикла;
	Части.Добавить("</tr></thead><tbody>");
	Если Строки.Количество() = 0 Тогда
		Части.Добавить("<tr><td colspan='" + Заголовки.Количество()
			+ "' class='empty'>данных нет</td></tr>");
	Иначе
		Для Каждого Строка Из Строки Цикл
			Части.Добавить("<tr>");
			Для Индекс = 0 По Строка.Количество() - 1 Цикл
				Класс = ?(Право.Найти(Индекс) = Неопределено, "", " class='n'");
				Части.Добавить("<td" + Класс + ">" + Строка(Строка[Индекс]) + "</td>");
			КонецЦикла;
			Части.Добавить("</tr>");
		КонецЦикла;
	КонецЕсли;
	Части.Добавить("</tbody></table>");
	Возврат СтрСоединить(Части, "");
КонецФункции

// Экранирование текста для HTML.
Функция Экранировать(Значение) Экспорт
	Результат = СтрЗаменить(Строка(Значение), "&", "&amp;");
	Результат = СтрЗаменить(Результат, "<", "&lt;");
	Результат = СтрЗаменить(Результат, ">", "&gt;");
	Возврат СтрЗаменить(Результат, """", "&quot;");
КонецФункции

// ---------------------------------------------------------------------------
// Блок: темы. Тёмная - базовая (Стили), светлая - переопределение поверх неё.
// Переключение: PFTheme.toggle(). Состояние хранится в константе ПерфТемаСветлая.
// ---------------------------------------------------------------------------

// Светлая тема по референсу index-v5: поверхности #FBF8FF/#FFFFFF, акцент #6A4CF6.
// Правила светлой темы без обрамляющих тегов: их вставляет Документ в <style media=...>.
Функция ПравилаСветлой() Экспорт

	Текст = СтилиСветлая();
	Текст = СтрЗаменить(Текст, "<style>", "");
	Текст = СтрЗаменить(Текст, "</style>", "");
	Возврат Текст;

КонецФункции

Функция СтилиСветлая() Экспорт
	// Светлая тема - это переопределение токенов. Правил оставлено минимум:
	// только там, где меняется не цвет, а контраст (акцент, панель, фон).
	Возврат "<style>"
		+ "html{--pf-bg:#FBF8FF;--pf-sunken:#F7F3FF;--pf-surface:#FFFFFF;--pf-raised:#F3EEFC;--pf-line:#E6E1F0;--pf-lin"
		+ "e-strong:#9C8AC6;--pf-fg:#1B1A21;--pf-fg-2:#45424F;--pf-fg-3:#6B6879;--pf-accent:#6A4CF6;--pf-accent-bg:#EDE"
		+ "8FF;--pf-on-accent:#FFFFFF;--pf-ok:#0F7A4F;--pf-ok-bg:#E2F5EC;--pf-ok-line:#0F7A4F;--pf-warn:#8A5A00;--pf-wa"
		+ "rn-bg:#FDF3E0;--pf-bad:#B3261E;--pf-bad-bg:#FBE6E5;--pf-bad-line:#F0C9C5;--pf-info:#1F5FA8;--pf-info-bg:#E3E"
		+ "FFC;--pf-hover:#F6F2FF;--pf-side-bg:#FFFFFF;--pf-side-fg:#3A3A45}html,body{background-image:none}.side a.act"
		+ "ive{background:var(--pf-accent-bg);color:var(--pf-accent);box-shadow:inset 2px 0 0 var(--pf-accent)}.side a:"
		+ "hover{background:var(--pf-hover)}.btn.primary,.btn.primary:hover:not(:disabled){background:var(--pf-accent);"
		+ "color:var(--pf-on-accent)}.brand .pulse{background:var(--pf-accent);box-shadow:0 0 0 4px var(--pf-accent-bg)"
		+ "}.idx{color:var(--pf-accent);background:var(--pf-accent-bg)}.track{background:var(--pf-raised)}.track i{back"
		+ "ground:var(--pf-accent)}"
		+ "</style>";
КонецФункции

// Скрипт темы: применяет сохранённое состояние и переключает по кнопке.




// Текущая тема приложения: "light" или "dark" (по умолчанию тёмная, как стиль 1С).


// Сохраняет выбор темы (команда theme:<имя> от кнопки на странице).


// Скрипт темы: применяет светлую или тёмную и (опционально) создаёт кнопку.
// Тема выбирается сама, без участия пользователя: сохранённый выбор приложения,
// иначе системная тема (prefers-color-scheme), иначе тёмная.
// ПоказыватьКнопку = Ложь - страница без переключателя (карточка стенда).
// Настройки интерфейса хранятся в константах: значение живет в базе, поэтому
// переживает и переход между формами, и перезапуск, и смену рабочего места.


// Читает настройки оформления одним запросом и возвращает снимок.
// Читаются обе константы сразу: страница обращается к настройкам несколько раз
// (тема каркаса, подпись кнопки, состояние панели), и повторные запросы не нужны.
// Значения берутся из таблицы, а не из менеджера констант: он кэширует значение
// в сеансе и не видит правку, сделанную снаружи.
Функция ПрочитатьНастройки() Экспорт

	Настройки = Новый Структура("Тема, Панель, Свернута, Версия", "dark", "expanded", Ложь, "dark|expanded");
	Попытка
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	Т.ПерфТемаСветлая КАК ТемаСветлая,
			|	П.ПерфПанельСвернута КАК ПанельСвернута
			|ИЗ
			|	Константа.ПерфТемаСветлая КАК Т,
			|	Константа.ПерфПанельСвернута КАК П";
		Результат = Запрос.Выполнить();
		Выборка = Результат.Выбрать();
		Если Выборка.Следующий() Тогда
			Настройки.Тема = ?(Выборка.ТемаСветлая, "light", "dark");
			Настройки.Свернута = Выборка.ПанельСвернута;
			Настройки.Панель = ?(Настройки.Свернута, "collapsed", "expanded");
		КонецЕсли;
	Исключение
		// База без констант оформления (старая выгрузка) - работаем на значениях по умолчанию.
		СведенияОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;
	Настройки.Версия = Настройки.Тема + "|" + Настройки.Панель;
	Возврат Настройки;

КонецФункции

// Слепок настроек: форма сравнивает его при активации окна.
Функция ВерсияНастроек() Экспорт

	Возврат ПрочитатьНастройки().Версия;

КонецФункции

// Приводит переданную структуру к полному виду (Тема, Панель, Свернута, Версия).
// Нужна, когда настройки пришли параметром формы, а поля заполнены не все.
Функция ДополнитьНастройки(Настройки) Экспорт

	Если Настройки = Неопределено Тогда
		Возврат ПрочитатьНастройки();
	КонецЕсли;
	Если ТипЗнч(Настройки) <> Тип("Структура") Тогда
		Возврат ПрочитатьНастройки();
	КонецЕсли;

	Результат = Новый Структура("Тема, Панель, Свернута, Версия", "dark", "expanded", Ложь, "");
	Если Настройки.Свойство("Тема") И (Настройки.Тема = "light" ИЛИ Настройки.Тема = "dark") Тогда
		Результат.Тема = Настройки.Тема;
	КонецЕсли;
	Если Настройки.Свойство("Панель") И (Настройки.Панель = "collapsed" ИЛИ Настройки.Панель = "expanded") Тогда
		Результат.Панель = Настройки.Панель;
	КонецЕсли;
	Результат.Свернута = (Результат.Панель = "collapsed");
	Результат.Версия = Результат.Тема + "|" + Результат.Панель;
	Возврат Результат;

КонецФункции

// Текущая тема приложения: "light" или "dark" (по умолчанию тёмная, как стиль 1С).


// Сохраняет выбор темы (команда theme:<имя> от кнопки на странице).


// Скрипт темы: применяет светлую или тёмную и (опционально) создаёт кнопку.
// Тема выбирается сама, без участия пользователя: сохранённый выбор приложения,
// иначе системная тема (prefers-color-scheme), иначе тёмная.
// ПоказыватьКнопку = Ложь - страница без переключателя (карточка стенда).
// Настройки интерфейса хранятся в константах: значение живет в базе, поэтому
// переживает и переход между формами, и перезапуск, и смену рабочего места.

// Текущая тема приложения: "light" или "dark" (по умолчанию тёмная, как стиль 1С).
Функция ТемаПриложения() Экспорт

	Возврат ПрочитатьНастройки().Тема;

КонецФункции

// Сохраняет выбор темы (команда theme:<имя> от кнопки на странице).
Процедура СохранитьТемуПриложения(Тема) Экспорт

	Если Тема <> "light" И Тема <> "dark" Тогда
		Возврат;
	КонецЕсли;
	Попытка
		Константы.ПерфТемаСветлая.Установить(Тема = "light");
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

// Состояние панели: "collapsed" или "expanded" (по умолчанию развернута).
Функция СостояниеПанели() Экспорт

	Возврат ПрочитатьНастройки().Панель;

КонецФункции

Процедура СохранитьСостояниеПанели(Значение) Экспорт

	Если Значение <> "collapsed" И Значение <> "expanded" Тогда
		Возврат;
	КонецЕсли;
	Попытка
		Константы.ПерфПанельСвернута.Установить(Значение = "collapsed");
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

Функция СкриптТемы(НачальнаяТема = "dark") Экспорт

	// Тема полностью определяется сервером: класс на <html> и media у <style id='pfLight'>
	// выставлены в разметке. Скрипт только переключает их по кнопке (она есть на кокпите)
	// и сообщает выбор в 1С.
	Возврат "<scr" + "ipt>"
		+ "var PFTheme={"
		+ "current:function(){try{return document.documentElement.classList.contains('pf-light')"
		+ "?'light':'dark';}catch(e){return 'dark';}},"
		+ "apply:function(name){var on=(name==='light');"
		+ "try{var h=document.documentElement;"
		+ "h.classList.toggle('pf-light',on);h.classList.toggle('pf-dark',!on);}catch(e){}"
		+ "var st=document.getElementById('pfLight');"
		+ "if(st){st.media=on?'all':'not all';}"
		+ "var b=document.getElementById('pfThemeBtn');"
		+ "if(b){b.innerHTML=on?'Тёмная тема':'Светлая тема';}},"
		+ "toggle:function(){var next=(PFTheme.current()==='light')?'dark':'light';"
		+ "PFTheme.apply(next);"
		+ "try{if(window.PF1C&&PF1C.send){PF1C.send('theme:'+next);}}catch(e){}"
		+ "return false;}};"
		+ "window.PFTheme=PFTheme;"
		+ "function PFThemeToggle(b){return PFTheme.toggle();}"
		+ "window.PFThemeToggle=PFThemeToggle;"
		+ "PFTheme.apply(PFTheme.current());"
		+ "</scr" + "ipt>";

КонецФункции

// ---------------------------------------------------------------------------
// Блок: боковое меню навигации (референс index-v2: тёмный рейл, активный пункт
// с лаймовой полосой). Ссылки шлют команды open:<ИмяФормы> через мост PF1C.
// ---------------------------------------------------------------------------

// Реестр пунктов боковой панели: единственное место, где перечислены разделы.
// Порядок в массиве = порядок в меню. Новая страница добавляется здесь, и она
// сразу появляется на всех страницах, потому что меню рисует один общий метод.
Функция ПунктыМеню() Экспорт

	Пункты = Новый Массив;
	Пункты.Добавить(ПунктМеню("НачальнаяСтраница", "Кокпит", "мониторинг", "grid"));
	Пункты.Добавить(ПунктМеню("ПерфДашборд", "Дашборд", "мониторинг", "list"));
	Пункты.Добавить(ПунктМеню("ПерфСтенды", "Стенды", "данные", "monitor"));
	Пункты.Добавить(ПунктМеню("ПерфТопКонфигураций", "Топ-100", "данные", "bars"));
	Пункты.Добавить(ПунктМеню("ПерфСравнениеСтендов", "Сравнение стендов", "данные", "columns"));
	Пункты.Добавить(ПунктМеню("ПерфИсторияЗамеров", "История замеров", "данные", "clock"));
	Возврат Пункты;

КонецФункции

Функция ПунктМеню(Форма, Подпись, Группа, Иконка)

	Возврат Новый Структура("Форма, Подпись, Группа, Иконка", Форма, Подпись, Группа, Иконка);

КонецФункции

// Единый каркас страницы: DOCTYPE, head с общими стилями, боковая панель,
// контент и скрипты. Все страницы (кокпит, отчёты, карточка стенда) обязаны
// собираться только здесь - тогда меню, тема и шапка меняются в одном месте.
//
//   Активный                   - имя формы для подсветки пункта меню
//   Заголовок                  - title документа
//   Тело                       - HTML контента
//   ДопСтили                   - CSS конкретной страницы (кокпит, карточка)
//   ПоказыватьПереключательТемы - Ложь: страница без кнопки темы (карточка стенда)
//   КлассОбёртки               - обёртка контента ("wrap" у кокпита); пусто - без неё
//   ВерсияСтрокой              - подпись версии в шапке панели
//   НачальнаяТема              - "light"/"dark"; пусто - взять сохранённую тему приложения
Функция Документ(Активный, Заголовок, Тело, ДопСтили = "",
	ПоказыватьПереключательТемы = Ложь, КлассОбёртки = "", ВерсияСтрокой = "",
	НачальнаяТема = "", Настройки = Неопределено) Экспорт

	// Настройки приходят снимком: при переходе по меню их прочитал обработчик
	// клика и передал в параметрах формы, поэтому страница не делает запросов.
	// Если снимка нет (прямой запуск формы), он читается здесь - один раз.
	Снимок = ДополнитьНастройки(Настройки);
	// Тема известна серверу (выбор кнопки сохраняется в 1С), поэтому класс
	// ставится сразу в разметке: поле HTML не зависит от выполнения JS.
	Тема = ?(ПустаяСтрока(НачальнаяТема), Снимок.Тема, НачальнаяТема);
	КлассТемы = ?(Тема = "light", "pf-light", "pf-dark");
	Части = Новый Массив;
	Части.Добавить("<!DOCTYPE html><html class='" + КлассТемы + "'><head><meta charset='utf-8'>");
	Части.Добавить("<meta name='viewport' content='width=device-width, initial-scale=1'>");
	Части.Добавить("<title>" + Экранировать(Заголовок) + "</title>");
	// Порядок важен: стили страницы идут до панели, поэтому фон, шрифт или
	// отступы конкретной страницы не могут изменить ее внешний вид.
	Части.Добавить(Стили());
	Части.Добавить(ДопСтили);
	// Светлые правила идут последними: слои выше задают тёмные значения для
	// наведения, нажатия и полос, и при равной специфичности побеждает последний.
	// Вставляются всегда, включаются только при теме light: media выставляет
	// сервер, поэтому страница правильная еще до выполнения JS.
	Части.Добавить("<style id='pfLight' media='" + ?(Тема = "light", "all", "not all") + "'>");
	Части.Добавить(ПравилаСветлой());
	Части.Добавить("</style>");
	Части.Добавить(СкриптМоста());
	КлассПанели = ?(Снимок.Свернута, " class='pf-collapsed'", "");
	Части.Добавить("</head><body" + КлассПанели + ">");
	Части.Добавить(Меню(Активный, ВерсияСтрокой));
	Если НЕ ПустаяСтрока(КлассОбёртки) Тогда
		Части.Добавить("<div class='" + КлассОбёртки + "'>");
	КонецЕсли;
	Части.Добавить(Тело);
	Если НЕ ПустаяСтрока(КлассОбёртки) Тогда
		Части.Добавить("</div>");
	КонецЕсли;
	Части.Добавить(СкриптМеню());
	Части.Добавить(СкриптСворачивания());
	Части.Добавить(СкриптТемы(Тема));
	Части.Добавить("</body></html>");
	Возврат СтрСоединить(Части, "");

КонецФункции

// Рейл навигации. Активный - имя открытой формы.
// Иконки - встроенный SVG: движок HTML-поля рисует его без внешних файлов,
// а цвет берется из currentColor, поэтому тема применяется автоматически.
Функция Меню(Активный = "", ВерсияСтрокой = "") Экспорт

	Пункты = ПунктыМеню();
	// Подпись всегда одна и та же: версия конфигурации из метаданных.
	// Параметр ВерсияСтрокой оставлен для совместимости вызовов и не используется.
	ПодписьВерсии = "версия " + СокрЛП(Строка(Метаданные.Версия));

	Части = Новый Массив;
	Части.Добавить("<nav class='side' id='pfSide'>"
		+ "<div class='logo'><span class='mark'></span>"
		+ "<div class='logo-t'><b>ПерфТест</b><span>" + Экранировать(ПодписьВерсии) + "</span></div></div>");

	ТекущаяГруппа = "";
	Для Каждого Пункт Из Пункты Цикл
		Если Пункт.Группа <> ТекущаяГруппа Тогда
			ТекущаяГруппа = Пункт.Группа;
			Части.Добавить("<div class='nav-label'>" + Экранировать(ТекущаяГруппа) + "</div>");
		КонецЕсли;
		Класс = ?(Пункт.Форма = Активный, " active", "");
		Части.Добавить("<a class='nav-i" + Класс + "' href='#' title='"
			+ Экранировать(Пункт.Подпись) + "' onclick='PFNav.go("""
			+ Пункт.Форма + """);return false'>"
			+ Иконка(Пункт.Иконка)
			+ "<span class='nm'>" + Экранировать(Пункт.Подпись) + "</span></a>");
	КонецЦикла;

	Части.Добавить(БлокСтенда());
	Части.Добавить("<div class='side-foot'><div><span class='dot'></span>готов к работе</div>"
		+ "<div>1c\\perf-test</div></div></nav>");
	Возврат СтрСоединить(Части, "");

КонецФункции

// Иконка пункта меню. Контур 16x16, цвет наследуется от ссылки (currentColor).
Функция Иконка(Ключ) Экспорт

	Начало = "<svg viewBox='0 0 16 16' fill='none' stroke='currentColor' stroke-width='1.5'"
		+ " stroke-linecap='round' stroke-linejoin='round'>";
	Конец = "</svg>";

	Если Ключ = "grid" Тогда
		Фигура = "<rect x='1.8' y='1.8' width='5.2' height='5.2' rx='1.2'/>"
			+ "<rect x='9' y='1.8' width='5.2' height='5.2' rx='1.2'/>"
			+ "<rect x='1.8' y='9' width='5.2' height='5.2' rx='1.2'/>"
			+ "<rect x='9' y='9' width='5.2' height='5.2' rx='1.2'/>";
	ИначеЕсли Ключ = "list" Тогда
		Фигура = "<path d='M2 4h12M2 8h12M2 12h8'/>";
	ИначеЕсли Ключ = "monitor" Тогда
		Фигура = "<rect x='1.8' y='3' width='12.4' height='8' rx='1.4'/>"
			+ "<path d='M6 13.4h4'/>";
	ИначеЕсли Ключ = "bars" Тогда
		Фигура = "<path d='M3.2 13V8.4M8 13V3.6M12.8 13v-3'/>";
	ИначеЕсли Ключ = "columns" Тогда
		Фигура = "<rect x='2' y='4' width='4.4' height='9' rx='1'/>"
			+ "<rect x='9.6' y='7' width='4.4' height='6' rx='1'/>";
	ИначеЕсли Ключ = "clock" Тогда
		Фигура = "<circle cx='8' cy='8' r='6'/><path d='M8 5v3.4l2.4 1.4'/>";
	Иначе
		Фигура = "<circle cx='8' cy='8' r='5.6'/>";
	КонецЕсли;

	Возврат Начало + Фигура + Конец;

КонецФункции

// Блок «стенд» в панели: платформа, ОС, режим ИБ, клиент, адрес базы, железо.
// Источники: паспорт последнего стенда (регистр ПерфСтенды) и системная
// информация сервера. Любая ошибка сбора не ломает страницу - строка пустая.
Функция БлокСтенда() Экспорт

	С = СведенияОСтенде();
	Строки = Новый Массив;
	ДобавитьСтрокуСтенда(Строки, "платформа", С.Платформа);
	ДобавитьСтрокуСтенда(Строки, "ОС", С.ОС);
	ДобавитьСтрокуСтенда(Строки, "режим", С.Режим);
	ДобавитьСтрокуСтенда(Строки, "клиент", С.Клиент);
	ДобавитьСтрокуСтенда(Строки, "база", С.База);
	ДобавитьСтрокуСтенда(Строки, "CPU", С.ЦПУ);
	ДобавитьСтрокуСтенда(Строки, "память", С.Память);

	Возврат "<div class='nav-label'>стенд</div><div class='side-stand'>"
		+ "<div class='ss-h' title='" + Экранировать(С.Имя) + "'>"
		+ Экранировать(?(ПустаяСтрока(С.Имя), "стенд не собран", С.Имя)) + "</div>"
		+ СтрСоединить(Строки, "") + "</div>";

КонецФункции

Процедура ДобавитьСтрокуСтенда(Строки, Подпись, Значение)

	Если ПустаяСтрока(Значение) Тогда
		Возврат;
	КонецЕсли;
	Строки.Добавить("<div class='ss-r'><span>" + Экранировать(Подпись) + "</span><b title='"
		+ Экранировать(Значение) + "'>" + Экранировать(Значение) + "</b></div>");

КонецПроцедуры

// Сведения о текущем стенде. Все значения - короткие строки для панели.
Функция СведенияОСтенде() Экспорт

	С = Новый Структура("Имя, Платформа, ОС, Режим, Клиент, База, ЦПУ, Память",
		"", "", "", "", "", "", "", "");

	Попытка
		Запрос = Новый Запрос(
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	Т.Стенд КАК Стенд,
			|	Т.ВерсияПлатформыСервер КАК Платформа,
			|	Т.СерверОС КАК ОС,
			|	Т.РежимИБ КАК РежимИБ,
			|	Т.РежимКлиента КАК Клиент,
			|	Т.СерверЦПУ КАК ЦПУ,
			|	Т.СерверПамятьМб КАК ПамятьМб,
			|	Т.СерверЯдер КАК Ядер
			|ИЗ
			|	РегистрСведений.ПерфСтенды КАК Т
			|УПОРЯДОЧИТЬ ПО
			|	Т.ДатаПаспорта УБЫВ");
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			С.Имя = КороткоеИмя(СокрЛП(Выборка.Стенд), " / ");
			С.Платформа = СокрЛП(Выборка.Платформа);
			С.ОС = КороткоеИмяОС(СокрЛП(Выборка.ОС));
			С.Режим = СокрЛП(Выборка.РежимИБ);
			С.Клиент = КороткийКлиент(СокрЛП(Выборка.Клиент));
			// Только модель процессора: число ядер есть в паспорте и карточке стенда.
			С.ЦПУ = КороткоеИмяЦПУ(СокрЛП(Выборка.ЦПУ));
			Если Выборка.ПамятьМб > 0 Тогда
				С.Память = Формат(Окр(Выборка.ПамятьМб / 1024, 0), "ЧГ=0") + " ГБ";
			КонецЕсли;
		КонецЕсли;
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

	Попытка
		СИ = Новый СистемнаяИнформация;
		Если ПустаяСтрока(С.Платформа) Тогда
			С.Платформа = СокрЛП(СИ.ВерсияПриложения);
		КонецЕсли;
		Если ПустаяСтрока(С.Память) Тогда
			С.Память = ПамятьСтрокой(СИ.ОперативнаяПамять);
		КонецЕсли;
		Если ПустаяСтрока(С.ЦПУ) Тогда
			С.ЦПУ = КороткоеИмяЦПУ(СокрЛП(СИ.Процессор));
		КонецЕсли;
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

	Если ПустаяСтрока(С.Режим) Тогда
		Попытка
			С.Режим = ПерфСценарии.ВариантРазвёртывания();
		Исключение
			ИгнорируемаяОшибка = ИнформацияОбОшибке();
		КонецПопытки;
	КонецЕсли;

	Попытка
		С.База = АдресБазыИзСтроки(СтрокаСоединенияИнформационнойБазы());
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

	Если ПустаяСтрока(С.Клиент) Тогда
		Попытка
			Если Не ПустаяСтрока(СокрЛП(СИ.ИнформацияПрограммыПросмотра)) Тогда
				С.Клиент = "веб-клиент";
			КонецЕсли;
		Исключение
			ИгнорируемаяОшибка = ИнформацияОбОшибке();
		КонецПопытки;
	КонецЕсли;

	Возврат С;

КонецФункции

// Адрес базы из строки соединения: путь файловой ИБ или сервер/имя.
Функция АдресБазыИзСтроки(Строка)

	Стр = СокрЛП(Строка);
	Если ПустаяСтрока(Стр) Тогда
		Возврат "";
	КонецЕсли;

	Поз = СтрНайти(ВРег(Стр), "FILE=""");
	Если Поз > 0 Тогда
		Начало = Поз + СтрДлина("FILE=""");
		Конец = СтрНайти(Стр, """", , Начало);
		Если Конец = 0 Тогда
			Возврат Сред(Стр, Начало);
		КонецЕсли;
		Возврат Сред(Стр, Начало, Конец - Начало);
	КонецЕсли;

	Сервер = "";
	Имя = "";
	Поз = СтрНайти(ВРег(Стр), "SRVR=""");
	Если Поз > 0 Тогда
		Начало = Поз + СтрДлина("SRVR=""");
		Конец = СтрНайти(Стр, """", , Начало);
		Если Конец > 0 Тогда
			Сервер = Сред(Стр, Начало, Конец - Начало);
		КонецЕсли;
	КонецЕсли;
	Поз = СтрНайти(ВРег(Стр), "REF=""");
	Если Поз > 0 Тогда
		Начало = Поз + СтрДлина("REF=""");
		Конец = СтрНайти(Стр, """", , Начало);
		Если Конец > 0 Тогда
			Имя = Сред(Стр, Начало, Конец - Начало);
		КонецЕсли;
	КонецЕсли;

	Если Не ПустаяСтрока(Сервер) И Не ПустаяСтрока(Имя) Тогда
		Возврат Сервер + " / " + Имя;
	КонецЕсли;
	Возврат ?(ПустаяСтрока(Сервер), Имя, Сервер);

КонецФункции

// Первый сегмент строки до разделителя: «Комп / 8.3.27 / файловая» -> «Комп».
Функция КороткоеИмя(Значение, Разделитель)

	Позиция = СтрНайти(Значение, Разделитель);
	Если Позиция > 0 Тогда
		Возврат СокрЛП(Лев(Значение, Позиция - 1));
	КонецЕсли;
	Возврат СокрЛП(Значение);

КонецФункции

// ОС без служебного хвоста: «Майкрософт Windows 11 Pro v10.0.26300 build 26300» -> «Windows 11 Pro».
Функция КороткоеИмяОС(Значение)

	Текст = СтрЗаменить(Значение, "Майкрософт ", "");
	Текст = СтрЗаменить(Текст, "Microsoft ", "");
	Для Каждого Маркер Из СтрРазделить(" v1, v10, version, (", ",") Цикл
		Позиция = СтрНайти(НРег(Текст), НРег(Маркер));
		Если Позиция > 0 Тогда
			Текст = Лев(Текст, Позиция - 1);
		КонецЕсли;
	КонецЦикла;
	Возврат Лев(СокрЛП(Текст), 24);

КонецФункции

// Режим клиента кратко: толстый, тонкий, веб.
Функция КороткийКлиент(Значение)

	Текст = НРег(Значение);
	Если СтрНайти(Текст, "веб") > 0 Тогда
		Возврат "веб";
	ИначеЕсли СтрНайти(Текст, "тонк") > 0 Тогда
		Возврат "тонкий";
	ИначеЕсли СтрНайти(Текст, "толст") > 0 Тогда
		Возврат "толстый";
	КонецЕсли;
	Возврат Лев(СокрЛП(Значение), 16);

КонецФункции

// Модель процессора без служебных обозначений:
// «Intel (R) Xeon(R) CPU E5-2696 v4 @ 2.20GHz» -> «Xeon E5-2696 v4».
Функция КороткоеИмяЦПУ(Значение)

	Текст = Значение;
	// Частоту отрезаем до замен: иначе символ «@» уже превратится в пробел.
	Позиция = СтрНайти(Текст, "@");
	Если Позиция > 0 Тогда
		Текст = Лев(Текст, Позиция - 1);
	КонецЕсли;
	Для Каждого Маркер Из СтрРазделить("(R),(TM),Intel (R),Intel(R),Intel,CPU,Processor", ",") Цикл
		Текст = СтрЗаменить(Текст, Маркер, " ");
	КонецЦикла;
	Пока СтрНайти(Текст, "  ") > 0 Цикл
		Текст = СтрЗаменить(Текст, "  ", " ");
	КонецЦикла;
	Возврат Лев(СокрЛП(Текст), 26);

КонецФункции

// Объем памяти: системная информация отдает число байт, паспорт - мегабайты.
Функция ПамятьСтрокой(Значение)

	Если ТипЗнч(Значение) = Тип("Число") Тогда
		Если Значение > 1048576 Тогда
			Возврат Формат(Окр(Значение / 1073741824, 0), "ЧГ=0") + " ГБ";
		КонецЕсли;
		Возврат Формат(Значение, "ЧГ=0") + " ГБ";
	КонецЕсли;

	Текст = СокрЛП(Строка(Значение));
	Возврат Лев(Текст, 16);

КонецФункции

// Скрипт навигации: пересылает выбор пункта в 1С.
Функция СкриптМеню() Экспорт
	Возврат "<scr" + "ipt>"
		+ "var PFNav={go:function(name){"
		+ ""
		+ "if(window.PF1C&&PF1C.send){PF1C.send('open:'+name);return;}"
		+ "if(window.parent&&window.parent.PF1C){window.parent.PF1C.send('open:'+name);}}};"
		+ "window.PFNav=PFNav;"
		+ "</scr" + "ipt>";
КонецФункции

// ---------------------------------------------------------------------------
// Блок: сворачивание бокового меню (как в панелях управления).
// Состояние хранится в константе ПерфПанельСвернута.
// ---------------------------------------------------------------------------



// "collapsed" или "expanded". По умолчанию панель развернута.




Функция СкриптСворачивания() Экспорт
	Возврат "<scr" + "ipt>"
		+ "var PFNav=window.PFNav||{};"
		+ "PFNav.on=function(){return document.body.classList.contains('pf-collapsed');};"
		+ "PFNav.apply=function(){var b=document.getElementById('pfNavBtn');"
		+ "if(b){b.innerHTML=PFNav.on()?'>':'<';}};"
		+ "PFNav.toggle=function(){var on=PFNav.on();"
		+ "document.body.classList.toggle('pf-collapsed',!on);"
		+ "try{if(window.PF1C&&PF1C.send){PF1C.send('nav:'+(on?'expanded':'collapsed'));}}"
		+ "catch(e){}"
		+ "PFNav.apply();return false;};"
		+ "PFNav.init=function(){"
		+ "var on=document.body.classList.contains('pf-collapsed');"
		+ "var side=document.getElementById('pfSide')||document.querySelector('.side');"
		+ "if(side&&!document.getElementById('pfNavBtn')){"
		+ "var b=document.createElement('button');b.id='pfNavBtn';b.className='nav-btn';"
		+ "b.onclick=PFNav.toggle;side.appendChild(b);}"
		+ "PFNav.apply();};"
		+ "window.PFNav=PFNav;PFNav.init();"
		+ "</scr" + "ipt>";
КонецФункции

// Минимальный мост для отчётов: очередь команд, читаемая таймером формы.
Функция СкриптМоста() Экспорт
	Возврат "<scr" + "ipt>" + "if(!window.PF1C){window.PF1C={q:[],"
		+ "send:function(c){this.q.push(c);},"
		+ "take:function(){if(!this.q.length){return '';}var s=this.q.join('|');"
		+ "this.q=[];return s;},"
		+ "clear:function(){this.q.length=0;}};}"
		+ "</scr" + "ipt>";
КонецФункции

// ---------------------------------------------------------------------------
// Блок: динамика. Переходы и мягкие анимации из референса (index-v3):
// hover карточек, нажатие кнопок, плавные полосы прогресса, пульс статуса.
// Движок HTML-поля поддерживает transition и keyframes; при их отсутствии
// вид деградирует до статичного, ничего не ломая.
// ---------------------------------------------------------------------------

