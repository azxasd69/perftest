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
	// Только адаптивная сетка карточек. Все оформление кокпита теперь в базе:
	// правила, которые здесь были, дословно совпадали с ПерфUI.Стили.
	Возврат "<style>"
		+ "@media (max-width:1500px){.card.span-4{grid-column:span 6}}@media (max-width:1100px){.card.span-4,.card.span"
		+ "-6{grid-column:span 12}}"
		+ "</style>";
КонецФункции

// Категория сценария по коду: чипы-фильтры и цвет карточки.
// Цвета заданы в ПерфUI.Стили, здесь только код категории и подпись.
Функция КатегорияСценария(Код)

	Верх = ВРег(СокрЛП(Код));
	Если СтрНайти(Верх, "CPU") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "cpu", "ЦПУ");
	ИначеЕсли СтрНайти(Верх, "ЗАПИСЬ") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "ib", "Запись ИБ");
	ИначеЕсли СтрНайти(Верх, "ЗАПРОСЫ") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "q", "Запросы");
	ИначеЕсли СтрНайти(Верх, "СЕРИАЛИЗАЦИЯ") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "ser", "Сериализация");
	ИначеЕсли СтрНайти(Верх, "ПАМЯТЬ") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "mem", "Память");
	ИначеЕсли СтрНайти(Верх, "ФАЙЛЫ") = 1 Тогда
		Возврат Новый Структура("Код, Подпись", "io", "Файлы");
	КонецЕсли;
	Возврат Новый Структура("Код, Подпись", "other", "Прочее");

КонецФункции

// Карточка сценария: индекс, код, бейдж, суть, реализация, единица, кнопка, кольцо.
Функция КарточкаHTML(Номер, Сценарий, Ширина)
	Порция = Формат(Сценарий.Порция, "ЧГ=");
	Кат = КатегорияСценария(Сценарий.Имя);
	Возврат "<section class='tile card span-" + Ширина + " state-idle' id='card"
		+ Номер + "' data-cat='" + Кат.Код + "'>"
		+ "<i class='edge'></i>"
		+ "<div class='c-top'><span class='idx'>" + Формат(Номер, "ЧЦ=2; ЧВН=; ЧГ=") + "</span>"
		+ "<span class='code' title='" + Экранировать(Сценарий.Имя) + "'>"
		+ Экранировать(Сценарий.Имя) + "</span>"
		+ "<span class='badge'>&mdash;</span></div>"
		+ "<h3>" + Экранировать(Сценарий.Представление) + "</h3>"
		// Метка блока идет отдельной строкой: карточку видно по структуре, а не по сплошному тексту.
		+ "<p class='p'><b class='pl'>Суть</b>" + Экранировать(Сценарий.Описание) + "</p>"
		+ "<p class='p'><b class='pl'>Реализация</b>" + Порция + " " + Экранировать(Сценарий.Единица)
		+ ", повторов " + Формат(Сценарий.Повторов, "ЧН=0; ЧГ=") + "</p>"
		+ "<div class='c-foot'><span class='unit'>" + Порция + " "
		+ Экранировать(Сценарий.Единица) + "</span>"
		+ "<button class='btn primary' data-pf='run:" + Номер + "'>Запустить</button></div>"
		+ "<div class='status'>&mdash;</div>"
		+ "<p class='result'></p>"
		// Кольцо прогресса в углу карточки: движение по нему не сдвигает текст.
		+ "<svg class='mr' viewBox='0 0 30 30' aria-hidden='true'>"
		+ "<circle class='mr-bg' cx='15' cy='15' r='12'></circle>"
		+ "<circle class='mr-fill' cx='15' cy='15' r='12'></circle></svg></section>";
КонецФункции

// Полная страница кокпита.
Функция Страница(СтендСтрокой, Повторов, Сценарии, ПлатформаСтрокой, КонфигурацияСтрокой,
	Настройки = Неопределено) Экспорт
	// Каркас страницы (head, общие стили, боковая панель, тема) собирает
	// ПерфUI.Документ: здесь остается только контент кокпита.
	Части = Новый Массив;

	// Верхняя панель в одну строку: бренд, переходы по отчетам, параметры прогона,
	// меню (палитра) и пуск/стоп. На узком окне строка переносится.
	Части.Добавить("<header class='bar bar-single'>");
	Части.Добавить("<div class='brand'><span class='pulse'></span>"
		+ "<span class='brand-name'>ПерфТест</span>"
		+ "<span class='ver'>" + Экранировать(КонфигурацияСтрокой) + "</span></div>");
	Части.Добавить("<nav class='bar-nav'>");
	Части.Добавить("<button class='btn nav' data-pf='open:ПерфДашборд'>Дашборд</button>");
	Части.Добавить("<button class='btn nav' data-pf='open:ПерфТопКонфигураций'>Топ-100</button>");
	Части.Добавить("<button class='btn nav' data-pf='open:ПерфСравнениеСтендов'>Сравнение</button>");
	Части.Добавить("<button class='btn nav' data-pf='open:ПерфИсторияЗамеров'>История</button>");
	Части.Добавить("</nav>");
	// Правая часть переносится одним блоком: параметры, меню и кнопки прогона.
	Части.Добавить("<span class='bar-right'>");
	Части.Добавить("<label class='field'><span>стенд</span>"
		+ "<input class='stand-input' id='stand' value='" + Экранировать(СтендСтрокой) + "'"
		+ " placeholder='по сеансу' spellcheck='false' data-pf-field='stand'></label>");
	Части.Добавить("<label class='field'><span>повторов</span>"
		+ "<input class='rep-input' type='number' min='1' max='9' value='"
		+ Формат(Повторов, "ЧН=0; ЧГ=") + "' data-pf-field='rep'></label>");
	// Палитра теперь называется «Меню»: в ней не только пуск, но и переходы по страницам.
	Части.Добавить("<button class='btn menu' data-pf='pal'>Меню<kbd>Ctrl+K</kbd></button>");
	// Пуск и стоп всегда рядом: при переносе строки они уезжают вместе, а не порознь.
	Части.Добавить("<span class='bar-actions'>");
	Части.Добавить("<button class='btn primary' id='runAll' data-pf='send:all'>"
		+ "Запустить все</button>");
	Части.Добавить("<button class='btn danger' id='stop' disabled "
		+ "data-pf='send:stop'>Стоп</button>");
	Части.Добавить("</span>");
	Части.Добавить("</span>");
	Части.Добавить("</header>");

	// Чипы-фильтры по категориям: клик скрывает чужие карточки (только в HTML).
	Категории = Новый Массив;
	Категории.Добавить(Новый Структура("Код, Подпись", "cpu", "ЦПУ"));
	Категории.Добавить(Новый Структура("Код, Подпись", "ib", "Запись ИБ"));
	Категории.Добавить(Новый Структура("Код, Подпись", "q", "Запросы"));
	Категории.Добавить(Новый Структура("Код, Подпись", "ser", "Сериализация"));
	Категории.Добавить(Новый Структура("Код, Подпись", "mem", "Память"));
	Категории.Добавить(Новый Структура("Код, Подпись", "io", "Файлы"));
	Счетчики = Новый Соответствие;
	Для Каждого Сценарий Из Сценарии Цикл
		КодКат = КатегорияСценария(Сценарий.Имя).Код;
		Текущий = Счетчики.Получить(КодКат);
		Счетчики.Вставить(КодКат, ?(Текущий = Неопределено, 0, Текущий) + 1);
	КонецЦикла;

	Части.Добавить("<div class='chips-bar'>");
	Части.Добавить("<button class='chipf' data-cat='all' data-pf='filter:all' aria-pressed='true'>"
		+ "Все<span class='c'>" + Строка(Сценарии.Количество()) + "</span></button>");
	Для Каждого Категория Из Категории Цикл
		Количество = Счетчики.Получить(Категория.Код);
		Если Количество = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		Части.Добавить("<button class='chipf' data-cat='" + Категория.Код + "'"
			+ " data-pf='filter:" + Категория.Код + "' aria-pressed='false'"
			+ " title='" + Экранировать(Категория.Подпись) + "'>"
			+ "<i class='dot'></i>" + Экранировать(Категория.Подпись)
			+ "<span class='c'>" + Строка(Количество) + "</span></button>");
	КонецЦикла;
	Части.Добавить("<span class='chips-info'>стенд: "
		+ Экранировать(?(ПустаяСтрока(СтендСтрокой), "по сеансу", СтендСтрокой)) + "</span>");
	Части.Добавить("</div>");

	// Bento: hero-кольцо выполнения и три показателя.
	Части.Добавить("<main class='bento'>");
	Части.Добавить("<section class='tile span-6 hero'>"
		// Кольцо - доля выполнения, рядом - число и состояние.
		+ "<svg class='ring' viewBox='0 0 120 120' aria-hidden='true'>"
		+ "<circle class='ring-bg' cx='60' cy='60' r='52'></circle>"
		+ "<circle class='ring-fill' id='heroRing' cx='60' cy='60' r='52'></circle></svg>"
		+ "<div class='hero-txt'><div class='lbl'>Выполнено сценариев</div>"
		+ "<div class='big'><span id='kDone'>0</span><small> / "
		+ Строка(Сценарии.Количество()) + "</small></div>"
		+ "<div class='hero-hint' id='kDoneHint'>еще не запускали</div></div>"
		+ "<i class='hero-blob'></i></section>");
	Части.Добавить("<section class='tile span-2'><div class='lbl'>Средняя медиана</div>"
		+ "<div class='big'><span id='kMedian'>&mdash;</span><small> мс</small></div>"
		+ "<div class='sub' id='kMedianHint'>по завершенным</div></section>");
	Части.Добавить("<section class='tile span-2'><div class='lbl'>Самый медленный</div>"
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
	Части.Добавить("<section class='tile span-12'>"
		+ "<div class='log-head'><h2>Журнал замеров</h2>"
		+ "<span>стенд x сценарий</span></div>"
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
		СтрСоединить(Части, ""), СтилиКокпита(), "wrap", КонфигурацияСтрокой, "", Настройки);
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
		+ "filter:function(cat){var cards=document.querySelectorAll('.card');"
		+ "for(var i=0;i<cards.length;i++){var c=cards[i];"
		+ "c.style.display=(cat==='all'||c.getAttribute('data-cat')===cat)?'':'none';}"
		+ "var ch=document.querySelectorAll('.chipf');"
		+ "for(var j=0;j<ch.length;j++){ch[j].setAttribute('aria-pressed',"
		+ "String(ch[j].getAttribute('data-cat')===cat));}},"
		+ "openPal:function(){var s=document.getElementById('scrim');"
		+ "if(s){s.classList.remove('hidden');}var i=document.getElementById('palInput');"
		+ "if(i){i.focus();}PF1C.palRefresh();},"
		+ "closePal:function(){var s=document.getElementById('scrim');if(s){s.classList.add('hidden');}},"
		+ "palIdx:0,palItems:[],"
		+ "palActions:function(){var a=[{t:'Дашборд',k:'page',c:'open:ПерфДашборд'},"
		+ "{t:'Топ-100 по сценариям',k:'page',c:'open:ПерфТопКонфигураций'},"
		+ "{t:'Сравнение стендов',k:'page',c:'open:ПерфСравнениеСтендов'},"
		+ "{t:'История замеров',k:'page',c:'open:ПерфИсторияЗамеров'},"
		+ "{t:'Запустить все последовательно',k:'action',c:'all'},"
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
		+ "html+=""<li class='""+(i===PF1C.palIdx?'sel':'')+""' data-pf='palpick:""+i+""'>""+it.t+'</li>';}"
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
		+ "var r=c.querySelector('.mr-fill');if(r){var v=(p<0?0:(p>100?100:p));"
		+ "r.style.strokeDashoffset=String(75.4*(1-v/100));}"
		+ "var s=c.querySelector('.status');if(s&&txt){s.innerHTML=txt;}},"
		+ "result:function(n,cls,txt){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "var r=c.querySelector('.result');if(r){r.className='result '+(cls||'');"
		+ "r.innerHTML=txt||'';}},"
		+ "kpi:function(done,avg,slow,slowTitle,last){var e;"
		+ "e=document.getElementById('kDone');if(e){e.innerHTML=done;}"
		+ "e=document.getElementById('heroRing');"
		+ "if(e){e.style.strokeDashoffset=String(326.7*(1-done/PF1C.total));}"
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
