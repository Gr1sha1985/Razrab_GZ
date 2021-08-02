
#Область СлужебныйПрограммныйИнтерфейс

#Область РасчетХешСумм

// Пересчитывает хеш-суммы всех упаковок формы. На клиенте формируется структура для расчёта, на сервере
// вычисляются хеш-суммы и проверяется необходимость перемаркировки.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма проверки и подбора маркируемой продукции.
//
Процедура ПересчитатьХешСуммыВсехУпаковок(Форма) Экспорт

	Если Не Форма.РасчитыватьХешСуммуУпаковок Тогда
		Возврат;
	КонецЕсли;

	Если Форма.ДетализацияСтруктурыХранения = ПредопределенноеЗначение("Перечисление.ДетализацияСтруктурыХраненияИС.ПотребительскиеУпаковки") Тогда
		Форма.КоличествоУпаковокКоторыеНеобходимоПеремаркировать = 0;
		ПроверкаИПодборПродукцииМОТПКлиентСервер.ОтобразитьИнформациюОНеобходимостиПеремаркировки(Форма);
		Возврат;
	КонецЕсли;
	
	ЗначенияСтрокДерева = Новый Массив();
	
	ПроверкаИПодборПродукцииИСКлиент.ЗаполнитьЗначенияСтрокДереваДляРасчетаХешСумм(ЗначенияСтрокДерева, Форма.ДеревоМаркированнойПродукции.ПолучитьЭлементы());

	ТаблицаПеремаркировки = ПроверкаИПодборПродукцииМОТПВызовСервера.ПересчитатьХешСуммыВсехУпаковок(ЗначенияСтрокДерева);
	
	СнятьПризнакПеремаркировкиДляПустыхУпаковок(ТаблицаПеремаркировки);
	
	ПроверкаИПодборПродукцииИСКлиент.ЗаполнитьХешСуммыВСтрокахДереваУпаковок(ЗначенияСтрокДерева, Форма.ДеревоМаркированнойПродукции);
	
	ПроверкаИПодборПродукцииМОТПКлиентСервер.ПроверитьНеобходимостьПеремаркировки(Форма, ТаблицаПеремаркировки, Ложь);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область ТипыШтрихкодов

Функция ДоступныеТипыШтрихкодовСтрокой() Экспорт
	
	ДоступныеТипы = Новый СписокЗначений();
	
	ДоступныеТипы.Добавить("GS1128");
	ДоступныеТипы.Добавить("SSCC");
	
	Возврат ДоступныеТипы;
	
КонецФункции

#КонецОбласти

Процедура СнятьПризнакПеремаркировкиДляПустыхУпаковок(ТаблицаПеремаркировки)
	
	Для Каждого СтрокаТаблицы Из ТаблицаПеремаркировки Цикл
		Если СтрокаТаблицы.ТребуетсяПеремаркировка И СтрокаТаблицы.ПустаяУпаковка Тогда
			СтрокаТаблицы.ТребуетсяПеремаркировка = Ложь;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти