
Функция РеквизитыПлатежаВБюджет() Экспорт
	
	Реквизиты = Новый Соответствие;
	
	Реквизиты.Вставить("ВидПеречисления",      "ВидПеречисленияВБюджет");
	Реквизиты.Вставить("ИдентификаторПлатежа", "ИдентификаторПлатежа");
	Реквизиты.Вставить("СтатусПлательщика",    "СтатусСоставителя");
	Реквизиты.Вставить("КБК",                  "КодБК");
	Реквизиты.Вставить("КодТерритории",        "КодОКАТО");
	Реквизиты.Вставить("ОснованиеПлатежа",     "ПоказательОснования");
	Реквизиты.Вставить("НалоговыйПериод",      "ПоказательПериода");
	Реквизиты.Вставить("НомерДокумента",       "ПоказательНомера");
	Реквизиты.Вставить("ДатаДокумента",        "ПоказательДаты");
	Реквизиты.Вставить("ТипПлатежа",           "ПоказательТипа");
	
	Возврат Реквизиты;
	
КонецФункции

Функция РеквизитыДокумента_ПлатежноеПоручение() Экспорт
	
	Реквизиты = РеквизитыПлатежаВБюджет();
	
	Реквизиты.Вставить("НазначениеПлатежа",  "НазначениеПлатежа");
	Реквизиты.Вставить("ОчередностьПлатежа", "ОчередностьПлатежа");
	
	Возврат Реквизиты;
	
КонецФункции

Функция РеквизитыДокумента_РасходныйКассовыйОрдер() Экспорт
	
	Реквизиты = РеквизитыПлатежаВБюджет();
	
	Реквизиты.Вставить("НазначениеПлатежа", "Основание");
	
	Возврат Реквизиты;
	
КонецФункции

Функция РеквизитыДокумента_СписаниеСРасчетногоСчета() Экспорт
	
	Реквизиты = РеквизитыПлатежаВБюджет();
	
	Реквизиты.Вставить("НазначениеПлатежа", "НазначениеПлатежа");
	
	Возврат Реквизиты;
	
КонецФункции

Функция ЭтоНДФЛ(ВидНалога) Экспорт
	
	Если Не ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат (ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.НДФЛ"))
		или (ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.НДФЛ_ДоходыСвышеПредельнойВеличины"));
	
КонецФункции

Функция ЭтоНДФЛ_ДоходыСвышеПредельнойВеличины(ВидНалога) Экспорт
	
	Если Не ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат (ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.НДФЛ_ДоходыСвышеПредельнойВеличины"));
	
КонецФункции

Функция ЭтоНДФЛ_ИП(ВидНалога) Экспорт
	
	Если Не ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ВидыНалоговНДФЛ_ИП = Новый Массив;
	ВидыНалоговНДФЛ_ИП.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.НДФЛ_ИП"));
	ВидыНалоговНДФЛ_ИП.Добавить(ПредопределенноеЗначение(
		"Перечисление.ВидыНалогов.НДФЛ_ИП_НалоговаяБазаСвышеПредельнойВеличины"));
	
	Возврат ВидыНалоговНДФЛ_ИП.Найти(ВидНалога) <> Неопределено;
	
КонецФункции

Функция ЭтоНДФЛ_ФизЛицо(ВидНалога) Экспорт
	
	Если Не ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат (ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.НДФЛ_ФизЛицо"));
	
КонецФункции

Функция ЭтоФиксированныеВзносы(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого ВидНалогаФиксированныеВзносы Из ВидыНалоговФиксированныеВзносы() Цикл
		Если ВидНалогаФиксированныеВзносы = ВидНалога Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ЭтоФиксированныеВзносыВФСС(ВидНалога) Экспорт
	
	Возврат ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ФСС");
	
КонецФункции

Функция ЭтоОбязательныеСтраховыеВзносы(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ПФР_СтраховаяЧасть")
		ИЛИ ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФСС")
		ИЛИ ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФСС_НСиПЗ")
		ИЛИ ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФФОМС")
		ИЛИ ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ПФР_НакопительнаяЧасть");
	
КонецФункции

Функция ЭтоСтраховыеВзносыФСС(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФСС")
		ИЛИ ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФСС_НСиПЗ");
	
КонецФункции

Функция НеактуальныеНалоги(Дата = Неопределено) Экспорт
	
	Налоги = Новый Соответствие();
	
	НачалоДействияПриказа2017_90н = ПлатежиВБюджетКлиентСервер.НачалоДействияПриказа2017_90н();
	Если Дата = Неопределено ИЛИ Дата >= НачалоДействияПриказа2017_90н Тогда
		Налоги.Вставить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.УСН_МинимальныйНалог"),
			Новый Структура("ДатаНеактуальности, АктуальныйНалог",
				НачалоДействияПриказа2017_90н,
				ПредопределенноеЗначение("Перечисление.ВидыНалогов.УСН_ДоходыМинусРасходы")));
		
		Для каждого ВидВзноса Из ВидыВзносовНаПенсионноеСтрахование() Цикл
			Налоги.Вставить(ВидВзноса, Новый Структура("ДатаНеактуальности", НачалоДействияПриказа2017_90н));
		КонецЦикла;
		
		Для каждого ВидВзноса Из ВидыНаСоциальноеСтрахование() Цикл
			Налоги.Вставить(ВидВзноса, Новый Структура("ДатаНеактуальности", НачалоДействияПриказа2017_90н));
		КонецЦикла;
	КонецЕсли;
	
	Возврат Налоги;
	
КонецФункции

Функция ЭтоВзносыНаПенсионноеСтрахование(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для каждого ВидВзноса Из ВидыВзносовНаПенсионноеСтрахование() Цикл
		Если ВидВзноса = ВидНалога Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ЭтоВзносыНаСоциальноеСтрахование(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для каждого ВидВзноса Из ВидыНаСоциальноеСтрахование() Цикл
		Если ВидВзноса = ВидНалога Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ЭтоТорговыйСбор(ВидНалога) Экспорт
	
	Если Не ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат (ВидНалога = ПредопределенноеЗначение("Перечисление.ВидыНалогов.ТорговыйСбор"));
	
КонецФункции

Функция НовыеРеквизитыПлатежаВБюджет(Объект, ПеречислениеВБюджет = Истина) Экспорт
	
	РеквизитыПлатежаВБюджет = Новый Структура;
	
	Если ТипЗнч(Объект.Ссылка) = Тип("ДокументСсылка.ПлатежноеПоручение") Тогда
		РеквизитыДокумента = РеквизитыДокумента_ПлатежноеПоручение();
	ИначеЕсли ТипЗнч(Объект.Ссылка) = Тип("ДокументСсылка.РасходныйКассовыйОрдер") Тогда
		РеквизитыДокумента = РеквизитыДокумента_РасходныйКассовыйОрдер();
	ИначеЕсли ТипЗнч(Объект.Ссылка) = Тип("ДокументСсылка.СписаниеСРасчетногоСчета") Тогда
		РеквизитыДокумента = РеквизитыДокумента_СписаниеСРасчетногоСчета();
	КонецЕсли;
	
	Для каждого Реквизит Из РеквизитыДокумента Цикл
		РеквизитыПлатежаВБюджет.Вставить(Реквизит.Значение)
	КонецЦикла;
	
	Если ПеречислениеВБюджет Тогда
		ЗаполнитьЗначенияСвойств(РеквизитыПлатежаВБюджет, Объект);
	КонецЕсли;
	
	Возврат РеквизитыПлатежаВБюджет;
	
КонецФункции

Функция НадписьРеквизитыПлатежейВБюджет(ДокументОбъект) Экспорт
	
	РеквизитыПлатежаВБюджет = ПлатежиВБюджетКлиентСервер.НовыйРеквизитыПлатежаВБюджет();
	
	Для Каждого Реквизит Из РеквизитыПлатежаВБюджет() Цикл
		РеквизитыПлатежаВБюджет[Реквизит.Ключ] = ДокументОбъект[Реквизит.Значение];
	КонецЦикла;
	
	ПлатежиВБюджетКлиентСервер.ОтметитьНезаполненныеЗначения(РеквизитыПлатежаВБюджет);
	
	Возврат ПлатежиВБюджетКлиентСервер.КраткоеПредставление(РеквизитыПлатежаВБюджет, ДокументОбъект.Дата);
	
КонецФункции

Функция ВидыВзносовНаПенсионноеСтрахование()
	
	Взносы = Новый Массив;
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ПФР_СтраховаяЧасть"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФФОМС"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ДополнительныеВзносы_ПФР_ВредныеУсловия"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ДополнительныеВзносы_ПФР_ЛетныеЭкипажи"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ДополнительныеВзносы_ПФР_ТяжелыеУсловия"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ДополнительныеВзносы_ПФР_Шахтеры"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ФФОМС"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ПФР_СтраховаяЧасть"));
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ПФР_НакопительнаяЧасть")); // до 2014 года
	
	Возврат Взносы;
	
КонецФункции

Функция ВидыНаСоциальноеСтрахование()
	
	Взносы = Новый Массив;
	Взносы.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.СтраховыеВзносы_ФСС"));
	
	Возврат Взносы;
	
КонецФункции

Функция ЭтоНалогУСН(ВидНалога) Экспорт
	
	Если НЕ ЗначениеЗаполнено(ВидНалога) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого ВидНалогаУСН Из ВидыНалоговУСН() Цикл
		Если ВидНалогаУСН = ВидНалога Тогда
			Возврат Истина;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ПериодУплатыНалогаВыбираетПользователь(ВидНалога, ПрименяетсяУСНДоходы, УчетЗарплатыВПрограмме) Экспорт
	
	// При уплате некоторых налогов/взносов пользователь может изменять период, за который осуществляется платеж.
	// Доступность изменения периода зависит от конкретного налога, системы налогообложения и настроек программы.
	
	ПрименяетсяНДФЛ = УчетЗарплатыВПрограмме И ЭтоНДФЛ(ВидНалога) Или ЭтоНДФЛ_ИП(ВидНалога);
	
	Возврат ЭтоОбязательныеСтраховыеВзносы(ВидНалога)
		Или ПрименяетсяНДФЛ
		Или ЭтоНалогУСН(ВидНалога)
		Или ПрименяетсяУСНДоходы И ЭтоТорговыйСбор(ВидНалога);
	
КонецФункции

Функция ПредставлениеПериодаУплатыНалога(Период, ВидНалога) Экспорт
	
	Если ЭтоТорговыйСбор(ВидНалога) Тогда
		
		ПредставлениеПериода = Формат(Период, "Л=ru_RU; ДФ='q ''квартал'' yyyy'");
		
	ИначеЕсли ЭтоНалогУСН(ВидНалога) Или ЭтоНДФЛ_ИП(ВидНалога) Тогда
		
		ТекстПериода = ПредставлениеПериода(НачалоГода(Период), КонецКвартала(Период), "ФП=Истина");
		
		Если КонецКвартала(Период) = КонецГода(Период) Тогда
			ПредставлениеПериода = СокрЛП(СтрЗаменить(ТекстПериода, НСтр("ru = 'г.'"), НСтр("ru = 'год'")));
		Иначе
			ПредставлениеПериода = СокрЛП(СтрЗаменить(ТекстПериода, НСтр("ru = 'г.'"), ""));
		КонецЕсли;
		
	Иначе
		
		ПредставлениеПериода = Формат(Период, "ДФ='MMMM yyyy'"); // По умолчанию - месяц
		
	КонецЕсли;
	
	Возврат ПредставлениеПериода;
	
КонецФункции

Функция ВидыНалоговУСН() Экспорт
	
	Налоги = Новый Массив;
	
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.УСН_Доходы"));
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.УСН_ДоходыМинусРасходы"));
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.УСН_МинимальныйНалог"));
	
	Возврат Налоги;
	
КонецФункции

Функция ВидыНалоговФиксированныеВзносы() Экспорт
	
	Налоги = Новый Массив;
	
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ПФР_СтраховаяЧасть"));
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ФФОМС"));
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ФСС"));
	Налоги.Добавить(ПредопределенноеЗначение("Перечисление.ВидыНалогов.ФиксированныеВзносы_ПФР_НакопительнаяЧасть"));
	
	Возврат Налоги;
	
КонецФункции
