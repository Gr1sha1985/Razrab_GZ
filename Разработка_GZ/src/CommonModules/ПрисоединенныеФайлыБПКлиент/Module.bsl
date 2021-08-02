
#Область ПрограммныйИнтерфейс

// Функция определяет содержат ли параметры перетаскивания файлы.
//
// Параметры:
// ПараметрыПеретаскивания - ПараметрыПеретаскивания.
//
// Возвращаемое значение:
// Булево - Истина - переданные параметры содержат файлы.
//
Функция ПараметрыПеретаскиванияСодержатФайлы(ПараметрыПеретаскивания) Экспорт
	
	ПараметрыПеретаскиванияСодержатФайлы = Ложь;
	
	Если ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Файл") И ПараметрыПеретаскивания.Значение.ЭтоФайл() Тогда
		
		ПараметрыПеретаскиванияСодержатФайлы = Истина;
		
	ИначеЕсли ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Массив") Тогда
		
		Если ПараметрыПеретаскивания.Значение.Количество() > 0 Тогда
			
			ПараметрыПеретаскиванияСодержатФайлы = Истина;
			
			Для Каждого ЭлементДанных Из ПараметрыПеретаскивания.Значение Цикл
				Если ТипЗнч(ЭлементДанных) <> Тип("Файл") Тогда
					ПараметрыПеретаскиванияСодержатФайлы = Ложь;
					Прервать;
				КонецЕсли;
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ПараметрыПеретаскиванияСодержатФайлы;
	
КонецФункции

// Добавляет файлы перетаскиванием в список присоединенных файлов.
//
// Параметры:
//  ПараметрыПеретаскивания - ПараметрыПеретаскивания.
//  Ссылка                  - Ссылка - владелец файла.
//  ИдентификаторФормы      - УникальныйИдентификатор формы.
//
Процедура ДобавитьФайлыПеретаскиванием(ПараметрыПеретаскивания, Ссылка, УникальныйИдентификатор) Экспорт
	
	МассивИменФайлов = Новый Массив;
	
	Если ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Файл") Тогда
		
		МассивИменФайлов.Добавить(ПараметрыПеретаскивания.Значение.ПолноеИмя);
		
	ИначеЕсли ТипЗнч(ПараметрыПеретаскивания.Значение) = Тип("Массив") Тогда
		
		Для Каждого Значение Из ПараметрыПеретаскивания.Значение Цикл
			МассивИменФайлов.Добавить(Значение.ПолноеИмя);
		КонецЦикла;
		
	КонецЕсли;
	
	// ИнтеграцияС1СДокументооборотом
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ИнтеграцияС1СДокументооборотом") Тогда
		МодульИнтеграцияС1СДокументооборотКлиентПовтИсп =
			ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияС1СДокументооборотКлиентПовтИсп");
		Если МодульИнтеграцияС1СДокументооборотКлиентПовтИсп.ИспользоватьПрисоединенныеФайлы1СДокументооборота() Тогда
			МодульИнтеграцияС1СДокументооборотКлиент =
				ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияС1СДокументооборотКлиент");
			ОписаниеОповещения = Новый ОписаниеОповещения("ПроверитьПодключениеЗавершение",
				ЭтотОбъект,
				Новый Структура("ПараметрыПеретаскивания, Ссылка, УникальныйИдентификатор, МассивИменФайлов",
					ПараметрыПеретаскивания, Ссылка, УникальныйИдентификатор, МассивИменФайлов));
			МодульИнтеграцияС1СДокументооборотКлиент.ПроверитьПодключение(ОписаниеОповещения,,,Истина);
			Возврат;
		КонецЕсли;
	КонецЕсли;
	// Конец ИнтеграцияС1СДокументооборотом
	
	Если МассивИменФайлов.Количество() > 0 Тогда
		РаботаСФайламиСлужебныйКлиент.ДобавитьФайлыПеретаскиванием(
			Ссылка, УникальныйИдентификатор, МассивИменФайлов);
	КонецЕсли;
	
	ОповеститьОбИзменении(Ссылка);
	
КонецПроцедуры

#Область СлужебныйПрограммныйИнтерфейс

Процедура ОбновитьСписокПослеДобавленияФайла(ЭтотОбъект, Знач ИмяСобытия, Знач Параметр, Источник) Экспорт
	
	Если ИмяСобытия = "Запись_Файл" Тогда
		
		ЭтотОбъект.Элементы.Список.Обновить();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПеретаскиваниеФайловОтветПолучен(ОтветПользователя, ДополнительныеПараметры) Экспорт
	
	Если ОтветПользователя = КодВозвратаДиалога.Да Тогда
		ПрисоединенныеФайлыБПКлиент.ДобавитьФайлыПеретаскиванием(
			ДополнительныеПараметры.ПараметрыПеретаскивания,
			ДополнительныеПараметры.Ссылка,
			ДополнительныеПараметры.УникальныйИдентификатор);
	КонецЕсли;
	
КонецПроцедуры

// ИнтеграцияС1СДокументооборотом
Процедура ПроверитьПодключениеЗавершение(Результат, Параметры) Экспорт
	
	МодульИнтеграцияС1СДокументооборотВызовСервера =
		ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияС1СДокументооборотВызовСервера");
	Если Результат И МодульИнтеграцияС1СДокументооборотВызовСервера.
			ИспользоватьПрисоединенныеФайлы1СДокументооборотаДляОбъекта(Параметры.Ссылка) Тогда
		
		МассивФайлов = Новый Массив;
		Если ТипЗнч(Параметры.ПараметрыПеретаскивания.Значение) = Тип("Файл") Тогда
			МассивФайлов.Добавить(Параметры.ПараметрыПеретаскивания.Значение);
		ИначеЕсли ТипЗнч(Параметры.ПараметрыПеретаскивания.Значение) = Тип("Массив") Тогда
			Для Каждого Значение Из Параметры.ПараметрыПеретаскивания.Значение Цикл
				МассивФайлов.Добавить(Значение);
			КонецЦикла;
		КонецЕсли;
		
		МодульИнтеграцияС1СДокументооборотКлиент =
			ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияС1СДокументооборотКлиент");
		ОписаниеОповещения = Новый ОписаниеОповещения("ФайлыПеретаскиваниеЗавершение",
			ПрисоединенныеФайлыБПКлиент,
			Новый Структура("МассивФайлов, УникальныйИдентификатор, Владелец",
				МассивФайлов,
				Параметры.УникальныйИдентификатор,
				Параметры.Ссылка));
		МодульИнтеграцияС1СДокументооборотКлиент.НачатьПоискСвязанногоОбъектаДО(Параметры.Ссылка, ОписаниеОповещения);
		
	Иначе
		
		Если Параметры.МассивИменФайлов.Количество() > 0 Тогда
			РаботаСФайламиСлужебныйКлиент.ДобавитьФайлыПеретаскиванием(
				Параметры.Ссылка, Параметры.УникальныйИдентификатор, Параметры.МассивИменФайлов);
		КонецЕсли;
		ОповеститьОбИзменении(Параметры.Ссылка);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ФайлыПеретаскиваниеЗавершение(Результат, Параметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура") Тогда
		ID = Результат.id;
		Тип = Результат.type;
	КонецЕсли;
	Если Не ЗначениеЗаполнено(ID) Тогда
		Возврат;
	КонецЕсли;
	
	МодульИнтеграцияС1СДокументооборотКлиент =
		ОбщегоНазначенияКлиент.ОбщийМодуль("ИнтеграцияС1СДокументооборотКлиент");
	ОписаниеОповещения = Новый ОписаниеОповещения("ФайлыПеретаскиваниеПослеДобавленияФайла",
		ПрисоединенныеФайлыБПКлиент, Параметры.Владелец);
	Для Каждого Файл Из Параметры.МассивФайлов Цикл
		МодульИнтеграцияС1СДокументооборотКлиент.СоздатьФайлСДискаПеретаскиванием(
			Файл,
			Параметры.УникальныйИдентификатор,
			ID,
			Тип,
			Строка(Параметры.Владелец),
			ОписаниеОповещения);
	КонецЦикла;
	
КонецПроцедуры

Процедура ФайлыПеретаскиваниеПослеДобавленияФайла(ОписанияФайлов, ВладелецФайла) Экспорт
	
	Оповестить("Запись_Файл", Новый Структура("ЭтоНовый, ВладелецФайла", Истина, ВладелецФайла));
	
КонецПроцедуры
// Конец ИнтеграцияС1СДокументооборотом

#КонецОбласти

#КонецОбласти

