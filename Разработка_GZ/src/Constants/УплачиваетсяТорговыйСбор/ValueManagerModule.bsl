#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Значение Тогда
		КлассификаторыДоходовРасходов.ОбеспечитьФункциональность(Справочники.СтатьиЗатрат, "УплачиваетсяТорговыйСбор");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли