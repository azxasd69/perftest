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
		+ ".wrap{max-width:1500px;margin:0 auto;padding:14px 18px 70px}"
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
