
#Область СлужебныйПрограммныйИнтерфейс

// Определяет соответствие проверяемому типу документа, результат возвращает через второй параметр.
//
// Параметры:
//  Контекст        - УправляемаяФорма, ДокументСсылка - Контекст для определения типа документа
//  ЭтоПриобретение - Булево - исходящий признак соответствия документа типу «Приобретение товаров и услуг».
Процедура ЭтоДокументПриобретения(Контекст, ЭтоПриобретение) Экспорт
	
	ЭтоПриобретение = Ложь;
	ТипКонтекста    = ТипЗнч(Контекст);
	
	Если ТипКонтекста = Тип("УправляемаяФорма") Тогда
		Если СтрНачинаетсяС(Контекст.ИмяФормы, "Документ.ПоступлениеТоваровУслуг") 
			ИЛИ СтрНачинаетсяС(Контекст.ИмяФормы, "Документ.ПриемкаТоваровИСМП")
			ИЛИ СтрНачинаетсяС(Контекст.ИмяФормы, "Документ.ВозвратТоваровОтПокупателя") Тогда
			ЭтоПриобретение = Истина;
		КонецЕсли;
	ИначеЕсли ТипКонтекста = Тип("ДокументСсылка.ПоступлениеТоваровУслуг")
		ИЛИ ТипКонтекста = Тип("ДокументСсылка.ПриемкаТоваровИСМП") 
		ИЛИ ТипКонтекста = Тип("ДокументСсылка.ВозвратТоваровОтПокупателя") Тогда 
		ЭтоПриобретение = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Определяет соответствие проверяемому типу документа, результат возвращает через второй параметр.
//
// Параметры:
//  Контекст - УправляемаяФорма, ДокументСсылка - Контекст для определения типа документа
//  ЭтоЧек   - Булево - исходящий признак соответствия документа типу «Чек ККМ».
Процедура ЭтоЧекККМ(Контекст, ЭтоЧек) Экспорт
	
	ЭтоЧек       = Ложь;
	ТипКонтекста = ТипЗнч(Контекст);
	
	Если ТипКонтекста = Тип("УправляемаяФорма") Тогда
		Если СтрНачинаетсяС(Контекст.ИмяФормы, "Документ.РозничнаяПродажа") Тогда
			ЭтоЧек = Истина;
		КонецЕсли;
	ИначеЕсли ТипКонтекста = Тип("ДокументСсылка.РозничнаяПродажа") Тогда 
		ЭтоЧек = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Определяет соответствие проверяемому типу документа, результат возвращает через второй параметр.
//
// Параметры:
//  Контекст      - УправляемаяФорма, ДокументСсылка - Контекст для определения типа документа
//  ЭтоЧекВозврат - Булево - исходящий признак соответствия документа типу «Чек ККМ возврат».
Процедура ЭтоЧекККМВозврат(Контекст, ЭтоЧекВозврат) Экспорт
	
	ЭтоЧекВозврат = Ложь;
	
КонецПроцедуры

#Область СерииНоменклатуры

// Возвращает через параметр коды статусов, соответствующих не заполненным сериям.
//
// Параметры:
//  СтатусыСерияНеУказана - Массив - Исходящий, значения статусов, соответствующих не заполненным сериям.
Процедура СтатусыСерийСерияНеУказана(СтатусыСерияНеУказана) Экспорт
	
	СтатусыСерияНеУказана = Новый Массив;
	
КонецПроцедуры

// Возвращает через параметр коды статусов указания серий, соответствующих сериям, которые можно заполнить.
//
// Параметры:
//  СтатусыСерияНеУказана - Массив - Исходящий, значения статусов, соответствующих сериям, которые можно заполнить.
Процедура СтатусыСерийСериюМожноУказать(СтатусыСерийСериюМожноУказать) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
