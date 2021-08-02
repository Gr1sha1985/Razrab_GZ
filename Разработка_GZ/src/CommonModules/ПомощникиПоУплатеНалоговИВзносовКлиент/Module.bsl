#Область ПрограммныйИнтерфейс

// Конструктор структуры параметров обработки навигационной ссылки платежных документов.
//
// Параметры:
//  КоллекцияПлатежей	 - Таблица - Таблица, которая содержит описание списка платежей.
//  ПрефиксИмени		 - Строка - Префикс имён элементов формы, в которые будет выведен список платежей.
//  ОповещениеУдаления	 - ОписаниеОповещения - Описание оповещения, которое будет вызывано, если пользователь 
//                                              нажал на крестик - удаление документа.
// 
// Возвращаемое значение:
//   - Структура - структура параметров, которую нужно передать в ОбработкаНавигационнойСсылкиПлатежногоДокумента()
//
Функция ПараметрыОбработкиПлатежныхДокументов(КоллекцияПлатежей, ПрефиксИмени, ОповещениеУдаления) Экспорт
	
	ПараметрыОбработкиПлатежныхДокументов = Новый Структура();
	ПараметрыОбработкиПлатежныхДокументов.Вставить("КоллекцияДокументов", КоллекцияПлатежей);
	ПараметрыОбработкиПлатежныхДокументов.Вставить("ПрефиксИмени", ПрефиксИмени);
	ПараметрыОбработкиПлатежныхДокументов.Вставить("ОповещениеУдаления", ОповещениеУдаления);
	
	Возврат ПараметрыОбработкиПлатежныхДокументов;
	
КонецФункции

// Конструктор структуры параметров обработки навигационной ссылки документов
//
// Параметры:
//  Коллекция - ДанныеФормыКоллекция - коллекция, которая содержит описание списка документов
//  ПрефиксИмени - Строка - префикс имен элементов формы, в которые будет выведен список документов
//  ОповещениеУдаления - ОписаниеОповещения - описание оповещения, которое будет вызывано, если пользователь 
//                       удаляет документ
//
// Возвращаемое значение:
//   - Структура - структура параметров, которую нужно передать в ОбработкаНавигационнойСсылкиДокумента
//
Функция ПараметрыОбработкиСпискаДокументов(КоллекцияДокументов, ПрефиксИмени, ОповещениеУдаления) Экспорт
	
	ПараметрыОбработки = Новый Структура();
	ПараметрыОбработки.Вставить("КоллекцияДокументов", КоллекцияДокументов);
	ПараметрыОбработки.Вставить("ПрефиксИмени", ПрефиксИмени);
	ПараметрыОбработки.Вставить("ОповещениеУдаления", ОповещениеУдаления);
	
	Возврат ПараметрыОбработки;
	
КонецФункции

// Обрабатывает действие навигационной строки из описания документа оплаты.
//
// Параметры:
//  Элемент									 - ЭлементФормы - Элемент, который содержит описание документа оплаты.
//  НавигационнаяСсылка						 - Строка - Навигационная ссылка, содержащее действие, которое выбрал пользователь.
//  ПараметрыОбработкиПлатежныхДокументов	 - Структура - Параметры обработки, см. ПараметрыОбработкиПлатежныхДокументов()
//
Процедура ОбработкаНавигационнойСсылкиПлатежногоДокумента(Элемент, НавигационнаяСсылка, ПараметрыОбработкиПлатежныхДокументов) Экспорт
	
	Если НавигационнаяСсылка = "ОткрытьДокумент" Тогда
		
		ОткрытьДокументИзКоллекции(Элемент.Имя, ПараметрыОбработкиПлатежныхДокументов.КоллекцияДокументов,
			ПараметрыОбработкиПлатежныхДокументов.ПрефиксИмени);
		
	ИначеЕсли НавигационнаяСсылка = "УдалитьДокумент" Тогда
		
		УдалитьДокументИзКоллекции(Элемент.Имя, ПараметрыОбработкиПлатежныхДокументов.КоллекцияДокументов,
			ПараметрыОбработкиПлатежныхДокументов.ПрефиксИмени, ПараметрыОбработкиПлатежныхДокументов.ОповещениеУдаления);
		
	КонецЕсли;
	
КонецПроцедуры

// Обрабатывает нажатие гиперссылки уведомления
//
// Параметры:
//  Элемент - ЭлементФормы - элемент, который содержит описание уведомления
//  НавигационнаяСсылка - Строка - навигационная ссылка, содержащая выбранное пользователем действие
//  ПараметрыОбработкиУведомлений - Структура - см. ПараметрыОбработкиУведомлений
//
Процедура ОбработкаНавигационнойСсылкиДокумента(Элемент, НавигационнаяСсылка, ПараметрыОбработкиУведомлений) Экспорт
	
	Если НавигационнаяСсылка = "ОткрытьДокумент" Тогда
		
		ОткрытьДокументИзКоллекции(Элемент.Имя, ПараметрыОбработкиУведомлений.КоллекцияДокументов,
			ПараметрыОбработкиУведомлений.ПрефиксИмени);
		
	ИначеЕсли НавигационнаяСсылка = "УдалитьДокумент" Тогда
		
		УдалитьДокументИзКоллекции(Элемент.Имя, ПараметрыОбработкиУведомлений.КоллекцияДокументов,
			ПараметрыОбработкиУведомлений.ПрефиксИмени, ПараметрыОбработкиУведомлений.ОповещениеУдаления);
		
	КонецЕсли;
	
КонецПроцедуры

// Открывает форму нового документа "СписаниеСРасчетногоСчета".
//
// Параметры:
//  Организация - СправочникСсылка.Организации
//  Период - дата внутри периода Помощника
//  ВидыНалогов - Массив - отбор по виду налога
//  ВидНалоговогоОбязательства - ПеречислениеСсылка.ВидыПлатежейВГосБюджет
//  БанковскийСчет - СправочникСсылка.БанковскиеСчета - если не указан, то используется Основной банковский счет
//
Процедура СоздатьОплатуЧерезБанк(Организация, Период, ВидыНалогов, ВидНалоговогоОбязательства, БанковскийСчет = Неопределено) Экспорт
	
	// Проверяем и включаем ФО ИспользоватьНесколькоБанковскихСчетовОрганизации.
	БанковскиеСчетаВызовСервера.ПроверитьИспользованиеНесколькоБанковскихСчетов(Организация);
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ВидОперации", ПредопределенноеЗначение("Перечисление.ВидыОперацийСписаниеДенежныхСредств.ПеречислениеНалога"));
	ЗначенияЗаполнения.Вставить("Организация", Организация);
	Если БанковскийСчет <> Неопределено Тогда
		ЗначенияЗаполнения.Вставить("БанковскийСчет", БанковскийСчет);
	КонецЕсли;
	Если ВидыНалогов.Количество() <> 0 Тогда
		ЗначенияЗаполнения.Вставить("Налог", РасчетыСБюджетомВызовСервера.НалогПоВиду(ВидыНалогов[0]));
	КонецЕсли;
	ЗначенияЗаполнения.Вставить("ВидНалоговогоОбязательства", ВидНалоговогоОбязательства);
	ЗначенияЗаполнения.Вставить("НалоговыйПериод", НачалоКвартала(Период));
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ПараметрыФормы.Вставить("ПериодПомощника", Период);
	ПараметрыФормы.Вставить("ВидыНалогов", ВидыНалогов);
	
	ОткрытьФорму("Документ.СписаниеСРасчетногоСчета.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры

// Открывает форму нового документа "РасходныйКассовыйОрдер".
//
// Параметры:
//  Организация - СправочникСсылка.Организации
//  Период - дата внутри периода Помощника
//  ВидыНалогов - Массив - отбор по виду налога
//  ВидНалоговогоОбязательства - ПеречислениеСсылка.ВидыПлатежейВГосБюджет
//
Процедура СоздатьОплатуНаличными(Организация, Период, ВидыНалогов, ВидНалоговогоОбязательства) Экспорт
	
	ЗначенияЗаполнения = Новый Структура;
	ЗначенияЗаполнения.Вставить("ВидОперации", ПредопределенноеЗначение("Перечисление.ВидыОперацийРКО.УплатаНалога"));
	ЗначенияЗаполнения.Вставить("Организация", Организация);
	Если ВидыНалогов.Количество() <> 0 Тогда
		ЗначенияЗаполнения.Вставить("Налог", РасчетыСБюджетомВызовСервера.НалогПоВиду(ВидыНалогов[0]));
	КонецЕсли;
	ЗначенияЗаполнения.Вставить("ВидНалоговогоОбязательства", ВидНалоговогоОбязательства);
	ЗначенияЗаполнения.Вставить("НалоговыйПериод", НачалоКвартала(Период));
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ПараметрыФормы.Вставить("ПериодПомощника", Период);
	ПараметрыФормы.Вставить("ВидыНалогов", ВидыНалогов);
	
	ОткрытьФорму("Документ.РасходныйКассовыйОрдер.ФормаОбъекта", ПараметрыФормы);
	
КонецПроцедуры
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ИндексЭлемента(ИмяЭлемента, ПрефиксИмени)
	
	НачалоПрефиксаИмени = СтрНайти(ИмяЭлемента, ПрефиксИмени);
	Если НачалоПрефиксаИмени = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ИндексСтрокой = Сред(ИмяЭлемента, НачалоПрефиксаИмени + СтрДлина(ПрефиксИмени));
	
	Если ПустаяСтрока(ИндексСтрокой) Или Не СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(ИндексСтрокой) Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Число(ИндексСтрокой);
	
КонецФункции

Процедура УдалитьДокументИзКоллекции(ИмяЭлемента, КоллекцияДокументов, ПрефиксИмени, ОповещениеУдаленияДокумента)
	
	Индекс = ИндексЭлемента(ИмяЭлемента, ПрефиксИмени);
	Если Индекс = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Индекс < КоллекцияДокументов.Количество() Тогда
		
		СтрокаКоллекции = КоллекцияДокументов[Индекс];
		
		ТекстВопроса = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Удалить %1?'"), СтрокаКоллекции.ПредставлениеДокумента);
		
		ДополнительныеПараметры = Новый Структура();
		ДополнительныеПараметры.Вставить("ДокументДляУдаления", СтрокаКоллекции.Ссылка);
		ДополнительныеПараметры.Вставить("ОповещениеУдаленияДокумента", ОповещениеУдаленияДокумента);
		ОписаниеОповещения = Новый ОписаниеОповещения("УдалитьДокументИзКоллекцииЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет, , КодВозвратаДиалога.Нет);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОткрытьДокументИзКоллекции(ИмяЭлемента, КоллекцияДокументов, ПрефиксИмени)
	
	Индекс = ИндексЭлемента(ИмяЭлемента, ПрефиксИмени);
	Если Индекс = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Индекс < КоллекцияДокументов.Количество() Тогда
		
		ДокументДляОткрытия = КоллекцияДокументов[Индекс].Ссылка;
		
		Если ТипЗнч(ДокументДляОткрытия) = Тип("ДокументСсылка.ПлатежноеПоручение") Тогда
			ПараметрыФормы = Новый Структура();
			ПараметрыФормы.Вставить("Ключ", ДокументДляОткрытия);
			ОткрытьФорму("Документ.ПлатежноеПоручение.Форма.ФормаДокументаНалоговая", ПараметрыФормы, ЭтотОбъект);
		Иначе
			ПоказатьЗначение(, ДокументДляОткрытия);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура УдалитьДокументИзКоллекцииЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ОповещениеУдаленияДокумента,
			ДополнительныеПараметры.ДокументДляУдаления);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти