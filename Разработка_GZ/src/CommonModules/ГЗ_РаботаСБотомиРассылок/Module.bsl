	
	
	//Пример отправки сообщения
	//Сообщение = СистемаВзаимодействия.СоздатьСообщение(новый ИдентификаторОбсужденияСистемыВзаимодействия("fdb10b67-d1e4-44fb-94aa-22ac7c9fbea0"));
	//Сообщение.Получатели.Добавить(новый ИдентификаторПользователяСистемыВзаимодействия("125541d6-4707-44da-b2a6-307b98db77a6"));
	//Сообщение.Автор = Новый ИдентификаторПользователяСистемыВзаимодействия("125541d6-4707-44da-b2a6-307b98db77a6");
	//
	//Сообщение.Текст = "Тестовое сообщение от бота GZ";
	//
	//Попытка
	//	Сообщение.Записать();
	//Исключение
	//	
	//КонецПопытки;
Процедура ОтправитьСообщениеПользователюТелеграмм(ИДПользователя, ИДОбсуждения, ТекстСообщения, ТаблицаОповещения) Экспорт 
	
	Сообщение = СистемаВзаимодействия.СоздатьСообщение(новый ИдентификаторОбсужденияСистемыВзаимодействия(ИДОбсуждения));
	
	Сообщение.Получатели.Добавить(новый ИдентификаторПользователяСистемыВзаимодействия(ИДПользователя));
	
	Сообщение.Автор = Новый ИдентификаторПользователяСистемыВзаимодействия("125541d6-4707-44da-b2a6-307b98db77a6");//Отправка от пользователя 1С
	
	Сообщение.Текст = ТекстСообщения;
	
	Попытка
		Сообщение.Записать();
	Исключение
		
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Истина);

КонецПроцедуры

Процедура ГЗ_РассылкаСообщенийБотомВТелеграмм() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Ссылка КАК Ссылка,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Регион КАК Регион,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.ОКПД2 КАК ОКПД2,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Организация КАК Организация,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Сумма КАК Сумма,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.НаименованиеЗакупки КАК НаименованиеЗакупки,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Активно КАК Активно,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Ссылка.ИДПользователя КАК ИДПользователя,
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Ссылка.ИДОбсуждения КАК ИДОбсуждения
		|ИЗ
		|	Справочник.ГЗ_ПользователяСистемыВзаимодействия.КритерииПоискаЗакупок КАК ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок
		|ГДЕ
		|	ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Ссылка.Актуален = ИСТИНА
		|	И ГЗ_ПользователяСистемыВзаимодействияКритерииПоискаЗакупок.Активно = ИСТИНА";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если Не РезультатЗапроса.Пустой() Тогда 
	
		ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
		Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		// Вставить обработку выборки ВыборкаДетальныеЗаписи
		КонецЦикла;
	КонецЕсли;
КонецПроцедуры

Процедура ГЗ_ФормированиеДанныхДляРассылкиБотом() Экспорт
	// Вставить содержимое обработчика.
КонецПроцедуры

