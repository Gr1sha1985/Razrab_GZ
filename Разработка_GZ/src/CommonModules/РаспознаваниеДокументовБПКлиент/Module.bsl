#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

Процедура ОткрытиеФормыСоздаваемогоДокумента(ТипДокумента, ПараметрыЗаполнения, Владелец) Экспорт
	
	ПараметрыОбработчика = Новый Структура;
	ПараметрыОбработчика.Вставить("ТипДокумента", ТипДокумента);
	ПараметрыОбработчика.Вставить("ПараметрыЗаполнения", ПараметрыЗаполнения);
	ПараметрыОбработчика.Вставить("Владелец", Владелец);
	
	Оповещение = Новый ОписаниеОповещения("ПослеВыбораЗначения", ЭтотОбъект, ПараметрыОбработчика);
	
	Заголовок = НСтр("ru = 'Выберите вид документа'");
	
	Если ТипДокумента = Тип("ДокументСсылка.СчетФактураВыданный") Тогда
		НаРеализацию = ПредопределенноеЗначение("Перечисление.ВидСчетаФактурыВыставленного.НаРеализацию");
		ПоказатьВводЗначения(Оповещение, НаРеализацию, Заголовок);
	ИначеЕсли ТипДокумента = Тип("ДокументСсылка.СчетФактураПолученный") Тогда
		НаПоступление = ПредопределенноеЗначение("Перечисление.ВидСчетаФактурыПолученного.НаПоступление");
		ПоказатьВводЗначения(Оповещение, НаПоступление, Заголовок);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПослеВыбораЗначения(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ТипДокумента = ДополнительныеПараметры.ТипДокумента;
	ПараметрыЗаполнения = ДополнительныеПараметры.ПараметрыЗаполнения;
	Владелец = ДополнительныеПараметры.Владелец;
	
	Если ТипДокумента = Тип("ДокументСсылка.СчетФактураВыданный")
		ИЛИ ТипДокумента = Тип("ДокументСсылка.СчетФактураПолученный") Тогда
		
		ПараметрыЗаполнения.Вставить("ВидСчетаФактуры", ВыбранноеЗначение);
		ПараметрыФормы = Новый Структура("ЗначенияЗаполнения", ПараметрыЗаполнения);
		
		ИменаФорм = РаспознаваниеДокументовБПВызовСервера.ФормыСоздаваемогоДокумента(ТипДокумента);
		Если ИменаФорм = Неопределено Тогда
			Возврат;
		КонецЕсли;
		
		Если ТипДокумента = Тип("ДокументСсылка.СчетФактураВыданный") Тогда
			ПрефиксИмени = "Документ.СчетФактураВыданный.Форма.";
		Иначе
			ПрефиксИмени = "Документ.СчетФактураПолученный.Форма.";
		КонецЕсли;
		
		ИмяФормы = ПрефиксИмени + ИменаФорм[ВыбранноеЗначение];
		
		ОткрытьФорму(ИмяФормы, ПараметрыФормы, Владелец, , , , , РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти