#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Значение Тогда
		Справочники.ВидыНоменклатуры.СоздатьЭлементыКомиссияНаЗакупку();
		Если Не Константы.ВестиУчетПоДоговорам.Получить() Тогда
			Константы.ВестиУчетПоДоговорам.Установить(Истина);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
