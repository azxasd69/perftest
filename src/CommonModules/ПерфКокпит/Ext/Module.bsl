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
// ПовторовПрогона - фактические повторы из шапки (не из каталога): иначе подпись
// в карточке расходится с тем, сколько прогонов будет сделано.
Функция КарточкаHTML(Номер, Сценарий, Ширина, ПовторовПрогона = 0)
	Порция = Формат(Сценарий.Порция, "ЧГ=3");
	Кат = КатегорияСценария(Сценарий.Имя);
	// Карточка-строка: в одну линию номер, название, код и медиана, детали и кнопка -
	// в раскрывающейся части. Раскрытие только на наведение и на завершение.
	Возврат "<section class='tile card row span-" + Ширина + " state-idle' id='card" + Номер
		+ "' data-cat='" + Кат.Код + "'>"
		+ "<i class='edge'></i><i class='fill'></i>"
		+ "<div class='r'><span class='idx'>" + Формат(Номер, "ЧЦ=2; ЧВН=; ЧГ=") + "</span>"
		+ "<h3 class='nm'>" + Экранировать(Сценарий.Представление) + "</h3>"
		+ "<span class='code'>" + Экранировать(Сценарий.Имя) + "</span>"
		+ "<span class='val'>&mdash;</span>"
		+ "<span class='badge'>&mdash;</span></div>"
		+ "<div class='more'><div class='more-in'>"
		+ "<span class='desc'>" + Порция + " " + Экранировать(Сценарий.Единица)
		+ " &middot; <span class='reps' data-reps='1'>повторов " + Формат(?(ПовторовПрогона > 0, ПовторовПрогона, Сценарий.Повторов), "ЧН=0; ЧГ=") + "</span></span>"
		+ "<button class='btn primary' data-pf='run:" + Номер + "'>Запустить</button>"
		+ "</div>"
		+ ТекстКарточкиHTML(Сценарий)
		+ "<p class='result'></p></div></section>";
КонецФункции

// Суть и реализация сценария: два абзаца в раскрывающейся части карточки (ТЗ ФТ-02).
// Тексты приходят из формы (ТекстСути/ТекстРеализации), где числа взяты из порции;
// если их нет, абзацы не выводятся и карточка остается рабочей.
Функция ТекстКарточкиHTML(Сценарий)
	Текст = "";
	Если Сценарий.Свойство("Суть") И Не ПустаяСтрока(Сценарий.Суть) Тогда
		Текст = Текст + "<p class='why'>" + Экранировать(Сценарий.Суть) + "</p>";
	КонецЕсли;
	Если Сценарий.Свойство("Реализация") И Не ПустаяСтрока(Сценарий.Реализация) Тогда
		Текст = Текст + "<p class='why why-impl'>" + Экранировать(Сценарий.Реализация) + "</p>";
	КонецЕсли;
	Возврат Текст;
КонецФункции

// Полная страница кокпита.
Функция Страница(СтендСтрокой, Повторов, Сценарии, ПлатформаСтрокой, КонфигурацияСтрокой,
	Настройки = Неопределено) Экспорт
	// Каркас страницы (head, общие стили, боковая панель, тема) собирает
	// ПерфUI.Документ: здесь остается только контент кокпита.
	Части = Новый Массив;

	// Верхняя панель в одну строку: бренд, переходы по отчетам, параметры прогона,
	// меню (палитра) и пуск/стоп. На узком окне строка переносится.
	Средняя = "<label class='field'><span>стенд</span>"
		+ "<input class='stand-input' id='stand' value='" + Экранировать(СтендСтрокой) + "'"
		+ " placeholder='по сеансу' spellcheck='false' data-pf-field='stand'></label>"
		+ "<label class='field'><span>повторов</span>"
		+ "<input class='rep-input' type='number' min='1' max='9' value='"
		+ Формат(Повторов, "ЧН=0; ЧГ=") + "' data-pf-field='rep'></label>";
	Правая = "<button class='btn menu' data-pf='pal'>Меню</button>"
		+ "<span class='bar-actions'>"
		+ "<button class='btn primary' id='runAll' data-pf='runall'>Запустить все</button>"
		+ "<button class='btn danger' id='stop' disabled data-pf='send:stop'>Стоп</button>"
		+ "</span>";
	Части.Добавить(ПерфUI.Шапка("НачальнаяСтраница", Средняя, Правая));

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
		+ "</section>");
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
		Ширина = 12; // карточка-строка занимает всю ширину сетки
		Части.Добавить(КарточкаHTML(Номер, Сценарий, Ширина, Повторов));
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
		// run(n): карточка сразу переходит в «выполняется», кнопки блокируются
		// (stop разблокируется): состояние ставит JS, а не вызов из 1С.
		+ "run:function(n){this.busy=true;this.state(n,'run');this.lock(true);this.send('run:'+n);},"
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
		+ "{t:'Журнал обмена',k:'page',c:'open:ПерфОбменЖурнал'},"
		+ "{t:'Отправить очередь сейчас',k:'action',c:'exchange:send'},"
		+ "{t:'Проба каналов обмена',k:'action',c:'exchange:probe'},"
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
		+ "c.className='tile card row'+(sp?' '+sp:'')+' state-'+st;"
		+ "var b=c.querySelector('.badge');if(b){b.className='badge '+st;"
		+ "b.innerHTML=(st==='run'?'выполняется':st==='ok'?'готово':st==='err'?'ошибка':"
		+ "st==='cancel'?'отменено':'-');}},"
		+ "progress:function(n,p,txt){var c=document.getElementById('card'+n);if(!c){return;}"
		+ "var v=(p<0?0:(p>100?100:p)),f=c.querySelector('.fill');"
		+ "if(f){var s=(v/100);f.style.webkitTransform='scaleX('+s+')';"
		+ "f.style.transform='scaleX('+s+')';}"
		+ "if(v<100){var q=c.querySelector('.val');if(q){q.innerHTML=v+'<i>%</i>';}}},"
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
		+ "var q=c.querySelector('.val');"
		+ "if(q){q.innerHTML=(res==='ok'?((median||0)+'<i>мс</i>'):'&mdash;');}"
		+ "c.setAttribute('data-median',median||0);PF1C.refreshKpi();"
		// Во время общего прогона кнопки не разблокируются: иначе «Стоп» гаснет
		// после первой же карточки, а «Запустить все» остается нажимаемой.
		+ "var own=c.querySelector('.btn');if(own){own.disabled=false;}"
		+ "if(!PF1C.busy){PF1C.lock(false);}},"
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
		// all(): очередь из всех карточек - блокировка ставится до первой
		// команды, иначе кнопка «Запустить все» остаётся нажимаемой.
		+ "all:function(){this.busy=true;this.lock(true);this.send('all');},"
		// end(): прогон закончился (очередь пуста, отмена или сбой) - снять
		// блокировку целиком.
		+ "end:function(){this.busy=false;this.lock(false);},"
		// setReps(n): подписи «повторов N» в карточках - по фактическому значению
		// из шапки, чтобы при смене поля они не оставались старыми.
		+ "setReps:function(n){var e=document.querySelectorAll('.reps');"
		+ "for(var i=0;i<e.length;i++){e[i].innerHTML='повторов '+n;}},"
		+ "status:function(txt){var s=document.getElementById('stat');if(s){s.innerHTML=txt;}},"
		+ "stand:function(v){var s=document.getElementById('stand');if(s){s.value=v;}"
		+ "var t=document.getElementById('stat');if(t){t.innerHTML='Готов к работе. Стенд: <b>'+v+'</b>';}}};"
		+ "if(PF1Cbase.clear){PF1C.clear=PF1Cbase.clear;}"
		+ "if(PF1Cbase.send){PF1C.send=PF1C.send||PF1Cbase.send;}"
		// Подгонка строк под окно: свободная высота делится на число строк
		// в пределах 46..58 px - без полос и без давки.
		+ "PF1C.pfFit=function(){var r=document.querySelectorAll('.card.row');if(!r.length){return;}"
		+ "var top=r[0].getBoundingClientRect().top;"
		+ "var avail=window.innerHeight-top-12;"
		+ "var h=Math.floor(avail/r.length)-8;"
		+ "if(h<46){h=46;}if(h>58){h=58;}"
		+ "document.documentElement.style.setProperty('--pf-row-h',h+'px');};"
		+ "window.addEventListener('load',function(){PF1C.pfFit();});"
		+ "window.addEventListener('resize',function(){PF1C.pfFit();});"
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

// Суть и реализация сценария для карточки. Тексты живут в модуле страницы,
// а не в форме: их используют и форма, и выгрузка страниц для дизайна
// (режим /C ПерфДампСтраниц), иначе карточки в выгрузке выходили без описаний.
Функция ТекстСути(НомерКарточки) Экспорт
	Если НомерКарточки = 1 Тогда
		Возврат "Суть: скорость исполнения встроенного языка на чистой арифметике - базовый потолок CPU без обращений к данным ИБ.";
	ИначеЕсли НомерКарточки = 2 Тогда
		Возврат "Суть: конвейер строковых операций - буферизация конкатенации через массив и поиск подстроки в склеенной строке.";
	ИначеЕсли НомерКарточки = 3 Тогда
		Возврат "Суть: менеджер памяти и хеш-таблицы встроенных коллекций - аллокации, вставки, полный обход.";
	ИначеЕсли НомерКарточки = 4 Тогда
		Возврат "Суть: скорость точечной записи в файловую ИБ (dbeng8.dll в процессе клиента): транзакция на каждый объект и сброс страниц на диск - здесь заметны замененные библиотеки.";
	ИначеЕсли НомерКарточки = 5 Тогда
		Возврат "Суть: те же записи справочника в одной большой транзакции; показывает цену пообъектных транзакций (контраст с карточкой 4).";
	ИначеЕсли НомерКарточки = 6 Тогда
		Возврат "Суть: полный конвейер документа: объект + табличная часть + обработка проведения + движения регистра накопления + индексы.";
	ИначеЕсли НомерКарточки = 7 Тогда
		Возврат "Суть: планировщик и исполнитель запросов: построение плана, чтение индексов, агрегация СУММА/КОЛИЧЕСТВО.";
	ИначеЕсли НомерКарточки = 8 Тогда
		Возврат "Суть: скорость сериализации в JSON и обратного разбора - обмены, HTTP-сервисы, интеграции.";
	ИначеЕсли НомерКарточки = 9 Тогда
		Возврат "Суть: внутренняя сериализация платформы (ЗначениеВСтрокуВнутр) - хранилища настроек, передачи клиент-сервер.";
	ИначеЕсли НомерКарточки = 10 Тогда
		Возврат "Суть: аллокатор платформы на множестве коротких строк - стоимость создания элементов и освобождения коллекции.";
	ИначеЕсли НомерКарточки = 11 Тогда
		Возврат "Суть: файловый ввод-вывод средствами платформы (ЗаписьТекста/ЧтениеТекста, UTF-8) сквозь кэш записи ОС.";
	КонецЕсли;
	Возврат "";
КонецФункции

// Реализация сценария словами. Числа не хардкодятся: порция берётся из каталога
// сценариев (СписокСценариев), поэтому текст не может разойтись с прогоном.
Функция ТекстРеализации(НомерКарточки, Сценарий) Экспорт
	Порция = Формат(Сценарий.Порция, "ЧГ=3");
	Если НомерКарточки = 1 Тогда
		Возврат "Реализация: цикл " + Порция + " итераций: умножение, деление, сравнение, присваивание; аккумулятор фиктивный (защита от выбрасывания вычислений).";
	ИначеЕсли НомерКарточки = 2 Тогда
		Возврат "Реализация: буфер-массив на " + Порция + " сегментов «0123456789abcdef+N», СтрСоединить в одну строку, затем СтрНайти «abcde» со сдвигом позиции на 10 символов; число поисков - длина строки / 10.";
	ИначеЕсли НомерКарточки = 3 Тогда
		Возврат "Реализация: " + Порция + " добавлений параллельно в Массив и Соответствие, затем полный обход Соответствия с накоплением суммы; коллекции освобождаются.";
	ИначеЕсли НомерКарточки = 4 Тогда
		Возврат "Реализация: " + Порция + " элементов справочника «Номенклатура (тест)», каждый - СоздатьЭлемент, Записать(); очистка тестовых элементов перед прогоном (вне замера).";
	ИначеЕсли НомерКарточки = 5 Тогда
		Возврат "Реализация: НачатьТранзакцию, " + Порция + " записей, ЗафиксироватьТранзакцию; при ошибке - ОтменитьТранзакцию.";
	ИначеЕсли НомерКарточки = 6 Тогда
		Возврат "Реализация: " + Порция + " документов «Поступление (тест)» по 5 строк, каждый - Записать(Проведение), движений - по одному на строку; номенклатура/склад готовятся вне замера.";
	ИначеЕсли НомерКарточки = 7 Тогда
		Возврат "Реализация: " + Порция + " пакетов по два запроса: остатки виртуальной таблицы регистра накопления с группировкой и группировка по справочнику; данные создаются при нехватке (вне замера).";
	ИначеЕсли НомерКарточки = 8 Тогда
		Возврат "Реализация: " + Порция + " структур «имя-цена-признак»: ЗаписатьJSON в строку, затем ПрочитатьJSON обратно; построение массива вне замера.";
	ИначеЕсли НомерКарточки = 9 Тогда
		Возврат "Реализация: массив " + Порция + " чисел; три полных цикла ЗначениеВСтрокуВнутр -> ЗначениеИзСтрокиВнутр.";
	ИначеЕсли НомерКарточки = 10 Тогда
		Возврат "Реализация: " + Порция + " коротких строк «элемент-N» в массив, замер построения, затем освобождение.";
	ИначеЕсли НомерКарточки = 11 Тогда
		// Объём файла выводится из порции: строка = "строка-N | " (около 11 символов) + 90 символов линии.
		Возврат "Реализация: запись " + Порция + " строк по ~104 символа (~"
			+ Формат(Сценарий.Порция * 104 / 1024, "ЧДЦ=0; ЧГ=0") + " КБ) во временный файл, построчное чтение с подсчетом длины, удаление файла.";
	КонецЕсли;
	Возврат "";
КонецФункции

// Экранирование текста для HTML.
Функция Экранировать(Значение) Экспорт
	Результат = СтрЗаменить(Строка(Значение), "&", "&amp;");
	Результат = СтрЗаменить(Результат, "<", "&lt;");
	Результат = СтрЗаменить(Результат, ">", "&gt;");
	Возврат СтрЗаменить(Результат, """", "&quot;");
КонецФункции
