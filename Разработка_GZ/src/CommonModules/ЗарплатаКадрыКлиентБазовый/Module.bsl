#Область СлужебныеПроцедурыИФункции

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.ОткрытьРасшифровкуОтчета.
Процедура ОткрытьРасшифровкуРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета) Экспорт
	// Открывает в качестве расшифровки переданной ячейки предварительно подготовленный вариант отчета.
	
	ФормаРасшифровки = Неопределено;
	
	Если ИДОтчета = "РегламентированныйОтчетРСВ1" Тогда
		Если Число(Лев(СтрЗаменить(ИДРедакцииОтчета, "ФормаОтчета", ""), 4)) < 2013 Тогда // Расшифровываем с 2013 года.
			Возврат
		КонецЕсли;
		ФормаРасшифровки = УчетСтраховыхВзносовКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета)
	ИначеЕсли ИДОтчета = "РегламентированныйОтчет4ФСС" Тогда
		Если Число(Лев(СтрЗаменить(ИДРедакцииОтчета, "ФормаОтчета", ""), 4)) < 2013 Тогда // Расшифровываем с 2013 года.
			Возврат
		КонецЕсли;
		ФормаРасшифровки = УчетСтраховыхВзносовКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета);
		Если ФормаРасшифровки = Неопределено Тогда
			ФормаРасшифровки = УчетПособийСоциальногоСтрахованияКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета)
		КонецЕсли;
	ИначеЕсли ИДОтчета = "РегламентированныйОтчет6НДФЛ" Тогда
		ФормаРасшифровки = УчетНДФЛКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета)
	ИначеЕсли ИДОтчета = "РегламентированныйОтчет6_НДФЛ" Тогда
		ФормаРасшифровки = УчетНДФЛКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета)
	ИначеЕсли ИДОтчета = "РегламентированныйОтчетРасчетПоСтраховымВзносам" Тогда
		ФормаРасшифровки = УчетСтраховыхВзносовКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета);
		Если ФормаРасшифровки = Неопределено Тогда
			ФормаРасшифровки = УчетПособийСоциальногоСтрахованияКлиент.ФормаРасшифровкиРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ИДИменПоказателей, ПараметрыОтчета)
		КонецЕсли;
	Иначе
		Возврат
	КонецЕсли;
	
	Если ФормаРасшифровки = Неопределено Тогда
		ПоказатьПредупреждение(, 
			НСтр("ru='Для выбранной ячейки расшифровка не существует.'"),,
			НСтр("ru = 'Расшифровка регламентированных отчетов'"));
	Иначе
		ФормаРасшифровки.Открыть();
	КонецЕсли;
	
КонецПроцедуры

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.Печать.
Процедура ПечатьДокументаОтчетности(Ссылка, ИмяМакетаДляПечати, СтандартнаяОбработка) Экспорт
	// Реализует печать объектов, отображаемых на закладке Отчеты и Уведомления формы Отчетность.
	ПерсонифицированныйУчетКлиент.ПечатьДокументаОтчетности(Ссылка, ИмяМакетаДляПечати, СтандартнаяОбработка);
	УчетНДФЛКлиент.ПечатьДокументаОтчетности(Ссылка, ИмяМакетаДляПечати, СтандартнаяОбработка);
КонецПроцедуры

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.Выгрузить.
Процедура ВыгрузитьДокументОтчетности(Ссылка, УникальныйИдентификаторФормы) Экспорт
	ПерсонифицированныйУчетКлиент.ВыгрузитьДокументОтчетности(Ссылка, УникальныйИдентификаторФормы);
	УчетНДФЛКлиент.ВыгрузитьДокументОтчетности(Ссылка, УникальныйИдентификаторФормы);
	УчетПособийСоциальногоСтрахованияКлиент.ВыгрузитьДокументОтчетности(Ссылка, УникальныйИдентификаторФормы);
КонецПроцедуры

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.СоздатьНовыйОбъект.
Процедура СоздатьНовыйДокументОтчетности(Организация, Тип, СтандартнаяОбработка) Экспорт
	ПерсонифицированныйУчетКлиент.СоздатьНовыйДокументОтчетности(Организация, Тип, СтандартнаяОбработка);
	УчетНДФЛКлиент.СоздатьНовыйДокументОтчетности(Организация, Тип, СтандартнаяОбработка);
КонецПроцедуры

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.ПроверитьНастройкиЗаполненияОтчета.
Процедура ПроверитьНастройкиЗаполненияОтчета(ПараметрыОтчета, ВыполняемоеОповещение, СтандартнаяОбработка) Экспорт
	Возврат; // Нестандартная проверка не требуется.
КонецПроцедуры

// См. ЗарплатаКадрыКлиент.ОткрытьФормуСведенийОтветственныхЛиц.
Процедура ОткрытьФормуСведенийОтветственныхЛиц(Организация) Экспорт
	
КонецПроцедуры

// См. ЗарплатаКадрыКлиент.ОткрытьОбработкуРедактированиеЗаконодательныхЗначений.
Процедура ОткрытьОбработкуРедактированиеЗаконодательныхЗначений() Экспорт
	
КонецПроцедуры

#КонецОбласти
