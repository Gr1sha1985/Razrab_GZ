// Процедура формирует сообщение об ошибке при выполнении рег. операции.
//
Процедура ОтправитьСлужебноеСообщение(Знач ТекстСообщения, Знач СсылкаНаОшибочныйОбъект = Неопределено, Отказ = Истина, РегОперация) Экспорт
	
	// Процедура может формировать служебные сообщения регламентных операций.
	// Такие сообщения содержат _в тексте_ навигационную ссылку и не должны выдаваться пользователю.
	// Они предназначены для заполнения списка ошибок в регламентной операции.
	// Такая возможность оставлена для совместимости.
	// Вместо этой процедуры следует явно заполнять список ошибок регламентной операции.
	//
	// Для того, чтобы понять, что сообщение служебное, следует использовать ЭтоСлужебноеСообщение()
	
	Отказ                = Истина;
	ТипОбъекта           = ТипЗнч(РегОперация);
	ЭтоРегОперацияСсылка = БухгалтерскийУчетКлиентСерверПереопределяемый.ЭтоРегламентнаяОперация(РегОперация);
	
	Если ЭтоРегОперацияСсылка Тогда
		
		Если ТипЗнч(СсылкаНаОшибочныйОбъект) = Тип("Строка") Тогда
			ТекстСообщения = ТекстСообщения + "
				|" + СсылкаНаОшибочныйОбъект;
			СсылкаНаОшибочныйОбъект = РегОперация;
		ИначеЕсли БухгалтерскийУчетКлиентСерверПереопределяемый.ЭтоРегламентнаяОперация(СсылкаНаОшибочныйОбъект) Тогда
			ТекстСообщения = ТекстСообщения + "
				|" + ПолучитьНавигационнуюСсылку(СсылкаНаОшибочныйОбъект);
		ИначеЕсли СсылкаНаОшибочныйОбъект = Неопределено Тогда
			СсылкаНаОшибочныйОбъект = РегОперация;
			ТекстСообщения = ТекстСообщения + "
				|" + ПолучитьНавигационнуюСсылку(РегОперация);
		Иначе
			ТекстСообщения = ТекстСообщения + "
				|" + ПолучитьНавигационнуюСсылку(СсылкаНаОшибочныйОбъект);
			СсылкаНаОшибочныйОбъект = РегОперация;
		КонецЕсли;
		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, СсылкаНаОшибочныйОбъект,,, Отказ);
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, СсылкаНаОшибочныйОбъект,,, Отказ);
	КонецЕсли;
	
КонецПроцедуры

// Определяет, является ли сообщение служебным, предназначенным для заполнения документа РегламентнаяОперация.
//
// Параметры:
//  Сообщение - проверяемое сообщение
//
// Возвращаемое значение:
//  Булево - является ли сообщение служебным
//
// Возвращаемые параметры:
//  ТекстДляПользователя - часть текста сообщения, предназначенная для пользователя
//  СсылкаДляПерехода    - часть текста сообщения, не предназначенная для пользователя
//
Функция ЭтоСлужебноеСообщение(Сообщение, ТекстДляПользователя = Неопределено, СсылкаДляПерехода = Неопределено)
	
	ТекстСообщения = Сообщение.Текст;
	
	ПозицияНавигационнойСсылки = СтрНайти(ТекстСообщения, "e1cib");
	Если ПозицияНавигационнойСсылки <> 0 Тогда
		ТекстДляПользователя = Лев(ТекстСообщения, ПозицияНавигационнойСсылки - 1);
		СсылкаДляПерехода    = Сред(ТекстСообщения, ПозицияНавигационнойСсылки);
		Возврат Истина;
	КонецЕсли;
	
	ПозицияИндикатораДлительнойОперации = СтрНайти(ТекстСообщения, "{СтандартныеПодсистемы.ДлительныеОперации}");
	Если ПозицияИндикатораДлительнойОперации <> 0 Тогда
		Возврат Истина;
	КонецЕсли;
	
	ТекстДляПользователя = ТекстСообщения;
	Возврат Ложь;
	
КонецФункции

Процедура ПолучитьИзДлительнойОперацииСообщенияПользователю(ИдентификаторЗадания, ИдентификаторНазначения = Неопределено) Экспорт
	
	Если Не ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		Возврат;
	КонецЕсли;
	
	ФоновоеЗадание = ФоновыеЗадания.НайтиПоУникальномуИдентификатору(ИдентификаторЗадания);
	Если ФоновоеЗадание = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Сообщения = ФоновоеЗадание.ПолучитьСообщенияПользователю(Истина);
	
	Если Сообщения = Неопределено Тогда
		// Вместо пустого массива возвращается Неопределено
		Возврат;
	КонецЕсли;
	
	// Сообщения фонового задания могут повторяться из-за особенностей технической реализации
	// заполнения списка Ошибки регламентной операции.
	// Также они могут содержать служебные сообщения.
	// См. ДополнитьИнформациюОбОшибкахСообщениямиПользователю()
	УникальныеТекстыСообщений = Новый Массив;
	УникальныеСообщения = Новый Массив;
	Для Каждого Сообщение Из Сообщения Цикл
		
		Если ЭтоСлужебноеСообщение(Сообщение) Тогда
			// Такие не показываем пользователю
			Продолжить;
		КонецЕсли;
		
		Если УникальныеТекстыСообщений.Найти(Сообщение.Текст) = Неопределено Тогда
			УникальныеТекстыСообщений.Добавить(Сообщение.Текст);
			УникальныеСообщения.Добавить(Сообщение);
		КонецЕсли;
		
	КонецЦикла;
	
	Для Каждого Сообщение Из УникальныеСообщения Цикл
		Если ИдентификаторНазначения <> Неопределено Тогда
			Сообщение.ИдентификаторНазначения = ИдентификаторНазначения;
		КонецЕсли;
		Сообщение.Сообщить();
	КонецЦикла;
	
КонецПроцедуры

Процедура ДополнитьИнформациюОбОшибкахСообщениямиПользователю(Ошибки, СообщенияПользователю) Экспорт
	
	// Среди сообщений могут быть
	// - "служебные" - они относятся к данной регламентной операции. Их записываем в ошибки.
	// - все остальные - они были отправлены до выполнения регламентной операции,
	//   но в том же серверном вызове и еще не выведены пользователю. Их пропускаем без изменений.
	
	Для Индекс = 0 По СообщенияПользователю.ВГраница() Цикл
		
		СообщениеПользователю = СообщенияПользователю[Индекс];
		
		СсылкаДляПерехода     = "";
		ТекстСообщения        = "";
		
		Служебное = ЭтоСлужебноеСообщение(
			СообщениеПользователю, 
			ТекстСообщения,
			СсылкаДляПерехода);
			
		Если Служебное Тогда
			
			Если Не ПустаяСтрока(СсылкаДляПерехода) Тогда
				// Указываем на документ РегламентнаяОперация
				ВыводСообщенийОбОшибках.ДобавитьПростоеОписаниеОшибки(Ошибки, ТекстСообщения, СсылкаДляПерехода);
			КонецЕсли;
			
		Иначе
			
			// Это сообщение не относится к данной регламентной операции.
			// Вернем его обратно в очередь сообщений для вывода пользователю.
			СообщениеПользователю.Сообщить();
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// ВЕРСТКА ТАБЛИЧНОГО ДОКУМЕНТА

Функция ОписаниеОшибок(Ошибки, Период, Организация, ВидОперации) Экспорт
	
	Если Не ВыводСообщенийОбОшибках.ЕстьОшибки(Ошибки) Тогда
		Возврат Новый ХранилищеЗначения(Неопределено);
	КонецЕсли;
	
	Если ПолучитьФункциональнуюОпцию("ВестиУчетЗатратПоПодразделениям") Тогда
		Макет = Документы.РегламентнаяОперация.ПолучитьМакет("ОписаниеОшибок");
	Иначе
		Макет = Документы.РегламентнаяОперация.ПолучитьМакет("ОписаниеОшибокБезУчетаЗатратПоПодразделениям");
	КонецЕсли;
	
	РеквизитыОперации = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = '%1 за %2'"),
		ВидОперации,
		Формат(Период, "ДФ='MMMM yyyy'"));
	
	ДанныеДляВывода = Новый Структура;
	ДанныеДляВывода.Вставить("Организация",       Организация);
	ДанныеДляВывода.Вставить("РеквизитыОперации", РеквизитыОперации);
	
	Возврат ВыводСообщенийОбОшибках.ОписаниеОшибок(Ошибки, Макет, ДанныеДляВывода);
	
КонецФункции