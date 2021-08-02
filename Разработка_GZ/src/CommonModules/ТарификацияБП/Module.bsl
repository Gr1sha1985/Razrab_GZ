#Область СлужебныйПрограммныйИнтерфейс

Процедура ДополнитьОписаниеТарифицируемыхУслуг(ПоставщикиУслуг) Экспорт
	
	НовыйПоставщик = Новый Структура;
	НовыйПоставщик.Вставить("Идентификатор", ИдентификаторПоставщикаУслугБухгалтерияПредприятия());
	НовыйПоставщик.Вставить("Наименование",  НСтр("ru = 'Конфигурация ""Бухгалтерия предприятия"", редакция 3.0'"));
	НовыйПоставщик.Вставить("Услуги",        Новый Массив);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиРегулярнаяДеятельность());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Возможность учитывать регулярную деятельность бизнеса и предоставлять ненулевую отчетность'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиТолькоИнтерфейсИнтеграцииСБанком());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Только интерфейс интеграции с банком'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиОбособленныеПодразделения());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Обособленные подразделения'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиОбратноеНачислениеНДС());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Обратное начисление НДС'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиРасширенныйФункционал());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Расширенный функционал'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиВестиУчетПоОрганизациям());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Учет по нескольким организациям'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиГособоронзаказ());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Контракты государственного заказа'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиУведомленияОКонтролируемыхСделках());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Контролируемые сделки'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Уникальная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиБухгалтерскийУчет());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Возможность вести бухгалтерский и налоговый учет и предоставлять отчетность'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиКадровыйУчет());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Возможность вести кадровый учет и регистрировать записи трудовых книжек'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиНачинатьРаботуСоСравненияРежимовНалогообложения());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Начинать работу с программой со сравнения режимов налогообложения'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиСервисРегистрации());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Сервис регистрации'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	Услуга = Новый Структура;
	Услуга.Вставить("Идентификатор", ИдентификаторУслугиКонсультацииБухОбслуживание());
	Услуга.Вставить("Наименование",  НСтр("ru = 'Оказываются консультации партнерами 1С:БухОбслуживание'"));
	Услуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	НовыйПоставщик.Услуги.Добавить(Услуга);
	
	ПоставщикиУслуг.Добавить(НовыйПоставщик);
	
КонецПроцедуры

Процедура ДополнитьОписаниеТарифицируемыхУслуг1СОтчетность(ПоставщикиУслуг) Экспорт
	
	ПоставщикПортал1СИТС = Неопределено;
	ИдентификаторПоставщикаУслугПортал1СИТС =
		ИнтернетПоддержкаПользователейКлиентСервер.ИдентификаторПоставщикаУслугПортал1СИТС();
	Для каждого ЗначениеМассива Из ПоставщикиУслуг Цикл
		Если ЗначениеМассива.Идентификатор = ИдентификаторПоставщикаУслугПортал1СИТС Тогда
			ПоставщикПортал1СИТС = ЗначениеМассива;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Если ПоставщикПортал1СИТС = Неопределено Тогда
		ПоставщикПортал1СИТС = Новый Структура;
		ПоставщикПортал1СИТС.Вставить("Идентификатор", ИдентификаторПоставщикаУслугПортал1СИТС);
		ПоставщикПортал1СИТС.Вставить("Наименование" , НСтр("ru = 'Портал 1С:ИТС'"));
		ПоставщикПортал1СИТС.Вставить("Услуги"       , Новый Массив);
		ПоставщикиУслуг.Добавить(ПоставщикПортал1СИТС);
	КонецЕсли;
	
	НоваяУслуга = Новый Структура;
	НоваяУслуга.Вставить("Идентификатор", ИдентификаторУслуги1СОтчетность());
	НоваяУслуга.Вставить("Наименование",  НСтр("ru = 'Лицензия для сдачи отчетности одного юридического лица'"));
	НоваяУслуга.Вставить("ТипУслуги",     Перечисления.ТипыУслуг.Безлимитная);
	
	ПоставщикПортал1СИТС.Услуги.Добавить(НоваяУслуга);
	
КонецПроцедуры

Процедура РазместитьИнформациюОбОграничении(Форма) Экспорт
	
	Если ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности() Тогда
		Возврат;
	КонецЕсли;
	
	Если Форма.ИмяФормы = "Обработка.ФункциональностьПрограммы.Форма.ФормаФункциональностьПрограммы" Тогда
		
		НаложитьОграничениеНаГруппуФормы(Форма, "ГруппаОсновное", "ТолькоПросмотр");
		
	ИначеЕсли Форма.ИмяФормы = "ОбщаяФорма.НалогиИОтчеты"
		ИЛИ Форма.ИмяФормы = "РегистрСведений.НастройкиСистемыНалогообложения.Форма.ФормаЗаписи" Тогда
		
		НаложитьОграничениеНаГруппуФормы(Форма, "ГруппаСпецрежим", "ТолькоПросмотр");
		
	КонецЕсли;
	
КонецПроцедуры

Процедура РазместитьИнформациюОбОграниченииПоКоличествуОбъектов(Форма) Экспорт
	
	Если НЕ ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности() Тогда
		
		Элементы = Форма.Элементы;
		Фон = Элементы.Вставить(
			"ГруппаОграничениеТарифа",
			Тип("ГруппаФормы"),,
			Элементы.Список);
			
		Фон.Вид                 = ВидГруппыФормы.ОбычнаяГруппа;
		Фон.ЦветФона            = ЦветаСтиля.ЦветФонаНедоступногоСервиса;
		Фон.ОтображатьЗаголовок = Ложь;
		
		КоличествоПредметов = СтроковыеФункцииКлиентСервер.ЧислоЦифрамиПредметИсчисленияПрописью(ОграничениеКоличестваОбъектов(),
			НСтр("ru = 'документа, документов, документов'"), Истина);
		ТекстПредупреждения = НСтр("ru='Можно ввести не больше %1 всех видов. На платном тарифе — сколько угодно.'");
		ТекстПредупреждения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ТекстПредупреждения, КоличествоПредметов);
		
		ВставитьДекорациюПредупреждения(Элементы, "ОграничениеТарифа", Фон, ТекстПредупреждения);
		
	ИначеЕсли РегламентированнаяОтчетностьБП.Используется1СОтчетность()
		И НЕ ТарификацияБПВызовСервераПовтИсп.РазрешенЭлектронныйДокументообротСКонтролирующимиОрганами() Тогда
		
		Элементы = Форма.Элементы;
		Фон = Элементы.Вставить(
			"ГруппаОграничениеТарифа",
			Тип("ГруппаФормы"),,
			Элементы.Список);
			
		Фон.Вид                 = ВидГруппыФормы.ОбычнаяГруппа;
		Фон.ЦветФона            = ЦветаСтиля.ЦветФонаНедоступногоСервиса;
		Фон.ОтображатьЗаголовок = Ложь;
		
		ТекстПредупреждения = НСтр("ru='Отправляйте отчетность через Интернет! Эта возможность доступна только на платном тарифе.'");
		
		ВставитьДекорациюПредупреждения(Элементы, "ОграничениеТарифа", Фон, ТекстПредупреждения);
		
	КонецЕсли;
	
КонецПроцедуры

// Обработчик подписки на событие ПроверкаТарифныхОграниченийДокументов.
// Если тарифные ограничения нарушены, будет вызвано исключение.
//	
Процедура ПроверкаТарифныхОграниченийДокументовПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	ПроверитьОграничениеОбъекта(Источник, Отказ);
	
КонецПроцедуры

Функция УстановитьРазрешенУчетРегулярнойДеятельности(РегистрироватьНаУзлахПлановОбмена = Ложь) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	РазрешенУчетРегулярнойДеятельности = ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности();
	
	МенеджерКонстанты = Константы.РазрешенУчетРегулярнойДеятельности.СоздатьМенеджерЗначения();
	МенеджерКонстанты.Прочитать();
	
	Если МенеджерКонстанты.Значение = РазрешенУчетРегулярнойДеятельности Тогда
		Возврат Ложь;
	КонецЕсли;
	
	МенеджерКонстанты.Значение = РазрешенУчетРегулярнойДеятельности;
	
	ОбновлениеИнформационнойБазы.ЗаписатьДанные(МенеджерКонстанты, РегистрироватьНаУзлахПлановОбмена);
	
	//УстановитьЗависимыеКонстантыРазрешенУчетРегулярнойДеятельности(МенеджерКонстанты.Значение);
	
	Возврат Истина;
	
КонецФункции

// Устанавливает значения общих констант загрузке данных из сервиса
//
Процедура УстановитьЗначенияКонстантПоставкиПослеЗагрузкиДанных() Экспорт
	
	Если Не РаботаВМоделиСервиса.РазделениеВключено() Тогда
		// При переходе в локальную версию значение общей константы не наследуется:
		// локальная версия не может иметь тарифных ограничений
		Константы.УчетРегулярнойДеятельностиОпределяетсяТарифом.Установить(Ложь);
		ОбновитьПовторноИспользуемыеЗначения();
		УстановитьРазрешенУчетРегулярнойДеятельности(Истина);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриОбновленииДоступныхЛицензий(ИдентификаторУслуги) Экспорт
	
	// Непосредственно после загрузки данных в сервис информация о тарифах и лицензиях может отсутствовать
	// в области. Она будет будут загружена позже.
	// По мере загрузки следует обновить значения констант, которые могут зависеть от тарифов.
	
	Если ИдентификаторУслуги = ТарификацияБП.ИдентификаторУслугиРегулярнаяДеятельность() Тогда
		ОбновитьПовторноИспользуемыеЗначения(); // Исключаем выбор значения из кеша
		УстановитьРазрешенУчетРегулярнойДеятельности(Истина);
	КонецЕсли;
	
КонецПроцедуры

// Получает информацию о текущей подписке на тариф
//
// Возвращаемое значение:
//  Структура - описание текущего тарифа. Элементы структуры:
//  - Идентификатор - строка - иденитификатор тарифа
//  - СрокДействия - дата - дата окончания действия подписки на тариф
//
Функция ТекущийТариф() Экспорт
	
	Результат = Новый Структура;
	Результат.Вставить("Идентификатор", "");
	Результат.Вставить("СрокДействия", Дата(1,1,1));
	
	Попытка
		
		СписокПлатныхТарифов = СписокПлатныхТарифов();
		
		СписокТарифов = СписокАктивныхТарифов();
		
		Если СписокТарифов = ТекстОшибкиПодключения() Тогда
			Возврат Результат;
		КонецЕсли;
		
		ЧтениеJSON = Новый ЧтениеJSON;
		ЧтениеJSON.УстановитьСтроку(СписокТарифов);
		ИменаСвойствТипаДата = "beginDate, endDate";
		Данные = ПрочитатьJSON(ЧтениеJSON, Ложь, СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИменаСвойствТипаДата,,, Истина));
		ЧтениеJSON.Закрыть();
		
		АктивныеТарифы = Неопределено;
		Данные.Свойство("TariffList", АктивныеТарифы);
		Если ТипЗнч(АктивныеТарифы) <> Тип("Массив") Тогда
			Возврат Результат;
		КонецЕсли;
		
		ДатаОкончанияПлатногоТарифа = Дата(1,1,1);
		ДатаОкончанияБесплатногоТарифа = Дата(1,1,1);
		
		ИдентификаторПлатногоТарифа = "";
		ИдентификаторБесплатногоТарифа = "";
		
		Для каждого Тариф Из АктивныеТарифы Цикл
			
			Если ТипЗнч(Тариф) <> Тип("Структура") Тогда
				Продолжить;
			КонецЕсли;
			
			ДатаОкончания = Дата(1,1,1);
			Тариф.Свойство("endDate", ДатаОкончания);
			
			ИдентификаторТарифа = "";
			Тариф.Свойство("ID", ИдентификаторТарифа);
			
			Если СписокПлатныхТарифов.Найти(ИдентификаторТарифа) <> Неопределено Тогда // Это платный тариф
				Если ДатаОкончания > ДатаОкончанияПлатногоТарифа Тогда
					ДатаОкончанияПлатногоТарифа = ДатаОкончания;
					ИдентификаторПлатногоТарифа = ИдентификаторТарифа;
				КонецЕсли;
			Иначе
				Если ДатаОкончания > ДатаОкончанияБесплатногоТарифа Тогда
					ДатаОкончанияБесплатногоТарифа = ДатаОкончания;
					ИдентификаторБесплатногоТарифа = ИдентификаторТарифа;
				КонецЕсли;
			КонецЕсли;
			
		КонецЦикла;
		
		Если ЗначениеЗаполнено(ДатаОкончанияПлатногоТарифа) Тогда
			Результат.Идентификатор = ИдентификаторПлатногоТарифа;
			Результат.СрокДействия = ДатаОкончанияПлатногоТарифа;
		Иначе
			Результат.Идентификатор = ИдентификаторБесплатногоТарифа;
			Результат.СрокДействия = ДатаОкончанияБесплатногоТарифа;
		КонецЕсли;
		
		Возврат Результат;
		
	Исключение
		
		ИмяСобытия = НСтр("ru='Оплата сервиса.Ошибка получения текущего тарифа.'", ОбщегоНазначения.КодОсновногоЯзыка());
			
		Комментарий = ПодробноеПредставлениеОшибки(ИнформацияОбОшибке());
		
		ЗаписьЖурналаРегистрации(
			ИмяСобытия ,
			УровеньЖурналаРегистрации.Ошибка,,,
			Комментарий);
		
		Возврат Результат;
		
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции

// Получает идентификатор актуального тарифа.
// В случае, если в информационной базе имеется счет от поставщика на 
// оплату сервиса, актуальным считается тариф, указанный в счете.
// В противном случае актуальным считается текущий тариф.
// Для платных тарифов возращается идентификатор тарифа,
// а для тестовых - пустая строка.
//
// Возвращаемое значение:
//  Строка - идентификатор актуального тарифа, или пустая строка, если тариф тестовый.
//
Функция ИдентификаторАктуальногоТарифа() Экспорт
	
	Если СервисЭлектронныхТрудовыхКнижек.ИспользуетсяСервисЭлектронныхТрудовыхКнижек() Тогда
		// В сервисе ЭТК счета не выставляются
		АктуальныйТариф = "СервисЭлектронныхТрудовыхКнижек";
	ИначеЕсли Обработки.ОплатаСервисаБП.ЕстьВыставленныйСчетНаОплатуСервиса() Тогда
		УстановитьПривилегированныйРежим(Истина);
		АктуальныйТариф = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища("ОплатаСервиса",
			"НовыйТарифНаименование");
		УстановитьПривилегированныйРежим(Ложь);
	Иначе
		ИдентификаторТарифа = ТекущийТариф().Идентификатор;
		АктуальныйТариф = ?(СписокПлатныхТарифов().Найти(ИдентификаторТарифа) <> Неопределено,
			ИдентификаторТарифа,
			"");
	КонецЕсли;
	
	Возврат АктуальныйТариф;
	
КонецФункции

// Возвращает Истина, если в информационной базе есть неоплаченный счет поставщика
// на оплату сервиса.
//
// Возвращаемое значение:
//  Булево - признак наличия выставленного счета на оплату сервиса
//
Функция ЕстьВыставленныйСчетНаОплатуСервиса() Экспорт
	
	Возврат Обработки.ОплатаСервисаБП.ЕстьВыставленныйСчетНаОплатуСервиса();
	
КонецФункции

// Возвращает адрес страницы выбора тарифов
//
// Возвращаемое значение:
//  Строка - URI страницы выбора тарифов
//
Функция АдресСтраницыВыбораТарифов() Экспорт
	
	Возврат "https://" + Домен() + "/tarif-select/";
	
КонецФункции

// Возвращает адрес таблицы тарифов
//
// Возвращаемое значение:
//  Строка - URI таблицы тарифов
//
Функция АдресТаблицыТарифов() Экспорт
	
	Возврат "https://" + Домен() + "/tarif-select/tariffs.xml";
	
КонецФункции

// Обработчик подписки на событие ПроверкаИспользованияФункциональностиБезТарифа.
// Если используется функциональность, не входящая в тариф, будет вызвано исключение.
//	
Процедура ПроверкаИспользованияФункциональностиБезТарифаПередЗаписью(Источник, Отказ, РежимЗаписи, РежимПроведения) Экспорт
	
	Если РежимЗаписи <> РежимЗаписиДокумента.Проведение Тогда
		Возврат;
	КонецЕсли;
	
	Если ТарификацияБПВызовСервераПовтИсп.ИспользуетсяНедоступнаяФункциональность() Тогда
		Отказ = Истина;
		ВызватьИсключение НСтр("ru='В программе используется функциональность, не входящая в ваш тариф.
			|Возможность проведения документов заблокирована.'");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ИдентификаторыТарифныхОпций

Функция ИдентификаторУслугиРегулярнаяДеятельность() Экспорт
	Возврат "РегулярнаяДеятельность";
КонецФункции

Функция ИдентификаторУслуги1СОтчетность() Экспорт
	Возврат "1C-reporting-1";
КонецФункции

Функция ИдентификаторУслугиТолькоИнтерфейсИнтеграцииСБанком() Экспорт
	
	Возврат "ТолькоИнтерфейсИнтеграцииСБанком";
	
КонецФункции

Функция ИдентификаторУслугиОбособленныеПодразделения() Экспорт
	Возврат "ОбособленныеПодразделения";
КонецФункции

Функция ИдентификаторУслугиОбратноеНачислениеНДС() Экспорт
	Возврат "ОбратноеНачислениеНДС";
КонецФункции

Функция ИдентификаторУслугиРасширенныйФункционал() Экспорт
	Возврат "РасширенныйФункционал";
КонецФункции

Функция ИдентификаторУслугиВестиУчетПоОрганизациям() Экспорт
	Возврат "ВестиУчетПоОрганизациям";
КонецФункции

Функция ИдентификаторУслугиГособоронзаказ() Экспорт
	Возврат "Гособоронзаказ";
КонецФункции

Функция ИдентификаторУслугиУведомленияОКонтролируемыхСделках() Экспорт
	Возврат "УведомленияОКонтролируемыхСделках";
КонецФункции

Функция ИдентификаторУслугиУчетЗарплатыИКадровВоВнешнейПрограмме() Экспорт
	Возврат "УчетЗарплатыИКадровВоВнешнейПрограмме";
КонецФункции

Функция ИдентификаторУслугиБухгалтерскийУчет() Экспорт
	
	Возврат "БухгалтерскийУчет";
	
КонецФункции

Функция ИдентификаторУслугиКадровыйУчет() Экспорт
	
	Возврат "КадровыйУчет";
	
КонецФункции

Функция ИдентификаторУслугиНачинатьРаботуСоСравненияРежимовНалогообложения() Экспорт
	
	Возврат "НачинатьРаботуСоСравненияРежимовНалогообложения";
	
КонецФункции

Функция ИдентификаторУслугиСервисРегистрации() Экспорт
	
	Возврат "СервисРегистрации";
	
КонецФункции

Функция ИдентификаторУслугиКонсультацииБухОбслуживание() Экспорт
	
	Возврат "КонсультацииБухОбслуживание";
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьЗависимыеКонстантыРазрешенУчетРегулярнойДеятельности(Разрешен)
	//УчетКассовыхЧековПодотчетныхЛиц.УстановитьЗависимыеКонстантыРазрешенУчетРегулярнойДеятельности(Разрешен);
КонецПроцедуры

Функция ОграничениеКоличестваОбъектов()
	
	Если ТарификацияБПВызовСервераПовтИсп.РазрешенТолькоИнтерфейсЭлектронныхТрудовыхКнижек() Тогда
		Возврат 0;
	Иначе
		Возврат 50;
	КонецЕсли;
	
КонецФункции

Функция ЦветФонаОграниченнойФункциональности()
	
	Возврат Новый Цвет(240, 240, 240);
	
КонецФункции

Процедура ПроверитьОграничениеОбъекта(Объект, Отказ)
	
	Если Объект.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности() Тогда
		Возврат;
	КонецЕсли;
	
	Если Объект.ДополнительныеСвойства.Свойство("НеПроверятьОграничения") Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	КОЛИЧЕСТВО(ЖурналОпераций.Ссылка) КАК КоличествоОбъектов
	|ИЗ
	|	ЖурналДокументов.ЖурналОпераций КАК ЖурналОпераций
	|ГДЕ
	|	НЕ ЖурналОпераций.Ссылка ССЫЛКА Документ.РегламентнаяОперация";
	
	УстановитьПривилегированныйРежим(Истина);
	
	Выборка = Запрос.Выполнить().Выбрать();
	
	УстановитьПривилегированныйРежим(Ложь);
	
	СлагаемоеНовогоОбъекта = ?(ЗначениеЗаполнено(Объект.Ссылка), 0, 1);
	
	Если Выборка.Следующий()
		И Выборка.КоличествоОбъектов + СлагаемоеНовогоОбъекта > ОграничениеКоличестваОбъектов() Тогда
		
		СообщениеДляЖурналаРегистрации = Новый Структура;
		СообщениеДляЖурналаРегистрации.Вставить("ИмяСобытия",          СобытиеЖурналаРегистрацииСообщение());
		СообщениеДляЖурналаРегистрации.Вставить("Комментарий",         Строка(Объект));
		СообщениеДляЖурналаРегистрации.Вставить("ПредставлениеУровня", "Информация");
		СообщенияДляЖурналаРегистрации = Новый СписокЗначений;
		СообщенияДляЖурналаРегистрации.Добавить(СообщениеДляЖурналаРегистрации);
		ЖурналРегистрации.ЗаписатьСобытияВЖурналРегистрации(СообщенияДляЖурналаРегистрации);
		
		Отказ = Истина;
		ВызватьИсключение ТарификацияБПКлиентСервер.ПолучитьТекстПредупреждения(
			НСтр("ru='Достигнуто ограничение бесплатного тарифа.'"));
		
	КонецЕсли;
	
КонецПроцедуры

Процедура НаложитьОграничениеНаГруппуФормы(Форма, ИмяГруппы, СпособОграничения)
	
	Элементы = Форма.Элементы;
	
	Элемент = Элементы[ИмяГруппы];
	
	Для каждого ПодчиненныйЭлемент Из Элемент.ПодчиненныеЭлементы Цикл
		Если ТипЗнч(ПодчиненныйЭлемент) = Тип("ГруппаФормы") Тогда
			ПодчиненныйЭлемент[СпособОграничения] = ?(СпособОграничения = "ТолькоПросмотр", Истина, Ложь);
		КонецЕсли;
	КонецЦикла;
	Элемент.ЦветФона = ЦветФонаОграниченнойФункциональности();
	
	ТекстПредупреждения = НСтр("ru='Эти возможности доступны на платном тарифе.'");
	ВставитьДекорациюПредупреждения(Элементы, "ОграничениеТарифа", Элемент, ТекстПредупреждения);
	
КонецПроцедуры

Процедура ВставитьДекорациюПредупреждения(Элементы, ИмяЭлемента, Родитель, ТекстПредупреждения)
	
	Декорация =  Элементы.Найти(ИмяЭлемента);
	Если Элементы.Найти(ИмяЭлемента) = Неопределено Тогда
		
		// Декорация вставляется всегда перед первым элементом.
		Если Родитель.ПодчиненныеЭлементы.Количество() > 0 Тогда
			ПервыйЭлементРодителя = Родитель.ПодчиненныеЭлементы[0];
		Иначе
			ПервыйЭлементРодителя = Неопределено;
		КонецЕсли;
		
		Декорация = Элементы.Вставить(
			ИмяЭлемента,
			Тип("ДекорацияФормы"),
			Родитель,
			ПервыйЭлементРодителя);
			
	КонецЕсли;
	
	Декорация.Заголовок = ТарификацияБПКлиентСервер.ПолучитьТекстПредупреждения(ТекстПредупреждения);
	Декорация.АвтоМаксимальнаяШирина = Ложь;
	Декорация.РастягиватьПоГоризонтали = Истина;
	
КонецПроцедуры

Функция СобытиеЖурналаРегистрацииСообщение()
	
	КодЯзыка = ОбщегоНазначения.КодОсновногоЯзыка();
	ШаблонТекста = НСтр("ru='%1.Достигнуто ограничение по количеству объектов'", КодЯзыка);
	Возврат СтрШаблон(ШаблонТекста, ТарификацияБПКлиентСервер.ГруппаСобытийЖурналаРегистрации());
	
КонецФункции

Функция Домен()
	
	Возврат ?(ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности(),
		"1cbiz.ru",
		"1cnul.ru");
	
КонецФункции

#КонецОбласти

#Область ПереходНаПлатныйТариф

Процедура ПолучитьКонтактныйТелефонВФоне(СтруктураПараметров, АдресРезультата = Неопределено) Экспорт
	
	СтруктураРезультата = Новый Структура;
	СтруктураРезультата.Вставить("Результат");
	СтруктураРезультата.Вставить("Телефон", "");
	
	Прокси = ПроксиВебСервиса();
	
	КлючОбласти = Константы.КлючОбластиДанных.Получить();
	РазделительСеанса = РаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	
	Телефон = "";
	Результат = Неопределено;
	
	Попытка
		Результат = Прокси.GetContactPhone(РазделительСеанса, КлючОбласти, Телефон);
	Исключение
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		ЗаписьЖурналаРегистрации(
			ИмяСобытияЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
	КонецПопытки;
	
	СтруктураРезультата.Телефон   = Телефон;
	СтруктураРезультата.Результат = Результат;
	ПоместитьВоВременноеХранилище(СтруктураРезультата, АдресРезультата);
	
КонецПроцедуры

Процедура ЗапросНаСменуТарифа(ПараметрыЗапроса, АдресРезультата = Неопределено) Экспорт
	
	Прокси = ПроксиВебСервиса();
	
	РазделительСеанса = РаботаВМоделиСервиса.ЗначениеРазделителяСеанса();
	КлючОбласти = Константы.КлючОбластиДанных.Получить();
	
	Попытка
		
		Результат = Прокси.SwitchTariffReq(
			РазделительСеанса,
			КлючОбласти,
			ПараметрыЗапроса.Телефон,
			ПараметрыЗапроса.ИНН
			);
		
	Исключение
		
		ИнформацияОбОшибке = ИнформацияОбОшибке();
		ЗаписьЖурналаРегистрации(
			ИмяСобытияЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Ошибка,,,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке));
		
	КонецПопытки;
	
КонецПроцедуры

Функция ИмяСобытияЖурналаРегистрации()
	
	Возврат НСтр("ru = 'ТарификацияБП'", ОбщегоНазначения.КодОсновногоЯзыка());
	
КонецФункции

Функция ПроксиВебСервиса()
	
	Адрес        = РаботаВМоделиСервиса.ВнутреннийАдресМенеджераСервиса() + "/ws/PrivateAPI?wsdl";
	Пользователь = РаботаВМоделиСервиса.ИмяСлужебногоПользователяМенеджераСервиса();
	Пароль       = РаботаВМоделиСервиса.ПарольСлужебногоПользователяМенеджераСервиса();
	
	Определения             = Новый WSОпределения(Адрес, Пользователь, Пароль);
	ПространствоИменСервиса = "http://www.1c.ru/1cFresh/PrivateAPI/1.0";
	Прокси                  = Новый WSПрокси(Определения, ПространствоИменСервиса, "PrivateAPI", "PrivateAPISoap");
	Прокси.Пользователь     = Пользователь;
	Прокси.Пароль           = Пароль;
	Возврат Прокси;
	
КонецФункции

#КонецОбласти

#Область ТекущийТариф

Функция СписокПлатныхТарифов()
	
	Результат = Новый Массив;
	
	СтруктураURI = ОбщегоНазначенияКлиентСервер.СтруктураURI(АдресТаблицыТарифов());
	ЗащищенноеСоединение = ?(Нрег(СтруктураURI.Схема) = "https", Новый ЗащищенноеСоединениеOpenSSL, Неопределено);
	Соединение = Новый HTTPСоединение(СтруктураURI.ИмяСервера,,,,,, ЗащищенноеСоединение);
	РезультатЗапроса = Соединение.Получить(Новый HTTPЗапрос(СтруктураURI.ПутьНаСервере)).ПолучитьТелоКакСтроку();
	
	ТаблицаТарифов = ОбщегоНазначения.ПрочитатьXMLВТаблицу(РезультатЗапроса).Данные;
	
	Для каждого Тариф Из ТаблицаТарифов Цикл
		Результат.Добавить(Тариф.Идентификатор);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

Функция СписокАктивныхТарифов()
	
	Если НЕ ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаВМоделиСервиса") Тогда
		Возврат ТекстОшибкиПодключения();
	КонецЕсли;
	
	МодульРаботаВМоделиСервиса = ОбщегоНазначения.ОбщийМодуль("РаботаВМоделиСервиса");
	
	УстановитьПривилегированныйРежим(Истина);
	URL = URLВнешнегоAPIСистемыТарификации();
	СлужебныйПользователь = СлужебныйПользовательМенеджераСервиса();
	ИмяПользователя = СлужебныйПользователь.ИмяПользователя;
	ПарольПользователя = СлужебныйПользователь.Пароль;
	ОбластьДанныхСтрокой = Строка(Формат(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса(), "ЧН=0; ЧГ=0"));
	КлючОбластиДанных = Константы.КлючОбластиДанных.Получить();
	УстановитьПривилегированныйРежим(Ложь);
	
	СтруктураURI = ОбщегоНазначенияКлиентСервер.СтруктураURI(URL);
	
	ЗащищенноеСоединение = ?(ВРег(СтруктураURI.Схема) = "HTTPS", Новый ЗащищенноеСоединениеOpenSSL, Неопределено);
	
	HTTPСоединение = Новый HTTPСоединение(СтруктураURI.Хост, СтруктураURI.Порт, ИмяПользователя, ПарольПользователя,, 10, ЗащищенноеСоединение);
	
	ОД_Параметр = "Zone";
	ОД_Значение = ОбластьДанныхСтрокой;
	Ключ_Параметр = "ZoneKey";
	Ключ_Значение = КлючОбластиДанных;
	
	URLМетода = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку("%1?%2=%3&%4=%5&GetFuture=true",
		СтруктураURI.ПутьНаСервере,
		ОД_Параметр,
		ОД_Значение,
		Ключ_Параметр,
		Ключ_Значение);
	Ответ = HTTPСоединение.ВызватьHTTPМетод("GET", Новый HTTPЗапрос(URLМетода));
	
	Возврат Ответ.ПолучитьТелоКакСтроку();
	
КонецФункции

Функция URLВнешнегоAPIСистемыТарификации()
	
	URL = ВнутреннийАдресМенеджераСервиса() + "/hs/ApplicationTariffControl_1_0_1_1/Tariffes";
	
	Возврат URL;
	
КонецФункции

Функция ТекстОшибкиПодключения()
	
	Возврат(НСтр("ru='Невозможно подключиться к Менеджеру сервиса.'"));
	
КонецФункции

Функция ВнутреннийАдресМенеджераСервиса()
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = РаботаВМоделиСервиса.ВнутреннийАдресМенеджераСервиса();
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции

Функция СлужебныйПользовательМенеджераСервиса()
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища("УдаленныйДоступПолучениеСоответствийТарифов",
		"ИмяПользователя,Пароль", Истина);
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#Область Тарификация

Функция ЗарегистрированаЛицензияБезлимитнойУслуги(ИдентификаторУслуги) Экспорт
	
	ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
	Возврат Тарификация.ЗарегистрированаЛицензияБезлимитнойУслуги(ПоставщикУслуг, ИдентификаторУслуги);
	
КонецФункции

Функция ЗарегистрированаЛицензияБезлимитнойНегативнойУслуги(ИдентификаторУслуги) Экспорт
	
	// Для "позитивной" услуги (т.е. услуга, которая разрешает что-то, если она доступна у пользователя),
	// если она не тарифицируется в менедежере сервиса, то считается, что услуга доступна.
	// См.Тарификация.ЗарегистрированаЛицензияБезлимитнойУслуги.
	// Т.е. если "позитивная" услуга не тарифицируется, то считается, что она есть у всех пользователей.
	// Для "негативной" услуги (т.е. услуга, которая запрещает что-то, если она доступна у пользователя)
	// если она не тарифицируется, то нужно считать, что услуги нет и ничего не запрещать.
	// Т.к. БТС такое поведение не поддерживает, то нужно проверить тарифицируемость услуги самостоятельно,
	// и вернуть Ложь, если услуга не тарифицируется.
	
	ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
	Услуга = Тарификация.УслугаПоИдентификаторуИИдентификаторуПоставщика(ИдентификаторУслуги, ПоставщикУслуг, Ложь);
	Если Услуга = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	УслугаТарифицируется = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Услуга, "Тарифицируется");
	Если Не УслугаТарифицируется Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Тарификация.ЗарегистрированаЛицензияБезлимитнойУслуги(ПоставщикУслуг, ИдентификаторУслуги);
	
КонецФункции

Функция ИдентификаторПоставщикаУслугБухгалтерияПредприятия()
	
	Возврат "БухгалтерияПредприятия";
	
КонецФункции

Функция КоличествоЛицензийУслугиФункциональности(ИдентификаторУслуги) Экспорт
	
	Попытка
		ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
		Возврат Тарификация.КоличествоЛицензийУникальнойУслуги(ПоставщикУслуг, ИдентификаторУслуги);
	Исключение
		// Записывать ошибку в журнал не требуется, она и так записывается в Тарификация.КоличествоЛицензийУникальнойУслуги.
		Возврат Неопределено;
	КонецПопытки;
	
КонецФункции

Функция ЗарегистрированаЛицензияУслугиФункциональности(ИдентификаторУслуги) Экспорт
	
	ИмяЛицензии = Формат(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса(), "ЧГ=0");
	ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
	Возврат Тарификация.ЗарегистрированаЛицензияУникальнойУслуги(ПоставщикУслуг, ИдентификаторУслуги, ИмяЛицензии);
	
КонецФункции

Функция ЗанятьЛицензиюУслугиФункциональности(ИдентификаторУслуги, УникальныйИдентификаторОперации) Экспорт
	
	ИмяЛицензии = Формат(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса(), "ЧГ=0");
	ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
	Возврат Тарификация.ЗанятьЛицензиюУникальнойУслуги(ПоставщикУслуг, ИдентификаторУслуги, ИмяЛицензии, УникальныйИдентификаторОперации);
	
КонецФункции

Функция ОсвободитьЛицензиюУслугиФункциональности(ИдентификаторУслуги, УникальныйИдентификаторОперации) Экспорт
	
	ИмяЛицензии = Формат(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса(), "ЧГ=0");
	ПоставщикУслуг = ИдентификаторПоставщикаУслугБухгалтерияПредприятия();
	Возврат Тарификация.ОсвободитьЛицензиюУникальнойУслуги(ПоставщикУслуг, ИдентификаторУслуги, ИмяЛицензии, УникальныйИдентификаторОперации);
	
КонецФункции

#КонецОбласти

#Область ТарификацияФункциональности

Функция ФункциональностьОграничиваетсяТарифом() Экспорт
	
	Если РаботаВМоделиСервиса.РазделениеВключено()
		Или ОбщегоНазначения.РежимОтладки() Тогда
		
		Возврат Константы.ФункциональностьОграничиваетсяТарифом.Получить();
		
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

#КонецОбласти