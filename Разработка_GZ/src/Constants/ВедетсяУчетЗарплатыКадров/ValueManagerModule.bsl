
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда
	
#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ЭтотОбъект.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УчетЗарплаты.УправлениеФункциональностьюУчетаЗарплатыИКадров(ЭтотОбъект.Значение, ЭтотОбъект.ДополнительныеСвойства);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
