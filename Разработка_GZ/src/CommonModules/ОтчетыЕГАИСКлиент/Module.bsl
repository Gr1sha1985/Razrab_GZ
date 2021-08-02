
#Область ПрограммныйИнтерфейс

// Обработчик расшифровки табличного документа формы отчета.
// См. "Расширение поля формы для поля табличного документа.ОбработкаРасшифровки" в синтакс-помощнике.
//
// Параметры:
//   ФормаОтчета - ФормаКлиентскогоПриложения - Форма отчета.
//   Элемент     - ПолеФормы        - Табличный документ.
//   Расшифровка - Произвольный     - Значение расшифровки точки, серии или значения диаграммы.
//   СтандартнаяОбработка - Булево  - Признак выполнения стандартной (системной) обработки события.
//
Процедура ОбработкаРасшифровкиОтчета(ФормаОтчета, Элемент, Расшифровка, СтандартнаяОбработка) Экспорт
	
	ПолноеИмяОтчета = ФормаОтчета.НастройкиОтчета.ПолноеИмя;
	
	Если ПолноеИмяОтчета <> "Отчет.ДвиженияМеждуРегистрамиЕГАИС"
		И ПолноеИмяОтчета <> "Отчет.ДвиженияПоСправке2ЕГАИС"
		И ПолноеИмяОтчета <> "Отчет.НеобработанныеТТНЕГАИС"
		И ПолноеИмяОтчета <> "Отчет.ОстаткиАлкогольнойПродукцииЕГАИС"
		И ПолноеИмяОтчета <> "Отчет.СводныйОтчетЕГАИС" Тогда
		Возврат;
	КонецЕсли;
	
	ПоляРасшифровки = Новый Массив;
	ПоляРасшифровки.Добавить("ДокументОснование");
	ПоляРасшифровки.Добавить("ИдентификаторЕГАИС");
	ПоляРасшифровки.Добавить("ОрганизацияЕГАИС");
	ПоляРасшифровки.Добавить("КодГрузоотправителя");
	ПоляРасшифровки.Добавить("КодАлкогольнойПродукции");
	ПоляРасшифровки.Добавить("Справка2");
	
	СтруктураРасшифровки = ОтчетыЕГАИСВызовСервера.ПараметрыФормыРасшифровки(Расшифровка, ФормаОтчета.ОтчетДанныеРасшифровки, Новый Массив, ПоляРасшифровки);
	
	Если СтруктураРасшифровки.Свойство("ДокументОснование") И СтруктураРасшифровки.ДокументОснование = Неопределено Тогда
		СтандартнаяОбработка = Ложь;
		ПоказатьПредупреждение(, НСтр("ru='В базе данных отсутствует документ-основание.'"));
		Возврат;
	КонецЕсли;
	
	Если НЕ СтруктураРасшифровки.Свойство("ОрганизацияЕГАИС") ИЛИ НЕ ЗначениеЗаполнено(СтруктураРасшифровки.ОрганизацияЕГАИС) Тогда
		Возврат;
	КонецЕсли;
	
	Если СтруктураРасшифровки.Свойство("ИдентификаторЕГАИС") И ЗначениеЗаполнено(СтруктураРасшифровки.ИдентификаторЕГАИС) Тогда
		
		СтандартнаяОбработка = Ложь;
		
		НачатьФормированиеЗапросаТТН(СтруктураРасшифровки.ОрганизацияЕГАИС, СтруктураРасшифровки.ИдентификаторЕГАИС);
		
	ИначеЕсли СтруктураРасшифровки.Свойство("КодГрузоотправителя") И ЗначениеЗаполнено(СтруктураРасшифровки.КодГрузоотправителя) Тогда
		
		СтандартнаяОбработка = Ложь;
		
		НачатьФормированиеЗапросаОрганизаций(СтруктураРасшифровки.ОрганизацияЕГАИС, СтруктураРасшифровки.КодГрузоотправителя);
		
	ИначеЕсли СтруктураРасшифровки.Свойство("КодАлкогольнойПродукции") И ЗначениеЗаполнено(СтруктураРасшифровки.КодАлкогольнойПродукции) Тогда
		
		СтандартнаяОбработка = Ложь;
		
		НачатьФормированиеЗапросаАлкогольнойПродукции(СтруктураРасшифровки.ОрганизацияЕГАИС, СтруктураРасшифровки.КодАлкогольнойПродукции);
		
	ИначеЕсли СтруктураРасшифровки.Свойство("Справка2") Тогда
		
		Если ЗначениеЗаполнено(СтруктураРасшифровки.Справка2) Тогда
			Возврат;
		КонецЕсли;
		
		СтандартнаяОбработка = Ложь;
		
		НомерСправки2 = "";
		
		ВыделенныеОбласти = ФормаОтчета.Элементы.ОтчетТабличныйДокумент.ПолучитьВыделенныеОбласти();
		Если ВыделенныеОбласти.Количество() = 1 И ЗначениеЗаполнено(ВыделенныеОбласти[0].Текст) Тогда
			НомерСправки2 = ВыделенныеОбласти[0].Текст;
		КонецЕсли;
		
		Если НЕ ПустаяСтрока(НомерСправки2) Тогда
			НачатьФормированиеЗапросаСправки2(СтруктураРасшифровки.ОрганизацияЕГАИС, НомерСправки2);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Обработчик команд, добавленных динамически и подключенных к обработчику "Подключаемый_Команда".
// Пример добавления команды см. ОтчетыПереопределяемый.ПриСозданииНаСервере().
//
// Параметры:
//   ФормаОтчета - ФормаКлиентскогоПриложения - Форма отчета.
//   Команда     - КомандаФормы     - Команда, которая была вызвана.
//   Результат   - Булево           - Истина, если вызов команды обработан.
//
Процедура ОбработчикКоманды(ФормаОтчета, Команда, Результат) Экспорт
	
	Если НЕ ФормаОтчета.ОтчетСформирован Тогда
		ОчиститьСообщения();
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru='Отчет не сформирован'"));
		Возврат;
	КонецЕсли;
	
	Если Команда.Имя = "ЗапроситьОтсутствующиеТТН" Тогда
		ЗапроситьОтсутствующиеТТН(ФормаОтчета);
	КонецЕсли;
	
	Если Команда.Имя = "ЗапроситьВыделенныеДанные" Тогда
		ЗапроситьВыделенныеДанные(ФормаОтчета);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Запрашивает отсутствующие в базе данных ТТН из УТМ.
//
Процедура ЗапроситьОтсутствующиеТТН(ФормаОтчета) Экспорт
	
	ДанныеЗапросов = ОтчетыЕГАИСВызовСервера.ПодготовитьДанныеЗапросовИзСхемыКомпоновкиДанных(ФормаОтчета.Отчет.КомпоновщикНастроек, ФормаОтчета.НастройкиОтчета.АдресСхемы);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресМассиваЗапросов", ПоместитьВоВременноеХранилище(ДанныеЗапросов));
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Запрашивает выделенные в табличном документе данные из УТМ.
//
Процедура ЗапроситьВыделенныеДанные(ФормаОтчета) Экспорт
	
	ВыделенныеОбласти = ФормаОтчета.Элементы.ОтчетТабличныйДокумент.ПолучитьВыделенныеОбласти();
	
	МассивРасшифровок = Новый Массив;
	
	Для Каждого Область Из ВыделенныеОбласти Цикл
		
		Для НомерСтроки = Область.Верх По Область.Низ Цикл
			Для НомерКолонки = Область.Лево По Область.Право Цикл
				ТекущаяОбласть = ФормаОтчета.ОтчетТабличныйДокумент.Область(НомерСтроки, НомерКолонки);
				Если ТекущаяОбласть.Расшифровка <> Неопределено Тогда
					МассивРасшифровок.Добавить(ТекущаяОбласть.Расшифровка);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
		
	КонецЦикла;
	
	ДанныеЗапросов = ОтчетыЕГАИСВызовСервера.ПодготовитьДанныеЗапросовИзМассиваРасшифровок(МассивРасшифровок, ФормаОтчета.ОтчетДанныеРасшифровки);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("АдресМассиваЗапросов", ПоместитьВоВременноеХранилище(ДанныеЗапросов));
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура НачатьФормированиеЗапросаТТН(ОрганизацияЕГАИС, ИдентификаторЕГАИС)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Операция"         , ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЗапросТТН"));
	ПараметрыФормы.Вставить("ЗначениеПараметра", ИдентификаторЕГАИС);
	ПараметрыФормы.Вставить("ОрганизацияЕГАИС" , ОрганизацияЕГАИС);
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура НачатьФормированиеЗапросаОрганизаций(ОрганизацияЕГАИС, КодФСРАР)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Операция"         , ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЗапросДанныхОрганизации"));
	ПараметрыФормы.Вставить("ИмяПараметра"     , "СИО");
	ПараметрыФормы.Вставить("ЗначениеПараметра", КодФСРАР);
	ПараметрыФормы.Вставить("ОрганизацияЕГАИС" , ОрганизацияЕГАИС);
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура НачатьФормированиеЗапросаАлкогольнойПродукции(ОрганизацияЕГАИС, КодАлкогольнойПродукции)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Операция"         , ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЗапросАлкогольнойПродукции"));
	ПараметрыФормы.Вставить("ИмяПараметра"     , "КОД");
	ПараметрыФормы.Вставить("ЗначениеПараметра", КодАлкогольнойПродукции);
	ПараметрыФормы.Вставить("ОрганизацияЕГАИС" , ОрганизацияЕГАИС);
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура НачатьФормированиеЗапросаСправки2(ОрганизацияЕГАИС, НомерСправки2)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Операция"         , ПредопределенноеЗначение("Перечисление.ВидыДокументовЕГАИС.ЗапросСправки2"));
	ПараметрыФормы.Вставить("ЗначениеПараметра", НомерСправки2);
	ПараметрыФормы.Вставить("ОрганизацияЕГАИС" , ОрганизацияЕГАИС);
	
	ОткрытьФорму(
		"ОбщаяФорма.ФормированиеИсходящегоЗапросаЕГАИС",
		ПараметрыФормы,
		ЭтотОбъект,,,,,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти