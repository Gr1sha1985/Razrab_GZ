
#Область СлужебныйПрограммныйИнтерфейс

Функция СгруппироватьТаблицу(Таблица, ПоляГруппировкиСтрокой, ГруппируемыеПоляСтрокой) Экспорт
	МакетКомпоновки = МакетКомпоновкиДанных();
	
	ПоляГруппировки = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ПоляГруппировкиСтрокой, ",", Истина, Истина);	
	ГруппируемыеПоля = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ГруппируемыеПоляСтрокой, ",", Истина, Истина);
	
	ТипыПолей = Новый Соответствие;
	
	ВыраженияПолейГруппировки = Новый Массив;
	Для Каждого Поле Из ПоляГруппировки Цикл
		ВыражениеПоля = "Таблица." + Поле;
		ДобавитьВыбираемоеПолеВМакетКомпоновки(МакетКомпоновки, ВыражениеПоля, Поле);
		ВыраженияПолейГруппировки.Добавить(ВыражениеПоля);
		ТипыПолей.Вставить(Поле, Таблица.Колонки[Поле].ТипЗначения);
	КонецЦикла;	
	
	Для Каждого Поле Из ГруппируемыеПоля Цикл
		ПервыйСимволПоля = СтрНайти(Поле, "(") + 1;
		ПоследнийСимволПоля = СтрНайти(Поле, ")") - 1;
		ПолеТаблицы = Сред(Поле, ПервыйСимволПоля, ПоследнийСимволПоля - ПервыйСимволПоля + 1);
		ТипыПолей.Вставить(ПолеТаблицы, Таблица.Колонки[ПолеТаблицы].ТипЗначения);
	
		ВыражениеПоля = СтрЗаменить(Поле, ПолеТаблицы, "Таблица." + ПолеТаблицы);
		ДобавитьВыбираемоеПолеВМакетКомпоновки(МакетКомпоновки, ВыражениеПоля, ПолеТаблицы);
	КонецЦикла;	
	
	ДобавитьНаборДанныхСКДПоТаблицеЗначений(МакетКомпоновки.НаборыДанных, Таблица, "Таблица", "Таблица");		
	ТаблицыИсточники = Новый Структура("Таблица", Таблица);
	
	Возврат ПолучитьДанныеПоМакетуКомпоновки(МакетКомпоновки, ТаблицыИсточники, ВыраженияПолейГруппировки, ТипыПолей);
КонецФункции

Функция ПолучитьДанныеПоМакетуКомпоновки(МакетКомпоновки, ТаблицыИсточники, ВыраженияПолейГруппировки = Неопределено, ТипыПолейРезультирующейТаблицы = Неопределено) Экспорт
	СоздатьТелоМакетаКомпоновки(МакетКомпоновки, ВыраженияПолейГруппировки);
	
	ПроцессорКомпоновки = Новый ПроцессорКомпоновкиДанных;
	ПроцессорКомпоновки.Инициализировать(МакетКомпоновки, ТаблицыИсточники);
	
	Результат = Новый ТаблицаЗначений;
	Если ТипыПолейРезультирующейТаблицы <> Неопределено Тогда
		Для Каждого Поле Из ТипыПолейРезультирующейТаблицы Цикл
			Результат.Колонки.Добавить(Поле.Ключ, Поле.Значение);
		КонецЦикла;	
	КонецЕсли;	
	
	ПроцессорВывода = Новый ПроцессорВыводаРезультатаКомпоновкиДанныхВКоллекциюЗначений;
	ПроцессорВывода.УстановитьОбъект(Результат);
	
	ПроцессорВывода.Вывести(ПроцессорКомпоновки);

	Возврат Результат;	                	
КонецФункции	

Процедура ДобавитьНаборДанныхСКДПоТаблицеЗначений(Приемник, Таблица, ИмяТаблицы, Псевдоним) Экспорт
	
	Набор = Приемник.Добавить(Тип("НаборДанныхОбъектМакетаКомпоновкиДанных"));
	Набор.Имя = Псевдоним;
	Набор.ИмяОбъекта = ИмяТаблицы;
	Набор.ИсточникДанных = "Источник";
	
	Для Каждого КолонкаТаблицы Из Таблица.Колонки Цикл
		ПолеНабораДанных = Набор.Поля.Добавить();
		ПолеНабораДанных.ПутьКДанным = КолонкаТаблицы.Имя;
		ПолеНабораДанных.Имя = КолонкаТаблицы.Имя;
	КонецЦикла;	
	
КонецПроцедуры	

Процедура ДобавитьВыбираемоеПолеВМакетКомпоновки(МакетКомпоновки, Выражение, Псевдоним) Экспорт
	Если МакетКомпоновки.Макеты.Количество() = 0 Тогда
		ОписаниеМакетаЗаголовкаКоллекции = МакетКомпоновки.Макеты.Добавить();
		ОписаниеМакетаЗаголовкаКоллекции.Имя = "Макет1";
		
		ОписаниеМакетаКоллекцииЗначений = МакетКомпоновки.Макеты.Добавить();
		ОписаниеМакетаКоллекцииЗначений.Имя = "Макет2";
	Иначе
		ОписаниеМакетаЗаголовкаКоллекции = МакетКомпоновки.Макеты[0];
		ОписаниеМакетаКоллекцииЗначений = МакетКомпоновки.Макеты[1];
	КонецЕсли;	
	
	ПараметрОбласти = ОписаниеМакетаКоллекцииЗначений.Параметры.Добавить(Тип("ПараметрОбластиВыражениеКомпоновкиДанных"));
	ПараметрОбласти.Выражение = Выражение;
	ПараметрОбласти.Имя = Псевдоним;
	
	Если ОписаниеМакетаКоллекцииЗначений.Макет = Неопределено Тогда
		ОписаниеМакетаКоллекцииЗначений.Макет = Новый МакетКоллекцииЗначенийОбластиКомпоновкиДанных;
	КонецЕсли;	
	
	Ячейка = ОписаниеМакетаКоллекцииЗначений.Макет.Ячейки.Добавить();
	Ячейка.Значение = Новый ПараметрКомпоновкиДанных(Псевдоним);
	Ячейка.Колонка = Псевдоним;	
	
	Если ОписаниеМакетаЗаголовкаКоллекции.Макет = Неопределено Тогда
		ОписаниеМакетаЗаголовкаКоллекции.Макет = Новый МакетЗаголовкаКоллекцииЗначенийОбластиКомпоновкиДанных;
	КонецЕсли;	
		
	Ячейка = ОписаниеМакетаЗаголовкаКоллекции.Макет.Ячейки.Добавить();
	Ячейка.Имя = Псевдоним;		
КонецПроцедуры	

Функция МакетКомпоновкиДанных() Экспорт
	МакетКомпоновки = Новый МакетКомпоновкиДанных;
	Источник = МакетКомпоновки.ИсточникиДанных.Добавить();
	Источник.Имя = "Источник";
	Источник.Тип = "Local";
	
	Возврат МакетКомпоновки;
КонецФункции

Функция УникальныеЗначенияКолонки(ТаблицаЗначений, ИмяКолонки) Экспорт
	Копия = ТаблицаЗначений.Скопировать(, ИмяКолонки);
	Копия.Свернуть(ИмяКолонки);
	Возврат Копия.ВыгрузитьКолонку(ИмяКолонки);
КонецФункции

Функция УникальныеЗначенияКолонкиСФильтром(ТаблицаЗначений, Фильтр, ИмяКолонки) Экспорт
	Копия = ТаблицаЗначений.Скопировать(Фильтр, ИмяКолонки);
	Копия.Свернуть(ИмяКолонки);
	Возврат Копия.ВыгрузитьКолонку(ИмяКолонки);
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура СоздатьТелоМакетаКомпоновки(МакетКомпоновки, ПоляГруппировки = Неопределено)	
	Тело = МакетКомпоновки.Тело.Добавить(Тип("МакетОбластиМакетаКомпоновкиДанных"));
	Тело.Макет = "Макет1";
	
	Тело = МакетКомпоновки.Тело.Добавить(Тип("ГруппировкаМакетаКомпоновкиДанных"));
	
	Если ПоляГруппировки <> Неопределено Тогда
		Для Каждого Поле Из ПоляГруппировки Цикл
			ПолеГруппировки = Тело.Группировка.Добавить();	
			ПолеГруппировки.Выражение = Поле;
			ПолеГруппировки.ИмяПоля  = Поле
		КонецЦикла;	
	Иначе
		Тело = МакетКомпоновки.Тело.Добавить(Тип("ЗаписиМакетаКомпоновкиДанных"));
		 
		Для Каждого Набор Из МакетКомпоновки.НаборыДанных Цикл
			Тело.НаборыДанных.Добавить(Набор.Имя);
		КонецЦикла;
	КонецЕсли;	
	
	Тело.Идентификатор = "Записи";
	Тело.Имя = "Записи";
	Тело.КоличествоЗаписей = -1;
			
	МакетОбласти = Тело.Тело.Добавить(Тип("МакетОбластиМакетаКомпоновкиДанных"));
	МакетОбласти.Макет = "Макет2";
	
КонецПроцедуры	

#КонецОбласти