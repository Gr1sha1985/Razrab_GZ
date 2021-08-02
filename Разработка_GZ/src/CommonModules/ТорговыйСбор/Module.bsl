
#Область СлужебныйПрограммныйИнтерфейс

Функция СуммаТорговогоСбора(Организация, ДатаНачалаПериода, ДатаОкончанияПериода) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("ДатаНачалаПериода", ДатаНачалаПериода);
	Запрос.УстановитьПараметр("ДатаОкончанияПериода", ДатаОкончанияПериода);
	Запрос.УстановитьПараметр("Организация", ОбщегоНазначенияБПВызовСервераПовтИсп.ВсяОрганизация(Организация));
	Запрос.УстановитьПараметр("ВидОперацииСнятиеСУчета", Перечисления.ВидыОперацийТорговыеТочки.СнятиеСУчета);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка КАК ТорговаяТочка,
	|	ПараметрыТорговыхТочекСрезПоследних.СуммаСбора КАК СуммаСбора
	|ПОМЕСТИТЬ ПараметрыТорговыхТочекНаНачалоПериода
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(&ДатаНачалаПериода, Организация В (&Организация)) КАК ПараметрыТорговыхТочекСрезПоследних
	|ГДЕ
	|	ПараметрыТорговыхТочекСрезПоследних.ВидОперации <> &ВидОперацииСнятиеСУчета
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТорговаяТочка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПараметрыТорговыхТочекСрезПоследних.Организация,
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка,
	|	ПараметрыТорговыхТочекСрезПоследних.КодПоОКТМО,
	|	РегистрацииВНалоговомОргане.Код КАК КодНалоговогоОргана,
	|	ПараметрыТорговыхТочекСрезПоследних.ПодразделениеОрганизации,
	|	ПараметрыТорговыхТочекСрезПоследних.ПодразделениеОрганизации.Владелец КАК ВладелецПодразделения
	|ПОМЕСТИТЬ ПараметрыТорговыхТочекНаКонецПериода
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(&ДатаОкончанияПериода, Организация В (&Организация)) КАК ПараметрыТорговыхТочекСрезПоследних
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.РегистрацииВНалоговомОргане КАК РегистрацииВНалоговомОргане
	|		ПО ПараметрыТорговыхТочекСрезПоследних.НалоговыйОрган = РегистрацииВНалоговомОргане.Ссылка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка,
	|	ПараметрыТорговыхТочекСрезПоследних.Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	РегистрацииВНалоговомОргане.Код КАК КодНалоговогоОргана,
	|	ИсторияРегистрацийВНалоговомОрганеСрезПоследних.СтруктурнаяЕдиница КАК Организация
	|ПОМЕСТИТЬ ОсновнаяРегистрацияВНалоговомОргане
	|ИЗ
	|	РегистрСведений.ИсторияРегистрацийВНалоговомОргане.СрезПоследних(&ДатаОкончанияПериода, СтруктурнаяЕдиница В (&Организация)) КАК ИсторияРегистрацийВНалоговомОрганеСрезПоследних
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.РегистрацииВНалоговомОргане КАК РегистрацииВНалоговомОргане
	|		ПО ИсторияРегистрацийВНалоговомОрганеСрезПоследних.РегистрацияВНалоговомОргане = РегистрацииВНалоговомОргане.Ссылка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ПараметрыТорговыхТочекНаНачалоПериода.ТорговаяТочка КАК ТорговаяТочка,
	|	ПараметрыТорговыхТочекНаНачалоПериода.СуммаСбора КАК Сумма
	|ПОМЕСТИТЬ ДействующиеТорговыеТочки
	|ИЗ
	|	ПараметрыТорговыхТочекНаНачалоПериода КАК ПараметрыТорговыхТочекНаНачалоПериода
	|ГДЕ
	|	НЕ ПараметрыТорговыхТочекНаНачалоПериода.ТорговаяТочка.ПометкаУдаления
	|
	|ОБЪЕДИНИТЬ
	|
	|ВЫБРАТЬ
	|	ПараметрыТорговыхТочек.ТорговаяТочка,
	|	ПараметрыТорговыхТочек.СуммаСбора
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек КАК ПараметрыТорговыхТочек
	|ГДЕ
	|	ПараметрыТорговыхТочек.Период МЕЖДУ &ДатаНачалаПериода И &ДатаОкончанияПериода
	|	И ПараметрыТорговыхТочек.Организация В(&Организация)
	|	И (ПараметрыТорговыхТочек.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.Регистрация)
	|		ИЛИ ПараметрыТорговыхТочек.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.ИзменениеПараметров))
	|	И НЕ ПараметрыТорговыхТочек.ТорговаяТочка.ПометкаУдаления
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТорговаяТочка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДействующиеТорговыеТочки.ТорговаяТочка КАК ТорговаяТочка,
	|	МАКСИМУМ(ДействующиеТорговыеТочки.Сумма) КАК Сумма
	|ПОМЕСТИТЬ СуммаСбораПоТорговымТочкам
	|ИЗ
	|	ДействующиеТорговыеТочки КАК ДействующиеТорговыеТочки
	|
	|СГРУППИРОВАТЬ ПО
	|	ДействующиеТорговыеТочки.ТорговаяТочка
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	ТорговаяТочка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	&ДатаОкончанияПериода КАК Период,
	|	СуммаСбораПоТорговымТочкам.ТорговаяТочка,
	|	ЕСТЬNULL(ПараметрыТорговыхТочекНаКонецПериода.КодНалоговогоОргана, ОсновнаяРегистрацияВНалоговомОргане.КодНалоговогоОргана) КАК КодНалоговогоОргана,
	|	ЕСТЬNULL(ПараметрыТорговыхТочекНаКонецПериода.КодПоОКТМО, """") КАК ОКАТО,
	|	СуммаСбораПоТорговымТочкам.Сумма КАК Сумма,
	|	ПараметрыТорговыхТочекНаКонецПериода.ПодразделениеОрганизации,
	|	ПараметрыТорговыхТочекНаКонецПериода.ВладелецПодразделения
	|ИЗ
	|	СуммаСбораПоТорговымТочкам КАК СуммаСбораПоТорговымТочкам
	|		ЛЕВОЕ СОЕДИНЕНИЕ ПараметрыТорговыхТочекНаКонецПериода КАК ПараметрыТорговыхТочекНаКонецПериода
	|			ЛЕВОЕ СОЕДИНЕНИЕ ОсновнаяРегистрацияВНалоговомОргане КАК ОсновнаяРегистрацияВНалоговомОргане
	|			ПО ПараметрыТорговыхТочекНаКонецПериода.Организация = ОсновнаяРегистрацияВНалоговомОргане.Организация
	|		ПО СуммаСбораПоТорговымТочкам.ТорговаяТочка = ПараметрыТорговыхТочекНаКонецПериода.ТорговаяТочка";
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Формирует таблицу льгот из поставляемых данных.
//
// Возвращаемое значение:
//  ТаблицаЗначений - данные льгот. Колонки таблицы:
//    * ДействуетС - Дата - Дата введения льготы.
//    * ДействуетПо - Дата - Дата окончания действия льготы.
//    * Регион - Строка (2) - Код региона из кода ОКТМО (два левых символа).
//    * ТипТорговойТочки - ПеречислениеСсылка.ТипыТорговыхТочек - тип торговой точки.
//    * Наименование - Строка (100) - Наименование льготы.
//    * КодНалоговойЛьготы - Строка (12) - Код налоговой льготы сформированный в соответствии с правилами
//                                         заполнения формы ТС-1.
//
Функция ПрочитатьТаблицуЛьгот() Экспорт

	Возврат ТаблицаЛьгот();
	
КонецФункции

// Формирует таблицу территорий на которых осуществление торговой деятельности облагается торговым сбором.
//
// Возвращаемое значение:
//  ТаблицаЗначений - данные льгот. Колонки таблицы:
//    * ОКТМО - Строка (11)- Код по ОКТМО муниципального образования.
//    * Территория - СправочникСсылка.ТерриторииОсуществленияТорговойДеятельности - Категория территории согласно
//        закону №62 от 17 декабря 2014 г.Москва.
//
Функция ПрочитатьТаблицуТерриторий() Экспорт
	
	МакетТерриторий = РегистрыСведений.ПараметрыТорговыхТочек.ПолучитьМакет("ТерриторииОсуществленияТорговойДеятельности");
	СтрокаXML = МакетТерриторий.ПолучитьТекст();
	ТаблицаТерриторий = ОбщегоНазначения.ЗначениеИзСтрокиXML(СтрокаXML);
	
	Возврат ТаблицаТерриторий;
	
КонецФункции

// Формирует таблицу льгот из поставляемых данных.
//
// Возвращаемое значение:
//  ТаблицаЗначений - данные льгот. Колонки таблицы:
//    * ДействуетС - Дата - Дата начала действия ставки.
//    * ДействуетПо - Дата - Дата окончания действия ставки.
//    * ВидТорговойДеятельности - ПеречислениеСсылка.ВидыТорговойДеятельностиОблагаемыеСбором
//        - Вид торговой деятельности облагаемый сбором.
//    * Территория - СправочникСсылка.ТерриторииОсуществленияТорговойДеятельности - Категория территории согласно
//        закону №62 от 17 декабря 2014 г.Москва.
//    * СтавкаДо50м2 - Число (8) - Ставка сбора за торговые точки площадью до 50 м.кв. (для торговых точек с торговым залом) или 
//        объект (для точек без торгового зала).
//    * СтавкаСвыше50м2 - Число (8) - Ставка сбора за каждый квадратный метр торговый точки превышающий 50 кв.м.
//        (для точек с торговым залом).
//
Функция ПрочитатьТаблицуСтавок() Экспорт
	
	МакетСтавок = РегистрыСведений.ПараметрыТорговыхТочек.ПолучитьМакет("СтавкиТорговогоСбора");
	СтрокаXML = МакетСтавок.ПолучитьТекст();
	ТаблицаСтавок = ОбщегоНазначения.ЗначениеИзСтрокиXML(СтрокаXML);
	
	Возврат ТаблицаСтавок;
	
КонецФункции

Функция УплачиваетсяТорговыйСбор(Организация, Период) Экспорт
	
	ЭтоОбособленноеПодразделение = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Организация, "ОбособленноеПодразделение");
	
	Возврат Период > '20150701' И НЕ ЭтоОбособленноеПодразделение И УчетнаяПолитика.ПлательщикТорговогоСбора(Организация, Период);
	
КонецФункции

// Обновляет дата подачи уведомления ТС-1 в параметрах торговой точки после отправки уведомления
// в ФНС через электронный документооборот.
//
Процедура ЗарегистрироватьИзменениеСтатусаОтправкиУведомления(Уведомление, СтатусОтправки) Экспорт
	
	Если СтатусОтправки = Перечисления.СтатусыОтправки.Доставлен
		ИЛИ СтатусОтправки = Перечисления.СтатусыОтправки.НеПринят Тогда
		
		ОбновитьДатуОтправкиУведомленияПоТорговойТочке(Уведомление, СтатусОтправки);
		
	КонецЕсли;
	
КонецПроцедуры

Функция ИспользуютсяТорговыеТочки(Организация, Период) Экспорт
	
	Если Не УчетнаяПолитика.ПлательщикТорговогоСбора(Организация, Период) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("Период",      Период);
	Запрос.УстановитьПараметр("Организация", Организация);
	
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(&Период, Организация = &Организация) КАК ПараметрыТорговыхТочекСрезПоследних
	|ГДЕ
	|	ПараметрыТорговыхТочекСрезПоследних.ВидОперации <> ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.СнятиеСУчета)";
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

Функция ИспользуютсяТорговыеТочкиЗаПериод(Организация, НачалоПериода, КонецПериода) Экспорт
	
	Если Не УчетнаяПолитика.ПлательщикТорговогоСбора(Организация, КонецПериода) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если ИспользуютсяТорговыеТочки(Организация, НачалоПериода) Тогда
		Возврат Истина;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("КонецПериода",  КонецПериода);
	Запрос.УстановитьПараметр("Организация",   Организация);
	
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПараметрыТорговыхТочек.ТорговаяТочка КАК ТорговаяТочка
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек КАК ПараметрыТорговыхТочек
	|ГДЕ
	|	ПараметрыТорговыхТочек.Период МЕЖДУ &НачалоПериода И &КонецПериода
	|	И ПараметрыТорговыхТочек.Организация = &Организация
	|	И ПараметрыТорговыхТочек.ВидОперации <> ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.СнятиеСУчета)";
	
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

Функция ЭтоПоследняяТорговаяТочкаОрганизации(ТорговаяТочка, Организация, Знач Дата) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(&НаДату, Организация = &Организация) КАК ПараметрыТорговыхТочекСрезПоследних
	|ГДЕ
	|	НЕ ПараметрыТорговыхТочекСрезПоследних.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.СнятиеСУчета)
	|	И НЕ ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка = &ТорговаяТочка";
	
	Запрос.УстановитьПараметр("НаДату"       , КонецДня(Дата));
	Запрос.УстановитьПараметр("Организация"  , Организация);
	Запрос.УстановитьПараметр("ТорговаяТочка", ТорговаяТочка);
	
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		Возврат Истина;
		
	Иначе
		Возврат Ложь;
		
	КонецЕсли;
	
КонецФункции

Функция ВозможноИзменитьПараметрыТорговойТочки(ТорговаяТочка) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("НаДату", ТекущаяДатаСеанса());
	Запрос.УстановитьПараметр("ТорговаяТочка", ТорговаяТочка);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПараметрыТорговыхТочекСрезПоследних.ТорговаяТочка
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(&НаДату, ТорговаяТочка = &ТорговаяТочка) КАК ПараметрыТорговыхТочекСрезПоследних
	|ГДЕ
	|	ПараметрыТорговыхТочекСрезПоследних.ВидОперации = ЗНАЧЕНИЕ(Перечисление.ВидыОперацийТорговыеТочки.СнятиеСУчета)";
	Результат = Запрос.Выполнить();
	
	Возврат Результат.Пустой();
	
КонецФункции

// Возвращает вид торговой деятельности по значению типа торговой точки.
//
// Параметры:
//  ТипТорговойТочки - ПеречислениеСсылка.ТипыТорговыхТочек - тип торговой точки.
//
// Возвращаемое значение:
//  Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором - вид торговой деятельности.
//
Функция ВидТорговойДеятельностиПоТипуТорговойТочки(ТипТорговойТочки) Экспорт
	
	Если ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.Магазин
		ИЛИ ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.Павильон
		ИЛИ ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ПрочееСТорговымЗалом Тогда
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.СтационарныеСетиСТорговымиЗалами;
		
	ИначеЕсли ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.Киоск
		ИЛИ ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала Тогда
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.СтационарныеСетиБезТорговыхЗалов;
		
	ИначеЕсли ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ТорговаяПалатка Тогда
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.НестационарныеСети;
		
	ИначеЕсли ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп
		ИЛИ ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ТорговаяТележка
		ИЛИ ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ТорговыйЛоток Тогда
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.РазвознаяРазноснаяТорговля;
		
	ИначеЕсли ТипТорговойТочки = Перечисления.ТипыТорговыхТочек.ТорговыйАвтомат Тогда
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.ТорговыеАвтоматы;
		
	Иначе
		
		Результат = Перечисления.ВидыТорговойДеятельностиОблагаемыеСбором.РозничныеРынки;
		
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Возвращает признак отнесения выручки от продаж со склада к деятельности на торговом сборе.
// Выручка от продаж со склада относится к деятельности на торговом сборе,
// если складу установлена в соответствие хотя бы одна торговая точка не снятая с учета.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - Организация, которой принадлежит склад.
//  Склад - СправочникСсылка.Склады - Склад, для которого необходимо определить признак обложения деятельности торговым сбором.
//  Период - Дата - Дата, на которую необходимо получить признак обложения склада торговым сбором.
//
// Возвращаемое значение:
//  Булево. Признак обложения деятельности на складе торговым сбором.
//
Функция ДеятельностьНаТорговомСбореПриУСНДоходы(Организация, Склад, Период) Экспорт
	
	Если НЕ ЗначениеЗаполнено(Организация) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если НЕ УчетнаяПолитика.РаздельныйУчетТорговыйСборПриУСН(Организация, Период) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ПараметрыТорговыхТочек.Организация КАК Организация,
	|	ПараметрыТорговыхТочек.ТорговаяТочка КАК ТорговаяТочка
	|ПОМЕСТИТЬ ВТ_ИспользуемыеТорговыеТочки
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек.СрезПоследних(
	|			&Период,
	|			Организация = &Организация) КАК ПараметрыТорговыхТочек
	|ГДЕ
	|	ПараметрыТорговыхТочек.ВидОперации <> &ВидОперацииСнятиеСУчета
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация,
	|	ТорговаяТочка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТорговыеТочкиСклада.Организация КАК Организация,
	|	ТорговыеТочкиСклада.ТорговаяТочка КАК ТорговаяТочка
	|ПОМЕСТИТЬ ВТ_ТорговыеТочкиСклада
	|ИЗ
	|	РегистрСведений.СоответствиеСкладовТорговымТочкам КАК ТорговыеТочкиСклада
	|ГДЕ
	|	ТорговыеТочкиСклада.Организация = &Организация
	|	И ТорговыеТочкиСклада.Склад = &Склад
	|
	|ИНДЕКСИРОВАТЬ ПО
	|	Организация,
	|	ТорговаяТочка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ ПЕРВЫЕ 1
	|	ИСТИНА
	|ИЗ
	|	ВТ_ТорговыеТочкиСклада КАК ТорговыеТочкиСклада
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ ВТ_ИспользуемыеТорговыеТочки КАК ПараметрыТорговыхТочек
	|		ПО ТорговыеТочкиСклада.Организация = ПараметрыТорговыхТочек.Организация
	|			И ТорговыеТочкиСклада.ТорговаяТочка = ПараметрыТорговыхТочек.ТорговаяТочка";
	
	Запрос.УстановитьПараметр("Период",      Период);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("Склад",       Склад);
	Запрос.УстановитьПараметр("ВидОперацииСнятиеСУчета", Перечисления.ВидыОперацийТорговыеТочки.СнятиеСУчета);
	
	УстановитьПривилегированныйРежим(Истина);
	Результат = Запрос.Выполнить();
	
	Возврат НЕ Результат.Пустой();
	
КонецФункции

// Определяет, введен ли торговый сбор в регионе регистрации налогоплательщика на указанную дату.
//
// Параметры:
//  Организация - СправочникСсылка.Организации - налогоплательщик.
//  Период - Дата - дата, на которую проверяется применение торгового сбора в регионе налогоплательщика.
//
// Возвращаемое значение:
//   Булево - если Истина, в регионе налогоплательщика введен торговый сбор.
//
Функция ОрганизацияЗарегистрированаВРегионеУплатыТорговогоСбора(Организация, Период) Экспорт
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	НалоговаяИнспекция = Справочники.Организации.РегистрацияВНалоговомОрганеНаДату(Организация, Период);
	КодНалоговойИнспекции = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НалоговаяИнспекция, "Код");
	КодРегиона = ДанныеГосударственныхОрганов.КодРегионаПоКодуНалоговогоОргана(КодНалоговойИнспекции);
	
	КодыРегионовУплатыТорговогоСбора = КодыРегионовУплатыТорговогоСбора();
	
	Возврат КодыРегионовУплатыТорговогоСбора.Найти(КодРегиона) <> Неопределено;
	
КонецФункции

// Возвращает коды регионов, в которых местным законодательством введен торговый сбор.
// При вводе торгового сбора в новом регионе необходимо указать здесь код этого региона.
//
// Возвращаемое значение:
//   ФиксированныйМассив - содержит коды регионов, в которых введен торговый сбор.
//
Функция КодыРегионовУплатыТорговогоСбора() Экспорт
	
	КодыРегионов = Новый Массив;
	
	КодыРегионов.Добавить("77"); // г. Москва
	
	Возврат Новый ФиксированныйМассив(КодыРегионов);
	
КонецФункции


#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ТаблицаЛьгот() 

	ОбщиеРеквизитыЛьгот = Новый Структура("ДействуетС, ДействуетПо, Регион, НаименованияЛьгот"); 
	ОбщиеРеквизитыЛьгот.ДействуетС = Дата("20150701");
	ОбщиеРеквизитыЛьгот.ДействуетПо = Дата("30991231");
	ОбщиеРеквизитыЛьгот.Регион = "45";
	ОбщиеРеквизитыЛьгот.НаименованияЛьгот = НаименованияЛьгот();
	ТаблицаНалоговыхЛьгот = НоваяТаблицаЛьгот();

	КодЛьготы = "000000000000"; // Не применяется
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Магазин, КодЛьготы               );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Павильон, КодЛьготы              );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Киоск, КодЛьготы                 );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяПалатка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп, КодЛьготы   );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяТележка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйЛоток, КодЛьготы         );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееСТорговымЗалом, КодЛьготы  );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала, КодЛьготы);
	
	КодЛьготы = "000300030000"; // Сопутствующая торговля при оказании бытовых услуг
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Магазин, КодЛьготы               );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Павильон, КодЛьготы              );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Киоск, КодЛьготы                 );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяПалатка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп, КодЛьготы   );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяТележка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйЛоток, КодЛьготы         );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееСТорговымЗалом, КодЛьготы  );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала, КодЛьготы);
	
	КодЛьготы = "000300010002"; // Торговая точка расположена на территории ярмарки
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяПалатка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп, КодЛьготы   );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяТележка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйЛоток, КодЛьготы         );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала, КодЛьготы);
	
	КодЛьготы = "000300010007"; // 'Торговая точка с печатной продукцией
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Павильон, КодЛьготы              );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Киоск, КодЛьготы                 );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяПалатка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп, КодЛьготы   );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяТележка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйЛоток, КодЛьготы         );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееСТорговымЗалом, КодЛьготы  );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала, КодЛьготы);
	
	КодЛьготы = "000300010003"; // Торговля на территории розничного рынка
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Магазин, КодЛьготы               );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Павильон, КодЛьготы              );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.Киоск, КодЛьготы                 );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяПалатка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.АвтолавкаАвтоприцеп, КодЛьготы   );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговаяТележка, КодЛьготы       );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйЛоток, КодЛьготы         );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееСТорговымЗалом, КодЛьготы  );
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ПрочееБезТорговогоЗала, КодЛьготы);
		
	КодЛьготы = "000300010001"; // Торговля с использованием вендинговых автоматов
	ОбщиеРеквизитыЛьгот.ДействуетПо = Дата("20201231");
	
	ДобавитьЛьготуВТаблицу(ТаблицаНалоговыхЛьгот, ОбщиеРеквизитыЛьгот,
		Перечисления.ТипыТорговыхТочек.ТорговыйАвтомат, КодЛьготы       );
	
	Возврат ТаблицаНалоговыхЛьгот;
	
КонецФункции

Процедура ДобавитьЛьготуВТаблицу(ТаблицаЛьгот, ДанныеЛьготы, ТипТорговойТочки, КодЛьготы)
	
	НаименованияЛьгот = ДанныеЛьготы.НаименованияЛьгот;

	НоваяСтрока = ТаблицаЛьгот.Добавить();
	ЗаполнитьЗначенияСвойств(НоваяСтрока, ДанныеЛьготы);
	НоваяСтрока.Наименование = НаименованияЛьгот[КодЛьготы];
	НоваяСтрока.КодНалоговойЛьготы = КодЛьготы;
	НоваяСтрока.ТипТорговойТочки = ТипТорговойТочки;

КонецПроцедуры

Функция НаименованияЛьгот() 

	Льготы = Новый Соответствие();
	Льготы.Вставить("000000000000", НСтр("ru = 'Не применяется'"));
	Льготы.Вставить("000300010001", НСтр("ru = 'Торговля с использованием вендинговых автоматов'"));
	Льготы.Вставить("000300010002", НСтр("ru = 'Торговая точка расположена на территории ярмарки'"));
	Льготы.Вставить("000300010007", НСтр("ru = 'Торговая точка с печатной продукцией'"));
	Льготы.Вставить("000300010003", НСтр("ru = 'Торговля на территории розничного рынка'"));
	Льготы.Вставить("000300030000", НСтр("ru = 'Сопутствующая торговля при оказании бытовых услуг'"));

	Возврат Льготы;
	
КонецФункции

Функция НоваяТаблицаЛьгот()
	
	ТаблицаЛьгот = Новый ТаблицаЗначений;
	ТаблицаЛьгот.Колонки.Добавить("ДействуетС", Новый ОписаниеТипов("Дата"));
	ТаблицаЛьгот.Колонки.Добавить("ДействуетПо", Новый ОписаниеТипов("Дата"));
	ТаблицаЛьгот.Колонки.Добавить("ТипТорговойТочки", Новый ОписаниеТипов("ПеречислениеСсылка.ТипыТорговыхТочек"));
	ТаблицаЛьгот.Колонки.Добавить("Регион", ОбщегоНазначения.ОписаниеТипаСтрока(2));
	ТаблицаЛьгот.Колонки.Добавить("Наименование", ОбщегоНазначения.ОписаниеТипаСтрока(100));
	ТаблицаЛьгот.Колонки.Добавить("КодНалоговойЛьготы", ОбщегоНазначения.ОписаниеТипаСтрока(12));
	
	Возврат ТаблицаЛьгот;

КонецФункции

#Область РасчетТорговогоСбора

Функция ПодготовитьТаблицыРасчета(ТаблицаРеквизиты, Отказ) Экспорт
	
	СтруктураТаблиц = Новый Структура();
	СтруктураТаблиц.Вставить("ТаблицаПроводок"      , Неопределено);
	СтруктураТаблиц.Вставить("ТаблицаСправкиРасчета", Неопределено);
	
	Если Не ЗначениеЗаполнено(ТаблицаРеквизиты) Тогда
		Возврат СтруктураТаблиц;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыРасчета(ТаблицаРеквизиты);
	Реквизиты = Параметры.Реквизиты[0];
	
	ТаблицаПроводок  = ПустаяТаблицаПроводок();
	
	Ошибки = Новый Массив;
	РассчитатьТорговыйСбор(Реквизиты, ТаблицаПроводок, Ошибки, Отказ);
	
	Если Отказ Тогда
		
		СтруктураТаблиц.Вставить("Ошибки", Ошибки);
		
	Иначе
		
		СтруктураТаблиц.Вставить("ТаблицаПроводок", ТаблицаПроводок);
		
	КонецЕсли;
	
	Возврат СтруктураТаблиц;
	
КонецФункции

Функция ПодготовитьПараметрыРасчета(ТаблицаРеквизиты)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
		+ "Период,"      // <Дата>
		+ "НачДата,"     // <Дата>
		+ "КонДата,"     // <Дата>
		+ "Организация," // <СправочникСсылка.Организации>
		+ "Регистратор," // <ДокументСсылка.*>
		+ "Содержание"   // <Строка, 150>
		;
	
	Параметры.Вставить("Реквизиты",
		ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(ТаблицаРеквизиты, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции

Процедура РассчитатьТорговыйСбор(Реквизиты, ТаблицаПроводок, Ошибки, Отказ)
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	// Федеральный закон № 172-ФЗ от 08.06.2020
	// В 2020 году некоторые организации и ИП освобождаются от уплаты сбора за 2-й квартал
	// В этом случае проводки по начислению сбора не формируем.
	ПериодОсвобожденияОтНалогов = НалоговыйУчет.ПериодОсвобожденияОтНалоговПострадавшимОтКоронавируса();
	Если НалоговыйУчет.ДеятельностьОтнесенаКПострадавшимОтКоронавируса(Реквизиты.Организация)
		 И ПериодОсвобожденияОтНалогов.Начало <= Реквизиты.КонДата 
		 И Реквизиты.КонДата <= ПериодОсвобожденияОтНалогов.Конец Тогда
		Возврат;
	КонецЕсли;
	
	РасчетПоСбору = СуммаТорговогоСбора(Реквизиты.Организация, Реквизиты.НачДата, Реквизиты.КонДата);
	
	Если РасчетПоСбору.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ТорговыеТочки = РасчетПоСбору.ВыгрузитьКолонку("ТорговаяТочка");
	ПустаяТорговаяТочка = Справочники.ТорговыеТочки.ПустаяСсылка();
	
	СчетДт = ПланыСчетов.Хозрасчетный.ИздержкиОбращения;
	СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(СчетДт);
	СтатьяЗатратПоТорговомуСбору = Справочники.СтатьиЗатрат.ПредопределенныйЭлемент("ТорговыйСбор");
	
	Для Каждого СтрокаТаблицы Из РасчетПоСбору Цикл
		
		Если СтрокаТаблицы.Сумма = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = ТаблицаПроводок.Добавить();
		
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Реквизиты);
		
		НоваяСтрока.СчетКт                 = ПланыСчетов.Хозрасчетный.ТорговыйСбор;
		НоваяСтрока.ВидыПлатежейВГосБюджет = Перечисления.ВидыПлатежейВГосБюджет.Налог;
		
		НоваяСтрока.СчетДт = СчетДт;
		
		ЗаполнятьПодразделение = СвойстваСчетаДт.УчетПоПодразделениям
			И СтрокаТаблицы.ВладелецПодразделения = НоваяСтрока.Организация;
			
		Если ЗаполнятьПодразделение Тогда
			НоваяСтрока.Подразделение = СтрокаТаблицы.ПодразделениеОрганизации;
		КонецЕсли;
		НоваяСтрока.Субконто1 = СтатьяЗатратПоТорговомуСбору;
		
		НоваяСтрока.Сумма = СтрокаТаблицы.Сумма;
		
	КонецЦикла;
	
	ТаблицаПроводок.Свернуть("Период,Организация,Содержание,
		|СчетДт,Подразделение, Субконто1,Субконто2,Субконто3,
		|СчетКт,ВидыПлатежейВГосБюджет", "Сумма");
	
КонецПроцедуры

Процедура СформироватьДвиженияРасчета(ТаблицаПроводок, ТаблицаРеквизитов, Движения, Отказ) Экспорт

	Если Не ЗначениеЗаполнено(ТаблицаРеквизитов) Тогда
		Возврат;
	КонецЕсли;
	
	Параметры = ПодготовитьПараметрыДвиженийРасчета(ТаблицаПроводок, ТаблицаРеквизитов);
	Реквизиты = Параметры.Реквизиты[0];
	
	ОтражатьВНалоговомУчете = УчетнаяПолитика.ПлательщикНалогаНаПрибыль(Реквизиты.Организация, Реквизиты.Период);
	ПоддержкаПБУ18 = УчетнаяПолитика.ПоддержкаПБУ18(Реквизиты.Организация, Реквизиты.Период);
	
	// проводка по начислению сбора
	Для каждого СтрокаТаблицы Из Параметры.Проводки Цикл
	
		Если СтрокаТаблицы.Сумма = 0 Тогда
			Продолжить;
		КонецЕсли;
		
		Проводка = Движения.Хозрасчетный.Добавить();
		ЗаполнитьЗначенияСвойств(Проводка, СтрокаТаблицы);
		
		СвойстваСчетаДт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетДт);
		Для Ном = 1 По СвойстваСчетаДт.КоличествоСубконто Цикл
			
			БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетДт, Проводка.СубконтоДт,
				СвойстваСчетаДт["ВидСубконто" + Ном], СтрокаТаблицы["Субконто" + Ном]);
			
		КонецЦикла;
		
		Если ЗначениеЗаполнено(СтрокаТаблицы.Подразделение) Тогда
			Проводка.ПодразделениеДт = СтрокаТаблицы.Подразделение;
		КонецЕсли;
		
		БухгалтерскийУчет.УстановитьСубконто(Проводка.СчетКт, Проводка.СубконтоКт,
			"ВидыПлатежейВГосБюджет", СтрокаТаблицы.ВидыПлатежейВГосБюджет);
			
		СвойстваСчетаКт = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Проводка.СчетКт);
	
		Если ОтражатьВНалоговомУчете Тогда
			
			Если СвойстваСчетаДт.НалоговыйУчет Тогда
			
				Проводка.СуммаНУДт = 0;
				
				Если ПоддержкаПБУ18 Тогда
					Проводка.СуммаПРДт = СтрокаТаблицы.Сумма;
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
		Движения.Хозрасчетный.Записывать = Истина;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ПодготовитьПараметрыДвиженийРасчета(ТаблицаПроводок, ТаблицаРеквизитов)
	
	Параметры = Новый Структура;
	
	// Подготовка таблицы Параметры.Реквизиты
	
	СписокОбязательныхКолонок = ""
		+ "Период,"      // <Дата>
		+ "Организация," // <СправочникСсылка.Организации>
		+ "Регистратор," // <ДокументСсылка.*>
		;
	
	Параметры.Вставить("Реквизиты",
		ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(ТаблицаРеквизитов, СписокОбязательныхКолонок));
	
	СписокОбязательныхКолонок = ""
		+ "Период,"                 // <Дата> - период проводок
		+ "Организация,"            // <СправочникСсылка.Организации>
		+ "СчетДт,"                 // <ПланСчетовСсылка.Хозрасчетный>
		+ "Подразделение,"          // <СправочникСсылка.ПодразделенияОрганизаций>
		+ "Субконто1,"              // <Характеристика.ВидыСубконтоХозрасчетные>
		+ "Субконто2,"              // <Характеристика.ВидыСубконтоХозрасчетные>
		+ "Субконто3,"              // <Характеристика.ВидыСубконтоХозрасчетные>
		+ "СчетКт,"                 // <ПланСчетовСсылка.Хозрасчетный>
		+ "ВидыПлатежейВГосБюджет," // <ПеречислениеСсылка.ВидыПлатежейВГосБюджет>
		+ "Сумма,"                  // <Число, 15, 0> - сумма проводки
		+ "Содержание";             // <Строка, 150> - содержание проводки
	
	Параметры.Вставить("Проводки", ОбщегоНазначенияБПВызовСервера.ПолучитьТаблицуПараметровПроведения(
		ТаблицаПроводок, СписокОбязательныхКолонок));
	
	Возврат Параметры;
	
КонецФункции

Функция ПустаяТаблицаПроводок()
	
	ТаблицаПроводок = Новый ТаблицаЗначений;
	
	ТаблицаПроводок.Колонки.Добавить("Период",
		ОбщегоНазначения.ОписаниеТипаДата(ЧастиДаты.ДатаВремя));
	ТаблицаПроводок.Колонки.Добавить("Организация",
		Новый ОписаниеТипов("СправочникСсылка.Организации"));
	ТаблицаПроводок.Колонки.Добавить("СчетДт",
		Новый ОписаниеТипов("ПланСчетовСсылка.Хозрасчетный"));
	ТаблицаПроводок.Колонки.Добавить("Подразделение",
		Новый ОписаниеТипов("СправочникСсылка.ПодразделенияОрганизаций"));
	ТаблицаПроводок.Колонки.Добавить("Субконто1");
	ТаблицаПроводок.Колонки.Добавить("Субконто2");
	ТаблицаПроводок.Колонки.Добавить("Субконто3");
	ТаблицаПроводок.Колонки.Добавить("СчетКт",
		Новый ОписаниеТипов("ПланСчетовСсылка.Хозрасчетный"));
	ТаблицаПроводок.Колонки.Добавить("ВидыПлатежейВГосБюджет",
		Новый ОписаниеТипов("ПеречислениеСсылка.ВидыПлатежейВГосБюджет"));
	ТаблицаПроводок.Колонки.Добавить("Сумма",
		ОбщегоНазначения.ОписаниеТипаЧисло(15, 2));
	ТаблицаПроводок.Колонки.Добавить("Содержание",
		ОбщегоНазначения.ОписаниеТипаСтрока(150));
	
	Возврат ТаблицаПроводок;
	
КонецФункции

#КонецОбласти

#Область Отчетность

Процедура ОбновитьДатуОтправкиУведомленияПоТорговойТочке(Уведомление, СтатусОтправки)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Уведомление", Уведомление);
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ПараметрыТорговыхТочек.ТорговаяТочка,
	|	ПараметрыТорговыхТочек.Организация,
	|	ПараметрыТорговыхТочек.Период
	|ИЗ
	|	РегистрСведений.ПараметрыТорговыхТочек КАК ПараметрыТорговыхТочек
	|ГДЕ
	|	ПараметрыТорговыхТочек.Уведомление = &Уведомление";
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	
	Пока РезультатЗапроса.Следующий() Цикл
		ПараметрыКлючаЗаписи = Новый Структура;
		ПараметрыКлючаЗаписи.Вставить("Период"       , РезультатЗапроса.Период);
		ПараметрыКлючаЗаписи.Вставить("Организация"  , РезультатЗапроса.Организация);
		ПараметрыКлючаЗаписи.Вставить("ТорговаяТочка", РезультатЗапроса.ТорговаяТочка);
		
		КлючЗаписи = РегистрыСведений.ПараметрыТорговыхТочек.СоздатьКлючЗаписи(ПараметрыКлючаЗаписи);
		
		Попытка
			
			ЗаблокироватьДанныеДляРедактирования(КлючЗаписи);
			
			МенеджерЗаписи = РегистрыСведений.ПараметрыТорговыхТочек.СоздатьМенеджерЗаписи();
			ЗаполнитьЗначенияСвойств(МенеджерЗаписи, ПараметрыКлючаЗаписи);
			МенеджерЗаписи.Прочитать();
			Если МенеджерЗаписи.Выбран() Тогда
				МенеджерЗаписи.ДатаПодачиУведомления = ДатаПодачиУведомления(Уведомление, СтатусОтправки);
				МенеджерЗаписи.Записать();
			КонецЕсли;
			
			РазблокироватьДанныеДляРедактирования(КлючЗаписи);
			
		Исключение
			
			ТекстСобытия = НСтр("ru = 'Торговый сбор'", ОбщегоНазначения.КодОсновногоЯзыка());
			ШаблонОшибки = НСтр("ru = 'Не удалось обновить дату отправки уведомления торговой точки ""%1"" по причине:
				|%2'");
			ТекстОшибки = СтрШаблон(ШаблонОшибки, РезультатЗапроса.ТорговаяТочка, ПодробноеПредставлениеОшибки(ОписаниеОшибки()));
			ЗаписьЖурналаРегистрации(ТекстСобытия,
				УровеньЖурналаРегистрации.Ошибка, ,
				РезультатЗапроса.ТорговаяТочка,
				ТекстОшибки);
				
		КонецПопытки;
		
	КонецЦикла;
	
КонецПроцедуры

Функция ДатаПодачиУведомления(Уведомление, СтатусОтправки)
	
	Если СтатусОтправки = Перечисления.СтатусыОтправки.НеПринят Тогда
		Возврат '00010101';
		
	ИначеЕсли СтатусОтправки = Перечисления.СтатусыОтправки.Доставлен Тогда
		
		СведенияПоВсемОтправкам = СведенияПоОтправкам.СведенияПоВсемОтправкам(Уведомление);
		Если СведенияПоВсемОтправкам.Количество() > 0 Тогда
			Возврат СведенияПоВсемОтправкам[0].ДатаОтправки;
			
		Иначе
			Возврат '00010101';
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецОбласти
