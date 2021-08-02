Функция ИспользоватьЗакрывающиеДокументыРозничнойТорговли() Экспорт
	
	Возврат ПолучитьФункциональнуюОпцию("ВедетсяРозничнаяТорговля") Или ПолучитьФункциональнуюОпцию("ИспользоватьОплатуПоПлатежнымКартам");
	
КонецФункции

///////////////////////////////////////////////////////////////////////////////
// ПРОВЕДЕНИЕ ДОКУМЕНТОВ

// ПРИОБРЕТЕНИЕ ВАЛЮТЫ

// Формируются бухгалтерские проводки по операции поступления приобретенной у банка иностранной валюты
//
// Параметры
//  РасшифровкаПлатежа - <ТаблицаЗначений> - данные табличной части документа
//                       Создается в модуле менеджера документа
//  ТаблицаРеквизиты   - <ТаблицаЗначений> - реквизиты документа, необходимые для формирования движений.
//                       Создается в модуле менеджера документа
//  Движения           - коллекция движений документа
//  Отказ              - <Булево> - флаг отказа от проведения
//
Процедура СформироватьДвиженияПриобретениеВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты, Движения, Отказ) Экспорт

	Если Не ЗначениеЗаполнено(РасшифровкаПлатежа) Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыПриобретениеВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты);
	Реквизиты = Параметры.Реквизиты[0];
	
	Для каждого СтрокаПлатежа Из Параметры.РасшифровкаПлатежа Цикл
	
		// Поступление на валютный счет отражается по курсу ЦБ
		
		Проводка = Движения.Хозрасчетный.Добавить();

		Проводка.Период      = Реквизиты.Период;
		Проводка.Организация = Реквизиты.Организация;
		Проводка.Содержание  = Реквизиты.Содержание;
		
		Проводка.СчетДт = СтрокаПлатежа.СчетУчетаДенежныхСредств;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
			"БанковскиеСчета", СтрокаПлатежа.БанковскийСчет);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
			"СтатьиДвиженияДенежныхСредств", СтрокаПлатежа.СтатьяДвиженияДенежныхСредств);
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Если СвойстваСчетаДт.Валютный Тогда
			Проводка.ВалютаДт        = Реквизиты.ВалютаДокумента;
			Проводка.ВалютнаяСуммаДт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.СчетКт = СтрокаПлатежа.СчетРасчетов;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
			"Контрагенты", СтрокаПлатежа.Контрагент);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
			"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
		Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.Сумма = СтрокаПлатежа.СуммаРубПоКурсуЦБ;
		
		// Доходы / расходы по приобретению валюты в БУ и НУ - разница между суммой рублевой оценки валюты по курсу ЦБ
		// и фактически потраченной на приобретение рублевой суммой (по курсу банка)
		// Доходы / расходы в БУ и НУ отражаются по счету 91.01 / 91.02 и статье ОтклонениеКурсаПродажиПокупкиВалюты,
		// если в документе явно не указано не отражать расходы (снят соответствующий флажок)
		
		СуммаРазницы = СтрокаПлатежа.СуммаРубПоКурсуЦБ - СтрокаПлатежа.СуммаРуб;
		
		Если Реквизиты.ОтражатьРазницуВКурсе И СуммаРазницы > 0 Тогда // Доходы
			
			Проводка = Движения.Хозрасчетный.Добавить();

			Проводка.Период      = Реквизиты.Период;
			Проводка.Организация = Реквизиты.Организация;
			Проводка.Содержание  = Реквизиты.Содержание;
			
			Проводка.СчетДт = СтрокаПлатежа.СчетРасчетов;
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
				"Контрагенты", СтрокаПлатежа.Контрагент);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
				"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
			СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
			Если СвойстваСчетаДт.Валютный Тогда
				Проводка.ВалютаДт        = Реквизиты.ВалютаДокумента;
			КонецЕсли;
			Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.СчетКт = ПланыСчетов.Хозрасчетный.ПрочиеДоходы;
			БухгалтерскийУчет.УстановитьСубконто(
				Проводка.СчетКт,
				Проводка.СубконтоКт,
				"ПрочиеДоходыИРасходы",
				Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ОтклонениеКурсаПродажиПокупкиВалюты"));
				
			СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
			Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.Сумма = СуммаРазницы;
			
		ИначеЕсли Реквизиты.ОтражатьРазницуВКурсе И СуммаРазницы < 0 Тогда // Расходы
				
			Проводка = Движения.Хозрасчетный.Добавить();

			Проводка.Период      = Реквизиты.Период;
			Проводка.Организация = Реквизиты.Организация;
			Проводка.Содержание  = Реквизиты.Содержание;
			
			Проводка.СчетДт = ПланыСчетов.Хозрасчетный.ПрочиеРасходы;
			БухгалтерскийУчет.УстановитьСубконто(
				Проводка.СчетДт,
				Проводка.СубконтоДт, 
				"ПрочиеДоходыИРасходы",
				Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ОтклонениеКурсаПродажиПокупкиВалюты"));
				
			СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
			Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.СчетКт = СтрокаПлатежа.СчетРасчетов;
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
				"Контрагенты", СтрокаПлатежа.Контрагент);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
				"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
			СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
			Если СвойстваСчетаКт.Валютный Тогда
				Проводка.ВалютаКт        = Реквизиты.ВалютаДокумента;
			КонецЕсли;
			Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
				
			Проводка.Сумма = -СуммаРазницы;
			
		КонецЕсли;
	
	КонецЦикла;

	Движения.Хозрасчетный.Записывать = Истина;

КонецПроцедуры

Функция ПодготовитьПараметрыПриобретениеВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.РасшифровкаПлатежа
	
	СписокОбязательныхКолонок = ""
	+ "СчетУчетаДенежныхСредств,"      // <ПланСчетовСсылка.Хозрасчетный> - счет учета приобретенной валюты (обычно 52)
	+ "БанковскийСчет,"                // <СправочникСсылка.БанковскиеСчета> - счет, куда поступила валюта
	+ "СтатьяДвиженияДенежныхСредств," // <СправочникСсылка.СтатьиДвиженияДенежныхСредств> 
	+ "Подразделение,"                 // <Ссылка на справочник подразделений> 
	+ "СчетРасчетов,"                  // <ПланСчетовСсылка.Хозрасчетный> - рублевый счет расчетов с банком (обычно 57.02)
	+ "Контрагент,"                    // <СправочникСсылка.Контрагенты> - банк, через который приобретается валюта
	+ "ДоговорКонтрагента,"            // <СправочникСсылка.ДоговорыКонтрагентов> - рублевый договор с банком вида "Прочее"
	+ "ВалютнаяСумма,"                // <Число,15,2> - сумма приобретенной валюты
	+ "СуммаРуб,"                     // <Число,15,2> - руб.сумма, потраченная на покупку валюты, по курсу банка
	+ "СуммаРубПоКурсуЦБ";            // <Число,15,2> - руб.оценка приобретенной валюты по курсу ЦБ на дату покупки валюты
	
	Параметры.Вставить("РасшифровкаПлатежа", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		РасшифровкаПлатежа, СписокОбязательныхКолонок));
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
	+ "Период,"                // <Дата> - период движений - дата документа
	+ "Организация,"           // <СправочникСсылка.Организации>
	+ "ВалютаДокумента,"       // <СправочникСсылка.Валюты>
	+ "Содержание,"            // <Строка,150> - содержание проводок
	+ "ОтражатьРазницуВКурсе"; // <Булево> - отражать ли разницу как внереализационные доходы/расходы
	
	Параметры.Вставить("Реквизиты", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаРеквизиты, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции

// ПРОДАЖА ВАЛЮТЫ

// Формируются бухгалтерские проводки по операции поступления рублевых средств от продажи банку иностранной валюты
//
// Параметры
//  РасшифровкаПлатежа - <ТаблицаЗначений> - данные табличной части документа
//                       Создается в модуле менеджера документа
//  ТаблицаРеквизиты   - <ТаблицаЗначений> - реквизиты документа, необходимые для формирования движений.
//                       Создается в модуле менеджера документа
//  Движения           - коллекция движений документа
//  Отказ              - <Булево> - флаг отказа от проведения
//
Процедура СформироватьДвиженияПродажаВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты, Движения, Отказ) Экспорт
	
	Если Не ЗначениеЗаполнено(РасшифровкаПлатежа) Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыПродажаВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты);
	Реквизиты = Параметры.Реквизиты[0];
	
	ОтражатьВНалоговомУчете = УчетнаяПолитика.ПлательщикНалогаНаПрибыль(Реквизиты.Организация, Реквизиты.Период);
	
	Для каждого СтрокаПлатежа Из Параметры.РасшифровкаПлатежа Цикл
	
		// Доходы от продажи валюты в БУ - вся поступившая на наш расчетный счет сумма
		// Доходы в БУ отражаются по счету 91.01 и статье ДоходыРасходыПриПродажеПокупкеВалюты
		
		Проводка = Движения.Хозрасчетный.Добавить();

		Проводка.Период      = Реквизиты.Период;
		Проводка.Организация = Реквизиты.Организация;
		Проводка.Содержание  = Реквизиты.Содержание;
		
		Проводка.СчетДт = СтрокаПлатежа.СчетУчетаДенежныхСредств;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
			"БанковскиеСчета", СтрокаПлатежа.БанковскийСчет);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
			"СтатьиДвиженияДенежныхСредств", СтрокаПлатежа.СтатьяДвиженияДенежныхСредств);
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.СчетКт = ПланыСчетов.Хозрасчетный.ПрочиеДоходы;
		
		БухгалтерскийУчет.УстановитьСубконто(
			Проводка.СчетКт,
			Проводка.СубконтоКт,
			"ПрочиеДоходыИРасходы",
			Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ДоходыРасходыПриПродажеПокупкеВалюты"));
			
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
		Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.Сумма = СтрокаПлатежа.СуммаРуб;
		
		Если ОтражатьВНалоговомУчете И СвойстваСчетаКт.НалоговыйУчет Тогда
			Проводка.СуммаНУКт = 0;
			Проводка.СуммаПРКт = Проводка.Сумма;
			Проводка.СуммаВРКт = 0;
		КонецЕсли;
		
		// Расходы от продажи валюты в БУ - сумма рублевой оценки проданной валюты по курсу ЦБ
		// Расходы в БУ отражаются по счету 91.02 и статье ДоходыРасходыПриПродажеПокупкеВалюты
		
		Проводка = Движения.Хозрасчетный.Добавить();

		Проводка.Период      = Реквизиты.Период;
		Проводка.Организация = Реквизиты.Организация;
		Проводка.Содержание  = Реквизиты.Содержание;
		
		Проводка.СчетДт = ПланыСчетов.Хозрасчетный.ПрочиеРасходы;
		
		БухгалтерскийУчет.УстановитьСубконто(
			Проводка.СчетДт,
			Проводка.СубконтоДт,
			"ПрочиеДоходыИРасходы",
			Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ДоходыРасходыПриПродажеПокупкеВалюты"));
			
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.СчетКт = СтрокаПлатежа.СчетРасчетов;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
			"Контрагенты", СтрокаПлатежа.Контрагент);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
			"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
			"ДокументыРасчетовСКонтрагентами", Реквизиты.Регистратор);
		
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
		Если СвойстваСчетаКт.Валютный Тогда
			Проводка.ВалютаКт        = СтрокаПлатежа.ВалютаВзаиморасчетов;
			Проводка.ВалютнаяСуммаКт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
		КонецЕсли;
		
		Проводка.Сумма = СтрокаПлатежа.СуммаРубПоКурсуЦБ;
		
		Если ОтражатьВНалоговомУчете И СвойстваСчетаДт.НалоговыйУчет Тогда
			Проводка.СуммаНУДт = 0;
			Проводка.СуммаПРДт = Проводка.Сумма;
			Проводка.СуммаВРДт = 0;
		КонецЕсли;
		
		// Доходы / расходы от продажи валюты в НУ - разница между поступившей на наш расчетный счет суммой 
		// и суммой рублевой оценки проданной валюты по курсу ЦБ
		// Доходы / расходы в НУ отражаются по счету 91.01 / 91.02 и статье ОтклонениеКурсаПродажиПокупкиВалюты
		
		СуммаНУ = СтрокаПлатежа.СуммаРуб - СтрокаПлатежа.СуммаРубПоКурсуЦБ;
		
		Если ОтражатьВНалоговомУчете И СуммаНУ > 0 Тогда // Доходы
			
			Проводка = Движения.Хозрасчетный.Добавить();

			Проводка.Период      = Реквизиты.Период;
			Проводка.Организация = Реквизиты.Организация;
			Проводка.Содержание  = Реквизиты.Содержание;
			
			Проводка.СчетДт = СтрокаПлатежа.СчетРасчетов;
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
				"Контрагенты", СтрокаПлатежа.Контрагент);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
				"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 
				"ДокументыРасчетовСКонтрагентами", Реквизиты.Регистратор);
			
			СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
			Если СвойстваСчетаДт.Валютный Тогда
				Проводка.ВалютаДт        = СтрокаПлатежа.ВалютаВзаиморасчетов;
			КонецЕсли;
			Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.СчетКт = ПланыСчетов.Хозрасчетный.ПрочиеДоходы;
			БухгалтерскийУчет.УстановитьСубконто(
				Проводка.СчетКт,
				Проводка.СубконтоКт,
				"ПрочиеДоходыИРасходы",
				Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ОтклонениеКурсаПродажиПокупкиВалюты"));
			
			СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
			Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.Сумма = 0;
			
			Если СвойстваСчетаКт.НалоговыйУчет Тогда
				Проводка.СуммаНУКт = СуммаНУ;
				Проводка.СуммаПРКт = - СуммаНУ;
				Проводка.СуммаВРКт = 0;
			КонецЕсли; 
				
		ИначеЕсли ОтражатьВНалоговомУчете И СуммаНУ < 0 Тогда // Расходы
				
			Проводка = Движения.Хозрасчетный.Добавить();

			Проводка.Период      = Реквизиты.Период;
			Проводка.Организация = Реквизиты.Организация;
			Проводка.Содержание  = Реквизиты.Содержание;
			
			Проводка.СчетДт = ПланыСчетов.Хозрасчетный.ПрочиеРасходы;
			БухгалтерскийУчет.УстановитьСубконто(
				Проводка.СчетДт,
				Проводка.СубконтоДт,
				"ПрочиеДоходыИРасходы",
				Справочники.ПрочиеДоходыИРасходы.ПредопределенныйЭлемент("ОтклонениеКурсаПродажиПокупкиВалюты"));
				
			СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
			Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеДт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
			
			Проводка.СчетКт = СтрокаПлатежа.СчетРасчетов;
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
				"Контрагенты", СтрокаПлатежа.Контрагент);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
				"Договоры", СтрокаПлатежа.ДоговорКонтрагента);
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 
				"ДокументыРасчетовСКонтрагентами", Реквизиты.Регистратор);
			
			СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
			Если СвойстваСчетаКт.Валютный Тогда
				Проводка.ВалютаКт        = СтрокаПлатежа.ВалютаВзаиморасчетов;
			КонецЕсли;
			Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
				Проводка.ПодразделениеКт = СтрокаПлатежа.Подразделение;
			КонецЕсли;
				
			Проводка.Сумма = 0;
			
			Если СвойстваСчетаДт.НалоговыйУчет Тогда
				Проводка.СуммаНУДт = -СуммаНУ;
				Проводка.СуммаПРДт = СуммаНУ;
				Проводка.СуммаВРДт = 0;
			КонецЕсли; 
				
		КонецЕсли;
	
	КонецЦикла;
	
	Движения.Хозрасчетный.Записывать = Истина;

КонецПроцедуры

Функция ПодготовитьПараметрыПродажаВалюты(РасшифровкаПлатежа, ТаблицаРеквизиты)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.РасшифровкаПлатежа
	
	СписокОбязательныхКолонок = ""
	+ "СчетУчетаДенежныхСредств,"      // <ПланСчетовСсылка.Хозрасчетный> - счет учета денежных средств (обычно 51)
	+ "БанковскийСчет,"                // <СправочникСсылка.БанковскиеСчета> - счет, куда поступили средства от продажи
	+ "СтатьяДвиженияДенежныхСредств," // <СправочникСсылка.СтатьиДвиженияДенежныхСредств> 
	+ "Подразделение,"                 // <Ссылка на справочник подразделений> 
	+ "СчетРасчетов,"                  // <ПланСчетовСсылка.Хозрасчетный> - валютный счет расчетов с банком (обычно 57.22)
	+ "Контрагент,"                    // <СправочникСсылка.Контрагенты> - банк, через который продается валюта
	+ "ДоговорКонтрагента,"            // <СправочникСсылка.ДоговорыКонтрагентов> - валютный договор с банком вида "Прочее"
	+ "ВалютаВзаиморасчетов,"          // <СправочникСсылка.Валюты> - валюта расчетов с банком - продаваемая валюта
	+ "ВалютнаяСумма,"                 // <Число,15,2> - сумма проданной валюты
	+ "СуммаРуб,"                      // <Число,15,2> - руб.сумма, полученная на наш счет, по курсу продажи валюты банком
	+ "СуммаРубПоКурсуЦБ";             // <Число,15,2> - руб.оценка проданной валюты по курсу ЦБ на дату продажи валюты
	
	Параметры.Вставить("РасшифровкаПлатежа", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		РасшифровкаПлатежа, СписокОбязательныхКолонок));
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
	+ "Период,"                // <Дата> - период движений - дата документа
	+ "Организация,"           // <СправочникСсылка.Организации>
	+ "Содержание,"            // <Строка,150> - содержание проводок
	+ "Регистратор";           // <ДокументСсылка>
	
	Параметры.Вставить("Реквизиты", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаРеквизиты, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции

// ПРОЧЕЕ ПОСТУПЛЕНИЕ

// Формируются бухгалтерские проводки по операциям поступления денежных средств в кассу или на расчетный счет, 
// не связанных с расчетами с покупателями и поставщиками, а также с приобретением или продажей иностранной валюты
//
// Параметры
//  РасшифровкаПлатежа - <ТаблицаЗначений> - данные табличной части документа
//                       Создается в модуле менеджера документа
//  ТаблицаРеквизиты   - <ТаблицаЗначений> - реквизиты документа, необходимые для формирования движений.
//                       Создается в модуле менеджера документа
//  Движения           - коллекция движений документа
//  Отказ              - <Булево> - флаг отказа от проведения
//
Процедура СформироватьДвиженияПрочееПоступление(РасшифровкаПлатежа, ТаблицаРеквизиты, Движения, Отказ) Экспорт
	
	Если Не ЗначениеЗаполнено(РасшифровкаПлатежа) Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыПрочееПоступление(РасшифровкаПлатежа, ТаблицаРеквизиты);
	Реквизиты = Параметры.Реквизиты[0];

	Для каждого СтрокаПлатежа Из Параметры.РасшифровкаПлатежа Цикл
		Проводка = Движения.Хозрасчетный.Добавить();
		
		Проводка.Период      = Реквизиты.Период;
		Проводка.Содержание  = Реквизиты.Содержание;
		Проводка.Организация = Реквизиты.Организация;
		Проводка.Сумма       = СтрокаПлатежа.СуммаРуб;
		
		Проводка.СчетДт = СтрокаПлатежа.СчетДт;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 1, СтрокаПлатежа.СубконтоДт1);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 2, СтрокаПлатежа.СубконтоДт2);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт, 3, СтрокаПлатежа.СубконтоДт3);
		
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Если СвойстваСчетаДт.Валютный Тогда
			Проводка.ВалютаДт        = Реквизиты.ВалютаДокумента;
			Проводка.ВалютнаяСуммаДт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		
		Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеДт = СтрокаПлатежа.ПодразделениеДт;
		КонецЕсли;
		
		Проводка.СчетКт = СтрокаПлатежа.СчетКт;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 1, СтрокаПлатежа.СубконтоКт1);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 2, СтрокаПлатежа.СубконтоКт2);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 3, СтрокаПлатежа.СубконтоКт3);
		
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
		Если СвойстваСчетаКт.Валютный Тогда
			Проводка.ВалютаКт        = Реквизиты.ВалютаДокумента;
			Проводка.ВалютнаяСуммаКт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		
		Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеКт = СтрокаПлатежа.ПодразделениеКт;
		КонецЕсли;
		
		НалоговыйУчет.ЗаполнитьНалоговыеСуммыПроводки(СтрокаПлатежа.СуммаРуб,СтрокаПлатежа.СуммаРуб,, ,,,Проводка);
	КонецЦикла;
	
	Движения.Хозрасчетный.Записывать = Истина;

КонецПроцедуры

Функция ПодготовитьПараметрыПрочееПоступление(РасшифровкаПлатежа, ТаблицаРеквизиты)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.РасшифровкаПлатежа
	
	СписокОбязательныхКолонок = ""
	+ "СчетДт,"                // <ПланСчетовСсылка.Хозрасчетный> - счет по дебету проводки (счет учета денежных средств)
	+ "СубконтоДт1,"           // Субконто1 по счету дебета
	+ "СубконтоДт2,"           // Субконто2 по счету дебета
	+ "СубконтоДт3,"           // Субконто3 по счету дебета
	+ "ПодразделениеДт,"       // <Ссылка на справочник подразделений> - подразделение по дебету проводки
	+ "СчетКт,"                // <ПланСчетовСсылка.Хозрасчетный> - счет по кредиту проводки (корреспондирующий со счетом ден.средств)
	+ "СубконтоКт1,"           // Субконто1 по счету кредита
	+ "СубконтоКт2,"           // Субконто2 по счету кредита
	+ "СубконтоКт3,"           // Субконто3 по счету кредита
	+ "ПодразделениеКт,"       // <Ссылка на справочник подразделений> - подразделение по кредиту проводки
	+ "ВалютнаяСумма,"         // <Число,15,2> - сумма поступления в валюте документа
	+ "СуммаРуб";              // <Число,15,2> - рублевая сумма поступления
	
	Параметры.Вставить("РасшифровкаПлатежа", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		РасшифровкаПлатежа, СписокОбязательныхКолонок));
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
	+ "Период,"                // <Дата> - период движений - дата документа
	+ "Организация,"           // <СправочникСсылка.Организации>
	+ "ВалютаДокумента,"       // <СправочникСсылка.Валюты>
	+ "Содержание";            // <Строка,150> - содержание проводок
	
	Параметры.Вставить("Реквизиты", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаРеквизиты, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции

// ПРОЧЕЕ СПИСАНИЕ

// Формируются бухгалтерские проводки по операциям списания (расхода) денежных средств из кассы или с расчетного счета,
// не связанных с расчетами с поставщиками и покупателями, а также с выплатой зарплаты
//
// Параметры
//  ТаблицаРасшифровкаПлатежа - <ТаблицаЗначений> - данные табличной части документа
//                       Создается в модуле менеджера документа
//  ТаблицаРеквизиты   - <ТаблицаЗначений> - реквизиты документа, необходимые для формирования движений.
//                       Создается в модуле менеджера документа
//  Движения           - коллекция движений документа
//  Отказ              - <Булево> - флаг отказа от проведения
//
Процедура СформироватьДвиженияПрочееСписание(ТаблицаРасшифровкаПлатежа, ТаблицаРеквизиты, Движения, Отказ) Экспорт
	
	Если Не ЗначениеЗаполнено(ТаблицаРасшифровкаПлатежа) Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыПрочееСписание(ТаблицаРасшифровкаПлатежа, ТаблицаРеквизиты);
	Реквизиты = Параметры.Реквизиты[0];
	
	Если Не ОбщегоНазначенияБПВызовСервераПовтИсп.ЭтоЮрЛицо(Реквизиты.Организация)
		И УчетСтраховыхВзносовИП.ЭтоСчетУчетаСтраховыхВзносовИП(Реквизиты.СчетУчета) Тогда
		
		// Заполнение автоаналитики при уплате фиксированных страховых взносов
		РасшифровкаПлатежа = УчетСтраховыхВзносовИП.ПодготовитьТаблицуУплатыСтраховыхВзносов(
			Параметры.РасшифровкаПлатежа, Параметры.Реквизиты);
	Иначе
		
		РасшифровкаПлатежа = Параметры.РасшифровкаПлатежа;
		
	КонецЕсли;
	
	Для каждого СтрокаПлатежа Из РасшифровкаПлатежа Цикл
		
		Проводка = Движения.Хозрасчетный.Добавить();
		
		Проводка.Период      = Реквизиты.Период;
		Проводка.Содержание  = Реквизиты.Содержание;
		Проводка.Организация = Реквизиты.Организация;
		Проводка.Сумма       = СтрокаПлатежа.СуммаРуб;
		
		Проводка.СчетДт = СтрокаПлатежа.СчетДт;
		Для НомерСубконто = 1 По 3 Цикл
			
			Если СтрокаПлатежа.ИспользоватьНомераСубконто Тогда
				ВидСубконто = НомерСубконто;
			Иначе
				ИмяКолонкиВидСубконто = "ВидСубконтоДт" + XMLСтрока(НомерСубконто);
				ВидСубконто = СтрокаПлатежа[ИмяКолонкиВидСубконто];
			КонецЕсли;
			
			ИмяКолонкиЗначениеСубконто = "СубконтоДт"    + XMLСтрока(НомерСубконто);
			БухгалтерскийУчет.УстановитьСубконто(
				Проводка.СчетДт,
				Проводка.СубконтоДт,
				ВидСубконто,
				СтрокаПлатежа[ИмяКолонкиЗначениеСубконто]);
			
		КонецЦикла;
		
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Если СвойстваСчетаДт.Валютный Тогда
			Проводка.ВалютаДт        = Реквизиты.ВалютаДокумента;
			Проводка.ВалютнаяСуммаДт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		
		Если СвойстваСчетаДт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеДт = СтрокаПлатежа.ПодразделениеДт;
		КонецЕсли;
		
		Проводка.СчетКт = СтрокаПлатежа.СчетКт;
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 1, СтрокаПлатежа.СубконтоКт1);
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт, 2, СтрокаПлатежа.СубконтоКт2);
		
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
		Если СвойстваСчетаКт.Валютный Тогда
			Проводка.ВалютаКт        = Реквизиты.ВалютаДокумента;
			Проводка.ВалютнаяСуммаКт = СтрокаПлатежа.ВалютнаяСумма;
		КонецЕсли;
		
		Если СвойстваСчетаКт.УчетПоПодразделениям Тогда
			Проводка.ПодразделениеКт = СтрокаПлатежа.ПодразделениеКт;
		КонецЕсли;
		
		НалоговыйУчет.ЗаполнитьНалоговыеСуммыПроводки(СтрокаПлатежа.СуммаРуб, СтрокаПлатежа.СуммаРуб,,,,, Проводка);
	КонецЦикла;
	
	Движения.Хозрасчетный.Записывать = Истина;
	
КонецПроцедуры

Функция ПодготовитьПараметрыПрочееСписание(РасшифровкаПлатежа, ТаблицаРеквизиты)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.РасшифровкаПлатежа
	
	СписокОбязательныхКолонок = ""
	+ "СчетДт,"                // <ПланСчетовСсылка.Хозрасчетный> - счет по дебету проводки (корреспондирующий со счетом ден.средств)
	+ "СубконтоДт1,"           // Субконто1 по счету дебета
	+ "СубконтоДт2,"           // Субконто2 по счету дебета
	+ "СубконтоДт3,"           // Субконто3 по счету дебета
	+ "ИспользоватьНомераСубконто," // Булево. Истина - субконто выше идентифицируются номерами субконто; Ложь - видам субконто, перечисленными ниже
	+ "ВидСубконтоДт1,"        // Вид СубконтоДт1
	+ "ВидСубконтоДт2,"        // Вид СубконтоДт2
	+ "ВидСубконтоДт3,"        // Вид СубконтоДт3
	+ "ПодразделениеДт,"       // <Ссылка на справочник подразделений> - подразделение по дебету проводки
	+ "СчетКт,"                // <ПланСчетовСсылка.Хозрасчетный> - счет по кредиту проводки (счет учета денежных средств)
	+ "СубконтоКт1,"           // Субконто1 по счету кредита
	+ "СубконтоКт2,"           // Субконто2 по счету кредита
	+ "СубконтоКт3,"           // Субконто3 по счету кредита
	+ "ПодразделениеКт,"       // <Ссылка на справочник подразделений> - подразделение по кредиту проводки
	+ "ВалютнаяСумма,"         // <Число,15,2> - сумма поступления в валюте документа
	+ "СуммаРуб";              // <Число,15,2> - рублевая сумма поступления
	
	Параметры.Вставить("РасшифровкаПлатежа", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		РасшифровкаПлатежа, СписокОбязательныхКолонок));
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
	+ "Период,"                // <Дата> - период движений - дата документа
	+ "Организация,"           // <СправочникСсылка.Организации>
	+ "ВалютаДокумента,"       // <СправочникСсылка.Валюты>
	+ "Содержание,"            // <Строка,150> - содержание проводок
	+ "СчетУчета,"             // <ПланСчетовСсылка.Хозрасчетный> - счет по дебету проводки (корреспондирующий со счетом ден.средств)
	+ "НалоговыйПериод,"       // <Дата>
	+ "Регистратор";           // <ДокументСсылка>
	
	Параметры.Вставить("Реквизиты", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаРеквизиты, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции
