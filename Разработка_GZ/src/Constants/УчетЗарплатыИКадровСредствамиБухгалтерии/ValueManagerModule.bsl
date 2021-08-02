#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПриЗаписи(Отказ)
	
	Если ЭтотОбъект.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	Если ЭтотОбъект.Значение = Константы.УчетЗарплатыИКадровВоВнешнейПрограмме.Получить() Тогда
		Константы.УчетЗарплатыИКадровВоВнешнейПрограмме.Установить(НЕ ЭтотОбъект.Значение);
	КонецЕсли;
	
	Константы.ИспользоватьНачислениеЗарплаты.Установить(ЭтотОбъект.Значение);
	
КонецПроцедуры

#КонецЕсли