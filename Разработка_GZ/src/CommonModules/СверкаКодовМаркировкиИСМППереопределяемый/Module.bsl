
#Область СлужебныйПрограммныйИнтерфейс

// Определяет соответствие проверяемому типу документа, результат возвращает через второй параметр.
//
// Параметры:
//  Контекст        - ФормаКлиентскогоПриложения, ДокументСсылка - Контекст для определения типа документа
//  ЭтоКорректировка - Булево - исходящий признак соответствия документа типу «Корректировка приобретения».
Процедура ЭтоДокументКорректировкаПриобретения(Контекст, ЭтоКорректировка) Экспорт
	
	
КонецПроцедуры

// Определяет соответствие вида корректировки хозяйственной операции "Корректировка по согласовнию",
// результат возвращает через второй параметр.
//
// Параметры:
//  Контекст - ДокументСсылка - Контекст для определения типа документа.
//  ЭтоКорректировкаПоСогласованиюСторон - Булево - исходящий признак соответствия вида хозяйственной операции значению "Корректировка по согласованию сторон".
Процедура ЭтоКорректировкаПриобретенияПоСогласованию(Контекст, ЭтоКорректировкаПоСогласованиюСторон) Экспорт
	
	
КонецПроцедуры

// Заполняет таблицу товаров, принятых без расхождений, при загрузке данных формы результатов сверки по кодам маркировки.
// Товары, принятые без расхождений, определяются как товары документа основания, данных по которым нет в массиве номенклатуры,
// полученном по ЭДО (из акта или корректировочного документа), соотвествующие отбору по видам продукции.
// 
// Параметры:
//  ДокументОснование - ДокументСсылка - документ основание, с которым производится сверка кодов из входящего электронного документа.
//  НоменклатураПоДаннымЭДО - Массив - массив из ОпределяемыйТип.Номенклатура, полученный из входящего электронного документа.
//  ВидыМаркируемойПродукции - Массив, ПеречислениеСсылка.ВидыПродукцииИС - виды маркируемой продукции документа основания, которую необходимо получить.
//  ТаблицаПродукции - ТаблицаЗначений - таблица продукции для заполнения. Колонки:
//  * Номенклатура - ОпределяемыйТип.Номенклатура - номенклатура.
//
Процедура ПриОпеределенииТаблицыПродукцииПринятойБезРасхождений(ДокументОснование, НоменклатураПоДаннымЭДО, ВидыМаркируемойПродукции, ТаблицаПродукции) Экспорт
	
	
КонецПроцедуры

// Реализовать заполнение в переданной таблице данные из документа по значениям штрихкодов в разрезе продукции.
// Используется для получения данных по документу, содержащему расхождения кодов маркировки (акты о расхождениях).
// 
// Параметры:
// ДокументСсылка - ДокументСсылка - ссылка на документ.
// ТаблицаТоваровЗначенийШтрихкодов - См. СверкаКодовМаркировкиИСМП.ИнициализироватьТаблицуТоваровЗначенийШтрихкодов.
//
Процедура ПриЗаполненииЗначенияШтрихкодовПродукцииПоДокументу(ДокументСсылка, ТаблицаТоваровЗначенийШтрихкодов) Экспорт
	
	
КонецПроцедуры

#Область ПараметрыИнтеграцииФормыПроверкиИПодбора

// Заполняет специфику интеграции формы сверки кодов маркировки в конкретную форму.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма для которой настраиваются параметры интеграции.
//  ПараметрыИнтеграции - (См. СверкаКодовМаркировкиИСМП.ПараметрыИнтеграцииФормыСверкиКодовМаркировки).
//
Процедура ПриОпределенииПараметровИнтеграцииФормыСверкиПоКодамМаркировки(Форма, ПараметрыИнтеграции) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределение параметров интеграции команды открытия формы результатов сверки кодов маркировки в документе Корректировка Приобретения
// (расположения форматированной строки перехода к результатам сверки, если полученный корректировочный документ
// отличается от отправленного акта о расхождениях).
//
// Параметры:
//   Форма            - ФормаКлиентскогоПриложения - прикладная форма для встраивания форматированной строки
//   ПараметрыНадписи - Структура        - (см. СобытияФормИСМП.ПараметрыИнтеграцииГиперссылкиИСМП)
//
Процедура ПриОпределенииПараметровИнтеграцииГиперссылкиСостояниеОбменаИСМП(Форма, ПараметрыНадписи) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

// Получает виды маркируемой продукции по товарам, содержащимся в документе.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка - документ, виды маркируемой продукции которого необходимо получить.
//  ВидыПродукции - Массив - Массив видов продукции.
Процедура ПриОпределенииВидовПродукцииДокумента(Знач ДокументСсылка, ВидыПродукции) Экспорт
	
	Если ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.КорректировкаПоступления")
		ИЛИ ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.АктОРасхождениях")
		ИЛИ ТипЗнч(ДокументСсылка) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") Тогда
		
		Запрос = Новый Запрос;
		Запрос.УстановитьПараметр("ДокументСсылка",   ДокументСсылка);
		Запрос.УстановитьПараметр("ФильтрВидПродукции", ИнтеграцияИСКлиентСервер.ВидыПродукцииИСМП(Истина));

		Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ РАЗЛИЧНЫЕ
		|	ВЫБОР
		|		КОГДА ТоварыНакладной.Номенклатура.ТабачнаяПродукция
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Табак)
		|		КОГДА ТоварыНакладной.Номенклатура.ОбувнаяПродукция
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Обувь)
		|		КОГДА ТоварыНакладной.Номенклатура.ЛегкаяПромышленность
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность)
		|		КОГДА ТоварыНакладной.Номенклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС)
		|		КОГДА ТоварыНакладной.Номенклатура.МолочнаяПродукцияБезВЕТИС
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукцияБезВЕТИС)
		|		КОГДА ТоварыНакладной.Номенклатура.Шины
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Шины)
		|		КОГДА ТоварыНакладной.Номенклатура.АльтернативныйТабак
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.АльтернативныйТабак)
		|		КОГДА ТоварыНакладной.Номенклатура.УпакованнаяВода
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.УпакованнаяВода)
		|		КОГДА ТоварыНакладной.Номенклатура.Фотоаппараты
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Фотоаппараты)
		|		КОГДА ТоварыНакладной.Номенклатура.Духи
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Духи)
		|		КОГДА ТоварыНакладной.Номенклатура.Велосипеды
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Велосипеды)
		|		КОГДА ТоварыНакладной.Номенклатура.КреслаКоляски
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.КреслаКоляски)
		|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ПустаяСсылка)
		|	КОНЕЦ КАК ВидПродукции
		|ИЗ
		|	Документ.ПоступлениеТоваровУслуг.Товары КАК ТоварыНакладной
		|ГДЕ
		|	ТоварыНакладной.Ссылка = &ДокументСсылка
		|	И ВЫБОР
		|		КОГДА ТоварыНакладной.Номенклатура.ТабачнаяПродукция
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Табак)
		|		КОГДА ТоварыНакладной.Номенклатура.ОбувнаяПродукция
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Обувь)
		|		КОГДА ТоварыНакладной.Номенклатура.ЛегкаяПромышленность
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ЛегкаяПромышленность)
		|		КОГДА ТоварыНакладной.Номенклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукцияПодконтрольнаяВЕТИС)
		|		КОГДА ТоварыНакладной.Номенклатура.МолочнаяПродукцияБезВЕТИС
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.МолочнаяПродукцияБезВЕТИС)
		|		КОГДА ТоварыНакладной.Номенклатура.Шины
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Шины)
		|		КОГДА ТоварыНакладной.Номенклатура.АльтернативныйТабак
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.АльтернативныйТабак)
		|		КОГДА ТоварыНакладной.Номенклатура.УпакованнаяВода
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.УпакованнаяВода)
		|		КОГДА ТоварыНакладной.Номенклатура.Фотоаппараты
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Фотоаппараты)
		|		КОГДА ТоварыНакладной.Номенклатура.Духи
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Духи)
		|		КОГДА ТоварыНакладной.Номенклатура.Велосипеды
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.Велосипеды)
		|		КОГДА ТоварыНакладной.Номенклатура.КреслаКоляски
		|			ТОГДА ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.КреслаКоляски)
		|		ИНАЧЕ ЗНАЧЕНИЕ(Перечисление.ВидыПродукцииИС.ПустаяСсылка)
		|	КОНЕЦ В (&ФильтрВидПродукции)";
		
		ВидыПродукции = Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("ВидПродукции");
	КонецЕсли;
	
КонецПроцедуры

// Заполняет переданную таблицу товарами переданного документа с указанием вида продукции.
// 
// Параметры:
//  ДокументСсылка - ДокументСсылка - документ, виды маркируемой продукции которого необходимо получить.
//  ТаблицаМаркируемойПродукции - ТаблицаЗначений - См. СверкаКодовМаркировкиИСМП.НоваяТаблицаМаркируемойПродукции
Процедура ПриОпределенииМаркируемойПродукцииДокумента(Знач ДокументСсылка, ТаблицаМаркируемойПродукции) Экспорт
	
	
КонецПроцедуры

// Предназначена для реализации функциональности проверки, обработаны или нет расхождения по кодам маркировки в документе пользователем.
// Возвращает истина, если требуется обработка (в табличной части расхождений вариант действий не заполнен (реквизит табличной части "Признан")).
// 
// Параметры:
//  ДокументОбъект - ДокументОбъект - документ объект, в котором необходимо проверить обработку пользователем варинатов действий по расхождениям.
//  ПараметрыИнтеграции - Структура - (см. СобытияФормИСМП.ПараметрыИнтеграцииГиперссылкиИСМП)
//  ТребуетсяОбработка - Булево - Истина, если колонка "Признан" в табличной части расхождений не заполнена.
//
Процедура ПриОпределенииНеобходимостиОбработкиКодовМаркировкиВДокументе(ДокументОбъект, ПараметрыИнтеграции, ТребуетсяОбработка) Экспорт
	
	
КонецПроцедуры

// Предназначена для реализации функциональности по отражению результатов сверки кодов маркировки в документе, из которого была вызвана соответствующая форма.
// Вызывается при сохранении действий пользователя при анализе расхождений отправленного УПД и ТОРГ-2 в документе акт о расхождениях.
// 
// Параметры:
//  ПараметрыОкончанияСверки - (См. СверкаКодовМаркировкиИСМП.ЗафиксироватьРезультатСверки).
Процедура ОтразитьРезультатыСверкиВДокументе(ПараметрыОкончанияСверки) Экспорт
	
	
КонецПроцедуры

// Предназначена для реализации заполнения данных колонки по расхождениям кодов маркировки в переданной коллекции.
//
// Параметры:
//  Товары - ДанныеФормыКоллекция, ТаблицаЗначений - Таблица, в которой необходимо заполнить реквизиты. Обязательные колонки:
//    * Номенклатура - ОпределяемыйТип.Номенклатура - номенклатура
//    * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - характеристика номенклатуры
//    * ИмяКолонкиЗаполнения - ФорматированнаяСтрока - колонка для заполнения данных о расхождениях. Имя определяется в 3м параметре процедуры.
//  ДанныеПоРасхождениям - ДанныеФормыКоллекция, ТаблицаЗначений - Таблица, содержащая данные по расхождениям.
//    * Номенклатура - ОпределяемыйТип.Номенклатура - номенклатура.
//    * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - характеристика номенклатуры.
//    * ТипРасхождения - ОпределяемыйТип.ТипРасхожденияИСМП - тип расхождения кодов маркировки.
//    * Количество - Число - количество единиц.
//    * Признан - ОпределяемыйТип.ВариантДействийПоРасхождениямКодовМаркировкиИСМП - Обязательная колонка, если 4й параметр Истина. Вариант действия для строки расхождения.
//  ИмяКолонкиЗаполнения - Строка - Имя колонки для заполнения данных о расхождениях.
//  ДоступноСогласованиеРасхождений  -Булево - Истина, если заполняются данные в документе, загруженном по  данным ЭДО ТОРГ-2.
// 
Процедура ЗаполнитьКолонкуРасхожденияПоКодамМаркировки(Товары, ДанныеПоРасхождениям,
													   ИмяКолонкиЗаполнения, ДоступноСогласованиеРасхождений) Экспорт
	
	
КонецПроцедуры

// Предназначена для определения документа основания для документа, переданного в параметре.
// Коды маркировки, полученные из документа основания, будут использоваться для построения исходного дерева упаковок в форме сравнения кодов маркировки.
//
// Параметры:
//  ДокументСсылка - ДокументСсылка - ссылка на документ, из формы которого открывается форма результатов сверки кодов маркировки.
//  ДокументОснование - ДокументСсылка, Неопределено - ссылка на документ-основание, Неопределено - если документ основание не найден.
Процедура ПриОпределенииДокументОснованиеСверкиКодов(ДокументСсылка, ДокументОснование) Экспорт
	
	
КонецПроцедуры

// Предназначена для реализации заполнения текста надписи команды открытия формы результатов сверки кодов маркировки в документе корректировка приобретения.
// Текст должен содержать информацию для пользователя о наличии расхождений. Если расхождений с актом о расхождениях нет - возвращать пустую строку. 
// Параметры:
//  ДокументСсылка - ДокументСсылка - ссылка на документ.
//  ТекстНадписи - Строка - строка для переопределения, содержащая информацию о наличии расхождений между полученным корректировочным документом и данными акта о расхождениях после приемки.
//
Процедура ПриОпределенииТекстаНадписиПоляРасхожденияПоРезультатамСверкиКодовМаркировкиИСМП(Знач ДокументСсылка, ТекстНадписи) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
