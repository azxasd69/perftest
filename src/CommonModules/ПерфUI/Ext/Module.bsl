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
// Правила светлой темы без обрамляющих тегов: их вставляет Документ в <style media=...>.
Функция ПравилаСветлой() Экспорт

	Текст = СтилиСветлая();
	Текст = СтрЗаменить(Текст, "<style>", "");
	Текст = СтрЗаменить(Текст, "</style>", "");
	Возврат Текст;

КонецФункции

Функция СтилиСветлая() Экспорт
	Возврат "<style>"
		+ "html,body{background:#FBF8FF !important;color:#1B1A21 !important;background-image:none !important}"
		+ ".bar{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".brand{color:#1B1A21}"
		+ ".brand .pulse{background:#6A4CF6;box-shadow:0 0 0 4px #EDE8FF}"
		+ ".brand .ver{color:#6B6879;border-color:#E6E1F0}"
		+ ".crumbles,.crumbles span{color:#6B6879 !important}"
		+ ".field,.field span{color:#6B6879}"
		+ ".field input{background:#FFFFFF;color:#1B1A21;border-color:#E6E1F0}"
		+ ".field input:focus{border-color:#6A4CF6}"
		+ ".btn{background:#F6F2FF !important;color:#3A2E6E !important;border-color:#D6CFE6 !important}"
		+ ".btn:hover:not(:disabled){background:#F6F2FF;border-color:#6A4CF6}"
		+ ".btn.primary{background:#6A4CF6;color:#FFFFFF}"
		+ ".btn.primary:hover:not(:disabled){background:#5B3DF0}"
		+ ".btn.danger{color:#B3261E !important;background:#FBE6E5 !important;border-color:#F0C9C5 !important}"
		+ ".tile{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".lbl{color:#6B6879 !important}"
		+ ".big{color:#1B1A21}"
		+ ".big small,.sub{color:#5A5766 !important}"
		+ ".track{background:#F3EEFC}"
		+ ".track i{background:#6A4CF6}"
		+ ".idx{color:#43289F;background:#EDE8FF}"
		+ ".code{color:#9A97A8}"
		+ ".badge{background:#EEEAF7 !important;color:#45424F !important}"
		+ ".badge.ok{background:#E2F5EC;color:#0F7A4F}.badge.err{background:#FBE6E5;color:#B3261E}"
		+ ".tile{box-shadow:0 14px 30px -26px rgba(27,26,33,.45) !important}"
		+ ".card h3{color:#1B1A21}"
		+ ".p{color:#45424F}.p b{color:#1B1A21}"
		+ ".unit{color:#5A5766 !important;border-color:#E6E1F0 !important}"
		+ ".result.ok{background:#E2F5EC;color:#0F7A4F}.result.err{background:#FBE6E5;color:#B3261E}"
		+ ".status{color:#6B6879}"
		+ ".cbar i{background:#6A4CF6}"
		+ ".side{background:#FFFFFF !important}"
		+ ".side .logo b{color:#1B1A21 !important}"
		+ ".side .logo span{color:#9A97A8 !important}"
		+ ".side .mark{background:#6A4CF6 !important}"
		+ ".nav-label{color:#9A97A8 !important}"
		+ ".side a{color:#45424F !important}"
		+ ".side a:hover{background:#F6F2FF !important;color:#1B1A21 !important}"
		+ ".side a.active{background:#EDE8FF !important;color:#43289F !important;box-shadow:inset 2px 0 0 #6A4CF6 !important}"
		+ ".side a .dot-n{background:#D6CFE6 !important}"
		+ ".side a.active .dot-n{background:#6A4CF6 !important}"
		+ ".nav-i svg{color:#8B84A3 !important}"
		+ ".nav-i.active svg{color:#6A4CF6 !important}"
		+ ".side-stand{background:#F7F3FF !important;border-color:#E7DEFB !important}"
		+ ".ss-h{color:#5C5770 !important}"
		+ ".ss-r span{color:#9A97A8 !important}"
		+ ".ss-r b{color:#45424F !important}"
		+ ".side-foot{color:#9A97A8 !important;border-color:#E6E1F0 !important}"
		+ ".nav-btn{background:#F3EEFC !important;color:#45424F !important;border-color:#E6D9FF !important}"
		+ ".card:hover{background:#F6F2FF !important;border-color:#D6CFE6 !important}"
		+ ".brand .pulse{background:#6A4CF6 !important}"
		+ ".btn.primary:hover:not(:disabled){box-shadow:0 8px 20px -10px #6A4CF6 !important}"
		+ "@-webkit-keyframes pfGlowL{0%{box-shadow:0 0 0 0 rgba(106,76,246,.35)}"
		+ "70%{box-shadow:0 0 0 8px rgba(106,76,246,0)}100%{box-shadow:0 0 0 0 rgba(106,76,246,0)}}"
		+ "@keyframes pfGlowL{0%{box-shadow:0 0 0 0 rgba(106,76,246,.35)}"
		+ "70%{box-shadow:0 0 0 8px rgba(106,76,246,0)}100%{box-shadow:0 0 0 0 rgba(106,76,246,0)}}"
		+ ".state-run .idx{-webkit-animation:pfGlowL 1.8s infinite !important;animation:pfGlowL 1.8s infinite !important}"
		+ ".state-run .edge{background:#6A4CF6 !important}"
		+ ".track i{background:#6A4CF6 !important}"
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

				// Отчётные страницы: шапка, чипы, таблицы, карточки, графики.
		+ ".top{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".top h1{color:#1B1A21 !important}"
		+ "h2{color:#1B1A21 !important}"
		+ ".chip{background:#F3EEFC !important;border-color:#E6D9FF !important;"
		+ "color:#5C5770 !important}"
		+ ".chip b{color:#1B1A21 !important}"
		+ "table{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ "th{background:#F6F2FF !important;color:#6B6879 !important}"
		+ "th,td{border-color:#EFEAF8 !important;color:#1B1A21 !important}"
		+ "tr:hover td{background:#F7F3FF !important}"
		+ "td.num{color:#1B1A21 !important}"
		+ ".muted{color:#6B6879 !important}"
		+ ".card{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".bar{background:#EFEAF8 !important}"
		+ "svg{background:#FFFFFF !important;border-color:#E6E1F0 !important}"
		+ ".good{color:#0F7A4F !important}"
		+ ".bad{color:#B3261E !important}"
		+ ".warn{color:#8A5A00 !important}"
		+ "</style>";
КонецФункции

// Скрипт темы: применяет сохранённое состояние и переключает по кнопке.
// Тема приложения хранится на стороне 1С: localStorage в поле HTML не переживает
// перезапуск процесса. Кнопка темы отправляет команду theme:<имя>, форма сохраняет
// выбор здесь, а любая страница получает тему при сборке (см. Документ).
Функция ФайлТемы()

	Возврат КаталогВременныхФайлов() + "perftest_theme.txt";

КонецФункции

// Текущая тема приложения: "light" или "dark" (по умолчанию тёмная, как стиль 1С).
Функция ТемаПриложения() Экспорт

	Попытка
		Файл = Новый Файл(ФайлТемы());
		Если Файл.Существует() Тогда
			Чтение = Новый ЧтениеТекста(ФайлТемы(), КодировкаТекста.UTF8);
			Тема = СокрЛП(Чтение.ПрочитатьСтроку());
			Чтение.Закрыть();
			Если Тема = "light" ИЛИ Тема = "dark" Тогда
				Возврат Тема;
			КонецЕсли;
		КонецЕсли;
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;
	Возврат "dark";

КонецФункции

// Сохраняет выбор темы (команда theme:<имя> от кнопки на странице).
Процедура СохранитьТемуПриложения(Тема) Экспорт

	Если Тема <> "light" И Тема <> "dark" Тогда
		Возврат;
	КонецЕсли;
	Попытка
		Запись = Новый ЗаписьТекста(ФайлТемы(), КодировкаТекста.UTF8);
		Запись.ЗаписатьСтроку(Тема);
		Запись.Закрыть();
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

// Скрипт темы: применяет светлую или тёмную и (опционально) создаёт кнопку.
// Тема выбирается сама, без участия пользователя: сохранённый выбор приложения,
// иначе системная тема (prefers-color-scheme), иначе тёмная.
// ПоказыватьКнопку = Ложь - страница без переключателя (карточка стенда).
Функция СкриптТемы(ПоказыватьКнопку = Истина, НачальнаяТема = "dark") Экспорт

	// Тема полностью определяется сервером: класс на <html> и media у <style id='pfLight'>
	// выставлены в разметке. Скрипт только переключает их по кнопке (она есть на кокпите)
	// и сообщает выбор в 1С.
	Возврат "<scr" + "ipt>"
		+ "var PFTheme={"
		+ "current:function(){try{return document.documentElement.className.indexOf('pf-light')>=0"
		+ "?'light':'dark';}catch(e){return 'dark';}},"
		+ "apply:function(name){var on=(name==='light');"
		+ "try{document.documentElement.className=on?'pf-light':'pf-dark';}catch(e){}"
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
		+ (?(ПоказыватьКнопку, "", ""))
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
	НачальнаяТема = "") Экспорт

	// Тема известна серверу (выбор кнопки сохраняется в 1С), поэтому класс
	// ставится сразу в разметке: поле HTML не зависит от выполнения JS.
	Тема = ?(ПустаяСтрока(НачальнаяТема), ТемаПриложения(), НачальнаяТема);
	КлассТемы = ?(Тема = "light", "pf-light", "pf-dark");
	Части = Новый Массив;
	Части.Добавить("<!DOCTYPE html><html class='" + КлассТемы + "'><head><meta charset='utf-8'>");
	Части.Добавить("<meta name='viewport' content='width=device-width, initial-scale=1'>");
	Части.Добавить("<title>" + Экранировать(Заголовок) + "</title>");
	// Порядок важен: стили страницы идут до панели, поэтому фон, шрифт или
	// отступы конкретной страницы не могут изменить ее внешний вид.
	Части.Добавить(ДопСтили);
	Части.Добавить(СтилиМеню());
	// Светлые правила вставляются всегда, но включаются только при теме light:
	// media выставляет сервер, поэтому страница правильная еще до выполнения JS.
	Части.Добавить("<style id='pfLight' media='" + ?(Тема = "light", "all", "not all") + "'>");
	Части.Добавить(ПравилаСветлой());
	Части.Добавить("</style>");
	Части.Добавить(СтилиДинамика());
	Части.Добавить(СтилиСворачивания());
	Части.Добавить(СкриптМоста());
	КлассПанели = ?(СостояниеПанели() = "collapsed", " class='pf-collapsed'", "");
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
	Части.Добавить(СкриптТемы(ПоказыватьПереключательТемы, Тема));
	Части.Добавить("</body></html>");
	Возврат СтрСоединить(Части, "");

КонецФункции

// Стили рейла. Вызывать один раз на страницу.
Функция СтилиМеню() Экспорт
	Возврат "<style>"
		+ "body{padding-left:232px}"
		+ ".side{position:fixed;left:0;top:0;bottom:0;width:220px;background:#0D1117;"
		+ "color:#C6CFDD;padding:16px 12px;box-sizing:border-box;z-index:50;overflow:auto;"
		+ "font:13px/20px 'Segoe UI',Arial,sans-serif}"
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
		+ "line-height:20px;padding:7px 10px;border-radius:8px;margin-bottom:2px}"
		+ ".side a:hover{background:#171E28;color:#E6ECF5}"
		+ ".side a.active{background:#1C232C;color:#EEF2FF;"
		+ "box-shadow:inset 2px 0 0 #C4F252}"
		+ ".side-foot{margin-top:18px;border-top:1px solid #1B222C;padding:12px 10px 4px;"
		+ "font-size:11px;color:#69748A}"
		+ ".side-foot .dot{width:6px;height:6px;border-radius:50%;background:#31C48D;"
		+ "display:inline-block;margin-right:6px}"
		+ ".nav-i svg{width:15px;height:15px;margin-right:9px;flex:0 0 15px;"
		+ "display:block;color:#6C7686}"
		+ ".nav-i:hover svg{color:#C6CFDD}"
		+ ".nav-i.active svg{color:#C4F252}"
		+ ".nav-i .nm{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}"
		+ ".side-stand{margin:6px 8px 0;padding:10px;border:1px solid #1E2530;"
		+ "border-radius:10px;background:#11161D}"
		+ ".ss-h{font-size:11px;color:#8D97A8;font-weight:600;margin-bottom:7px;"
		+ "overflow:hidden;text-overflow:ellipsis;white-space:nowrap}"
		+ ".ss-r{display:-webkit-flex;display:flex;justify-content:space-between;"
		+ "gap:8px;font-size:10.5px;line-height:16px}"
		+ ".ss-r span{color:#5F6A7C;text-transform:uppercase;letter-spacing:.05em;"
		+ "flex:0 0 auto}"
		+ ".ss-r b{color:#AAB4C4;font-weight:500;text-align:right;line-height:14px;"
		+ "word-wrap:break-word;overflow:hidden}"
		+ "</style>";
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
// Состояние хранится в localStorage под ключом pf-nav.
// ---------------------------------------------------------------------------

// Состояние панели (свернута / развернута) хранится на стороне 1С: localStorage
// не переживает переход между формами, потому что каждая форма - новый документ.
Функция ФайлПанели()

	Возврат КаталогВременныхФайлов() + "perftest_nav.txt";

КонецФункции

// "collapsed" или "expanded". По умолчанию панель развернута.
Функция СостояниеПанели() Экспорт

	Попытка
		Файл = Новый Файл(ФайлПанели());
		Если Файл.Существует() Тогда
			Чтение = Новый ЧтениеТекста(ФайлПанели(), КодировкаТекста.UTF8);
			Значение = СокрЛП(Чтение.ПрочитатьСтроку());
			Чтение.Закрыть();
			Если Значение = "collapsed" ИЛИ Значение = "expanded" Тогда
				Возврат Значение;
			КонецЕсли;
		КонецЕсли;
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;
	Возврат "expanded";

КонецФункции

Процедура СохранитьСостояниеПанели(Значение) Экспорт

	Если Значение <> "collapsed" И Значение <> "expanded" Тогда
		Возврат;
	КонецЕсли;
	Попытка
		Запись = Новый ЗаписьТекста(ФайлПанели(), КодировкаТекста.UTF8);
		Запись.ЗаписатьСтроку(Значение);
		Запись.Закрыть();
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

Функция СтилиСворачивания() Экспорт
	Возврат "<style>"
		+ "body{-webkit-transition:padding-left .18s;transition:padding-left .18s}"
		+ "body.pf-collapsed{padding-left:76px !important}"
		+ ".side{-webkit-transition:width .18s;transition:width .18s}"
		+ "body.pf-collapsed .side{width:60px !important;padding:16px 8px !important}"
		+ "body.pf-collapsed .side .logo b,body.pf-collapsed .side .logo span,"
		+ "body.pf-collapsed .nav-label,body.pf-collapsed .side-foot,"
		+ "body.pf-collapsed .side-stand{display:none !important}"
		+ "body.pf-collapsed .side{overflow:hidden}"
		+ "body.pf-collapsed .side .logo{-webkit-justify-content:center;"
		+ "justify-content:center;padding:6px 0 14px}"
		+ "body.pf-collapsed .side a{font-size:0 !important;padding:0 !important;"
		+ "width:34px;height:34px;margin:0 auto 6px;-webkit-justify-content:center;"
		+ "justify-content:center}"
		+ "body.pf-collapsed .side a .nm{display:none !important}"
		+ "body.pf-collapsed .side a svg{width:17px;height:17px;margin:0 auto !important}"
		+ ".side a .dot-n{width:8px;height:8px;border-radius:50%;background:#4A5464;"
		+ "display:inline-block;margin-right:9px}"
		+ "body.pf-collapsed .side a .dot-n{display:none}"
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
		+ "try{if(window.PF1C&&PF1C.send){PF1C.send('nav:'+(on?'expanded':'collapsed'));}}"
		+ "catch(e){}"
		+ "PFNav.apply();return false;};"
		+ "PFNav.init=function(){"
		+ "var on=(document.body.className.indexOf('pf-collapsed')>=0);"
		+ "try{localStorage.setItem(PFNav.key,on?'1':'0');}catch(e){}"
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

// ---------------------------------------------------------------------------
// Блок: динамика. Переходы и мягкие анимации из референса (index-v3):
// hover карточек, нажатие кнопок, плавные полосы прогресса, пульс статуса.
// Движок HTML-поля поддерживает transition и keyframes; при их отсутствии
// вид деградирует до статичного, ничего не ломая.
// ---------------------------------------------------------------------------

Функция СтилиДинамика() Экспорт
	Возврат "<style>"
		+ ".tile{-webkit-transition:border-color .18s,background .18s,box-shadow .18s;"
		+ "transition:border-color .18s,background .18s,box-shadow .18s}"
		+ ".card:hover{border-color:#3A4150;background:#1B1E25}"
		+ ".btn{-webkit-transition:background .15s,border-color .15s,box-shadow .15s,"
		+ "transform .06s;transition:background .15s,border-color .15s,box-shadow .15s,transform .06s}"
		+ ".btn:active:not(:disabled){transform:translateY(1px)}"
		+ ".btn.primary:hover:not(:disabled){box-shadow:0 8px 20px -10px #C4F252}"
		+ ".track i,.cbar i{-webkit-transition:width .4s ease;transition:width .4s ease}"
		+ ".side a{-webkit-transition:background .15s,color .15s;transition:background .15s,color .15s}"
		+ ".nav-btn{-webkit-transition:background .15s,color .15s;transition:background .15s,color .15s}"
		+ "tbody tr{-webkit-transition:background .12s;transition:background .12s}"
		+ ".result{-webkit-transition:background .2s,color .2s;transition:background .2s,color .2s}"
		+ ".badge{-webkit-transition:background .2s,color .2s;transition:background .2s,color .2s}"
		+ "@-webkit-keyframes pfPulse{0%,100%{opacity:1}50%{opacity:.45}}"
		+ "@keyframes pfPulse{0%,100%{opacity:1}50%{opacity:.45}}"
		+ ".brand .pulse{-webkit-animation:pfPulse 2.4s infinite;animation:pfPulse 2.4s infinite}"
		+ "@-webkit-keyframes pfGlow{0%{box-shadow:0 0 0 0 rgba(196,242,82,.35)}"
		+ "70%{box-shadow:0 0 0 8px rgba(196,242,82,0)}100%{box-shadow:0 0 0 0 rgba(196,242,82,0)}}"
		+ "@keyframes pfGlow{0%{box-shadow:0 0 0 0 rgba(196,242,82,.35)}"
		+ "70%{box-shadow:0 0 0 8px rgba(196,242,82,0)}100%{box-shadow:0 0 0 0 rgba(196,242,82,0)}}"
		+ ".state-run .idx{-webkit-animation:pfGlow 1.8s infinite;animation:pfGlow 1.8s infinite}"
		+ ".stat b{-webkit-transition:color .2s;transition:color .2s}"
		+ ".cbar i,.track i{-webkit-transition:none !important;transition:none !important}"
		+ ".card{min-height:196px}"
		+ ".status{display:block !important;visibility:hidden;min-height:18px}"
		+ ".state-run .status,.state-ok .status,.state-err .status,.state-cancel .status{visibility:visible !important}"
		+ ".result{display:block !important;visibility:hidden;min-height:28px;box-sizing:border-box}"
		+ ".result.ok,.result.err,.result.cancel{visibility:visible !important}"
		+ "</style>";
КонецФункции
