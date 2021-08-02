#Область СлужебныеПроцедурыИФункции

Функция СравнитьНаселенныеПункты(Знач Адрес1, Знач Адрес2) Экспорт
	
	Возврат РегистрацияОрганизацииПовтИсп.СравнитьНаселенныеПункты(Адрес1, Адрес2);
	
КонецФункции

Функция ПараметрыНавигацииПомощникаРегистрации() Экспорт
	
	СтруктураНавигации = Обработки.РегистрацияОрганизации.СтруктураНавигацииПомощникаРегистрации();
	Если СтруктураНавигации = Неопределено Тогда
		СтруктураНавигации = Обработки.РегистрацияОрганизации.ПодготовитьСтруктуруНавигацииПомощникаРегистрации().Структура;
		НомерШага = 1;
	Иначе
		// Получим текущий номер шага помощника.
		НомерШага = Обработки.РегистрацияОрганизации.НомерШагаПомощника();
	КонецЕсли;
	
	Возврат Новый Структура("НомерШага, СтруктураНавигации", НомерШага, СтруктураНавигации);
	
КонецФункции

Функция СтруктураНавигацииПомощникаРегистрации() Экспорт
	
	Возврат Обработки.РегистрацияОрганизации.СтруктураНавигацииПомощникаРегистрации();
	
КонецФункции

Функция ЭтоУведомлениеВнесениеИзмененийЕГР(ВидУведомления) Экспорт
	
	ВидыУведомлений = Новый Массив;
	ВидыУведомлений.Добавить(Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ФормаР13001);
	ВидыУведомлений.Добавить(Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ФормаР14001);
	ВидыУведомлений.Добавить(Перечисления.ВидыУведомленийОСпецрежимахНалогообложения.ФормаР24001);
	
	Возврат (ВидыУведомлений.Найти(ВидУведомления) <> Неопределено);
	
КонецФункции

// Приводит адрес к формату, обеспечивающему наиболее точный поиск на картах Google и Яндекс.
// Преобразует адрес всегда к формату "Административно-территориальное деление",
// удаляет из представления почтовый индекс и символ "№"
//
// Параметры:
//   АдресЗначениеJSON - Строка - json-строка, содержащая описание адреса.
//
// Возвращаемое значение:
//   Строка - представление адреса
//
Функция ПредставлениеАдресаДляПоискаМФЦ(АдресЗначениеJSON) Экспорт
	
	// Преобразуем адрес из формата "Муниципальное деление" в "Административно-территориальное деление"
	// для более точного поиска на картах.
	
	ТипАдреса = РаботаСАдресамиКлиентСервер.АдминистративноТерриториальныйАдрес();
	СтруктураАдреса = УправлениеКонтактнойИнформациейСлужебный.СтрокуJSONВСтруктуру(АдресЗначениеJSON);
	
	СтруктураАдреса.ZipCode = "";
	ПредставлениеАдреса = РаботаСАдресамиКлиентСервер.ПредставлениеАдреса(СтруктураАдреса, Ложь, ТипАдреса);
	ПредставлениеАдреса = СтрЗаменить(ПредставлениеАдреса, "№", ""); // без номера поиск на карте точнее
	
	Возврат ПредставлениеАдреса;
	
КонецФункции

#Область ПечатьБезДвумерногоКода

// Формирует список печатаемых листов регламентированного отчета
//
// Параметры:
//   Объект - Структура - Структура, описывающая объект с ключами:
//     * ИмяФормы - Строка - Имя формы регламентированного отчета
//     * Ссылка   - ДокументСсылка.УведомлениеОСпецрежимахНалогообложения - ссылка на уведомление
//
// Возвращаемое значение:
//   СписокЗначений
//
Функция СписокПечатаемыхЛистов(Объект, ИмяОтчета) Экспорт
	
	Возврат Отчеты[ИмяОтчета].СформироватьСписокЛистов(Объект, Ложь);
	
КонецФункции

// Возвращает адрес во временном хранилище записанного пакета табличных документов
//
// Параметры:
//   ПакетТаблДок            - ПакетОтображаемыхДокументов - пакет документов для записи
//   УникальныйИдентификатор - Уникальный идентификатор формы
//
// Возвращаемое значение:
//   Строка
//
Функция ПоместитьЗаявлениеБезДвумерногоКодаВоВременноеХранилище(ПакетТаблДок, УникальныйИдентификатор) Экспорт
	
	АдресВоВременномХранилище = Неопределено;
	
	Если ПакетТаблДок.Состав.Количество() > 0 Тогда
		
		ИмяФайла = ПолучитьИмяВременногоФайла("pdf");
		ПакетТаблДок.ЗаписатьФайлДляПечати(ИмяФайла);
		
		ФайлЛиста = Новый ДвоичныеДанные(ИмяФайла);
		АдресВоВременномХранилище = ПоместитьВоВременноеХранилище(ФайлЛиста, УникальныйИдентификатор);
		
		// Удаляем временный файл
		Попытка
			УдалитьФайлы(ИмяФайла);
		Исключение
			ЗаписьЖурналаРегистрации(НСтр("ru = 'Файлы.Удаление'", ОбщегоНазначения.КодОсновногоЯзыка()),
				УровеньЖурналаРегистрации.Ошибка, , ,
				ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецПопытки;
		
	КонецЕсли;
	
	Возврат АдресВоВременномХранилище;
	
КонецФункции

#КонецОбласти

// Возвращает адрес во временном хранилище, которое содержит двоичные данные сформированного типового устава в формате PDF
//
// Параметры:
//   ДанныеУстава            - Структура - см. РегистрацияОрганизацииКлиентСервер.НовыйДанныеТиповогоУстава()
//   НомерТиповогоУстава     - Число - Номер типового устава
//   УникальныйИдентификатор - УникальныйИдентификатор - Уникальный идентификатор формы
//
// Возвращаемое значение:
//   Строка
//
Функция ТиповойУставООО(ДанныеУстава, НомерТиповогоУстава, УникальныйИдентификатор) Экспорт
	
	Возврат Обработки.РегистрацияОрганизации.ТиповойУставООО(НомерТиповогоУстава, ДанныеУстава, УникальныйИдентификатор);
	
КонецФункции

#КонецОбласти

