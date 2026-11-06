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

// Палитра и базовая типографика. Возвращает содержимое тега style.
Функция Стили() Экспорт
	Возврат "<style>"
		+ "html,body{margin:0;height:100%;background:#0E0F13;color:#ECEEF3;"
		+ "font:16px/1.55 'Segoe UI',Arial,sans-serif;"
		+ "background-image:radial-gradient(90% 60% at 15% -10%,rgba(58,72,110,.45),rgba(14,15,19,0)),"
		+ "radial-gradient(70% 50% at 90% 0%,rgba(48,84,58,.28),rgba(14,15,19,0));"
		+ "background-repeat:no-repeat}"
		+ ".wrap{max-width:100%;margin:0 auto;padding:14px 18px 70px}"
		+ ".bar{position:-webkit-sticky;top:0;z-index:40;background:#1A1D24;"
		+ "border:1px solid #26292F;border-radius:16px;padding:9px 12px;margin-bottom:14px}"
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
		+ ".field input:focus{border-color:#C4F252}"
		+ ".btn{font:600 14px 'Segoe UI',Arial,sans-serif;border-radius:9px;cursor:pointer;"
		+ "padding:6px 12px;border:1px solid #2F333A;background:#1F2228;color:#ECEEF3;margin-left:8px}"
		+ ".btn:hover:not(:disabled){background:#282B33;border-color:#424853}"
		+ ".btn:disabled{opacity:.4;cursor:default}"
		+ ".btn.primary{background:#C4F252;color:#111900;border-color:transparent}"
		+ ".btn.primary:hover:not(:disabled){background:#D1FF61}"
		+ ".btn.danger{color:#FF7E70;border-color:#5A3A37}"
		+ ".bento{display:grid;grid-template-columns:repeat(12,minmax(0,1fr));grid-column-gap:12px}"
		+ ".tile{background:#17191F;border:1px solid #26292F;border-radius:16px;"
		+ "padding:14px 15px;margin-bottom:12px;position:relative;overflow:hidden;"
		+ "min-width:0;box-sizing:border-box}"
		+ ".span-2{grid-column:span 2}.span-3{grid-column:span 3}.span-4{grid-column:span 4}"
		+ ".span-6{grid-column:span 6}.span-12{grid-column:span 12}"
		+ ".lbl{font-size:11.5px;letter-spacing:.12em;text-transform:uppercase;color:#767A84;font-weight:650}"
		+ ".big{font-size:32px;font-weight:680;letter-spacing:-.03em;line-height:1.1;margin-top:7px;"
		+ "font-family:Consolas,'Courier New',monospace}"
		+ ".big small{font-size:14px;color:#767A84;font-weight:500;letter-spacing:0;"
		+ "font-family:'Segoe UI',Arial,sans-serif}"
		+ ".sub{font-size:13px;color:#A0A5AE;margin-top:4px;overflow:hidden;"
		+ "text-overflow:ellipsis;white-space:nowrap}"
		+ ".track{height:4px;border-radius:99px;background:#2B2E34;margin-top:10px;overflow:hidden}"
		+ ".track i{display:block;height:100%;width:0;background:#C4F252}"
		+ ".card{display:-webkit-flex;display:flex;-webkit-flex-direction:column;flex-direction:column}"
		+ ".c-top{margin-bottom:8px}"
		+ ".idx{font-family:Consolas,'Courier New',monospace;font-size:12px;color:#C4F252;"
		+ "background:#2B332A;border-radius:5px;padding:1px 5px;margin-right:8px}"
		+ ".code{font-family:Consolas,'Courier New',monospace;font-size:11.5px;color:#767A84;"
		+ "overflow:hidden;text-overflow:ellipsis;white-space:nowrap}"
		+ ".badge{margin-left:auto;font-size:11.5px;font-weight:650;border-radius:99px;"
		+ "padding:2px 8px;background:#2B2E34;color:#A0A5AE;white-space:nowrap}"
		+ ".badge.ok{background:#283933;color:#76E699}.badge.err{background:#402D2F;color:#FF7E70}"
		+ ".card h3{margin:0 0 8px;font-size:17px;font-weight:640;line-height:1.35}"
		+ ".p{margin:0 0 6px;font-size:14px;line-height:1.55;color:#A0A5AE}"
		+ ".p b{color:#E4E7EC;font-weight:600}"
		+ ".unit{font-family:Consolas,'Courier New',monospace;font-size:12px;color:#767A84;"
		+ "border:1px solid #26292F;border-radius:5px;padding:1px 6px;white-space:nowrap}"
		+ "table{width:100%;border-collapse:collapse;font-size:13.5px}"
		+ "th,td{padding:7px 10px;text-align:left;border-bottom:1px solid #26292F}"
		+ "thead th{font-size:11px;letter-spacing:.1em;text-transform:uppercase;"
		+ "color:#767A84;font-weight:650}"
		+ "tbody tr:hover{background:#1F2228}"
		+ "td.n,th.n{text-align:right;white-space:nowrap;"
		+ "font-family:Consolas,'Courier New',monospace;font-size:13px}"
		+ ".empty{color:#767A84;font-size:13.5px;padding:10px 2px}"
		+ ".foot{margin-top:16px;font-size:12.5px;color:#767A84}"
		+ ".stat{position:fixed;left:0;right:0;bottom:0;background:#17191F;"
		+ "border-top:1px solid #2F333A;padding:7px 18px;font-size:13px;color:#A0A5AE;z-index:30}"
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
// Переключение: PFTheme.toggle(), состояние в localStorage (pf-theme).
// ---------------------------------------------------------------------------

// Светлая тема по референсу index-v5: поверхности #FBF8FF/#FFFFFF, акцент #6A4CF6.
Функция СтилиСветлая() Экспорт
	Возврат "<style id='pfLight' media='not all'>"
		+ "html,body{background:#FBF8FF !important;color:#1B1A21 !important;background-image:none !important}"
		+ ".bar{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".brand{color:#1B1A21}"
		+ ".brand .pulse{background:#6A4CF6;box-shadow:0 0 0 4px #EDE8FF}"
		+ ".brand .ver{color:#6B6879;border-color:#E6E1F0}"
		+ ".crumbles,.crumbles span{color:#9A97A8}"
		+ ".field,.field span{color:#6B6879}"
		+ ".field input{background:#FFFFFF;color:#1B1A21;border-color:#E6E1F0}"
		+ ".field input:focus{border-color:#6A4CF6}"
		+ ".btn{background:#FFFFFF;color:#45424F;border-color:#D6CFE6}"
		+ ".btn:hover:not(:disabled){background:#F6F2FF;border-color:#6A4CF6}"
		+ ".btn.primary{background:#6A4CF6;color:#FFFFFF}"
		+ ".btn.primary:hover:not(:disabled){background:#5B3DF0}"
		+ ".btn.danger{color:#B3261E;border-color:#F0C9C5}"
		+ ".tile{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".lbl{color:#9A97A8}"
		+ ".big{color:#1B1A21}"
		+ ".big small,.sub{color:#6B6879}"
		+ ".track{background:#F3EEFC}"
		+ ".track i{background:#6A4CF6}"
		+ ".idx{color:#43289F;background:#EDE8FF}"
		+ ".code{color:#9A97A8}"
		+ ".badge{background:#F3EEFC;color:#6B6879}"
		+ ".badge.ok{background:#E2F5EC;color:#0F7A4F}.badge.err{background:#FBE6E5;color:#B3261E}"
		+ ".card h3{color:#1B1A21}"
		+ ".p{color:#45424F}.p b{color:#1B1A21}"
		+ ".unit{color:#6B6879;border-color:#E6E1F0}"
		+ ".result.ok{background:#E2F5EC;color:#0F7A4F}.result.err{background:#FBE6E5;color:#B3261E}"
		+ ".status{color:#6B6879}"
		+ ".cbar i{background:#6A4CF6}"
		+ "table th,table td{border-color:#EDE9F6}"
		+ "thead th{color:#9A97A8}"
		+ "tbody tr:hover{background:#F6F2FF}"
		+ ".empty,.foot{color:#9A97A8}"
		+ ".log-head h2{color:#1B1A21}.log-head span{color:#9A97A8}"
		+ ".stat{background:#FFFFFF;border-color:#E6E1F0;color:#45424F}"
		+ ".stat b{color:#1B1A21}"
		+ ".scrim{background:rgba(27,26,33,.45)}"
		+ ".pal{background:#FFFFFF;border-color:#E6E1F0}"
		+ ".pal input{color:#1B1A21;border-color:#E6E1F0}"
		+ ".pal li{color:#6B6879}.pal li.sel{background:#EDE8FF;color:#1B1A21}"
		+ ".pal .tip{color:#9A97A8;border-color:#E6E1F0}"
		+ ".theme-btn{position:fixed;right:18px;bottom:42px;z-index:60;background:#FFFFFF;"
		+ "color:#45424F;border:1px solid #D6CFE6;border-radius:999px;padding:7px 14px;"
		+ "font:600 13px 'Segoe UI',Arial,sans-serif;cursor:pointer}"
		+ "</style>"
		+ "<style>.theme-btn{position:fixed;right:18px;bottom:42px;z-index:60;"
		+ "background:#1F2228;color:#ECEEF3;border:1px solid #2F333A;border-radius:999px;"
		+ "padding:7px 14px;font:600 13px 'Segoe UI',Arial,sans-serif;cursor:pointer}"
		+ "</style>";
КонецФункции

// Скрипт темы: применяет сохранённое состояние и переключает по кнопке.
Функция СкриптТемы() Экспорт
	Возврат "<scr" + "ipt>"
		+ "var PFTheme={key:'pf-theme',css:'',"
		+ "apply:function(name){var st=document.getElementById('pfLight');"
		+ "if(st){st.innerHTML=(name==='light')?PFTheme.css:'';}"
		+ "var b=document.getElementById('pfThemeBtn');"
		+ "if(b){b.innerHTML=(name==='light')?'Тёмная тема':'Светлая тема';}},"
		+ "toggle:function(){var cur='dark';"
		+ "try{cur=localStorage.getItem(PFTheme.key)||'dark';}catch(e){cur='dark';}"
		+ "var next=(cur==='light')?'dark':'light';"
		+ "try{localStorage.setItem(PFTheme.key,next);}catch(e){}"
		+ "PFTheme.apply(next);return false;},"
		+ "init:function(){var st=document.getElementById('pfLight');"
		+ "if(st){PFTheme.css=st.innerHTML;st.innerHTML='';}"
		+ "var cur='dark';"
		+ "try{cur=localStorage.getItem(PFTheme.key)||'dark';}catch(e){cur='dark';}"
		+ "if(!document.getElementById('pfThemeBtn')&&document.body){"
		+ "var b=document.createElement('button');b.id='pfThemeBtn';b.className='theme-btn';"
		+ "b.onclick=PFTheme.toggle;document.body.appendChild(b);}"
		+ "PFTheme.apply(cur);}};"
		+ "window.PFTheme=PFTheme;PFTheme.init();"
		+ "</scr" + "ipt>";
КонецФункции

// ---------------------------------------------------------------------------
// Блок: боковое меню навигации (референс index-v2: тёмный рейл, активный пункт
// с лаймовой полосой). Ссылки шлют команды open:<ИмяФормы> через мост PF1C.
// ---------------------------------------------------------------------------

// Стили рейла. Вызывать один раз на страницу.
Функция СтилиМеню() Экспорт
	Возврат "<style>"
		+ "body{padding-left:232px}"
		+ ".side{position:fixed;left:0;top:0;bottom:0;width:220px;background:#0D1117;"
		+ "color:#C6CFDD;padding:16px 12px;box-sizing:border-box;z-index:50;overflow:auto}"
		+ ".side .logo{display:-webkit-flex;display:flex;-webkit-align-items:center;"
		+ "align-items:center;padding:6px 8px 18px}"
		+ ".side .mark{width:28px;height:28px;border-radius:8px;margin-right:10px;"
		+ "background:#C4F252}"
		+ ".side .logo b{color:#F2F6FF;font-size:13.5px;font-weight:650;display:block}"
		+ ".side .logo span{font-size:10.5px;color:#7D8798;letter-spacing:.06em;"
		+ "text-transform:uppercase}"
		+ ".nav-label{font-size:10px;letter-spacing:.1em;text-transform:uppercase;"
		+ "color:#5F6A7C;padding:12px 10px 6px}"
		+ ".side a{display:-webkit-flex;display:flex;-webkit-align-items:center;"
		+ "align-items:center;color:#AAB4C4;text-decoration:none;font-size:13px;"
		+ "padding:8px 10px;border-radius:8px;margin-bottom:2px}"
		+ ".side a:hover{background:#171E28;color:#E6ECF5}"
		+ ".side a.active{background:#1C232C;color:#EEF2FF;"
		+ "box-shadow:inset 2px 0 0 #C4F252}"
		+ ".side-foot{margin-top:18px;border-top:1px solid #1B222C;padding:12px 10px 4px;"
		+ "font-size:11px;color:#69748A}"
		+ ".side-foot .dot{width:6px;height:6px;border-radius:50%;background:#31C48D;"
		+ "display:inline-block;margin-right:6px}"
		+ "</style>";
КонецФункции

// Рейл навигации. Активный - имя открытой формы.
Функция Меню(Активный = "") Экспорт
	Пункты = Новый Массив;
	Пункты.Добавить(Новый Структура("Форма, Подпись", "НачальнаяСтраница", "Кокпит"));
	Пункты.Добавить(Новый Структура("Форма, Подпись", "ПерфДашборд", "Дашборд"));
	Пункты.Добавить(Новый Структура("Форма, Подпись", "ПерфТопКонфигураций", "Топ-100"));
	Пункты.Добавить(Новый Структура("Форма, Подпись", "ПерфСравнениеСтендов", "Сравнение стендов"));
	Пункты.Добавить(Новый Структура("Форма, Подпись", "ПерфИсторияЗамеров", "История замеров"));

	Части = Новый Массив;
	Части.Добавить("<nav class='side' id='pfSide'>"
		+ "<div class='logo'><span class='mark'></span>"
		+ "<div class='logo-t'><b>ПерфТест</b><span>кокпит 1.19</span></div></div>");
	Части.Добавить("<div class='nav-label'>разделы</div>");
	Для Каждого Пункт Из Пункты Цикл
		Класс = ?(Пункт.Форма = Активный, " active", "");
		Части.Добавить("<a class='nav-i" + Класс + "' href='#' title='"
			+ Экранировать(Пункт.Подпись) + "' onclick='PFNav.go("""
			+ Пункт.Форма + """);return false'><i class='dot-n'></i>"
			+ "<span class='nm'>" + Экранировать(Пункт.Подпись) + "</span></a>");
	КонецЦикла;
	Части.Добавить("<div class='side-foot'><div><span class='dot'></span>готов к работе</div>"
		+ "<div>1c\\perf-test</div></div></nav>");
	Возврат СтрСоединить(Части, "");
КонецФункции

// Скрипт навигации: пересылает выбор пункта в 1С.
Функция СкриптМеню() Экспорт
	Возврат "<scr" + "ipt>"
		+ "var PFNav={go:function(name){"
		+ "if(name==='НачальнаяСтраница'){return;}"
		+ "if(window.PF1C&&PF1C.send){PF1C.send('open:'+name);return;}"
		+ "if(window.parent&&window.parent.PF1C){window.parent.PF1C.send('open:'+name);}}};"
		+ "window.PFNav=PFNav;"
		+ "</scr" + "ipt>";
КонецФункции

// ---------------------------------------------------------------------------
// Блок: сворачивание бокового меню (как в панелях управления).
// Состояние хранится в localStorage под ключом pf-nav.
// ---------------------------------------------------------------------------

Функция СтилиСворачивания() Экспорт
	Возврат "<style>"
		+ "body{-webkit-transition:padding-left .18s;transition:padding-left .18s}"
		+ "body.pf-collapsed{padding-left:76px !important}"
		+ ".side{-webkit-transition:width .18s;transition:width .18s}"
		+ "body.pf-collapsed .side{width:60px !important;padding:16px 8px !important}"
		+ "body.pf-collapsed .side .logo b,body.pf-collapsed .side .logo span,"
		+ "body.pf-collapsed .nav-label,body.pf-collapsed .side-foot{display:none !important}"
		+ "body.pf-collapsed .side a{font-size:0 !important;padding:9px 0 !important;"
		+ "text-align:center}"
		+ "body.pf-collapsed .side a .dot-n,.side a .dot-n{width:8px;height:8px;"
		+ "border-radius:50%;background:#4A5464;display:inline-block;margin-right:9px}"
		+ "body.pf-collapsed .side a .dot-n{margin-right:0}"
		+ ".side a.active .dot-n{background:#C4F252}"
		+ ".nav-btn{position:absolute;top:12px;right:-12px;width:24px;height:24px;"
		+ "border-radius:50%;background:#1C232C;color:#C6CFDD;border:1px solid #2A323D;"
		+ "cursor:pointer;font:600 12px 'Segoe UI',Arial,sans-serif;padding:0;z-index:51}"
		+ ".nav-btn:hover{background:#26303C;color:#FFFFFF}"
		+ "</style>";
КонецФункции

Функция СкриптСворачивания() Экспорт
	Возврат "<scr" + "ipt>"
		+ "var PFNav=window.PFNav||{};"
		+ "PFNav.key='pf-nav';"
		+ "PFNav.on=function(){return document.body.className.indexOf('pf-collapsed')>=0;};"
		+ "PFNav.apply=function(){var b=document.getElementById('pfNavBtn');"
		+ "if(b){b.innerHTML=PFNav.on()?'>':'<';}};"
		+ "PFNav.toggle=function(){var on=PFNav.on();"
		+ "document.body.className=on?'':'pf-collapsed';"
		+ "try{localStorage.setItem(PFNav.key,on?'0':'1');}catch(e){}"
		+ "PFNav.apply();return false;};"
		+ "PFNav.init=function(){var on=false;"
		+ "try{on=localStorage.getItem(PFNav.key)==='1';}catch(e){on=false;}"
		+ "document.body.className=on?'pf-collapsed':'';"
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
		+ "take:function(){if(!this.q.length){return '';}var s=this.q.join('|');this.q=[];return s;}};}"
		+ "</scr" + "ipt>";
КонецФункции
