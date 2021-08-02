#Область ПрограммныйИнтерфейс

// Возвращает список вариантов отражения доходов кассовым методом, допустимых для организации на переданную дату
// с учетом применяемых режимов налогообложения и настроек функциональности.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация.
//  Период       - Дата - дата, на которую требуются сведения.
//
// Возвращаемое значение:
//   СписокЗначений   - список с перечнем допустимых вариантов отражения доходов, содержимое:
//                       * значения - порядок отражения доходов, указывается в документах поступления денежных средств;
//                       * представления - представления вариантов отражения доходов для отображения в списках выбора.
//
Функция ДопустимыеВариантыОтраженияДоходов(Организация, Период) Экспорт
	
	СписокВариантов = Новый СписокЗначений;
	
	Если Не ЗначениеЗаполнено(Организация) Или Не ЗначениеЗаполнено(Период) Тогда
		Возврат СписокВариантов;
	КонецЕсли;
	
	Для Каждого Вариант Из УчетУСН.ДопустимыеВариантыОтраженияДоходов(Организация, Период) Цикл
		СписокВариантов.Добавить(Вариант.Значение, Вариант.Представление);
	КонецЦикла;
	
	Для Каждого Вариант Из УчетДоходовИРасходовПредпринимателя.ДопустимыеВариантыОтраженияДоходов(Организация, Период) Цикл
		СписокВариантов.Добавить(Вариант.Значение, Вариант.Представление);
	КонецЦикла;
	
	Для Каждого Вариант Из УчетЕНВД.ДопустимыеВариантыОтраженияДоходов(Организация, Период) Цикл
		СписокВариантов.Добавить(Вариант.Значение, Вариант.Представление);
	КонецЦикла;
	
	Для Каждого Вариант Из УчетПСН.ДопустимыеВариантыОтраженияДоходов(Организация, Период) Цикл
		СписокВариантов.Добавить(Вариант.Значение, Вариант.Представление);
	КонецЦикла;
	
	Возврат СписокВариантов;
	
КонецФункции

// Возвращает основной порядок отражения доходов кассовым методом в организации.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация.
//  Период       - Дата - дата, на которую требуются сведения.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.ПорядокОтраженияАвансов, СправочникСсылка.Патенты, Неопределено  - основной порядок отражения доходов.
//
Функция ОтражениеДоходовПоУмолчанию(Организация, Период) Экспорт
	
	СвойстваОтраженияДоходов = ПорядокОтраженияДоходовПоУмолчанию(Организация, Период);
	
	Если СвойстваОтраженияДоходов.ПорядокОтраженияАванса = Перечисления.ПорядокОтраженияАвансов.ДоходПатент Тогда
		Возврат СвойстваОтраженияДоходов.Патент;
	Иначе
		Возврат СвойстваОтраженияДоходов.ПорядокОтраженияАванса;
	КонецЕсли;
	
КонецФункции

// Возвращает режим учета доходов и расходов без закрывающих документов (кассовым методом) по умолчанию
// для данной организации и вида операции с учетом настроек программы.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация.
//  Дата         - Дата - дата, на которую требуются сведения.
//  ВидОперации  - ПеречислениеСсылка - вид операции документа, для которого определяется режим по умолчанию.
//
// Возвращаемое значение:
//   Булево   - Если Истина, то для данной операции по умолчанию задается режим без закрывающих документов.
//
Функция БезЗакрывающихДокументов(Организация, Дата, ВидОперации) Экспорт
	
	БезЗакрывающихДокументов = УчетБезЗакрывающихДокументовВозможен(Организация, Дата)
		И (УчетДенежныхСредствКлиентСервер.ЕстьРасчетыСПокупателями(ВидОперации)
			И НЕ ПолучитьФункциональнуюОпцию("ИспользоватьДокументыРеализации")
		ИЛИ УчетДенежныхСредствКлиентСервер.ЕстьРасчетыСПоставщиками(ВидОперации)
			И НЕ ПолучитьФункциональнуюОпцию("ИспользоватьДокументыПоступления")
		ИЛИ УчетДенежныхСредствКлиентСервер.ЕстьРозничнаяВыручка(ВидОперации)
			И НЕ УчетДенежныхСредств.ИспользоватьЗакрывающиеДокументыРозничнойТорговли());
	Возврат БезЗакрывающихДокументов;
	
КонецФункции

// Проверяет допустимость учета доходов и расходов без закрывающих документов (кассовым методом)
// для данной организации на переданную дату.
//
// Параметры:
//  Организация  - СправочникСсылка.Организации - организация.
//  Дата         - Дата - дата, на которую требуются сведения.
//
// Возвращаемое значение:
//   Булево   - Если Истина, то учет без закрывающих документов допустим.
//
Функция УчетБезЗакрывающихДокументовВозможен(Организация, Дата) Экспорт
	
	СистемаНалогообложения = УчетнаяПолитика.СистемаНалогообложения(Организация, Дата);
	ПрименяетсяУСНДоходы = УчетнаяПолитика.ПрименяетсяУСНДоходы(Организация, Дата);
	
	УчетВозможен = (СистемаНалогообложения = Перечисления.СистемыНалогообложения.Упрощенная И ПрименяетсяУСНДоходы)
		Или СистемаНалогообложения = Перечисления.СистемыНалогообложения.ОсобыйПорядок
		Или СистемаНалогообложения = Перечисления.СистемыНалогообложения.НалогНаПрофессиональныйДоход;
	
	Возврат УчетВозможен;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПорядокОтраженияДоходовПоУмолчанию(Организация, Знач Период)
	
	Результат = Новый Структура("ПорядокОтраженияАванса, Патент");
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		Возврат Результат;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(Период) Тогда
		Период = ТекущаяДатаСеанса();
	КонецЕсли;
	
	Если УчетнаяПолитика.ПрименяетсяУСН(Организация, Период) Тогда
		
		Результат.ПорядокОтраженияАванса = УчетнаяПолитика.ПорядокОтраженияАвансаУСН(Организация, Период);
		Результат.Патент                 = УчетнаяПолитика.ПатентУСН(Организация, Период);
		
	ИначеЕсли УчетнаяПолитика.ПрименяетсяОсобыйПорядокНалогообложения(Организация, Период) Тогда
		
		Если УчетнаяПолитика.ПрименяетсяУСНПатент(Организация, Период) И Не УчетнаяПолитика.ПлательщикЕНВД(Организация, Период) Тогда
			
			ПатентПоУмолчанию = УчетПСН.ПатентПоУмолчанию(Организация, Период);
			Если ЗначениеЗаполнено(ПатентПоУмолчанию) Тогда
				Результат.ПорядокОтраженияАванса = Перечисления.ПорядокОтраженияАвансов.ДоходПатент;
				Результат.Патент = ПатентПоУмолчанию;
			КонецЕсли;
			
		ИначеЕсли УчетнаяПолитика.ПлательщикЕНВД(Организация, Период) Тогда
			
			Результат.ПорядокОтраженияАванса = Перечисления.ПорядокОтраженияАвансов.ДоходЕНВД;
			
		КонецЕсли;
		
	ИначеЕсли УчетнаяПолитика.ПлательщикНДФЛ(Организация, Период) Тогда
		
		Если УчетнаяПолитика.ПрименяетсяУСНПатент(Организация, Период)
			И УчетнаяПолитика.ОсновнойХарактерДеятельности(Организация, Период)
				= Перечисления.ХарактерДеятельности.ВсяДеятельностьНаПатенте Тогда
			
			ПатентПоУмолчанию = УчетПСН.ПатентПоУмолчанию(Организация, Период);
			Если ЗначениеЗаполнено(ПатентПоУмолчанию) Тогда
				Результат.ПорядокОтраженияАванса = Перечисления.ПорядокОтраженияАвансов.ДоходПатент;
				Результат.Патент = ПатентПоУмолчанию;
			КонецЕсли;
			
		Иначе
			
			Результат.ПорядокОтраженияАванса = Перечисления.ПорядокОтраженияАвансов.ДоходИП;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти