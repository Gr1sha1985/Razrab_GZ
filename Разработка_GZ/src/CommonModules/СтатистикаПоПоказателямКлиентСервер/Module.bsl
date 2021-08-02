////////////////////////////////////////////////////////////////////////////////
// Подсистема "СтатистикаПоПоказателям"
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

Процедура ДобавитьСобытие(ИмяСобытия, Комментарий = "") Экспорт
	
	РазделениеВключено = Ложь;
	
	#Если Клиент Тогда
		РазделениеВключено = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().РазделениеВключено;	
	#Иначе
		РазделениеВключено = ОбщегоНазначения.РазделениеВключено();
	#КонецЕсли
		
	Если Не РазделениеВключено Тогда
		Возврат;
	КонецЕсли;	
	
	#Если Клиент Тогда	
		ЖурналРегистрацииКлиент.ДобавитьСообщениеДляЖурналаРегистрации(
			МаркерСобытияСтатистики(), "Информация", ЗаписатьСобытиеИКомментарий(ИмяСобытия, Комментарий));		
	#Иначе
		ЗаписьЖурналаРегистрации(
			МаркерСобытияСтатистики(), УровеньЖурналаРегистрации.Информация,,, ЗаписатьСобытиеИКомментарий(ИмяСобытия, Комментарий));
	#КонецЕсли
	
КонецПроцедуры

Функция МаркерСобытияСтатистики() Экспорт
	
	Возврат "Статистика_abd4d044ff5798fa";
               
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ЗаписатьСобытиеИКомментарий(ИмяСобытия, Комментарий)
	
	Возврат МаркерСобытияСтатистики() + ". " + СокрЛП(ИмяСобытия) + Символы.ПС + Комментарий;
	
КонецФункции

#КонецОбласти