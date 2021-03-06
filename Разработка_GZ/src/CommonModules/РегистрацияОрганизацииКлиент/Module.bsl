#Область СлужебныйПрограммныйИнтерфейс

// Открывает помощник Регистрация организации (ИП)
//
Функция ОткрытьПомощникРегистрации() Экспорт
	
	ПараметрыНавигацииПомощника = РегистрацияОрганизацииВызовСервера.ПараметрыНавигацииПомощникаРегистрации();
	Если ПараметрыНавигацииПомощника.СтруктураНавигации <> Неопределено Тогда
		НавигацияПомощниковКлиент.ОткрытьЭтап(
			ПараметрыНавигацииПомощника.НомерШага,
			ПараметрыНавигацииПомощника.СтруктураНавигации);
		Результат = Истина;
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Сервис регистрации отключен или не используется'"));
		Результат = Ложь;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Открывает помощник Внесение изменений в ЕГРЮЛ (ЕГРИП)
//
// Параметры:
//   ПараметрыПомощника - см. РегистрацияОрганизацииКлиентСервер.НовыеПараметрыПомощникаВнесенияИзменений()
//
Функция ОткрытьПомощникВнесенияИзменений(Знач ПараметрыПомощника = Неопределено) Экспорт
	
	Если ПараметрыПомощника = Неопределено Тогда
		ПараметрыПомощника = РегистрацияОрганизацииКлиентСервер.НовыеПараметрыПомощникаВнесенияИзменений();
	КонецЕсли;
	
	ОткрытьФорму("Обработка.РегистрацияОрганизации.Форма.ВнесениеИзмененийЕГР", ПараметрыПомощника);
	Возврат Истина;
	
КонецФункции

Процедура ОткрытьЭтап(НомерТекущегоШага) Экспорт
	
	СтруктураНавигации = РегистрацияОрганизацииВызовСервера.СтруктураНавигацииПомощникаРегистрации();
	Если СтруктураНавигации <> Неопределено Тогда
		НавигацияПомощниковКлиент.ОткрытьЭтап(НомерТекущегоШага, СтруктураНавигации);
	Иначе
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Сервис регистрации отключен или не используется'"));
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьНавигационнуюСсылку(НавигационнаяСсылка, СтандартнаяОбработка) Экспорт
	
	Если НавигацияПомощниковКлиент.ЭтоНавигационнаяСсылкаШага(НавигационнаяСсылка) Тогда
		СтандартнаяОбработка = Ложь;
		НавигацияПомощниковКлиент.ОбработатьНавигационнуюСсылку(
			НавигационнаяСсылка,
			РегистрацияОрганизацииВызовСервера.СтруктураНавигацииПомощникаРегистрации());
	КонецЕсли;
	
КонецПроцедуры

Процедура ОповеститьОбОткрытии(Форма, ИмяПомощника, НомерШага) Экспорт
	
	Оповестить("ОткрытШагПомощника_РегистрацияОрганизации",
		Новый Структура("ИмяПомощника, НомерШага", ИмяПомощника, НомерШага),
		Форма);
	
КонецПроцедуры

Функция ОткрытьФормуУчредителя(Элемент, ТекущиеДанные) Экспорт
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("РежимВыбора", Истина);
	
	Если ЗначениеЗаполнено(ТекущиеДанные.Ссылка) Тогда
		ПараметрыФормы.Вставить("Ключ", ТекущиеДанные.Ссылка);
	Иначе
		ПараметрыФормы.Вставить("ТекстЗаполнения", ТекущиеДанные.Наименование);
	КонецЕсли;
	
	Если ТекущиеДанные.ТипУчредителя = ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо") Тогда
		ЗначенияЗаполнения = Новый Структура;
		ЗначенияЗаполнения.Вставить("ЮридическоеФизическоеЛицо", ПредопределенноеЗначение("Перечисление.ЮридическоеФизическоеЛицо.ЮридическоеЛицо"));
		ПараметрыФормы.Вставить("ЗначенияЗаполнения", ЗначенияЗаполнения);
		ИмяФормы = "Обработка.РегистрацияОрганизации.Форма.ФормаЮридическогоЛица";
	Иначе
		ИмяФормы = "Обработка.РегистрацияОрганизации.Форма.ФормаФизическогоЛица";
	КонецЕсли;
	
	ОткрытьФорму(ИмяФормы, ПараметрыФормы, Элемент);
	
КонецФункции

// см. РегламентированнаяОтчетностьКлиентПереопределяемый.ПередОткрытиемФормыУведомления
//
Процедура ПередОткрытиемФормыУведомления(Организация, ВидУведомления, СтандартнаяОбработка) Экспорт
	
	Если РегистрацияОрганизацииВызовСервера.ЭтоУведомлениеВнесениеИзмененийЕГР(ВидУведомления) Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// См. РегламентированнаяОтчетностьКлиентПереопределяемый.ОбработчикСозданияУведомления
//
Процедура ОбработчикСозданияУведомления(Форма, Параметр) Экспорт
	
	Если ТипЗнч(Параметр) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	ВидУведомления = Неопределено;
	Параметр.Свойство("ВидУведомления", ВидУведомления);
	
	Если РегистрацияОрганизацииВызовСервера.ЭтоУведомлениеВнесениеИзмененийЕГР(ВидУведомления)
		Или УчетПСНВызовСервера.ЭтоУведомлениеЗаявлениеНаПолучениеПатента(ВидУведомления) Тогда
		
		ОткрытьФорму("Обработка.РегистрацияОрганизации.Форма.ФормаСозданияУведомления", Параметр, Форма);
		
	КонецЕсли;
	
КонецПроцедуры

// Проверяет, что переданный текст введен кириллицей или латиницей (проверяемый язык ввода регулируется параметром),
// при этом не учитываются разделители слов, независимо от проверяемого языка. В случае отрицательного результата
// проверки выводит сообщение об ошибке
//
// Параметры:
//  Текст - Строка - проверяемый текст
//  Путь - Строка - полный путь к реквизиту формы. Например, "Объект.Контрагент"
//  ЗаголовокЭлемента - Строка - заголовок проверяемого поля, для отображения в сообщении об ошибке
//  ВводитсяКириллицей - Булево - Истина, если текст должен содержать только символы кириллицы
//                              - Ложь, если текст должен содержать только символы латиницы
//
Процедура ПроверкаЯзыкаВвода(Текст, Путь, ЗаголовокЭлемента, ВводитсяКириллицей) Экспорт
	
	Если ПустаяСтрока(Текст) Тогда
		Возврат;
	КонецЕсли;
	ОшибкаВвода = "";
	ДопустимыеСимволы = РегистрацияОрганизацииКлиентСервер.УниверсальныеСимволыВПаспортныхДанных();
	Если ВводитсяКириллицей И Не СтроковыеФункцииКлиентСерверРФ.ТолькоКириллицаВСтроке(
		Текст, Ложь, ДопустимыеСимволы) Тогда
		ОшибкаВвода = СтрШаблон(НСтр("ru = '%1 заполняется на русском языке'"), ЗаголовокЭлемента);
	ИначеЕсли Не ВводитсяКириллицей И Не СтроковыеФункцииКлиентСервер.ТолькоЛатиницаВСтроке(
		Текст, Ложь, ДопустимыеСимволы) Тогда
		ОшибкаВвода = СтрШаблон(НСтр("ru = '%1 заполняется латиницей'"), ЗаголовокЭлемента);
	КонецЕсли;
	Если Не ПустаяСтрока(ОшибкаВвода) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(ОшибкаВвода, , , Путь);
	КонецЕсли;
	
КонецПроцедуры

// Инициирует событие НачалоВыбора поля формы контактной информации
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма, из которой вызывается обработчик
//  Элемент - ПолеФормы - элемент формы, в которое помещается выбранное значение
//  СтандартнаяОбработка - Булево - признак стандартной обработки события Нажатие
//  Заголовок - Строка -представление выбираемого вида контактной информации
//
&НаКлиенте
Процедура ВыборАдресаФизическогоЛица(Форма, Элемент, СтандартнаяОбработка, Заголовок = "") Экспорт
	
	ПараметрыОткрытияФормы = Новый Структура;
	Если ЗначениеЗаполнено(Заголовок) Тогда
		ПараметрыОткрытияФормы.Вставить("Заголовок", Заголовок);
	КонецЕсли;
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(
		Форма, Элемент, Форма.Модифицированность, СтандартнаяОбработка, ПараметрыОткрытияФормы);
	
КонецПроцедуры

// Открывает форму предварительного просмотра заявления
//
// Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма уведомления (см. Документ.УведомлениеОСпецрежимахНалогообложения)
//   ИмяОтчета - Строка - Имя регламентированного отчета
//   ИмяФайла  - Строка - Имя сохраняемого файла
//
Процедура ОткрытьФормуПредварительногоПросмотраЗаявленияБезДвумерногоКода(Форма, ИмяОтчета, ИмяФайла) Экспорт
	
	ПараметрыПечати = Новый Структура;
	ПараметрыПечати.Вставить("Ссылка", Форма.Объект.Ссылка);
	ПараметрыПечати.Вставить("ИмяФормы", Форма.Объект.ИмяФормы);
	
	СписокПечатаемыхЛистов = РегистрацияОрганизацииВызовСервера.СписокПечатаемыхЛистов(ПараметрыПечати, ИмяОтчета);
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("СписокПечатаемыхЛистов", СписокПечатаемыхЛистов);
	ПараметрыФормы.Вставить("ВидПечати",              Неопределено);
	ПараметрыФормы.Вставить("ЗаголовокФормы",         Форма.Заголовок);
	ПараметрыФормы.Вставить("ЕстьВыходЗаГраницы",     Ложь);
	
	// Имитируем открытие формы предварительного просмотра
	ПредПросмотр = РегламентированнаяОтчетностьКлиент.ПолучитьОбщуюФормуПоИмени(
		"ПечатьРегламентированныхОтчетов",
		ПараметрыФормы,
		Форма,
		Форма.УникальныйИдентификатор);
	
	Если ПредПросмотр = Неопределено Тогда
		ТекстСообщения = НСтр("ru='Невозможно открыть форму для просмотра. Обратитесь к администратору.'");
		ОбщегоНазначенияКлиент.СообщитьПользователю(ТекстСообщения);
		Возврат;
	КонецЕсли;
	
	// Сохраняем файл в PDF формат
	ПакетОтображаемыхДокументов = Новый ПакетОтображаемыхДокументов;
	
	Для Каждого Лист Из ПредПросмотр.СписокЛистов.ПолучитьЭлементы() Цикл
		
		ПакетОтображаемыхДокументов.Состав.Добавить(Лист.АдресВоВременномХранилище);
		
	КонецЦикла;
	
	АдресХранилища = РегистрацияОрганизацииВызовСервера.ПоместитьЗаявлениеБезДвумерногоКодаВоВременноеХранилище(
		ПакетОтображаемыхДокументов,
		Форма.УникальныйИдентификатор);
	
	Если АдресХранилища = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Откроем файл для просмотра
	
	Попытка
		ПолучитьФайл(АдресХранилища, ИмяФайла, Истина);
	Исключение
		ТекстСообщения = НСтр("ru = 'Не удалось получить файл. Возможно, файл уже открыт.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецПопытки;
	
	ПакетОтображаемыхДокументов = Неопределено;
	
КонецПроцедуры

// Открывает форму просмотра типового устава
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма помощника заполнения заявления
//   НомерТиповогоУстава     - Число - Номер типового устава
//   УникальныйИдентификатор - УникальныйИдентификатор - Уникальный идентификатор формы
//
Процедура ОткрытьФормуПросмотраТиповогоУстава(Форма, НомерТиповогоУстава, УникальныйИдентификатор) Экспорт
	
	ДанныеУстава = РегистрацияОрганизацииКлиентСервер.НовыйДанныеТиповогоУстава();
	ЗаполнитьЗначенияСвойств(ДанныеУстава, Форма);
	
	АдресХранилища = РегистрацияОрганизацииВызовСервера.ТиповойУставООО(ДанныеУстава, НомерТиповогоУстава, УникальныйИдентификатор);
	
	ИмяФайла = СтрШаблон("%1.pdf", РегистрацияОрганизацииКлиентСервер.ИмяТиповогоУстава(НомерТиповогоУстава));
	
	Попытка
		ПолучитьФайл(АдресХранилища, ИмяФайла, Истина);
	Исключение
		ТекстСообщения = НСтр("ru = 'Не удалось получить файл. Возможно, файл уже открыт.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти
