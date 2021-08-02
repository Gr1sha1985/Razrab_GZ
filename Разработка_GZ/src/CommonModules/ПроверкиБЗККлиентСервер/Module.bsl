#Область СлужебныйПрограммныйИнтерфейс

// АПК:558-выкл Кандидаты в публичный программный интерфейс.
// АПК:559-выкл Кандидаты в публичный программный интерфейс.

// Проверяет корректность заполнения начала и окончания периода в объекте или строке таблицы формы.
//
// Параметры:
//   Форма      - УправляемаяФорма - Форма с датами начала и окончания.
//   ПутьКОбъекту         - Строка - Полный путь к реквизиту формы с датами начала и окончания.
//   ИмяПоляДатыНачала    - Строка - Имя реквизита строки табличной части, в котором хранится дата начала периода.
//   ИмяПоляДатыОкончания - Строка - Имя реквизита строки табличной части, в котором хранится дата окончания.
//   ПредставлениеВРодительномПадеже - Строка - Представление (заголовок) периода в родительном падеже.
//
// Возвращаемое значение:
//   Булево - Признак того, что поля успешно прошли проверку.
//       Возвращает Ложь если была выявлена ошибка.
//
Функция ПериодСоответствуетТребованиям(Форма, ПутьКОбъекту, ИмяПоляДатыНачала, ИмяПоляДатыОкончания, ПредставлениеВРодительномПадеже) Экспорт
	Объект = ОбщегоНазначенияБЗККлиентСервер.ЗначениеСвойства(Форма, ПутьКОбъекту);
	Дата1 = Объект[ИмяПоляДатыНачала];
	Дата2 = Объект[ИмяПоляДатыОкончания];
	Если Не ЗначениеЗаполнено(Дата1) Тогда
		Текст = СтрШаблон(НСтр("ru = 'Не заполнена дата начала %1.'"), ПредставлениеВРодительномПадеже);
		СообщитьПользователю(Текст, ИмяПоляДатыНачала, , , ПутьКОбъекту);
		Возврат Ложь;
	ИначеЕсли Не ЗначениеЗаполнено(Дата2) Тогда
		Текст = СтрШаблон(НСтр("ru = 'Не заполнена дата окончания %1.'"), ПредставлениеВРодительномПадеже);
		СообщитьПользователю(Текст, ИмяПоляДатыОкончания, , , ПутьКОбъекту);
		Возврат Ложь;
	ИначеЕсли Дата1 > Дата2 Тогда
		Текст = СтрШаблон(НСтр("ru = 'Дата начала %1 больше даты окончания.'"), ПредставлениеВРодительномПадеже);
		СообщитьПользователю(Текст, ИмяПоляДатыНачала, , , ПутьКОбъекту);
		Возврат Ложь;
	ИначеЕсли Год(Дата1) + 100 < Год(Дата2) Тогда
		Текст = СтрШаблон(НСтр("ru = 'Период %1 превышает 100 лет.'"), ПредставлениеВРодительномПадеже);
		СообщитьПользователю(Текст, ИмяПоляДатыНачала, , , ПутьКОбъекту);
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

// Создает сообщение пользователю.
//
// Параметры:
//   Текст - Строка, ОбъектМетаданных - Текст сообщения.
//   ИмяРеквизита - Строка - Имя реквизита, к которому необходимо привязать сообщение.
//   ИмяТаблицы - Строка - Необязательный. Имя табличной части, в которой размещен реквизит.
//   НомерСтроки - Число - Необязательный. Номер строки табличной части, к которой необходимо привязать сообщение.
//   ПутьКДанным - Строка - Необязательный. В данном параметре можно указать имя объекта данных формы,
//       в котором расположен указанный реквизит или табличная часть. Пример: "Объект".
//
Процедура СообщитьПользователю(Текст, ИмяРеквизита, ИмяТаблицы = Неопределено, НомерСтроки = 0, ПутьКДанным = Неопределено) Экспорт
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = Текст;
	Если ИмяТаблицы = Неопределено Тогда
		Сообщение.Поле = ИмяРеквизита;
	Иначе
		Сообщение.Поле = ОбщегоНазначенияКлиентСервер.ПутьКТабличнойЧасти(ИмяТаблицы, НомерСтроки, ИмяРеквизита);
	КонецЕсли;
	Если ПутьКДанным <> Неопределено Тогда
		Сообщение.ПутьКДанным = ПутьКДанным;
	КонецЕсли;
	Сообщение.Сообщить();
КонецПроцедуры

// Проверяет номер расчетного счета на соответствие БИКу и корреспондентскому счету банка.
//
// Параметры:
//   НомерСчета - Строка
//   БИК - Строка
//   КорреспондентскийСчет - Строка
//
// Возвращаемое значение:
//   Структура - описание
//       * Успех - Булево - Если Истина, то номер счета прошел проверку. В пояснении будут подробности.
//       * Пояснение - Строка - Текст для вывода результатов в интерфейсе.
//
Функция РезультатПроверкиНомераСчета(Знач НомерСчета, Знач БИК, Знач КорреспондентскийСчет) Экспорт
	РезультатПроверки = Новый Структура("Успех, Пояснение");
	
	НомерСчетаСтрока = НомерСчета;
	
	Если ПустаяСтрока(НомерСчетаСтрока) Тогда
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = НСтр("ru = 'Не заполнен номер счета.'");
		Возврат РезультатПроверки;
	КонецЕсли;
	
	Если СтрДлина(НомерСчетаСтрока) <> 20 Тогда
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'В номере счета %1 символов, а должно быть 20.'"),
			СтрДлина(НомерСчетаСтрока));
		Возврат РезультатПроверки;
	КонецЕсли;
	
	// См. "Порядок расчета контрольного ключа в номере лицевого счета" (утв. Банком России 08.09.1997 N 515).
	// Алфавитное значение 6-го разряда счета (в случае использования клиринговой валюты) заменяется на цифровое:
	Разряд6 = Сред(НомерСчетаСтрока, 6, 1);
	Если СтрНайти("0123456789", Разряд6) = 0 Тогда
		АлфавитныеЗначения6гоРазряда = СтрРазделить("А,В,С,Е,Н,К,М,Р,Т,Х", ",", Ложь);
		Индекс = АлфавитныеЗначения6гоРазряда.Найти(Разряд6);
		Если Индекс <> Неопределено Тогда
			НомерСчетаСтрока = Лев(НомерСчетаСтрока, 5) + Формат(Индекс, "ЧН=") + Сред(НомерСчетаСтрока, 7);
		КонецЕсли;
	КонецЕсли;
	
	ЛишниеСимволы = СтроковыеФункцииБЗККлиентСервер.УдалитьЦифрыИзСтроки(НомерСчетаСтрока);
	Если Не ПустаяСтрока(ЛишниеСимволы) Тогда
		Если СтрДлина(ЛишниеСимволы) = 1 Тогда
			Пояснение = НСтр("ru = 'В номере счета должны быть только цифры (%1 - не цифра).'");
		Иначе
			Пояснение = НСтр("ru = 'В номере счета должны быть только цифры (%1 - не цифры).'");
		КонецЕсли;
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Пояснение, ЛишниеСимволы);
		Возврат РезультатПроверки;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(БИК) Тогда
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = НСтр("ru = 'Не заполнен БИК банка.'");
		Возврат РезультатПроверки;
	ИначеЕсли СтрДлина(БИК) <> 9 Тогда
		Пояснение = НСтр("ru = 'БИК банка занимает %1 символов, а должно быть 9.'");
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = СтрШаблон(Пояснение, СтрДлина(БИК));
		Возврат РезультатПроверки;
	Иначе
		ЛишниеСимволы = СтроковыеФункцииБЗККлиентСервер.УдалитьЦифрыИзСтроки(БИК);
		Если Не ПустаяСтрока(ЛишниеСимволы) Тогда
			Если СтрДлина(ЛишниеСимволы) = 1 Тогда
				Пояснение = НСтр("ru = 'В БИК банка должны быть только цифры (%1 - не цифра).'");
			Иначе
				Пояснение = НСтр("ru = 'В БИК банка должны быть только цифры (%1 - не цифры).'");
			КонецЕсли;
			РезультатПроверки.Успех = Ложь;
			РезультатПроверки.Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Пояснение, ЛишниеСимволы);
			Возврат РезультатПроверки;
		КонецЕсли;
	КонецЕсли;
	
	Если Не РегламентированныеДанныеКлиентСервер.КонтрольныйКлючЛицевогоСчетаСоответствуетТребованиям(
			НомерСчетаСтрока,
			БИК,
			ЗначениеЗаполнено(КорреспондентскийСчет)) Тогда
		РезультатПроверки.Успех = Ложь;
		РезультатПроверки.Пояснение = НСтр("ru = 'Ошибка в номере счета или в БИК банка. Не совпадает контрольное число.'");
		Возврат РезультатПроверки;
	КонецЕсли;
	
	РезультатПроверки.Успех = Истина;
	РезультатПроверки.Пояснение = НСтр("ru = 'Номер счета соответствует требованиям.'");
	Возврат РезультатПроверки;
КонецФункции

// АПК:559-вкл
// АПК:558-вкл

#КонецОбласти

