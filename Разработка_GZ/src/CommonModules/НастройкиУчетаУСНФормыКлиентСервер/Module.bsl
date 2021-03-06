
////////////////////////////////////////////////////////////////////////////////
// Универсальные методы для формы записи регистра и формы настройки налогов
//
// Клиент-серверные методы формы записи регистра сведений НастройкиУчетаУСН
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура УправлениеФормой(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Запись   = Форма.НастройкиУчетаУСН;
	
	ПериодЧтенияНастройки = ПериодЧтенияНастройки(Форма);
	
	ОтображатьУстаревшие = Запись.Период < '20160101';
	
	Элементы.БазаРаспределенияРасходовПоВидамДеятельности.Видимость = ОтображатьУстаревшие И Форма.ПлательщикЕНВД;
	Элементы.УменьшатьНаНЗП.Видимость                               = ОтображатьУстаревшие;
	Элементы.Реализация.Видимость                                   = ОтображатьУстаревшие;
	Элементы.ГруппаРеализацияТоваровОбязательна.Видимость           = НЕ ОтображатьУстаревшие;
	
	Элементы.МетодРаспределенияРасходовПоВидамДеятельности.Видимость = Форма.ПлательщикЕНВД;
	
	Элементы.НалоговыеКаникулы.Видимость = НЕ Форма.ЭтоЮрЛицо И Запись.Период >= '20150101';
	Элементы.НалоговыеКаникулы.РасширеннаяПодсказка.Заголовок = НалоговыеКаникулы_ТекстПодсказки(ПериодЧтенияНастройки);
	
	ПрименяетсяПрогрессивнаяШкала = ПрименяетсяПрогрессивнаяШкала(ПериодЧтенияНастройки)
		И Форма.СтавкаНалогаУСНПовышенная > 0;
	
	Элементы.ГруппаСтавкаУСНОсновная.Доступность = Не Запись.НалоговыеКаникулы;
	Элементы.СтавкаНалогаУСН.Заголовок = СтавкаНалогаУСНЗаголовок(ПериодЧтенияНастройки);
	
	Элементы.ДекорацияСтавкаУСНОсновная.Видимость = ПрименяетсяПрогрессивнаяШкала;
	Если ПрименяетсяПрогрессивнаяШкала Тогда
		Элементы.ДекорацияСтавкаУСНОсновная.Заголовок = СтавкаУСНОсновная_Подсказка(ПериодЧтенияНастройки);
	КонецЕсли;
	
	Элементы.ГруппаСтавкаУСНПовышенная.Видимость = ПрименяетсяПрогрессивнаяШкала;
	Элементы.ДекорацияСтавкаУСНПовышенная.Видимость = ПрименяетсяПрогрессивнаяШкала;
	Если ПрименяетсяПрогрессивнаяШкала Тогда
		Элементы.ДекорацияСтавкаУСНПовышенная.Заголовок = СтавкаУСНПовышенная_Подсказка(ПериодЧтенияНастройки);
	КонецЕсли;
	
	Если Форма.ПрименяетсяУСНДоходыМинусРасходы Тогда
		Элементы.ГруппаПорядокПризнанияРасходов.Видимость = Истина;
		ПолучитьПараметрыРасходов(Форма);
	Иначе
		Элементы.ГруппаПорядокПризнанияРасходов.Видимость = Ложь;
	КонецЕсли;
	
	Элементы.ПорядокОтраженияАвансаУСН.Видимость = НЕ ЗначениеЗаполнено(Форма.ПорядокОтраженияАванса)
		ИЛИ Элементы.ПорядокОтраженияАвансаУСН.СписокВыбора.Количество() > 1;
	
	СписокВыбора = Элементы.ПорядокОтраженияАвансаУСН.СписокВыбора;
	Форма.ПорядокОтраженияАванса = НастройкиУчетаУСНФормыВызовСервера.СписокВыбораОтраженияАвансов(Запись,
		СписокВыбора,
		Форма.СписокПатентов);
		
	Элементы.ПорядокОтраженияАвансаУСН.СписокВыбора.ЗагрузитьЗначения(СписокВыбора.ВыгрузитьЗначения());
		
	Элементы.ПорядокОтраженияАвансаУСН.Видимость =
		ЗначениеЗаполнено(Запись.Организация)
		И (НЕ ЗначениеЗаполнено(Форма.ПорядокОтраженияАванса)
		ИЛИ Элементы.ПорядокОтраженияАвансаУСН.СписокВыбора.Количество() > 1);
		
		Если ТипЗнч(Форма.ПорядокОтраженияАванса) = Тип("ПеречислениеСсылка.ПорядокОтраженияАвансов") Тогда
			Запись.ПорядокОтраженияАванса = Форма.ПорядокОтраженияАванса;
		КонецЕсли;
		
	Если Форма.ВозможноПродлениеСроковНалоговОтчетов Тогда 
		ЗаполнитьЗначенияСвойств(Форма, НастройкиУчетаУСНФормыВызовСервера.СрокиУплатыУСН(Запись.Организация, Форма.ЭтоЮрЛицо));
	КонецЕсли;	
	
	// Раздел УСН может быть доступен, даже если сейчас УСН уже не применяется.
	// В этом случае показывать настройку сроков не имеет смысла.
	Элементы.ГруппаПереносСроковУСН.Видимость = (Форма.ПрименяетсяУСНДоходы ИЛИ Форма.ПрименяетсяУСНДоходыМинусРасходы) 
		И Форма.ВозможноПродлениеСроковНалоговОтчетов;
	
КонецПроцедуры

// Возвращает период чтения настроек учетной политики.
// В форме Налоги и отчеты настройки отображаются на дату Форма.ТекущаяДата, в форме записи - на дату записи.
// 
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения
// Возвращаемое значение:
// 	Дата
// 	
Функция ПериодЧтенияНастройки(Форма) Экспорт
	
	Запись = Форма.НастройкиУчетаУСН;
	
	Если ЗначениеЗаполнено(Форма.ТекущаяДата) Тогда
		ПериодЧтенияНастройки = Форма.ТекущаяДата;
	Иначе
		ПериодЧтенияНастройки = Запись.Период;
	КонецЕсли;
	
	Возврат ПериодЧтенияНастройки;
	
КонецФункции

Функция ПрименяетсяПрогрессивнаяШкала(Период)
	
	Возврат Период >= УчетУСНКлиентСервер.ДатаНачалаПрогрессивнойШкалы();
	
КонецФункции

Функция НалоговыеКаникулы_ТекстПодсказки(Период)
	
	ЭлементыПодсказки = Новый Массив;
	ЭлементыПодсказки.Добавить(
		НСтр("ru = 'Налоговые каникулы предоставляются индивидуальным предпринимателям, которые:
		|- Зарегистрированы впервые;
		|- Ведут деятельность, связанную с услугами населению, производственной, социальной или научной сферой.
		|Региональные власти могут определять конкретные виды деятельности, которые попадают под налоговые каникулы.
		|При налоговых каникулах отчетность сдавать нужно.'"));
	
	Если ПрименяетсяПрогрессивнаяШкала(Период) Тогда
		
		ЛимитДоходов = ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Период);
		ГраницаСреднесписочнойЧисленности = КонтрольПраваПримененияСпецрежимаКлиентСервер.ГраницаЧисленностиРаботниковДляПримененияОсновнойСтавкиУСН();
		
		ЭлементыПодсказки.Добавить(Символы.ПС);
		ЭлементыПодсказки.Добавить(
			СтрШаблон(НСтр("ru = 'Налоговые каникулы перестают действовать при сумме доходов за год свыше %1%2млн.%3руб. либо при средней численности наемных работников свыше %4%5человек.'"),
				Формат(ЛимитДоходов, "ЧГ=;"),
				Символы.НПП,
				Символы.НПП,
				Формат(ГраницаСреднесписочнойЧисленности, "ЧДЦ=0; ЧГ=;"),
				Символы.НПП));
	КонецЕсли;
	
	ЭлементыПодсказки.Добавить(Символы.ПС);
	ЭлементыПодсказки.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Подробнее на ИТС'"), , , , "https://its.1c.ru/db/bizlegsup/content/134/1"));
	
	Возврат Новый ФорматированнаяСтрока(ЭлементыПодсказки);
	
КонецФункции

Функция СтавкаУСНОсновная_Подсказка(Период)
	
	Если ПрименяетсяПрогрессивнаяШкала(Период) Тогда
		ЛимитДоходов = ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Период);
		ГраницаСреднесписочнойЧисленности = КонтрольПраваПримененияСпецрежимаКлиентСервер.ГраницаЧисленностиРаботниковДляПримененияОсновнойСтавкиУСН();
		
		Подсказка = СтрШаблон(НСтр("ru = 'Действует до достижения суммы доходов %1%2млн.%3руб. при средней численности наемных работников не более %4%5человек'"),
			Формат(ЛимитДоходов, "ЧГ=;"),
			Символы.НПП,
			Символы.НПП,
			Формат(ГраницаСреднесписочнойЧисленности, "ЧДЦ=0; ЧГ=;"),
			Символы.НПП);
	Иначе
		Подсказка = "";
	КонецЕсли;
	
	Возврат Подсказка;
	
КонецФункции

Функция СтавкаУСНПовышенная_Подсказка(Период)
	
	Если ПрименяетсяПрогрессивнаяШкала(Период) Тогда
		ЛимитДоходов = ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Период);
		ГраницаСреднесписочнойЧисленности = КонтрольПраваПримененияСпецрежимаКлиентСервер.ГраницаЧисленностиРаботниковДляПримененияОсновнойСтавкиУСН();
		
		Подсказка = СтрШаблон(НСтр("ru = 'Действует с начала квартала, в котором доходы превысили %1%2млн.%3руб. либо средняя численность наемных работников превысила %4%5человек'"),
			Формат(ЛимитДоходов, "ЧГ=;"),
			Символы.НПП,
			Символы.НПП,
			Формат(ГраницаСреднесписочнойЧисленности, "ЧДЦ=0; ЧГ=;"),
			Символы.НПП);
	Иначе
		Подсказка = "";
	КонецЕсли;
	
	Возврат Подсказка;
	
КонецФункции

Функция ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Период)
	
	ГраницаДоходов = КонтрольПраваПримененияСпецрежимаКлиентСервер.ГраницаДоходовДляПримененияОсновнойСтавкиУСН(Период);
	
	Возврат Окр(ГраницаДоходов / 1000000, 2);
	
КонецФункции

Функция СтавкаНалогаУСНЗаголовок(Период)
	
	Если ПрименяетсяПрогрессивнаяШкала(Период) Тогда
		Заголовок = НСтр("ru = 'Основная ставка'");
	Иначе
		Заголовок = НСтр("ru = 'Ставка налога'");
	КонецЕсли;
	
	Возврат Заголовок;
	
КонецФункции

Процедура ПолучитьПараметрыРасходов(Форма)
	
	НастройкиУчетаУСН = Форма.НастройкиУчетаУСН;
	
	Форма.УменьшатьНаНЗП = НастройкиУчетаУСН.ПорядокПризнанияМатериальныхРасходов
		= ПредопределенноеЗначение("Перечисление.ПорядокПризнанияМатериальныхРасходов.УменьшатьРасходыНаОстатокНЗП");
	
	Форма.ПередачаВПроизводство = НастройкиУчетаУСН.ПорядокПризнанияМатериальныхРасходов
		<> ПредопределенноеЗначение("Перечисление.ПорядокПризнанияМатериальныхРасходов.ПоОплатеПоставщику");
	
	Форма.ПолучениеДохода = НастройкиУчетаУСН.ПорядокПризнанияРасходовПоТоварам
		= ПредопределенноеЗначение("Перечисление.ПорядокПризнанияРасходовПоТоварам.ПоФактуПолученияДохода");
	
	Форма.Реализация = НастройкиУчетаУСН.ПорядокПризнанияРасходовПоТоварам
		<> ПредопределенноеЗначение("Перечисление.ПорядокПризнанияРасходовПоТоварам.ПоОплатеПоставщику");
	
	Форма.ПризнаниеРасхода = (НастройкиУчетаУСН.ПорядокПризнанияРасходовПоНДС
		= ПредопределенноеЗначение("Перечисление.ПорядокПризнанияРасходовПоНДС.ВключатьВСтоимость"));
	
	Форма.ДопРасходыПризнаниеРасхода = (НастройкиУчетаУСН.ПорядокПризнанияДопРасходов
		= ПредопределенноеЗначение("Перечисление.ПорядокПризнанияДопРасходов.ВключатьВСтоимость"));
	
	Форма.ТаможенныеПлатежиПризнаниеРасхода = (НастройкиУчетаУСН.ПорядокПризнанияТаможенныхПлатежей
		= ПредопределенноеЗначение("Перечисление.ПорядокПризнанияТаможенныхПлатежей.ВключатьВСтоимость"));
	
КонецПроцедуры

#КонецОбласти
