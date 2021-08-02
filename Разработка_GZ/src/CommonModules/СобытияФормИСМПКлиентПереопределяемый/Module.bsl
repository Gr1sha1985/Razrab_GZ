#Область СобытияЭлементовФорм

// Клиентская переопределяемая процедура, вызываемая из обработчика события элемента.
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - Строка           - имя элемента-источника события "При изменении"
//   ДополнительныеПараметры - Структура        - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
// 
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - Произвольный     - элемент-источник события "Выбор".
//   ВыбраннаяСтрока         - ДанныеФормыЭлементКоллекции - выбранный элемент коллекции.
//   Поле                    - ПолеФормы - поле формы события "Выбор".
//   СтандартнаяОбработка    - Булево - установить ложь, если требуется отказываться от выполнения стандартной обработки.
//   ДополнительныеПараметры - Структура  - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры = Неопределено) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры) Экспорт

	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
// 
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - Произвольный     - элемент-источник события "ПриАктивизации".
//   ДополнительныеПараметры - Структура  - значения дополнительных параметров влияющих на обработку.
Процедура ПриАктивизацииСтроки(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийФормы

Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

Процедура ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

Процедура ПослеЗаписи(Форма, ПараметрыЗаписи) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Выполняет переопределяемую команду
//
// Параметры:
//  Форма                   - ФормаКлиентскогоПриложения - форма, в которой расположена команда
//  Команда                 - КомандаФормы     - команда формы
//  ДополнительныеПараметры - Структура        - дополнительные параметры.
//
Процедура ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСТСД

// В процедуре нужно реализовать алгоритм передачи данных в ТСД.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма документа, инициировавшая выгрузку.
Процедура ВыгрузитьДанныеВТСД(Форма) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В процедуре нужно реализовать алгоритм заполнения формы данными из ТСД.
//
// Параметры:
//  ОписаниеОповещения - ОписаниеОповещения - процедура, которую нужно вызвать после заполнения данных формы,
//  Форма - ФормаКлиентскогоПриложения - форма, данные в которой требуется заполнить,
//  РезультатВыполнения - (См. МенеджерОборудованияКлиент.ПараметрыВыполненияОперацииНаОборудовании).
Процедура ПриПолученииДанныхИзТСД(ОписаниеОповещения, Форма, РезультатВыполнения) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область Номенклатура

// Выполняется при создании номенклатуры из формы МОТП. Требуется определить и открыть форму (диалога) создания номенклатуры.
//
// Параметры:
//  Владелец     - УправляемаяФорма            - Форма владелец.
//  ДанныеСтроки - ДанныеФормыЭлементКоллекции - текущие данные строки таблицы товаров откуда производится создание.
Процедура ПриСозданииНоменклатуры(Владелец, ДанныеСтроки, СтандартнаяОбработка, ВидПродукцииИС) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("Наименование",      ДанныеСтроки.ПредставлениеНоменклатуры);
	Если ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
		ПараметрыФормы.Вставить("ТабачнаяПродукция", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь") Тогда
		ПараметрыФормы.Вставить("ОбувнаяПродукция", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды") Тогда
		ПараметрыФормы.Вставить("Велосипеды", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи") Тогда
		ПараметрыФормы.Вставить("Духи", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски") Тогда
		ПараметрыФормы.Вставить("КреслаКоляски", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность") Тогда
		ПараметрыФормы.Вставить("ЛегкаяПромышленность", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС") Тогда
		ПараметрыФормы.Вставить("МолочнаяПродукцияПодконтрольнаяВЕТИС", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияБезВЕТИС") Тогда
		ПараметрыФормы.Вставить("МолочнаяПродукцияБезВЕТИС", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты") Тогда
		ПараметрыФормы.Вставить("Фотоаппараты", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины") Тогда
		ПараметрыФормы.Вставить("Шины", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.АльтернативныйТабак") Тогда
		ПараметрыФормы.Вставить("АльтернативныйТабак", Истина);
	ИначеЕсли ВидПродукцииИС = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.УпакованнаяВода") Тогда
		ПараметрыФормы.Вставить("УпакованнаяВода", Истина);
	КонецЕсли;
		
	ОткрытьФорму("Справочник.Номенклатура.ФормаОбъекта", ПараметрыФормы, Владелец);
	
КонецПроцедуры

// Выполняется при обработке выбора. Требуется выделить и обработать событие выбора номенклатуры.
//
// Параметры:
//  ОповещениеПриЗавершении - ОписаниеОповещения - Метод формы, который обрабатывает событие выбора.
//  ВыбранноеЗначение       - ОпределяемыйТип..Номенклатура - Результат выбора.
//  ИсточникВыбора          - УправляемаяФорма - Форма, в которой произведен выбор.
Процедура ОбработкаВыбораНоменклатуры(ОповещениеПриЗавершении, ВыбранноеЗначение, ИсточникВыбора) Экспорт
	
	Если СтрНачинаетсяС(ИсточникВыбора.ИмяФормы, "Справочник.Номенклатура") Тогда
		ВыполнитьОбработкуОповещения(ОповещениеПриЗавершении, ВыбранноеЗначение);
	КонецЕсли;
	
КонецПроцедуры

// Выполняет действия при изменении номенклатуры в строке таблицы формы.
//
// Параметры:
//  Форма                  - УправляемаяФорма - форма, в которой произошло событие,
//  ТекущаяСтрока          - ДанныеФормыЭлементКоллекции - текущие данные редактируемой строки таблицы товаров,
//  КэшированныеЗначения   - Структура - сохраненные значения параметров, используемых при обработке,
//  ПараметрыУказанияСерий - ФиксированнаяСтруктура - параметры указаний серий формы
Процедура ПриИзмененииНоменклатуры(Форма, ТекущаяСтрока, КэшированныеЗначения, ПараметрыУказанияСерий = Неопределено) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "Количество")
		И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "КоличествоУпаковок") Тогда

		ТекущаяСтрока.Количество = ТекущаяСтрока.КоличествоУпаковок;
	
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "Номенклатура")
		И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "КодТНВЭД") Тогда

		Если ЗначениеЗаполнено(ТекущаяСтрока.Номенклатура) Тогда
			ТекущаяСтрока.КодТНВЭД = ИнтеграцияИСМПБПВызовСервера.КодТНВЭД(ТекущаяСтрока.Номенклатура);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму подбора номенклатуры.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, в которой вызывается команда открытия обработки подбора,
//  ОповещениеПриЗавершении - ОписаниеОповещения - процедура, вызываемая после закрытия формы подбора.
Процедура ОткрытьФормуПодбораНоменклатуры(Форма, ОповещениеПриЗавершении = Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	
	Если СтрНачинаетсяС(Форма.ИмяФормы, "Документ.МаркировкаТоваровИСМП") Тогда
		
		ПараметрыФормы.Вставить("Организация", Форма.Объект.Организация);
		ПараметрыФормы.Вставить("ПоказыватьОстатки", Истина);
		
		ВидыПродукции = Новый Массив;
		ВидыПродукции.Добавить(Форма.Объект.ВидПродукции);
		
		ПараметрыОтбора = ПараметрыОтбора(ВидыПродукции);
		
		ПараметрыФормы.Вставить("ДопустимыеВидыПродукции", ПараметрыОтбора);
	КонецЕсли; 
	
	
	ОткрытьФорму("Обработка.ПодборНоменклатуры.Форма", 
		ПараметрыФормы, 
		Форма, , , ,
		ОповещениеПриЗавершении, 
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

// Обрабатывает результат выбора в форму документа ИСМП (например из формы подбора номенклатуры,
//   при использовании множественного выбора вместо закрытия формы подбора с общим результатом).
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, в которой вызывается команда открытия обработки сопоставления,
//  ВыбранноеЗначение - Произвольный - результат выбора.
//  ИсточникВыбора    - ФормаКлиентскогоПриложения - форма, в которой произведен выбор.
Процедура ОбработкаВыбора(Форма, ВыбранноеЗначение, ИсточникВыбора) Экспорт
	
	Возврат;
	
КонецПроцедуры

#Область ПараметрыВыбора

// Устанавливает параметры выбора контрагента.
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, в которой нужно установить параметры выбора.
//   ТолькоЮрЛицаНерезиденты - Неопределено, Булево - Признак нерезидента.
//   ИмяПоляВвода            - Строка               - имя поля ввода номенклатуры.
Процедура УстановитьПараметрыВыбораКонтрагента(Форма, ТолькоЮрЛицаНерезиденты = Неопределено, ИмяПоляВвода = "Контрагент") Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Устанавливает параметры выбора номенклатуры.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, в которой нужно установить параметры выбора,
//  ИмяПоляВвода - Строка - имя поля ввода номенклатуры.
Процедура УстановитьПараметрыВыбораНоменклатуры(Форма, ВидПродукцииИС = Неопределено, ИмяПоляВвода = "ТоварыНоменклатура") Экспорт
	
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

// Выполняется при начале выбора номенклатуры. Требуется определить и открыть форму выбора.
//
// Параметры:
//  Владелец     - УправляемаяФорма            - Форма владелец.
//  ДанныеСтроки - ДанныеФормыЭлементКоллекции - текущие данные строки таблицы товаров откуда производится выбор.
//  СтандартнаяОбработка - Булево - Выключается в переопределении
//  ВидПродукцииИС - Перечисления.ВидыПродукцийИСМП - Вид продукции
//  Описание - ОписаниеОповещения - Вызывается при выборе значения в форме выбора.
//
Процедура ПриНачалеВыбораНоменклатуры(Владелец, ДанныеСтроки, СтандартнаяОбработка, ВидПродукцииИС, Описание=Неопределено) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ВыборГруппИЭлементов", ИспользованиеГруппИЭлементов.Элементы);
	
	ПараметрыОтбора = ПараметрыОтбора(ВидПродукцииИС);
		
	СтандартнаяОбработка = Ложь;
	
	Если ПараметрыОтбора.Количество() = 1 Тогда
		ПараметрыФормы.Вставить("Отбор", Новый Структура(ПараметрыОтбора[0], Истина));
	ИначеЕсли ПараметрыОтбора.Количество() > 1 Тогда
		ПараметрыФормы.Вставить("ДопустимыеВидыПродукции", ПараметрыОтбора);
	КонецЕсли;
	
	ОткрытьФорму("Справочник.Номенклатура.ФормаВыбора", ПараметрыФормы, Владелец,,,,Описание);
	
КонецПроцедуры

#КонецОбласти

#Область ХарактеристикиНоменклатуры

// Выполняется при начале выбора характеристики. Требуется определить и открыть форму выбора.
//
// Параметры:
//  Владелец     - ФормаКлиентскогоПриложения            - форма, в которой вызывается команда выбора характеристики.
//  ДанныеСтроки - ДанныеФормыЭлементКоллекции - текущие данные строки таблицы товаров откуда производится выбор.
//  СтандартнаяОбработка - Булево - Выключается в переопределении
//  Описание - ОписаниеОповещения - Вызывается при выборе значения в форме выбора.
//
Процедура ПриНачалеВыбораХарактеристики(
	Владелец, ДанныеСтроки, СтандартнаяОбработка, ИмяКолонкиНоменклатура="Номенклатура", Описание=Неопределено) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Выполняется при создании характеристики из формы МОТП. Требуется пепеопределить и открыть форму (диалога)
// создания характеристики при необходимости.
//
// Параметры:
//  Владелец             - ФормаКлиентскогоПриложения            - Форма владелец.
//  ДанныеСтроки         - ДанныеФормыЭлементКоллекции - текущие данные строки таблицы товаров откуда производится создание.
//  Элемент              - ПолеВвода                   - элемент в котором создается характеристика.
//  СтандартнаяОбработка - Булево                      - Признак стандартной обработки.
Процедура ПриСозданииХарактеристики(Владелец, ДанныеСтроки, Элемент, СтандартнаяОбработка) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Выполняется при обработке выбора. Требуется выделить и обработать событие выбора характеристики.
//
// Параметры:
//  ОповещениеПриЗавершении - ОписаниеОповещения - Метод формы, который обрабатывает событие выбора.
//  ВыбранноеЗначение       - ОпределяемыйТип.ХарактеристикаНоменклатуры - результат выбора.
//  ИсточникВыбора          - ФормаКлиентскогоПриложения - Форма, в которой произведен выбор.
Процедура ОбработкаВыбораХарактеристики(ОповещениеПриЗавершении, ВыбранноеЗначение, ИсточникВыбора) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Выполняет действия при изменении характеристики номенклатуры в строке таблицы формы.
//
// Параметры:
//  Форма                - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока        - ДанныеФормыЭлементКоллекции - текущие данные редактируемой строки таблицы товаров,
//  КэшированныеЗначения - Структура - сохраненные значения параметров, используемых при обработке,
Процедура ПриИзмененииХарактеристики(Форма, ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область СерииНоменклатуры

// Выполняет действия при изменении серии номенклатуры в строке таблицы формы.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока - ДанныеФормыЭлементКоллекции - строка таблицы товаров,
//  КэшированныеЗначения - Структура - сохраненные значения параметров, используемых при обработке,
//  ПараметрыУказанияСерий - ФиксированнаяСтруктура - параметры указаний серий формы
Процедура ПриИзмененииСерии(Форма, ТекущаяСтрока, КэшированныеЗначения, ПараметрыУказанияСерий) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Выполняется при обработке выбора. Требуется выделить и обработать событие выбора серии.
// 
// Параметры:
//  Форма                  - ФормаКлиентскогоПриложения - Форма для которой требуется обработать событие выбора.
//  ВыбранноеЗначение      - ОпределяемыйТип.СерияНоменклатуры - результат выбора.
//  ИсточникВыбора         - ФормаКлиентскогоПриложения - Форма, в которой произведен выбор.
//  ПараметрыУказанияСерий - (См. ПроверкаИПодборПродукцииМОТП.ПараметрыУказанияСерий).
Процедура ОбработкаВыбораСерии(Форма, ВыбранноеЗначение, ИсточникВыбора, ПараметрыУказанияСерий) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#Область Количество

// Выполняет действия при изменении подобранного количества в строке таблицы формы.
//
// Параметры:
//  Форма - УправляемаяФорма - форма, в которой произошло событие,
//  ТекущаяСтрока - ДанныеФормыЭлементКоллекции - строка таблицы товаров,
//  КэшированныеЗначения - Структура - сохраненные значения параметров, используемых при обработке,
//  ПараметрыУказанияСерий - ФиксированнаяСтруктура - параметры указаний серий формы
Процедура ПриИзмененииКоличества(Форма, ТекущаяСтрока, КэшированныеЗначения, ПараметрыУказанияСерий = Неопределено) Экспорт
	

	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "Количество")
		И ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ТекущаяСтрока, "КоличествоУпаковок") Тогда

		ТекущаяСтрока.Количество = ТекущаяСтрока.КоличествоУпаковок;
	
	КонецЕсли;
	
	
КонецПроцедуры

#КонецОбласти

#Область СуммаИНДС

// Выполняет действия при изменении ставки НДС в строке таблицы формы.
//
// Параметры:
//  Форма                  - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока          - ДанныеФормыЭлементКоллекции - текущие данные редактируемой строки таблицы товаров,
//  КэшированныеЗначения   - Структура - сохраненные значения параметров, используемых при обработке,
Процедура ПриИзмененииСтавкиНДС(Форма, ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Выполняет действия при изменении суммы в строке таблицы формы.
//
// Параметры:
//  Форма                  - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока          - ДанныеФормыЭлементКоллекции - текущие данные редактируемой строки таблицы товаров,
//  КэшированныеЗначения   - Структура - сохраненные значения параметров, используемых при обработке,
Процедура ПриИзмененииСуммы(Форма, ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Выполняет действия при изменении суммы НДС в строке таблицы формы.
//
// Параметры:
//  Форма                  - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока          - ДанныеФормыЭлементКоллекции - текущие данные редактируемой строки таблицы товаров,
//  КэшированныеЗначения   - Структура - сохраненные значения параметров, используемых при обработке,
Процедура ПриИзмененииСуммыНДС(Форма, ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

// Выполняет действия при изменении подобранного количества в строке таблицы формы.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, в которой произошло событие,
//  ТекущаяСтрока - ДанныеФормыЭлементКоллекции - строка таблицы товаров,
//  КэшированныеЗначения - Структура - сохраненные значения параметров, используемых при обработке,
//  ПараметрыУказанияСерий - ФиксированнаяСтруктура - параметры указаний серий формы
Процедура ПриИзмененииЦены(Форма, ТекущаяСтрока, КэшированныеЗначения) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

Процедура ПриНачалеВыбораКодТНВЭД(Владелец, ДанныеСтроки, СтандартнаяОбработка, Описание = Неопределено) Экспорт
	
	Если ДанныеСтроки <> Неопределено Тогда
		
		ПараметрыФормы = Новый Структура;
		
		ТНВЭД = ИнтеграцияИСМПВызовСервера.КлассификаторТНВЭДПоКоду(ДанныеСтроки.КодТНВЭД);
		Если ЗначениеЗаполнено(ТНВЭД) Тогда
			ПараметрыФормы.Вставить("ТекущаяСтрока", ТНВЭД);
		КонецЕсли;
		
		ОткрытьФорму("Справочник.КлассификаторТНВЭД.ФормаВыбора", ПараметрыФормы, Владелец,,,, Описание);
		
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму создания нового контрагента.
//
// Параметры:
//  ФормаВладелец - ФормаУправляемогоПриложения - форма-владелец.
//  Реквизиты     - Структура        - (См. ИнтеграцияИСМПКлиентСервер.РеквизитыСозданияКонтрагента)
//
Процедура ОткрытьФормуСозданияКонтрагента(ФормаВладелец, Реквизиты) Экспорт
	
	Основание = Новый Структура;
	Основание.Вставить("ИНН",                     Реквизиты.ИНН);
	Основание.Вставить("КПП",                     Реквизиты.КПП);
	Основание.Вставить("Наименование",            Реквизиты.Наименование);
	Основание.Вставить("НаименованиеПолное",      Реквизиты.НаименованиеПолное);
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("РежимВыбора",     Истина);
	ПараметрыФормы.Вставить("Основание",       Основание);
	ПараметрыФормы.Вставить("ТекстЗаполнения", Реквизиты.ИНН);
	
	ОткрытьФорму("Справочник.Контрагенты.ФормаОбъекта", ПараметрыФормы, ФормаВладелец);
	
КонецПроцедуры

#Область GTIN

Процедура ПриНачалеВыбораGTIN(Элемент, ТекущиеДанные, СтандартнаяОбработка) Экспорт
	
	МассивGTIN = ИнтеграцияГИСМВызовСервераБП.МассивGTINМаркированногоТовара(ТекущиеДанные.Номенклатура);
	Элемент.СписокВыбора.ЗагрузитьЗначения(МассивGTIN);
	
КонецПроцедуры

#КонецОбласти
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПараметрыОтбора(ВидПродукцииИС)

	ПараметрыОтбора = Новый Массив;
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("ТабачнаяПродукция");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Обувь")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("ОбувнаяПродукция");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Велосипеды")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("Велосипеды");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Духи")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("Духи");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.КреслаКоляски")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("КреслаКоляски");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("ЛегкаяПромышленность");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("МолочнаяПродукцияПодконтрольнаяВЕТИС");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.МолочнаяПродукцияБезВЕТИС")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("МолочнаяПродукцияБезВЕТИС");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Фотоаппараты")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("Фотоаппараты");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Шины")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("Шины");
	КонецЕсли;
	
	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.АльтернативныйТабак")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("АльтернативныйТабак");
	КонецЕсли;

	Если ВидПродукцииИС.Найти(ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.УпакованнаяВода")) <> Неопределено Тогда
		ПараметрыОтбора.Добавить("УпакованнаяВода");
	КонецЕсли;
	
	Возврат ПараметрыОтбора;
КонецФункции 

#КонецОбласти 
