#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПриЗаписи(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Значение Тогда
		Возврат;
	КонецЕсли;
	
	// Удалим недоступную детализацию в настройках учета затрат
	РегистрыСведений.МетодыОпределенияПрямыхРасходовПроизводстваВНУ.ОбновитьМетодыОпределенияПрямыхРасходовПроизводстваВНУ();
		
	// См. также ПланыСчетов.Хозрасчетный.УстановитьУчетЗатратПоПодразделениям()
	
КонецПроцедуры

#КонецЕсли
