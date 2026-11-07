// ПерфUI - единая библиотека оформления кокпита.
//
// Один источник правды по токенам и компонентам шаблона index-v3:
// палитра, типографика 1080p (база 16 px), сетка bento, шапка, плитки KPI,
// карточки, таблицы, поля, кнопки, состояния и палитра команд.
//
// Все потребители (панель, отчеты, списки, формы) собирают страницу через
// ПерфUI.Страница: заголовок плюс объединенные стили и тело.
// чтобы не дублировать CSS в каждом модуле.
//
// Ограничения движка HTML-поля 1С: нет flex-gap, oklch, color-mix, clamp,
// backdrop-filter; sticky только с префиксом -webkit-.

Функция Стили() Экспорт
																												Возврат "<style>"
		+ "html{--pf-bg:#FBF8FF;--pf-sunken:#F7F3FF;--pf-surface:#FFFFFF;--pf-raised:#F3EEFC;--pf-line:#E6E1F0;--pf-lin"
		+ "e-strong:#9C8AC6;--pf-fg:#1B1A21;--pf-fg-2:#45424F;--pf-fg-3:#6B6879;--pf-accent:#6A4CF6;--pf-accent-bg:#EDE"
		+ "8FF;--pf-on-accent:#FFFFFF;--pf-ok:#0F7A4F;--pf-ok-bg:#E2F5EC;--pf-ok-line:#0F7A4F;--pf-warn:#8A5A00;--pf-wa"
		+ "rn-bg:#FDF3E0;--pf-bad:#B3261E;--pf-bad-bg:#FBE6E5;--pf-bad-line:#F0C9C5;--pf-info:#1F5FA8;--pf-info-bg:#E3E"
		+ "FFC;--pf-hover:#F6F2FF;--pf-side-bg:#FFFFFF;--pf-side-fg:#3A3A45;--pf-scrim:rgba(27,26,33,.42);--pf-shadow-t"
		+ "ile:0 12px 26px -20px rgba(0,0,0,.55);--pf-shadow-bar:0 8px 20px rgba(6,7,10,.18)}html,body{margin:0;backgro"
		+ "und:var(--pf-bg);color:var(--pf-fg);font:14px/1.5 'Segoe UI',Arial,sans-serif;}body{padding-left:284px;overf"
		+ "low-x:hidden;max-width:100%}.wrap{max-width:1500px;width:100%;margin:0 auto;padding:16px 16px 40px;box-sizin"
		+ "g:border-box;height:100vh;overflow-y:auto;overflow-x:hidden}.bar{position:relative;z-index:40;font-size:14px"
		+ ";background:var(--pf-surface);border:1px solid var(--pf-line);border-radius:16px;padding:8px 12px;margin-bot"
		+ "tom:14px;display:-webkit-flex;display:flex;-webkit-flex-direction:column;flex-direction:column;gap:8px}.bar-"
		+ "row{display:-webkit-flex;display:flex;-webkit-align-items:center;align-items:center;-webkit-flex-wrap:wrap;f"
		+ "lex-wrap:wrap;gap:8px}.crumbles{font-size:14px;color:var(--pf-fg-2);margin-left:12px;display:-webkit-flex;di"
		+ "splay:flex;-webkit-align-items:center;align-items:center}.crumbles span{margin-right:14px}.grow{-webkit-flex"
		+ ":1 1 auto;flex:1 1 auto}.field{font-size:14px;color:var(--pf-fg-2);margin-right:12px;display:-webkit-flex;di"
		+ "splay:flex;-webkit-align-items:center;align-items:center}.field span{margin-right:6px}.field input{font:14px"
		+ " 'Segoe UI',Arial,sans-serif;color:var(--pf-fg);background:var(--pf-raised);border:1px solid var(--pf-line);"
		+ "border-radius:8px;padding:4px 8px;outline:none}.field .stand-input{width:132px}.field .rep-input{width:52px;"
		+ "text-align:center}.field input:focus{border-color:var(--pf-accent)}.btn{font:600 14px 'Segoe UI',Arial,sans-"
		+ "serif;border-radius:8px;cursor:pointer;padding:8px 12px;border:1px solid var(--pf-line);background:var(--pf-"
		+ "raised);color:var(--pf-fg);margin-left:8px}.btn:hover:not(:disabled){background:var(--pf-hover);border-color"
		+ ":var(--pf-line-strong)}.btn:disabled{opacity:.4;cursor:default}.btn.primary{background:var(--pf-accent);colo"
		+ "r:var(--pf-on-accent);border-color:transparent}.btn.primary:hover:not(:disabled){background:var(--pf-accent)"
		+ "}.btn.danger{color:var(--pf-bad);border-color:var(--pf-bad-line)}.btn.danger:hover:not(:disabled){background"
		+ ":var(--pf-bad-bg)}.btn.kbd{font-size:14px;color:var(--pf-fg-2);padding:4px 8px}.btn.kbd kbd{font-family:Cons"
		+ "olas,'Courier New',monospace;font-size:12px;background:var(--pf-raised);border:1px solid var(--pf-line);bord"
		+ "er-radius:4px;padding:0 4px;margin-left:6px}.span-2{grid-column:span 2}.span-3{grid-column:span 3}.span-4{gr"
		+ "id-column:span 4}.span-6{grid-column:span 6}.span-12{grid-column:span 12}.bento{display:grid;grid-template-c"
		+ "olumns:repeat(12,minmax(0,1fr));grid-column-gap:12px}.tile{background:var(--pf-surface);border:1px solid var"
		+ "(--pf-line);border-radius:16px;padding:16px;margin-bottom:12px;position:relative;overflow:hidden;min-width:0"
		+ ";box-sizing:border-box}.lbl{font-size:12px;letter-spacing:.1em;text-transform:uppercase;color:var(--pf-fg-2)"
		+ ";font-weight:600}.big{font-size:32px;font-weight:700;letter-spacing:-.01em;line-height:1.3;margin-top:8px;fo"
		+ "nt-family:Consolas,'Courier New',monospace}.big small{font-size:14px;color:var(--pf-fg-2);font-weight:500;le"
		+ "tter-spacing:0;font-family:'Segoe UI',Arial,sans-serif}.sub{font-size:14px;color:var(--pf-fg-2);margin-top:4"
		+ "px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.track{height:4px;border-radius:999px;backgroun"
		+ "d:var(--pf-raised);margin-top:12px;overflow:hidden}.track i{display:block;height:100%;width:0;background:var"
		+ "(--pf-accent)}.card{display:-webkit-flex;display:flex;-webkit-flex-direction:column;flex-direction:column}.e"
		+ "dge{position:absolute;left:0;top:14px;bottom:14px;width:2px;border-radius:2px;background:transparent}.idx{fo"
		+ "nt-family:Consolas,'Courier New',monospace;font-size:12px;color:var(--pf-accent);background:var(--pf-accent-"
		+ "bg);border-radius:6px;padding:0 4px;margin-right:8px}.code{font-family:Consolas,'Courier New',monospace;font"
		+ "-size:12px;color:var(--pf-fg-2);overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.badge{margin-left"
		+ ":auto;font-size:12px;font-weight:600;border-radius:999px;padding:4px 8px;background:var(--pf-raised);color:v"
		+ "ar(--pf-fg-2);white-space:nowrap}.badge.run{background:var(--pf-info-bg);color:var(--pf-info)}.badge.ok{back"
		+ "ground:var(--pf-ok-bg);color:var(--pf-ok)}.badge.err{background:var(--pf-bad-bg);color:var(--pf-bad)}.badge."
		+ "cancel{background:var(--pf-warn-bg);color:var(--pf-warn)}.p{margin:0 0 6px;font-size:14px;line-height:1.5;co"
		+ "lor:var(--pf-fg-2)}.p b{color:var(--pf-fg-2);font-weight:600}.result{display:none;margin:8px 0 0;font-size:1"
		+ "4px;font-weight:600;line-height:1.5;padding:6px 8px;border-radius:8px}.result.ok{display:block;color:var(--p"
		+ "f-ok);background:var(--pf-ok-bg)}.result.err{display:block;color:var(--pf-bad);background:var(--pf-bad-bg)}."
		+ "result.cancel{display:block;color:var(--pf-warn);background:var(--pf-warn-bg)}.log-head{margin-bottom:12px;d"
		+ "isplay:-webkit-flex;display:flex;-webkit-align-items:center;align-items:center}.log-head h2{margin:0;font-si"
		+ "ze:26px;font-weight:600;letter-spacing:-.01em}.log-head span{font-size:14px;color:var(--pf-fg-2);margin-left"
		+ ":12px}table{width:100%;border-collapse:collapse;font-size:14px}th,td{padding:8px 12px;text-align:left;border"
		+ "-bottom:1px solid var(--pf-line)}thead th{font-size:12px;letter-spacing:.1em;text-transform:uppercase;color:"
		+ "var(--pf-fg-2);font-weight:600}tbody tr:hover{background:var(--pf-raised)}td.n,th.n{text-align:right;white-s"
		+ "pace:nowrap;font-family:Consolas,'Courier New',monospace;font-size:14px}.empty{color:var(--pf-fg-2);font-siz"
		+ "e:14px;padding:12px 2px}.foot{margin-top:16px;font-size:14px;color:var(--pf-fg-2)}.scrim{position:fixed;left"
		+ ":0;top:0;right:0;bottom:0;background:var(--pf-scrim);z-index:90;padding-top:12vh}.pal{width:560px;max-width:"
		+ "92%;margin:0 auto;background:var(--pf-surface);border:1px solid var(--pf-line);border-radius:12px;overflow:h"
		+ "idden}.pal input{width:100%;box-sizing:border-box;border:0;background:transparent;color:var(--pf-fg);font:16"
		+ "px 'Segoe UI',Arial,sans-serif;padding:16px 16px;border-bottom:1px solid var(--pf-line);outline:none}.pal ul"
		+ "{list-style:none;margin:0;padding:6px;max-height:46vh;overflow:auto}.pal li{padding:8px 12px;border-radius:8"
		+ "px;font-size:14px;cursor:pointer;color:var(--pf-fg-2)}.pal li.sel{background:var(--pf-accent-bg);color:var(-"
		+ "-pf-fg)}.pal .tip{font-size:12px;color:var(--pf-fg-2);padding:8px 16px;border-top:1px solid var(--pf-line)}."
		+ "stat{position:fixed;left:272px;right:0;bottom:0;background:var(--pf-surface);border-top:1px solid var(--pf-l"
		+ "ine);padding:8px 16px;font-size:14px;color:var(--pf-fg-2);z-index:30}.stat b{color:var(--pf-fg)}.xs{font-siz"
		+ "e:12px}.big-lg{font-size:26px}.big-md{font-size:26px}.hidden{display:none}.side{position:fixed;left:0;top:0;"
		+ "bottom:0;width:272px;background:var(--pf-side-bg);color:var(--pf-side-fg);padding:16px 14px;box-sizing:borde"
		+ "r-box;z-index:50;overflow:auto;font:14px/18px 'Segoe UI',Arial,sans-serif}.side .logo{display:-webkit-flex;d"
		+ "isplay:flex;-webkit-align-items:center;align-items:center;padding:10px 8px 20px}.side .mark{width:38px;height"
		+ ":38px;margin-right:11px;background:transparent;-webkit-flex:0 0 auto;flex:0 0 auto}.side .logo b{color:var(--pf-fg);font-"
		+ "size:15px;font-weight:600;display:block;letter-spacing:-.01em}.side .logo span{font-size:11.5px;color:var(--pf-fg-2);letter-spacing:"
		+ "0;text-transform:none;margin-top:3px;display:block}.side a{display:-webkit-flex;display:flex;-webkit-align-items:center;align-it"
		+ "ems:center;color:var(--pf-side-fg);text-decoration:none;font-size:14px;line-height:20px;padding:8px 12px;bor"
		+ "der-radius:8px;margin-bottom:2px}.side a:hover{background:var(--pf-hover);color:var(--pf-fg)}.side a.active{"
		+ "background:var(--pf-accent-bg);color:var(--pf-accent);box-shadow:inset 2px 0 0 var(--pf-accent)}.side-foot{m"
		+ "argin-top:16px;border-top:1px solid var(--pf-sunken);padding:12px 12px 4px;font-size:12px;color:var(--pf-fg-"
		+ "2)}.side-foot .dot{width:6px;height:6px;border-radius:50%;background:var(--pf-ok-line);display:inline-block;"
		+ "margin-right:6px}.nav-i svg{width:15px;height:15px;margin-right:9px;flex:0 0 15px;display:block;color:var(--"
		+ "pf-fg-2)}.nav-i:hover svg{color:var(--pf-side-fg)}.nav-i.active svg{color:var(--pf-accent)}.nav-i .nm{overfl"
		+ "ow:hidden;text-overflow:ellipsis;white-space:nowrap}.side-stand{margin:10px 2px 0;padding:12px 12px 10px;bor"
		+ "der:1px solid var(--pf-line);border-radius:8px;background:var(--pf-sunken)}.ss-h{font-size:12px;color:var(--"
		+ "pf-fg-2);font-weight:600;margin-bottom:8px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}.ss-r{d"
		+ "isplock;font-size:12px;line-height:14px;padding:4px 0}.ss-r span{display:block;color:var(--pf-fg-3);text-tra"
		+ "nsform:uppercase;letter-spacing:.04em;font-size:10px}.ss-r b{display:block;color:var(--pf-side-fg);font-weig"
		+ "ht:600;text-align:left;line-height:16px;font-size:12px;white-space:nowrap;overflow:hidden;text-overflow:elli"
		+ "psis}body.pf-collapsed{padding-left:76px !important}body.pf-collapsed .stat{left:60px !important}body.pf-col"
		+ "lapsed .side{width:60px !important;padding:16px 8px !important}body.pf-collapsed .side .logo{-webkit-justify"
		+ "-content:center;justify-content:center;padding:6px 0 14px}body.pf-collapsed .side a{font-size:0 !important;p"
		+ "adding:0 !important;width:34px;height:34px;margin:0 auto 6px;-webkit-justify-content:center;justify-content:"
		+ "center}body.pf-collapsed .side a .nm{display:none !important}body.pf-collapsed .side a svg{width:17px;height"
		+ ":17px;margin:0 auto !important}.side a .dot-n{width:8px;height:8px;border-radius:50%;background:var(--pf-fg-"
		+ "3);display:inline-block;margin-right:9px}body.pf-collapsed .side a .dot-n{display:none}.side a.active .dot-n"
		+ "{background:var(--pf-accent)}.nav-btn{position:absolute;top:12px;right:-12px;width:24px;height:24px;border-r"
		+ "adius:50%;background:var(--pf-raised);color:var(--pf-side-fg);border:1px solid var(--pf-line);cursor:pointer"
		+ ";font:600 12px 'Segoe UI',Arial,sans-serif;padding:0;z-index:51}.nav-btn:hover{background:var(--pf-hover);co"
		+ "lor:var(--pf-fg)}.card:hover{border-color:var(--pf-line-strong);background:var(--pf-hover)}.btn:active:not(:"
		+ "disabled){transform:translateY(1px)}tbody tr{-webkit-transition:background .12s;transition:background .12s}."
		+ "chips{display:flex;flex-wrap:wrap;align-items:center}.chips .badge{margin:0 6px 6px 0}.subtle{color:var(--pf"
		+ "-fg-2);font-size:12px;font-weight:400}.tile:hover{border-color:var(--pf-line-strong);background:var(--pf-hov"
		+ "er)}.tile[data-pf]{cursor:pointer}.tile-flat:hover{border-color:var(--pf-line);background:var(--pf-surface)}"
		+ ".tile[data-pf]:active{background:var(--pf-raised)}.side a[data-pf='theme']{margin-top:6px}body.pf-collapsed "
		+ ".side a[data-pf='theme']{margin-top:14px}/* категория: цвет номера и метки строки */.card[data-cat='cpu'],.c"
		+ "hipf[data-cat='cpu']{--cat:#2F6FD0}.card[data-cat='ib'],.chipf[data-cat='ib']{--cat:#5C8A16}.card[data-cat='"
		+ "q'],.chipf[data-cat='q']{--cat:#7B4BE0}.card[data-cat='ser'],.chipf[data-cat='ser']{--cat:#A96A12}.card[data"
		+ "-cat='mem'],.chipf[data-cat='mem']{--cat:#0E8C80}.card[data-cat='io'],.chipf[data-cat='io']{--cat:#C2417F}.c"
		+ "ard[data-cat] .idx{color:var(--cat)}.hero,.card{position:relative}/* hero-плитка */.hero{display:-webkit-fle"
		+ "x;display:flex;-webkit-align-items:center;align-items:center;overflow:hidden;background:linear-gradient(150d"
		+ "eg,var(--pf-accent-bg),var(--pf-surface) 62%)}.hero:hover{background:linear-gradient(150deg,var(--pf-accent-"
		+ "bg),var(--pf-surface) 62%)}.hero .ring{width:96px;height:96px;-webkit-flex:0 0 96px;flex:0 0 96px;margin-rig"
		+ "ht:18px;-webkit-transform:rotate(-90deg);transform:rotate(-90deg)}.ring-bg{fill:none;stroke:var(--pf-accent)"
		+ ";opacity:.42;stroke-width:10}.ring-fill{fill:none;stroke:var(--pf-accent);stroke-width:10;stroke-linecap:rou"
		+ "nd;stroke-dasharray:326.7;stroke-dashoffset:326.7;-webkit-transition:stroke-dashoffset .5s ease;transition:s"
		+ "troke-dashoffset .5s ease}.hero-txt{min-width:0}/* чипы-фильтры */.chips-bar{display:-webkit-flex;display:fl"
		+ "ex;-webkit-flex-wrap:wrap;flex-wrap:wrap;-webkit-align-items:center;align-items:center;margin:0 0 12px}.chip"
		+ "f{font-family:inherit;font-size:12px;font-weight:600;color:var(--pf-fg-2);background:var(--pf-surface);borde"
		+ "r:1px solid var(--pf-line);border-radius:999px;padding:6px 12px;margin:0 8px 6px 0;cursor:pointer;display:-w"
		+ "ebkit-inline-flex;display:inline-flex;-webkit-align-items:center;align-items:center}.chipf:hover{background:"
		+ "var(--pf-hover);color:var(--pf-fg)}.chipf[aria-pressed='true']{background:var(--pf-accent-bg);border-color:v"
		+ "ar(--pf-accent);color:var(--pf-fg)}.chipf .dot{width:7px;height:7px;border-radius:50%;background:var(--cat,#"
		+ "8A8F98);margin-right:7px}.chipf .c{font-size:11px;color:var(--pf-fg-3);margin-left:6px}.chips-info{font-size"
		+ ":12px;color:var(--pf-fg-2);margin-left:auto}/* мягкие состояния и фокус */.tile{-webkit-transition:backgroun"
		+ "d .04s,border-color .04s,box-shadow .04s;transition:background .04s,border-color .04s,box-shadow .04s}.card{"
		+ "-webkit-transition:none;transition:none}.tile:hover{box-shadow:var(--pf-shadow-tile)}.row{padding:0;border-r"
		+ "adius:10px;margin-bottom:8px}.row .r{display:flex;align-items:center;height:var(--pf-row-h,50px);padding:0 1"
		+ "2px}.row .nm{margin:0;font-size:14px;font-weight:600;flex:1 1 auto;min-width:0;white-space:nowrap;overflow:h"
		+ "idden;text-overflow:ellipsis}.row .code{margin-left:12px;flex:0 1 auto}.row .idx{margin-right:10px}.row .val"
		+ "{font:600 14px/1 Consolas,'Courier New',monospace;min-width:72px;text-align:right;margin-left:12px}.row .val"
		+ " i{font:500 11px/1 'Segoe UI',Arial,sans-serif;font-style:normal;color:var(--pf-fg-3);margin-left:3px}.row ."
		+ "badge{margin-left:10px}.row.state-idle .badge{display:none}.row .edge{top:12px;bottom:12px;width:3px;border-"
		+ "radius:2px;background:var(--cat)}.row .fill{position:absolute;left:0;top:0;bottom:0;right:0;background:var(-"
		+ "-pf-info-bg);opacity:.5;-webkit-transform:scaleX(0);transform:scaleX(0);-webkit-transform-origin:0 50%;trans"
		+ "form-origin:0 50%;-webkit-transition:-webkit-transform .18s linear;transition:transform .18s linear}.row.sta"
		+ "te-ok .fill{background:var(--pf-ok-bg);opacity:.28;-webkit-transform:scaleX(1);transform:scaleX(1)}.row.stat"
		+ "e-err .fill{background:var(--pf-bad-bg);opacity:.4;-webkit-transform:scaleX(1);transform:scaleX(1)}.row.stat"
		+ "e-cancel .fill{background:var(--pf-warn-bg);opacity:.4;-webkit-transform:scaleX(1);transform:scaleX(1)}.row "
		+ ".more{display:none;padding:0 12px 10px 46px}.row:hover .more,.row:focus-within .more,.row.state-ok .more,.ro"
		+ "w.state-err .more,.row.state-cancel .more{display:block}.row .more-in{display:flex;align-items:flex-start}.r"
		+ "ow .desc{flex:1 1 auto;min-width:0;font-size:12px;color:var(--pf-fg-2);margin-right:12px}.row .btn{margin-le"
		+ "ft:auto;padding:5px 12px;font-size:12.5px;flex:0 0 auto}.row .result{margin:8px 0 0;font-size:12px}.tile-fla"
		+ "t:hover{box-shadow:none}html.kbd .btn:focus,html.kbd .chipf:focus,html.kbd .field input:focus,html.kbd a:foc"
		+ "us,html.kbd .pal input:focus{outline:2px solid var(--pf-accent);outline-offset:2px}.pal input:focus{outline:"
		+ "2px solid var(--pf-accent);outline-offset:2px}.p .pl{display:block;font-size:10px;font-weight:700;letter-spa"
		+ "cing:.09em;text-transform:uppercase;color:var(--cat,#8A8F98);margin:0 0 2px}.bar-single{position:fixed;left:"
		+ "284px;right:0;top:0;z-index:45;display:block;margin:0;padding:0;border-radius:0 0 14px 14px;border-top:0;bor"
		+ "der-left:0;border-right:0;-webkit-box-shadow:var(--pf-shadow-bar);box-shadow:var(--pf-shadow-bar)}.bar-in{di"
		+ "splay:-webkit-flex;display:flex;-webkit-flex-wrap:wrap;flex-wrap:wrap;-webkit-align-items:center;align-items"
		+ ":center;max-width:1500px;margin:0 auto;padding:9px 16px}#barspace{height:60px}body.pf-collapsed .bar-single{"
		+ "left:76px}.bar-actions{display:-webkit-inline-flex;display:inline-flex;-webkit-align-items:center;align-item"
		+ "s:center;margin-left:4px}.bar-right{display:-webkit-flex;display:flex;-webkit-flex-wrap:wrap;flex-wrap:wrap;"
		+ "-webkit-align-items:center;align-items:center;margin-left:auto}.bar-nav{display:-webkit-flex;display:flex;-w"
		+ "ebkit-align-items:center;align-items:center;background:var(--pf-raised);border:1px solid var(--pf-line);bord"
		+ "er-radius:10px;padding:2px}.bar-nav .btn{margin-left:0;padding:5px 9px;font-size:13px;border-color:transpare"
		+ "nt;background:transparent;color:var(--pf-fg-2);border-radius:8px}.bar-nav .btn:hover:not(:disabled){backgrou"
		+ "nd:var(--pf-surface);border-color:var(--pf-line);color:var(--pf-fg)}.bar-nav .btn + .btn{margin-left:2px}.ba"
		+ "r-single .field{margin-right:10px}.btn.menu{display:-webkit-inline-flex;display:inline-flex;-webkit-align-it"
		+ "ems:center;align-items:center;color:var(--pf-fg-2)}.btn.menu:hover:not(:disabled){color:var(--pf-fg)}.hero-h"
		+ "int{font-size:12px;color:var(--pf-fg-2)}.hero .lbl{margin-bottom:6px}html.pf-dark{--pf-bg:#292D36;--pf-sunke"
		+ "n:#232730;--pf-surface:#363A44;--pf-raised:#40444E;--pf-line:#4B4F59;--pf-line-strong:#A8ACB8;--pf-fg:#EDF0F"
		+ "7;--pf-fg-2:#B6BAC5;--pf-fg-3:#ACB0BC;--pf-accent:#C0A4FF;--pf-accent-bg:#3E3466;--pf-on-accent:#171226;--pf"
		+ "-ok:#63E3AB;--pf-ok-bg:#2B4A3D;--pf-ok-line:#3ACB93;--pf-warn:#F5C273;--pf-warn-bg:#4A3D26;--pf-bad:#FF9689;"
		+ "--pf-bad-bg:#4E3036;--pf-bad-line:#6E444A;--pf-info:#94C6FF;--pf-info-bg:#2E3E5C;--pf-hover:#484D56;--pf-sid"
		+ "e-bg:#20242C;--pf-side-fg:#C2C6D2;--pf-scrim:rgba(16,18,22,.6);--pf-shadow-tile:0 12px 26px -6px rgba(0,0,0,"
		+ ".55);--pf-shadow-bar:0 10px 24px rgba(0,0,0,.45)}html.pf-dark .card[data-cat='cpu'],html.pf-dark .chipf[data"
		+ "-cat='cpu']{--cat:#6EA8FE}html.pf-dark .card[data-cat='ib'],html.pf-dark .chipf[data-cat='ib']{--cat:#C4F252"
		+ "}html.pf-dark .card[data-cat='q'],html.pf-dark .chipf[data-cat='q']{--cat:#B49CFF}html.pf-dark .card[data-ca"
		+ "t='ser'],html.pf-dark .chipf[data-cat='ser']{--cat:#F0B45A}html.pf-dark .card[data-cat='mem'],html.pf-dark ."
		+ "chipf[data-cat='mem']{--cat:#59D3C8}html.pf-dark .card[data-cat='io'],html.pf-dark .chipf[data-cat='io']{--c"
		+ "at:#F58FBF}.good{color:var(--pf-ok)}.bad{color:var(--pf-bad)}.warn{color:var(--pf-warn)}.tile .log-head h2{f"
		+ "ont-size:20px}.lbl .badge{text-transform:none;letter-spacing:0}.tw{overflow-x:auto}.tw table{font-size:13px}"
		+ ".tw th,.tw td{padding:6px 10px}.tw-wide th,.tw-wide td{white-space:nowrap}.bento{-webkit-align-items:start;a"
		+ "lign-items:start}.tile .track{max-width:320px}.spark svg{display:block;margin:2px 0 6px;max-width:100%}.foot"
		+ " b{color:var(--pf-fg)}.field select{font:14px 'Segoe UI',Arial,sans-serif;color:var(--pf-fg);background:var("
		+ "--pf-raised);border:1px solid var(--pf-line);border-radius:8px;padding:5px 8px;max-width:340px;outline:none}"
		+ ".field select:focus{border-color:var(--pf-accent)}.kv{display:grid;grid-template-columns:minmax(120px,32%) 1"
		+ "fr;gap:8px 16px;margin:0}.kv dt{margin:0;font-size:13px;line-height:1.45;color:var(--pf-fg-2)}.kv dd{margin:"
		+ "0;font-size:14px;line-height:1.45;overflow-wrap:anywhere}@media (max-width:1100px){.kv{grid-template-columns"
		+ ":1fr}.kv dt{margin-top:6px}}html.pf-dark th,html.pf-dark td{border-bottom-color:var(--pf-hover)}html.pf-dark"
		+ " tbody tr:nth-child(even):not(:hover){background:var(--pf-sunken)}.side,.wrap{scrollbar-width:none;-ms-overf"
		+ "low-style:none}::-webkit-scrollbar{display:none}.side{overflow-x:hidden}body.pf-collapsed .sec-h{display:non"
		+ "e}.sec{margin:0}.sec-h{display:flex;-webkit-align-items:center;align-items:center;width:100%;font:600 12px/1"
		+ " 'Segoe UI',Arial,sans-serif;letter-spacing:.1em;text-transform:uppercase;color:var(--pf-fg-2);padding:14px "
		+ "12px 8px;border:0;background:none;cursor:pointer;text-align:left}.sec-h:hover{color:var(--pf-fg)}.sec-h .che"
		+ "v{display:block;width:7px;height:7px;margin-left:auto;border-right:1.6px solid currentColor;border-bottom:1."
		+ "6px solid currentColor;-webkit-transform:rotate(45deg);transform:rotate(45deg);-webkit-transition:-webkit-tr"
		+ "ansform .15s;transition:transform .15s}.sec.closed .chev{-webkit-transform:rotate(-45deg);transform:rotate(-"
		+ "45deg)}.sec.closed>*:not(.sec-h){display:none}body.pf-collapsed .logo-t,body.pf-collapsed .side-stand,body.p"
		+ "f-collapsed .side-foot{display:none}body.pf-collapsed .side{overflow:hidden}.logo .mark{display:-webkit-flex"
		+ ";display:flex;-webkit-align-items:center;align-items:center;-webkit-justify-content:center;justify-content:c"
		+ "enter}.logo .mark svg{width:100%;height:100%;display:block}"
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
	Результат = СтрЗаменить(Результат, """", "&quot;");
	// Атрибуты в разметке стоят в одинарных кавычках: без этой замены
	// имя стенда с апострофом ломает атрибут (аудит 07.11.2026, п.7).
	Возврат СтрЗаменить(Результат, "'", "&#39;");
КонецФункции

// ---------------------------------------------------------------------------
// Блок: темы. Палитры живут рядом со структурой: базовая (светлая) - в Стили(),
// тёмная - переопределением токенов html.pf-dark. Переключение: PFTheme.toggle().
// ---------------------------------------------------------------------------

// Скрипт темы: применяет сохраненное состояние и переключает по кнопке.

// Текущая тема приложения: "light" или "dark" (по умолчанию темная, как стиль 1С).

// Сохраняет выбор темы (команда theme:<имя> от кнопки на странице).

// Скрипт темы: применяет светлую или темную и (опционально) создает кнопку.
// Тема выбирается сама, без участия пользователя: сохраненный выбор приложения,
// иначе системная тема (prefers-color-scheme), иначе темная.
// ПоказыватьКнопку = Ложь - страница без переключателя (карточка стенда).
// Настройки интерфейса хранятся в константах: значение живет в базе, поэтому
// переживает и переход между формами, и перезапуск, и смену рабочего места.

// Настройки интерфейса: тема и состояние панели.
// Значения берутся из констант; чтение через Получить(), а не запросом:
// у таблицы одиночной константы поле называется "Константа", и запрос к
// Т.ПерфТемаСветлая падал с "Поле не найдено", ошибка глоталась Попыткой.
Функция ПрочитатьНастройки() Экспорт

	Настройки = Новый Структура("Тема, Панель, Свернута, Версия", "dark", "expanded", Ложь, "dark|expanded");
	Попытка
		// Константы в запросе читаются через префикс "Константы" и имя константы:
		// значение приходит как Булево (Истина = светлая тема).
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	Константы.ПерфТемаСветлая КАК ТемаСветлая,
			|	Константы.ПерфПанельСвернута КАК ПанельСвернута";
		Выборка = Запрос.Выполнить().Выбрать();
		Если Выборка.Следующий() Тогда
			Настройки.Тема = ?(Выборка.ТемаСветлая, "light", "dark");
			Настройки.Свернута = Выборка.ПанельСвернута;
			Настройки.Панель = ?(Настройки.Свернута, "collapsed", "expanded");
		КонецЕсли;
	Исключение
		// Устаревшая выгрузка без констант оформления - значения по умолчанию.
		СведенияОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;
	Настройки.Версия = Настройки.Тема + "|" + Настройки.Панель;
	Возврат Настройки;

КонецФункции

Функция ВерсияНастроек() Экспорт

	Возврат ПрочитатьНастройки().Версия;

КонецФункции

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

Функция ТемаПриложения() Экспорт

	Возврат ПрочитатьНастройки().Тема;

КонецФункции

Процедура СохранитьТемуПриложения(Тема) Экспорт

	Если Тема <> "light" И Тема <> "dark" Тогда
		Возврат;
	КонецЕсли;
	Попытка
		Константы.ПерфТемаСветлая.Установить(Тема = "light");
	Исключение
		СведенияОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

Процедура СохранитьПанельПриложения(Значение) Экспорт

	Свернута = (Значение = "collapsed");
	Попытка
		Константы.ПерфПанельСвернута.Установить(Свернута);
	Исключение
		СведенияОбОшибке = ИнформацияОбОшибке();
	КонецПопытки;

КонецПроцедуры

Функция СостояниеПанели() Экспорт

	Возврат ПрочитатьНастройки().Панель;

КонецФункции

Процедура СохранитьСостояниеПанели(Значение) Экспорт

	Если Значение <> "collapsed" И Значение <> "expanded" Тогда
		Возврат;
	КонецЕсли;
	СохранитьПанельПриложения(Значение);

КонецПроцедуры

Функция СкриптТемы(НачальнаяТема = "dark") Экспорт

	// Обе палитры лежат в одном наборе стилей: базовые токены и html.pf-dark поверх них.
	// Поэтому переключение - это только класс на <html>; выбор сообщается в 1С.
	Возврат "<scr" + "ipt>"
		+ "var PFTheme={"
		+ "current:function(){try{return document.documentElement.classList.contains('pf-light')"
		+ "?'light':'dark';}catch(e){return 'dark';}},"
		+ "apply:function(name){var on=(name==='light');"
		+ "try{var h=document.documentElement;"
		+ "h.classList.toggle('pf-light',on);h.classList.toggle('pf-dark',!on);}catch(e){}"
		+ "var b=document.getElementById('pfThemeLabel');"
		+ "if(b){b.innerHTML=on?'Темная тема':'Светлая тема';}},"
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
// Блок: боковое меню навигации (референс index-v2: темный рейл, активный пункт
// с лаймовой полосой). Ссылки шлют команды open:<ИмяФормы> через мост PF1C.
// ---------------------------------------------------------------------------

// Реестр пунктов боковой панели: единственное место, где перечислены разделы.
// Порядок в массиве = порядок в меню. Новая страница добавляется здесь, и она
// сразу появляется на всех страницах, потому что меню рисует один общий метод.
Функция ПунктыМеню() Экспорт

	Пункты = Новый Массив;
	Пункты.Добавить(ПунктМеню("НачальнаяСтраница", "Кокпит", "мониторинг", "grid"));
	Пункты.Добавить(ПунктМеню("ПерфДашборд", "Дашборд", "мониторинг", "list"));
	Пункты.Добавить(ПунктМеню("ПерфСтенды", "Стенд", "данные", "monitor"));
	Пункты.Добавить(ПунктМеню("ПерфТопКонфигураций", "Топ-100", "данные", "bars"));
	Пункты.Добавить(ПунктМеню("ПерфСравнениеСтендов", "Сравнение стендов", "данные", "columns"));
	Пункты.Добавить(ПунктМеню("ПерфИсторияЗамеров", "История замеров", "данные", "clock"));
	Возврат Пункты;

КонецФункции

Функция ПунктМеню(Форма, Подпись, Группа, Иконка)

	Возврат Новый Структура("Форма, Подпись, Группа, Иконка", Форма, Подпись, Группа, Иконка);

КонецФункции

// Единый каркас страницы: DOCTYPE, head с общими стилями, боковая панель,
// контент и скрипты. Все страницы (кокпит, отчеты, карточка стенда) обязаны
// собираться только здесь - тогда меню, тема и шапка меняются в одном месте.
//
//   Активный                   - имя формы для подсветки пункта меню
//   Заголовок                  - title документа
//   Тело                       - HTML контента
//   ДопСтили                   - CSS конкретной страницы (кокпит, карточка)
//   Переключатель темы всегда в боковом меню (виден и в свернутом рейле).
//   КлассОбертки               - обертка контента ("wrap" у кокпита); пусто - без нее
//   ВерсияСтрокой              - подпись версии в шапке панели
//   НачальнаяТема              - "light"/"dark"; пусто - взять сохраненную тему приложения
// Шаблон страницы: каркас (head, панель, тело, скрипты) одним текстом.
// Раньше он собирался десятком конкатенаций внутри Документ; шаблон читается
// как разметка, а подстановка - один вызов Рендер (аудит 07.11.2026, п.9).
Функция ШаблонСтраницы() Экспорт

	Возврат "<!DOCTYPE html><html class='{{КлассТемы}}'><head><meta charset='utf-8'>"
		+ "<meta name='viewport' content='width=device-width, initial-scale=1'>"
		+ "<title>{{Заголовок}}</title>"
		+ "{{Стили}}{{ДопСтили}}"
		+ "{{СкриптМоста}}</head><body{{КлассПанели}}>"
		+ "{{Меню}}{{ОберткаОткрыть}}{{Тело}}{{ОберткаЗакрыть}}"
		+ "{{СкриптМеню}}{{СкриптСворачивания}}{{СкриптТемы}}"
		+ "</body></html>";

КонецФункции

// Подстановка {{Ключ}} в шаблон. Значения экранируются по умолчанию:
// шаблон описывает разметку, данные приходят из регистров и полей формы.
// Для готовых фрагментов разметки передаётся ЭкранироватьЗначения = Ложь.
Функция Рендер(Шаблон, Параметры = Неопределено, ЭкранироватьЗначения = Истина) Экспорт

	Результат = Шаблон;
	Если Параметры = Неопределено Тогда
		Возврат Результат;
	КонецЕсли;
	Для Каждого Параметр Из Параметры Цикл
		Значение = ?(ЭкранироватьЗначения, Экранировать(Параметр.Значение), Строка(Параметр.Значение));
		Результат = СтрЗаменить(Результат, "{{" + Параметр.Ключ + "}}", Значение);
	КонецЦикла;
	Возврат Результат;

КонецФункции

Функция Документ(Активный, Заголовок, Тело, ДопСтили = "",
	КлассОбертки = "", ВерсияСтрокой = "", НачальнаяТема = "",
	Настройки = Неопределено) Экспорт

	// Настройки приходят снимком: при переходе по меню их прочитал обработчик
	// клика и передал в параметрах формы, поэтому страница не делает запросов.
	// Если снимка нет (прямой запуск формы), он читается здесь - один раз.
	Снимок = ДополнитьНастройки(Настройки);
	// Тема известна серверу (выбор кнопки сохраняется в 1С), поэтому класс
	// ставится сразу в разметке: поле HTML не зависит от выполнения JS.
	Тема = ?(ПустаяСтрока(НачальнаяТема), Снимок.Тема, НачальнаяТема);
	Параметры = Новый Структура;
	Параметры.Вставить("КлассТемы", ?(Тема = "light", "pf-light", "pf-dark"));
	Параметры.Вставить("Заголовок", Экранировать(Заголовок));
	Параметры.Вставить("Стили", Стили());
	Параметры.Вставить("ДопСтили", ДопСтили);
	Параметры.Вставить("СкриптМоста", СкриптМоста());
	Параметры.Вставить("КлассПанели", ?(Снимок.Свернута, " class='pf-collapsed'", ""));
	Параметры.Вставить("Меню", Меню(Активный, ВерсияСтрокой, Тема));
	Параметры.Вставить("ОберткаОткрыть", ?(ПустаяСтрока(КлассОбертки), "", "<div class='" + КлассОбертки + "'>"));
	Параметры.Вставить("Тело", Тело);
	Параметры.Вставить("ОберткаЗакрыть", ?(ПустаяСтрока(КлассОбертки), "", "</div>"));
	Параметры.Вставить("СкриптМеню", СкриптМеню());
	Параметры.Вставить("СкриптСворачивания", СкриптСворачивания());
	Параметры.Вставить("СкриптТемы", СкриптТемы(Тема));
	// Все значения - готовые фрагменты: на этом шаге экранировать нечего.
	Возврат Рендер(ШаблонСтраницы(), Параметры, Ложь);

КонецФункции

// Рейл навигации. Активный - имя открытой формы.
// Иконки - встроенный SVG: движок HTML-поля рисует его без внешних файлов,
// а цвет берется из currentColor, поэтому тема применяется автоматически.
// Знак бренда: два разных узла на наклонной оси - базовый стенд и кандидат.
// Один цвет, геометрия 32x32, вес около 0,4 КБ.
Функция ЗнакЛоготипа() Экспорт
	Возврат "<svg viewBox='0 0 32 32' xmlns='http://www.w3.org/2000/svg'>"
		+ "<rect width='32' height='32' rx='7.4' fill='#6A4CF6'/>"
		+ "<g transform='translate(2.6 2.6) scale(0.84)'>"
		+ "<path d='M15.7 8.2A8.8 8.8 0 1 0 15.7 23.8' fill='none' stroke='#F2A63C'"
		+ " stroke-width='3.4' stroke-linecap='round'/>"
		+ "<g stroke='#ffffff' stroke-width='2.6' stroke-linecap='round'>"
		+ "<path d='M19.8 16H26.6'/></g>"
		+ "<circle cx='19.8' cy='16' r='2.4' fill='#ffffff'/>"
		+ "<circle cx='26.6' cy='16' r='2.4' fill='#ffffff'/></g></svg>";
КонецФункции

Функция Меню(Активный = "", ВерсияСтрокой = "", Тема = "dark") Экспорт

	Пункты = ПунктыМеню();
	// Подпись всегда одна и та же: версия конфигурации из метаданных.
	// Параметр ВерсияСтрокой оставлен для совместимости вызовов и не используется.
	ПодписьВерсии = "версия " + СокрЛП(Строка(Метаданные.Версия));

	Части = Новый Массив;
	Части.Добавить("<nav class='side' id='pfSide'>"
		+ "<div class='logo'><span class='mark'>" + ЗнакЛоготипа() + "</span>"
		+ "<div class='logo-t'><b>ПерфТест</b><span>" + Экранировать(ПодписьВерсии) + "</span></div></div>");

	ТекущаяГруппа = "";
	Для Каждого Пункт Из Пункты Цикл
		Если Пункт.Группа <> ТекущаяГруппа Тогда
			Если НЕ ПустаяСтрока(ТекущаяГруппа) Тогда
				Части.Добавить("</div>");
			КонецЕсли;
			ТекущаяГруппа = Пункт.Группа;
			// Раздел сворачивается: состояние помнит браузер (localStorage),
			// сервер о нем не знает и лишних запросов не делает.
			Части.Добавить("<div class='sec' id='sec-" + НРег(СокрЛП(ТекущаяГруппа))
				+ "'><button class='sec-h' type='button' data-pf='sec:"
				+ НРег(СокрЛП(ТекущаяГруппа)) + "'>" + Экранировать(ВРег(ТекущаяГруппа))
				+ "<i class='chev'></i></button>");
		КонецЕсли;
		Класс = ?(Пункт.Форма = Активный, " active", "");
		Части.Добавить("<a class='nav-i" + Класс + "' href='#' title='"
			+ Экранировать(Пункт.Подпись) + "' data-pf='open:"
			+ Пункт.Форма + "'>"
			+ Иконка(Пункт.Иконка)
			+ "<span class='nm'>" + Экранировать(Пункт.Подпись) + "</span></a>");
	КонецЦикла;

	// Оформление - отдельная группа внизу: не смешивается с разделами и
	// остаётся доступным в свернутом рейле (подпись скрыта, иконка видна).
	Части.Добавить("</div>");
	Части.Добавить("<div class='sec' id='sec-оформление'>"
		+ "<button class='sec-h' type='button' data-pf='sec:оформление'>Оформление"
		+ "<i class='chev'></i></button>");
	Части.Добавить("<a class='nav-i' href='#' data-pf='theme' title='Тема'>"
		+ Иконка("theme")
		+ "<span class='nm' id='pfThemeLabel'>"
		+ ?(Тема = "light", "Темная тема", "Светлая тема") + "</span></a>");
	Части.Добавить("</div>");

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
	ИначеЕсли Ключ = "theme" Тогда
		Фигура = "<circle cx='8' cy='8' r='3.1'/><path d='M8 1.6v1.6M8 12.8v1.6M1.6 8h1.6M12.8 8h1.6'/>"
			+ "<path d='M3.4 3.4l1.1 1.1M11.5 11.5l1.1 1.1M12.6 3.4l-1.1 1.1M4.5 11.5l-1.1 1.1'/>";
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
	ДобавитьСтрокуСтенда(Строки, "режим", С.Режим);
	Если С.КлиентСервер Тогда
		// Две машины: сервер приложения и рабочее место.
		ДобавитьСтрокуСтенда(Строки, "сервер", С.Сервер);
		ДобавитьСтрокуСтенда(Строки, "клиент", С.МашинаКлиента);
	Иначе
		ДобавитьСтрокуСтенда(Строки, "ОС", С.ОС);
		ДобавитьСтрокуСтенда(Строки, "запуск", С.Клиент);
	КонецЕсли;
	ДобавитьСтрокуСтенда(Строки, "база", С.База);
	ДобавитьСтрокуСтенда(Строки, "CPU", С.ЦПУ);
	ДобавитьСтрокуСтенда(Строки, "память", С.Память);
	ДобавитьСтрокуСтенда(Строки, "ID профиля", С.Идентификатор);

	// Стенд - такая же сворачиваемая секция, как разделы меню.
	Возврат "<div class='sec' id='sec-стенд'>"
		+ "<button class='sec-h' type='button' data-pf='sec:стенд'>Стенд"
		+ "<i class='chev'></i></button><div class='side-stand'>"
		+ "<div class='ss-h' title='" + Экранировать(С.Имя) + "'>"
		+ Экранировать(?(ПустаяСтрока(С.Имя), "стенд не собран", С.Имя)) + "</div>"
		+ СтрСоединить(Строки, "") + "</div></div>";

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

	С = Новый Структура("Имя, Платформа, ОС, Режим, Клиент, База, ЦПУ, Память,"
		+ "КлиентСервер, Сервер, МашинаКлиента, Идентификатор",
		"", "", "", "", "", "", "", "", Ложь, "", "", "");

	Попытка
		Запрос = Новый Запрос(
			"ВЫБРАТЬ ПЕРВЫЕ 1
			|	Т.Стенд КАК Стенд,
			|	Т.ВерсияПлатформыСервер КАК Платформа,
			|	Т.СерверОС КАК ОС,
			|	Т.СерверКомпьютер КАК КомпьютерСервера,
			|	Т.КлиентИмяКомпьютера КАК КомпьютерКлиента,
			|	Т.КлиентОС КАК ОСКлиента,
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
			// Клиент-серверный вариант: панель показывает машины сервера и клиента.
			С.КлиентСервер = ВРег(С.Режим) <> "ФАЙЛОВЫЙ";
			Если С.КлиентСервер Тогда
				С.Сервер = МашинаСтрокой(СокрЛП(Выборка.КомпьютерСервера), С.ОС);
				С.МашинаКлиента = МашинаСтрокой(СокрЛП(Выборка.КомпьютерКлиента),
					КороткоеИмяОС(СокрЛП(Выборка.ОСКлиента)));
			КонецЕсли;
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
	Если НЕ С.КлиентСервер Тогда
		С.КлиентСервер = ВРег(С.Режим) <> "ФАЙЛОВЫЙ";
	КонецЕсли;

	// ID профиля (ID базы): по нему сравниваются сборки в отчётах.
	Попытка
		С.Идентификатор = СокрЛП(ПерфСценарии.ИдентификаторСтендаИзРегистра());
	Исключение
		ИгнорируемаяОшибка = ИнформацияОбОшибке();
	КонецПопытки;

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

// «Компьютер (ОС)» для блока стенда: пустые части не выводятся.
Функция МашинаСтрокой(Компьютер, ОС)

	Если ПустаяСтрока(Компьютер) Тогда
		Возврат ОС;
	КонецЕсли;
	Если ПустаяСтрока(ОС) Тогда
		Возврат Компьютер;
	КонецЕсли;
	Возврат Компьютер + " (" + ОС + ")";

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

// Минимальный мост для отчетов: очередь команд, читаемая таймером формы.
Функция СкриптМоста() Экспорт
	Возврат "<scr" + "ipt>" + "if(!window.PF1C){window.PF1C={q:[],"
		+ "send:function(c){this.q.push(c);},"
		+ "take:function(){if(!this.q.length){return '';}var s=this.q.join('|');"
		+ "this.q=[];return s;},"
		+ "clear:function(){this.q.length=0;}};"
		+ "if(!window.PFAct){"
		+ "var act=function(el){var a=el&&el.getAttribute&&el.getAttribute('data-pf');"
		+ "if(!a){return false;}var i=a.indexOf(':');"
		+ "var cmd=i<0?a:a.substring(0,i),arg=i<0?'':a.substring(i+1);"
		+ "if(cmd==='open'||cmd==='nav'){if(window.PFNav&&PFNav.go){PFNav.go(arg);}"
		+ "else if(window.PF1C&&PF1C.send){PF1C.send('open:'+arg);}}"
		+ "else if(cmd==='send'){PF1C.send(arg);}"
		+ "else if(cmd==='run'){if(PF1C.run){PF1C.run(arg);}else{PF1C.send('run:'+arg);}}"
		+ "else if(cmd==='pal'){if(PF1C.openPal){PF1C.openPal();}}"
		+ "else if(cmd==='palpick'){if(PF1C.palPick){PF1C.palPick(parseInt(arg,10));}}"
		+ "else if(cmd==='close'){if(PF1C.closePal){PF1C.closePal();}}"
		+ "else if(cmd==='theme'){if(window.PFThemeToggle){PFThemeToggle(el);}}"
		+ "else if(cmd==='filter'){if(PF1C.filter){PF1C.filter(arg);}}"
		+ "else if(cmd==='sec'){var sc=document.getElementById('sec-'+arg);"
		+ "if(sc){sc.className=sc.className.indexOf('closed')>=0?'sec':'sec closed';"
		+ "if(window.PFSec){PFSec.save();}}}"
		+ "else{console.warn('PF: unknown data-pf action',a);}"
		+ "return true;};"
		+ "document.addEventListener('click',function(e){var el=e.target;"
		+ "while(el&&el!==document.body&&!(el.getAttribute&&el.getAttribute('data-pf'))){el=el.parentNode;}"
		+ "if(el&&el.getAttribute&&act(el)){e.preventDefault();}},false);"
		+ "document.addEventListener('change',function(e){var el=e.target;"
		+ "var f=el&&el.getAttribute&&el.getAttribute('data-pf-field');"
		+ "if(f&&window.PF1C){PF1C.send(f+':'+el.value);}},false);}}"
		+ "window.PFSec={save:function(){try{var o=[],n=document.querySelectorAll('.sec');"
		+ "for(var i=0;i<n.length;i++){if(n[i].className.indexOf('closed')>=0){"
		+ "o.push(n[i].id.replace('sec-',''));}}"
		+ "localStorage.setItem('pfSec',o.join(','));}catch(e){}},"
		+ "apply:function(){try{var v=(localStorage.getItem('pfSec')||'').split(',');"
		+ "for(var i=0;i<v.length;i++){if(!v[i]){continue;}"
		+ "var s=document.getElementById('sec-'+v[i]);"
		+ "if(s){s.className='sec closed';}}}catch(e){}}};"
		+ "window.addEventListener('load',function(){if(window.PFSec){PFSec.apply();}});"
		+ "document.addEventListener('keydown',function(e){"
		+ "if(e.key==='Tab'||e.keyCode===9){var h=document.documentElement;"
		+ "if(h.classList){h.classList.add('kbd');}}},true);"
		+ "document.addEventListener('mousedown',function(){var h=document.documentElement;"
		+ "if(h.classList){h.classList.remove('kbd');}},true);"
		+ "</scr" + "ipt>";
КонецФункции

// ---------------------------------------------------------------------------
// Блок: динамика. Переходы и мягкие анимации из референса (index-v3):
// hover карточек, нажатие кнопок, плавные полосы прогресса, пульс статуса.
// Движок HTML-поля поддерживает transition и keyframes; при их отсутствии
// вид деградирует до статичного, ничего не ломая.
// ---------------------------------------------------------------------------
