
#Область СлужебныйПрограммныйИнтерфейс

// В процедуре нужно реализовать очистку кэшированных штрихкодов для исключения повторной обработки.
//
// Параметры:
//  ДанныеШтрихкодов - Массив - полученные штрихкоды,
//  КэшированныеЗначения - Структура - используется механизмом обработки изменения реквизитов ТЧ.
//
Процедура ОчиститьКэшированныеШтрихкоды(ДанныеШтрихкодов, КэшированныеЗначения) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Вызывается после обработки штрихкодов. В процедуре нужно проанализировать полученные штрихкоды на предмет сканирования акцизной марки, а также
// обработать штрихкоды, не привязанные к номенклатуре.
//
// Параметры:
//  Форма - УправляемаяФорма - форма документа, в которой были обработаны штрихкоды,
//  ОбработанныеДанные - Структура - подготовленные ранее данные штрихкодов,
//  КэшированныеЗначения - Структура - используется механизмом обработки изменения реквизитов ТЧ.
//
Процедура ПослеОбработкиШтрихкодов(Форма, ОбработанныеДанные, КэшированныеЗначения) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В функции нужно реализовать подготовку данных для дальнейшей обработки штрихкодов, полученных из ТСД.
//
// Параметры:
//   Форма - УправляемаяФорма - форма документа, в которой происходит обработка,
//   ТаблицаТоваров - Массив - полученные данные из ТСД,
//   КэшированныеЗначения - Структура - используется механизмом обработки изменения реквизитов ТЧ,
//   ПараметрыЗаполнения - Структура - параметры заполнения (см. ИнтеграцияЕГАИСКлиентСервер.ПараметрыЗаполненияТабличнойЧасти()).
//   СтруктураДействий - Структура - подготовленные данные.
//
Процедура ПодготовитьДанныеДляОбработкиТаблицыТоваровПолученнойИзТСД(
	Форма, ТаблицаТоваров, КэшированныеЗначения, ПараметрыЗаполнения, СтруктураДействий) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Вызывается после загрузки данных из ТСД. В процедуре нужно проанализировать полученные штрихкоды на предмет сканирования акцизной марки, а также
// обработать штрихкоды, не привязанные к номенклатуре.
//
// Параметры:
//  Форма - УправляемаяФорма - форма документа, в которой были обработаны штрихкоды,
//  ОбработанныеДанные - Структура - подготовленные ранее данные штрихкодов,
//  КэшированныеЗначения - Структура - используется механизмом обработки изменения реквизитов ТЧ.
//
Процедура ПослеОбработкиТаблицыТоваровПолученнойИзТСД(Форма, ОбработанныеДанные, КэшированныеЗначения) Экспорт
	
	Возврат;
	
КонецПроцедуры

// В процедуре нужно открыть форму регистрации новых штрихкодов номенклатуры.
//
// Параметры:
//  Форма - УправляемаяФорма - форма, откуда производится вызов процедуры,
//  ДанныеШтрихкодов - Массив - элемент массива - структура с ключами:
//   * Штрихкод - Строка - штрихкод номенклатуры,
//   * Количество - Число - количество алкогольной продукции.
//
Процедура ОткрытьФормуРегистрацииШтрихкодовНоменклатуры(Форма, ДанныеШтрихкодов) Экспорт
	
	Параметры = Новый Структура;
	
	Параметры.Вставить("Отбор", Новый Структура("Штрихкод", ДанныеШтрихкодов[0].Штрихкод));
	
	ОткрытьФорму("РегистрСведений.ШтрихкодыНоменклатуры.Форма.ФормаСписка", Параметры);
	
КонецПроцедуры

// В процедуре реализуется открытие формы считывания акцизной марки в случае необходимости.
//
//Параметры:
//  Форма -  УправляемаяФорма - форма документа, в которой были обработаны штрихкоды,
//  СтруктураДействий - Структура - подготовленные ранее данные штрихкодов.
//
Процедура ОткрытьФормуСчитыванияАкцизнойМаркиПриНеобходимости(Форма, СтруктураДействий) Экспорт
	
	Если НужноОткрытьФормуУказанияАкцизныхМарокПослеОбработкиШтрихкодов(СтруктураДействий) Тогда
		
		ПараметрыСканирования = ШтрихкодированиеИСКлиент.ПараметрыСканирования(Форма,,ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Алкогольная"));
		ПараметрыСканирования.ИдентификаторСтроки = СтруктураДействий.МассивСтрокСАкцизнымиМарками[0];
		
		ПараметрыСканирования.Вставить("Форма", Форма);
		
		СчитываниеАкцизнойМарки = Новый ОписаниеОповещения(
			"ОткрытьФормуСчитыванияАкцизнойМарки",
			ШтрихкодированиеНоменклатурыЕГАИСКлиентПереопределяемый,
			ПараметрыСканирования);
		
	Иначе
		СчитываниеАкцизнойМарки = Неопределено;
	КонецЕсли;
	
	Если СчитываниеАкцизнойМарки <> Неопределено Тогда
		ВыполнитьОбработкуОповещения(СчитываниеАкцизнойМарки);
	КонецЕсли;
	
	Если СтруктураДействий.ТекущаяСтрока <> Неопределено Тогда
		Форма.Элементы.Товары.ТекущаяСтрока = СтруктураДействий.ТекущаяСтрока;
	КонецЕсли;

	
КонецПроцедуры

// Определяет необходимость открытия формы указания акцизных марок после обработки штрихкодов.
// Форму нужно открывать, если был отсканирован один штрихкод маркируемой алкогольной продукции.
//
// Параметры:
//  ПараметрыОбработкиШтрихкодов - Структура - см. ШтрихкодированиеНоменклатурыКлиент.ПараметрыОбработкиШтрихкодов().
//
// Возвращаемое значение:
//  Булево - Истина, если нужно открыть форму.
//
Функция НужноОткрытьФормуУказанияАкцизныхМарокПослеОбработкиШтрихкодов(ПараметрыОбработкиШтрихкодов) Экспорт
	
	ОдинШтрихкод = Ложь;
	
	Если ТипЗнч(ПараметрыОбработкиШтрихкодов.Штрихкоды) = Тип("Массив") Тогда
		ОдинШтрихкод = ПараметрыОбработкиШтрихкодов.Штрихкоды.Количество() = 1;
	Иначе
		ОдинШтрихкод = Истина;
	КонецЕсли;
	
	Если ОдинШтрихкод
		И ПараметрыОбработкиШтрихкодов.МассивСтрокСАкцизнымиМарками.Количество() = 1 Тогда
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

// Процедура - Открыть форму считывания акцизной марки
//
// Параметры:
//  Результат - Булево - Не используется
//  ДополнительныеПараметры - Структура - Параметры открытия формы считывания марки: (Форма, ИдентификаторСтроки, Редактирование, АдресВоВременномХранилище)
//
Процедура ОткрытьФормуСчитыванияАкцизнойМарки(Результат, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ДополнительныеПараметры.Форма, "Объект") Тогда
		Источник = ДополнительныеПараметры.Форма.Объект;
	Иначе
		Источник = ДополнительныеПараметры.Форма;
	КонецЕсли;
	
	ТекущиеДанные = Источник.Товары.НайтиПоИдентификатору(ДополнительныеПараметры.ИдентификаторСтроки);
	
	ПараметрыОткрытияФормы = Новый Структура;
	ПараметрыОткрытияФормы.Вставить("Номенклатура"  , ТекущиеДанные.Номенклатура);
	ПараметрыОткрытияФормы.Вставить("Характеристика", Неопределено);
	
	ОткрытьФорму(
		"Обработка.РаботаСАкцизнымиМаркамиЕГАИС.Форма.ФормаВводаАкцизнойМарки",
		ПараметрыОткрытияФормы,
		ДополнительныеПараметры.Форма,,,,
		Новый ОписаниеОповещения("ПоискПоШтрихкодуЗавершение", ДополнительныеПараметры.Форма, ДополнительныеПараметры));
	
КонецПроцедуры



#КонецОбласти
