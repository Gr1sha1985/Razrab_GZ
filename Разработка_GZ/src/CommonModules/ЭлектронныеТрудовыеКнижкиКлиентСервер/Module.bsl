#Область СлужебныйПрограммныйИнтерфейс

Процедура УстановитьОтображениеТаблицыМероприятия(УправляемаяФорма, Организация, Мероприятия) Экспорт
	
	Элементы = УправляемаяФорма.Элементы;
	
	ДоступныеПоляМероприятий = ДоступныеПоляПоВидамМероприятий();
	
	// Подготовка коллекции имен полей с управляемым выводом
	ИменаПолейСУправляемымВыводом = Новый Структура;
	Для Каждого ОписаниеДоступныхПолей Из ДоступныеПоляМероприятий Цикл
		
		Для Каждого ИмяПоля Из ОписаниеДоступныхПолей.Значение Цикл
			ИменаПолейСУправляемымВыводом.Вставить(ИмяПоля, Истина);
		КонецЦикла;
		
	КонецЦикла;
	
	// Подготовка коллекции имен полей документа
	ИменаПолейДокумента = Новый Структура("Идентификатор", Истина);
	
	ДанныеМероприятий = ДанныеСтрокМероприятий(Мероприятия);
	Для Каждого ВидМероприятия Из ДанныеМероприятий.ВидыМероприятий Цикл
		
		ДоступныеПоляВида = ДоступныеПоляМероприятий[ВидМероприятия.Ключ];
		Если ДоступныеПоляВида <> Неопределено Тогда
			Для Каждого ИмяПоля Из ДоступныеПоляВида Цикл
				ИменаПолейДокумента.Вставить(ИмяПоля, Истина);
			КонецЦикла;
		КонецЕсли;
		
	КонецЦикла;
	
	// Поле редактирования идентификатора мероприятия скрывается, если нет отмененных мероприятий
	Если Не ДанныеМероприятий.ЕстьДатаОтмены
		И ДанныеМероприятий.ВидыМероприятий.Получить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.Перевод")) = Неопределено Тогда
		
		ИменаПолейДокумента.Удалить("Идентификатор");
		ВидимостьДатаОтмены = Ложь;
	Иначе
		ВидимостьДатаОтмены = Истина;
	КонецЕсли;
	
	// Скрытие поля ДатаОтмены, если нет отмененных событий
	Если Не ВидимостьДатаОтмены Тогда
		ВидимостьДатаОтмены = ДанныеМероприятий.ЕстьФиксСтрока;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"МероприятияДатаОтмены",
		"Видимость",
		ВидимостьДатаОтмены);
	
	ВидимостьПодразделений = ДанныеМероприятий.ЕстьПодразделения;
	Если Не ВидимостьПодразделений Тогда
		
		Если Не ЭлектронныеТрудовыеКнижкиВызовСервера.НеЗаполнятьПодразделенияВМероприятияхТрудовойДеятельности(Организация) Тогда
			ВидимостьПодразделений = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Не ВидимостьПодразделений Тогда
		ИменаПолейДокумента.Удалить("Подразделение");
	КонецЕсли;
	
	// Установка видимости элементов полей с управляемым выводом
	КоллекцииЭлементов = Новый Массив;
	КоллекцииЭлементов.Добавить(Элементы.Мероприятия.ПодчиненныеЭлементы);
	
	Для Каждого ЭлементФормы Из Элементы.Мероприятия.ПодчиненныеЭлементы Цикл
		
		Если ТипЗнч(ЭлементФормы) = Тип("ГруппаФормы") Тогда
			КоллекцииЭлементов.Добавить(ЭлементФормы.ПодчиненныеЭлементы);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого КоллекцияЭлементов Из КоллекцииЭлементов Цикл
		
		Для Каждого ЭлементФормы Из КоллекцияЭлементов Цикл
			
			ИмяКолонки = Сред(ЭлементФормы.Имя, СтрДлина("Мероприятия") + 1);
			
			Если Не ИменаПолейСУправляемымВыводом.Свойство(ИмяКолонки) Тогда
				Продолжить;
			КонецЕсли;
			
			ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
				Элементы,
				ЭлементФормы.Имя,
				"Видимость",
				ИменаПолейДокумента.Свойство(ИмяКолонки));
			
		КонецЦикла;
		
	КонецЦикла;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"МероприятияКодПоРееструДолжностей",
		"Видимость",
		УправляемаяФорма.КодПоРееструДолжностейВидимость
		И ИменаПолейДокумента.Свойство("Должность"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"МероприятияРазрядКатегория",
		"Видимость",
		УправляемаяФорма.РазрядКатегорияВидимость
		И ИменаПолейДокумента.Свойство("Должность"));
	
КонецПроцедуры

Функция ДоступныеПоляВсехВидовМероприятий() Экспорт
	
	Возврат "ИдМероприятия,ЯвляетсяСовместителем,ДатаМероприятия,ВидМероприятия,Сведения,НаименованиеДокументаОснования,"
		+ "ДатаДокументаОснования,НомерДокументаОснования,СерияДокументаОснования,ДатаОтмены,СотрудникЗаписи,"
		+ "НаименованиеВторогоДокументаОснования,ДатаВторогоДокументаОснования,СерияВторогоДокументаОснования,НомерВторогоДокументаОснования";
	
КонецФункции

Функция ДоступныеПоляВсехВидовМероприятийДокумента() Экспорт
	
	Возврат СтрЗаменить(ДоступныеПоляВсехВидовМероприятий(), "ИдМероприятия,", "") + ",ФиксСтрока";
	
КонецФункции

Функция ИменаДоступныхПолейВидовМероприятий() Экспорт
	
	ДоступныеПоля = Новый Соответствие;
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.ЗапретЗаниматьДолжность"),
		"Должность,КодПоРееструДолжностей,РазрядКатегория,ТрудоваяФункция,ДатаС,ДатаПо,"
		+ "ПредставлениеДолжности");
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.Перевод"),
		"Должность,КодПоРееструДолжностей,РазрядКатегория,Подразделение,ТрудоваяФункция,"
		+ "ПредставлениеДолжности,ПредставлениеПодразделения");
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.Переименование"),
		"Должность,КодПоРееструДолжностей,РазрядКатегория,Подразделение,ТрудоваяФункция,"
		+ "ПредставлениеДолжности,ПредставлениеПодразделения");
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.Прием"),
		"Должность,КодПоРееструДолжностей,РазрядКатегория,Подразделение,ТрудоваяФункция,"
		+ "ПредставлениеДолжности,ПредставлениеПодразделения");
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.Увольнение"),
		"ОснованиеУвольнения,ОснованиеУвольненияТекстОснования,ОснованиеУвольненияСтатья,ОснованиеУвольненияЧасть,ОснованиеУвольненияПункт,ОснованиеУвольненияПодПункт");
	
	ДоступныеПоля.Вставить(ПредопределенноеЗначение("Перечисление.ВидыМероприятийТрудовойДеятельности.УстановлениеВторойПрофессии"),
		"Должность,КодПоРееструДолжностей,РазрядКатегория,ТрудоваяФункция,"
		+ "ОписаниеДолжности");
	
	Возврат ДоступныеПоля;
	
КонецФункции

Процедура УстановитьОтображениеНомеровДокумента(УправляемаяФорма) Экспорт
	
	Если ЗначениеЗаполнено(УправляемаяФорма.Объект.Номер) Тогда
		ПодсказкаВвода = ЭлектронныеТрудовыеКнижкиВызовСервера.НомерНаПечать(УправляемаяФорма.Объект.Номер);
	Иначе
		ПодсказкаВвода = НСтр("ru = '<Авто>'");
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		УправляемаяФорма.Элементы,
		"НомерПриказа",
		"ПодсказкаВвода",
		ПодсказкаВвода);
	
КонецПроцедуры

Процедура УстановитьЗаголовокГруппыВторогоДокументаОснования(УправляемаяФорма, РедактированиеСтрокиСписочногоДокумента = Ложь) Экспорт
	
	Объект = УправляемаяФорма.Объект;
	Элементы = УправляемаяФорма.Элементы;
	
	Если ЗначениеЗаполнено(Объект.НаименованиеВторогоДокументаОснования) Тогда
		
		ЗаголовокГруппы = НСтр("ru = 'Второй документ основание'") + ": " + Объект.НаименованиеВторогоДокументаОснования
			+ " " + НСтр("ru = 'от'") + " " + Формат(Объект.ДатаВторогоДокументаОснования, "ДЛФ=D; ДП=")
			+ " № " + Объект.СерияВторогоДокументаОснования + ?(ЗначениеЗаполнено(Объект.СерияВторогоДокументаОснования), " ", "")
			+ Объект.НомерВторогоДокументаОснования;
		
	Иначе
		ЗаголовокГруппы = НСтр("ru = 'Второй документ основание: не задан'")
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ВторойДокументОснованиеГруппа",
		"ЗаголовокСвернутогоОтображения",
		ЗаголовокГруппы);
	
	ВидимостьГруппы = Не РедактированиеСтрокиСписочногоДокумента
		И (ЗначениеЗаполнено(Объект.НаименованиеВторогоДокументаОснования)
			Или ЗначениеЗаполнено(Объект.ДатаВторогоДокументаОснования)
			Или ЗначениеЗаполнено(Объект.СерияВторогоДокументаОснования)
			Или ЗначениеЗаполнено(Объект.НомерВторогоДокументаОснования)
			Или ЭлектронныеТрудовыеКнижкиВызовСервера.ИспользоватьДляМероприятийПриемПереводУвольнениеДваДокументаОснования());
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		Элементы,
		"ВторойДокументОснованиеГруппа",
		"Видимость",
		ВидимостьГруппы);
	
КонецПроцедуры

Процедура УстановитьДоступностьКомандыИзмененияДокумента(УправляемаяФорма) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(
		УправляемаяФорма.Элементы,
		"КнопкаИзменитьДокументЭТК",
		"Видимость",
		УправляемаяФорма.ТолькоПросмотр);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДоступныеПоляПоВидамМероприятий()
	
	ДоступныеПоля = Новый Соответствие;
	
	ИменаДоступныхПолей = ИменаДоступныхПолейВидовМероприятий();
	Для Каждого ОписаниеИменДоступныхПолей Из ИменаДоступныхПолей Цикл
		
		ИменаПолей = СтрРазделить(ОписаниеИменДоступныхПолей.Значение, ",");
		ИменаПолей.Добавить("Идентификатор");
		
		ДоступныеПоля.Вставить(ОписаниеИменДоступныхПолей.Ключ, ИменаПолей);
		
	КонецЦикла;
	
	Возврат ДоступныеПоля;
	
КонецФункции

Функция ДанныеСтрокМероприятий(КоллекцияСтрок)
	
	ДанныеСтрок = Новый Структура;
	
	ВидыМероприятий = Новый Соответствие;
	ДанныеСтрок.Вставить("ВидыМероприятий", ВидыМероприятий);
	
	ЕстьПодразделения = Ложь;
	ЕстьДатаОтмены    = Ложь;
	ЕстьФиксСтрока    = Ложь;
	
	Для каждого СтрокаКоллекции Из КоллекцияСтрок Цикл
		
		Если ЗначениеЗаполнено(СтрокаКоллекции.ВидМероприятия) Тогда
			ВидыМероприятий.Вставить(СтрокаКоллекции.ВидМероприятия, Истина);
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаКоллекции.Подразделение) Тогда
			ЕстьПодразделения = Истина;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(СтрокаКоллекции.ДатаОтмены) Тогда
			ЕстьДатаОтмены = Истина;
		КонецЕсли;
		
		Если СтрокаКоллекции.ФиксСтрока Тогда
			ЕстьФиксСтрока = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	ДанныеСтрок.Вставить("ЕстьПодразделения", ЕстьПодразделения);
	ДанныеСтрок.Вставить("ЕстьДатаОтмены", ЕстьДатаОтмены);
	ДанныеСтрок.Вставить("ЕстьФиксСтрока", ЕстьФиксСтрока);
	
	Возврат ДанныеСтрок;
	
КонецФункции

#КонецОбласти