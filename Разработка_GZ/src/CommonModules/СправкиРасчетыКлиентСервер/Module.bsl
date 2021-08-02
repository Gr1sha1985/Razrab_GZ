// Общие требования к отчетам, работа с которыми возможна с помощью модулей СправкиРасчеты:
// - в качестве периода выбирается целое количество месяцев с начала отчетного года
//   -- допустимо использовать для отчетов, в которых опционально можно выбрать данные только за конкретный месяц
//   -- некоторые функции можно использовать в отчетах, период которых задается явно как две даты
// - программный интерфейс
//  - ПоддерживаемыеНаборыСуммовыхПоказателей() - если иное не задано манифестом отчета, см. СправкиРасчеты.УстановитьОтчетНеИспользуетНаборыСуммовыхПоказателей()
// - параметры формы
//   -- НачалоПериода
//   -- КонецПериода
//   -- Организация
// - реквизиты формы
//   - ПредставлениеПериодаЗаголовок // период целиком для заголовка формы, с концевым разделителем "г.", используется в подсистеме стандартных отчетов
//   - ПредставлениеПериодаВыбор     // только выбранный месяц для заголовка поля выбора периода, подсистема выбора периода
//   - ПредставлениеОрганизации
//   - ДатаРегистрацииОрганизации
//   - ИдентификаторЗадания (для форм, использующих предыдущую версию API длительных операций БСП)
//   - ДлительнаяОперацияПриОткрытии (для форм, использующих актуальную версию API длительных операций БСП)
//   - Результат
// - элементы формы
//   - Результат
//   - элементы формы, описанные в БухгалтерскиеОтчетыКлиентСервер.НовыйОписаниеЭлементовНастройки()
//
// Эти требования дополнительные к накладываемым подсистемой БухгалтерскиеОтчеты.
// Отдельные функции могут накладывать дополнительные требования.
// Они описаны рядом с методами, относящимися к этим функциям.

#Область ПрограммныйИнтерфейс

// Определяет, адаптирован ли отчет для использования в подсистеме.
//
// Параметры:
//  ИмяОтчета	 - Строка - имя отчета, заданное при конфигурировании
// 
// Возвращаемое значение:
//  Булево  - Истина, если для отчета можно использовать методы подсистемы
//
Функция ОтчетПодключен(ИмяОтчета) Экспорт
	
	Возврат ПодключенныеОтчеты().Найти(ИмяОтчета) <> Неопределено;
	
КонецФункции

// Перечень отчетов, адаптированных для использования в подсистеме.
// 
// Возвращаемое значение:
//  ФиксированныйМассив из Строка - имена отчетов
//
Функция ПодключенныеОтчеты() Экспорт
	
	// Перечисленные отчеты рекомендуется включить в подсистемы СправкиРасчеты
	// (при необходимости - в подчиненные им подсистемы)
	
	ИменаОтчетов =
		"СправкаРасчетДолиНалоговойБазы
		|СправкаРасчетКалькуляцияСебестоимости
		|СправкаРасчетНалогаНаПрибыль
		|СправкаРасчетНормированияРасходов
		|СправкаРасчетОтложенногоНалога
		|СправкаРасчетОбесцененияЗапасов
		|СправкаРасчетПереоценкаВалютныхСредств
		|СправкаРасчетПостоянныхИВременныхРазниц
		|СправкаРасчетПризнаниеРасходовПоОСПоступившимВЛизинг
		|СправкаРасчетРаспределенияКосвенныхРасходов
		|СправкаРасчетРасходаПоНалогуНаПрибыль
		|СправкаРасчетРезервыПоСомнительнымДолгам
		|СправкаРасчетСебестоимостиПродукции
		|СправкаРасчетСписанияКосвенныхРасходов
		|СправкаРасчетТранспортныхРасходов
		|СправкаРасчетУбытковПрошлыхЛет
		|СправкаРасчетЭффектаИзмененияСтавокНалогаНаПрибыль";
	
	ИменаОтчетов = СтрРазделить(ИменаОтчетов, Символы.ПС);
	
	БухгалтерскиеОтчетыКлиентСерверПереопределяемый.УстановитьИспользуемыеСправкиРасчеты(ИменаОтчетов);
	
	Возврат Новый ФиксированныйМассив(ИменаОтчетов);
	
КонецФункции

// Приводит номер набора суммовых показателей в соответствие с видом регламентной операции, с которой связан отчет
// (если набор еще не определен).
//
// Параметры:
//  НомерНабораСуммовыхПоказателей	 - Число - см. область НомераНаборов, изменяется процедурой
//  ИдентификаторОтчета				 - Строка - Имя отчета
//  ВидРегламентнойОперации			 - ПеречислениеСсылка.ВидыРегламентныхОпераций - вид выполненной регламентной операции
//
Процедура УточнитьНаборСуммовыхПоказателейОтчетаПоВидуОперации(НомерНабораСуммовыхПоказателей, ИмяОтчета, ВидРегламентнойОперации) Экспорт
	
	Если ЗначениеЗаполнено(НомерНабораСуммовыхПоказателей) Тогда
		Возврат;
	КонецЕсли;
	
	Если ИмяОтчета = "СправкаРасчетНалогаНаПрибыль" Тогда
		Если ВидРегламентнойОперации = ПредопределенноеЗначение("Перечисление.ВидыРегламентныхОпераций.РасчетНалогаНаПрибыль") Тогда
			НомерНабораСуммовыхПоказателей = НомерНабораСуммовыхПоказателейНалоговыйУчет();
		ИначеЕсли ВидРегламентнойОперации = ПредопределенноеЗначение("Перечисление.ВидыРегламентныхОпераций.РасчетОтложенногоНалога") Тогда
			НомерНабораСуммовыхПоказателей = НомерНабораСуммовыхПоказателейОтложенногоНалога();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Готовит текст заголовка справки-расчета, включающий контекст ее формирования.
//
// Текст заголовка справки-расчета (как экранной, так и печатной формы) строится всегда по одному шаблону,
// но для разных применений может содержать не все элементы шаблона или разные значения элементов.
// Скажем
// - в заголовке формы выводится краткое название отчета (как на втором шаге программного интерфейса)
//   и не выводятся названия показателей,
// - в печатной форме название отчета может содержать слова "справка-расчет", а название организации выводится отдельно.
//
// Параметры:
//  НазваниеОтчета			 - Строка - пользовательское представление отчета или его варианта
//  ПредставлениеПериода	 - Строка - пользовательское представление периода, за который формируется отчет
//  ПредставлениеОрганизации - Строка - пользовательское представление организации, по которой формируется отчет
//  ПредставлениеПоказателей - Строка - пользовательское представление набора суммовых показателей, которые содержит отчет
// 
// Возвращаемое значение:
//  Строка - текст заголовка экранной или печатной формы
//
Функция ТекстЗаголовка(НазваниеОтчета, ПредставлениеПериода = "", ПредставлениеОрганизации = "", ПредставлениеПоказателей = "") Экспорт
	
	Слова = Новый Массив;
	
	Слова.Добавить(НазваниеОтчета); // свойство расширения отчета
	
	Если Не ПустаяСтрока(ПредставлениеПериода) Тогда
		ПолноеПредставлениеПериода = СтрШаблон(НСтр("ru = 'за %1'"), ПредставлениеПериода);// должно содержать концевой разделитель "г."
		ПолноеПредставлениеПериода = СтрЗаменить(ПолноеПредставлениеПериода, " ", Символы.НПП); // перенос отдельных элементов периода может ввести в заблуждение
		Слова.Добавить(ПолноеПредставлениеПериода);
	КонецЕсли;
	
	Если Не ПустаяСтрока(ПредставлениеОрганизации) Тогда
		Слова.Добавить(ПредставлениеОрганизации); 
	КонецЕсли;
	
	Если Не ПустаяСтрока(ПредставлениеПоказателей) Тогда
		
		// Это - второстепенная информация. В то же время, представление показателей может быть длинным.
		// Обеспечим перенос этого названия на новую строку целиком.
		ПредставлениеПоказателейНПП = СтрЗаменить(ПредставлениеПоказателей, " ", Символы.НПП);
		
		Слова.Добавить(СтрШаблон(НСтр("ru = '(%1)'"), ПредставлениеПоказателейНПП));
		
	КонецЕсли;
	
	Возврат СтрСоединить(Слова, " ");
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область ДополнительныеФункции

Функция ОтчетПоддерживаетВыборВсяОрганизация(Форма) Экспорт
	
	// Требования к отчету для этой поддержки
	// - Форма.ПолеОрганизация // строка, ключ из СоответствиеОрганизаций
	// - Отчет.ВключатьОбособленныеПодразделения
	// - отдельная (не общая) форма отчета
	
	Возврат ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "СоответствиеОрганизаций");
	
КонецФункции

Функция ОтчетПоддерживаетВыборСНачалаГода(Форма) Экспорт
	
	// Требования к отчету для этой поддержки
	// - отдельная (не общая) форма отчета
	// - Отчет.СНачалаГода
	// - Форма.СНачалаГода
	
	Возврат Форма.Элементы.Найти("СНачалаГода") <> Неопределено;
	
КонецФункции

Функция ОтчетПоддерживаетВыборПроизвольногоИнтервала(Форма) Экспорт
	
	Возврат Форма.Элементы.Найти("НачалоПериода") <> Неопределено
		И Форма.Элементы.Найти("КонецПериода") <> Неопределено;
	
КонецФункции

#КонецОбласти

#Область Умолчания

Функция ВидПериодаМесяц() Экспорт
	
	Возврат ПредопределенноеЗначение("Перечисление.ДоступныеПериодыОтчета.Месяц");
	
КонецФункции

#КонецОбласти

#Область НаборыСуммовыхПоказателей

// Определяет, может ли пользователь в форме отчета выбирать один из наборов показателей отчета.
// Перечень показателей, среди которых может выбирать,
// см. в ПоддерживаемыеНаборыСуммовыхПоказателей() в модуле менеджера отчета.
//
// Параметры:
//  Отчет	 - ОтчетОбъект - проверяемый отчет
// 
// Возвращаемое значение:
//  Булево - Истина, если пользователь может выбирать явно набор показателей отчета
//
Функция ПоддерживаетсяВыборПоказателей(Отчет) Экспорт
	
	Возврат ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Отчет, "НаборПоказателейОтчета");
	
КонецФункции

#Область НомераНаборов

Функция ВсеНаборыСуммовыхПоказателей() Экспорт
	
	ВсеНаборы = Новый Массив;
	ВсеНаборы.Добавить(НомерНабораСуммовыхПоказателейПоУмолчанию());
	ВсеНаборы.Добавить(НомерНабораСуммовыхПоказателейНалоговыйУчет());
	ВсеНаборы.Добавить(НомерНабораСуммовыхПоказателейОтложенногоНалога());
	ВсеНаборы.Добавить(НомерНабораСуммовыхПоказателейСверкиНалоговогоУчета());
	
	Возврат ВсеНаборы;
	
КонецФункции

Функция ВсеПоказателиОтчета() Экспорт
	
	Показатели = Новый Массив;
	Показатели.Добавить("БУ");
	Показатели.Добавить("НУ");
	Показатели.Добавить("ПР");
	Показатели.Добавить("ВР");
	Показатели.Добавить("СверкаНУ");
	
	Возврат Показатели;
	
КонецФункции


Функция НомерНабораСуммовыхПоказателейПоУмолчанию() Экспорт
	
	Возврат 1;
	
КонецФункции

Функция НомерНабораСуммовыхПоказателейНалоговыйУчет() Экспорт
	
	Возврат 2;
	
КонецФункции

Функция НомерНабораСуммовыхПоказателейОтложенногоНалога() Экспорт
	
	Возврат 3;
	
КонецФункции

Функция НомерНабораСуммовыхПоказателейСверкиНалоговогоУчета() Экспорт
	
	Возврат 4;
	
КонецФункции

Функция ЭтоНаборСуммовыхПоказателейНалоговыйУчет(НомерНабораСуммовыхПоказателей) Экспорт
	Возврат НомерНабораСуммовыхПоказателей = НомерНабораСуммовыхПоказателейНалоговыйУчет();
КонецФункции

Функция ЭтоНаборСуммовыхПоказателейОтложенныхНалогов(НомерНабораСуммовыхПоказателей) Экспорт
	Возврат НомерНабораСуммовыхПоказателей = НомерНабораСуммовыхПоказателейОтложенногоНалога();
КонецФункции

Функция ЭтоНаборСуммовыхПоказателейСверкиНалоговогоУчета(НомерНабораСуммовыхПоказателей) Экспорт
	Возврат НомерНабораСуммовыхПоказателей = НомерНабораСуммовыхПоказателейСверкиНалоговогоУчета();
КонецФункции

Функция НаборСуммовыхПоказателейВключаетБухгалтерскийУчет(НомерНабораСуммовыхПоказателей) Экспорт
	
	Возврат НомерНабораСуммовыхПоказателей <> НомерНабораСуммовыхПоказателейНалоговыйУчет();
	
КонецФункции

Функция НазваниеНабораСуммовыхПоказателей(НомерНабораСуммовыхПоказателей) Экспорт
	
	// См. также ПредставленияНаборовСуммовыхПоказателей
	
	Если ЭтоНаборСуммовыхПоказателейНалоговыйУчет(НомерНабораСуммовыхПоказателей) Тогда
		
		Возврат НСтр("ru = 'налоговый учет'");
		
	ИначеЕсли ЭтоНаборСуммовыхПоказателейОтложенныхНалогов(НомерНабораСуммовыхПоказателей) Тогда
		
		Возврат НСтр("ru = 'бухгалтерский учет с постоянными и временными разницами'");
		
	ИначеЕсли ЭтоНаборСуммовыхПоказателейСверкиНалоговогоУчета(НомерНабораСуммовыхПоказателей) Тогда
		
		Возврат НСтр("ru = 'бухгалтерский и налоговый учет'");
		
	Иначе // значение по умолчанию
		
		Возврат НСтр("ru = 'бухгалтерский учет'");
		
	КонецЕсли;
	
КонецФункции

#КонецОбласти

Процедура ИсправитьНаборСуммовыхПоказателей(НомерНабора, ДоступныеНаборы) Экспорт
	
	Если ДоступныеНаборы.Найти(НомерНабора) <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ДоступныеНаборы) Тогда
		НомерНабора = ДоступныеНаборы[0];
	Иначе
		НомерНабора = НомерНабораСуммовыхПоказателейПоУмолчанию();
	КонецЕсли;
	
КонецПроцедуры

Функция СоставНабораСуммовыхПоказателей(НомерНабораСуммовыхПоказателей) Экспорт
	
	СоставНабора = Новый Массив;
	
	Если ЭтоНаборСуммовыхПоказателейНалоговыйУчет(НомерНабораСуммовыхПоказателей) Тогда
		
		СоставНабора.Добавить("НУ");
		
	ИначеЕсли ЭтоНаборСуммовыхПоказателейОтложенныхНалогов(НомерНабораСуммовыхПоказателей) Тогда
		
		СоставНабора.Добавить("БУ");
		СоставНабора.Добавить("ПР");
		СоставНабора.Добавить("ВР");
		
	ИначеЕсли ЭтоНаборСуммовыхПоказателейСверкиНалоговогоУчета(НомерНабораСуммовыхПоказателей) Тогда
		
		СоставНабора.Добавить("БУ");
		СоставНабора.Добавить("НУ");
		СоставНабора.Добавить("СверкаНУ");
		
	Иначе // набор по умолчанию
		
		СоставНабора.Добавить("БУ");
		
	КонецЕсли;
	
	Возврат СоставНабора;
	
КонецФункции

Процедура УстановитьСоставНабораСуммовыхПоказателей(Контекст, НомерНабораСуммовыхПоказателей) Экспорт
	
	СоставНабора = СоставНабораСуммовыхПоказателей(НомерНабораСуммовыхПоказателей);
	Для Каждого Суффикс Из СоставНабора Цикл
		
		ИмяПоказателя = "Показатель" + Суффикс;
		Контекст[ИмяПоказателя] = Истина;
		
	КонецЦикла;
	
КонецПроцедуры

// Настраивает состав набора показателей отчета, доступный пользователю
// Вызывается в контексте формы на клиенте или на сервере
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма справки-расчета. Общая форма не поддерживается.
//          Для форм, поддерживающих выбор набора показателей, форма должна содержать элемент "Переключатель".
//          Для того, чтобы сократить количество серверных вызовов, форма может обеспечивать кеш:
//          содержать свойство НаборПоказателейЗависитОтКонтекста, доступное на клиенте, например экспортную переменную.
//          Кеш не следует инициализировать (при первом вызове должен содержать Неопределено).
//
// ОбработкаНаСервере - Структура - позволяет оптимизировать вызовы сервера.
//          Если требуется дальнейшая обработка, которую оптимальнее выполнять в контекстном вызове сервера,
//          то в структуру будут помещены данные для обработки с ключем УстановитьСписокВыбораНабораСуммовыхПоказателей.
//          В этом случае следует вызвать УстановитьСписокВыбораНабораСуммовыхПоказателей
//                    - Неопределено - все необходимые действия будут выполнены непосредственно.
//
Процедура НастроитьНаборПоказателейОтчета(Форма, ОбработкаНаСервере = Неопределено) Экспорт
	
	Если Не ПоддерживаетсяВыборПоказателей(Форма.Отчет) Тогда
		Возврат;
	КонецЕсли;
	
	ИмяОтчета = БухгалтерскиеОтчетыКлиентСервер.ИмяОтчетаПоИмениФормы(Форма);
	Если ИмяОтчета = Неопределено Тогда
		// Общая форма СправкаРасчет еще не поддерживает выбор показателей отчета
		Возврат;
	КонецЕсли;
	
	ЭлементВыбораНабораПоказателей = Форма.Элементы.Найти("Переключатель");
	Если ЭлементВыбораНабораПоказателей = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДоступенКешНаборПоказателейЗависитОтКонтекста = ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(
		Форма,
		"НаборПоказателейЗависитОтКонтекста");
		
	Если ДоступенКешНаборПоказателейЗависитОтКонтекста
		И Форма.НаборПоказателейЗависитОтКонтекста = Ложь
		И ЗначениеЗаполнено(ЭлементВыбораНабораПоказателей.СписокВыбора) Тогда
		Возврат;
	КонецЕсли;
	
	Если ДоступенКешНаборПоказателейЗависитОтКонтекста Тогда
		ХранилищеКеша = Форма.НаборПоказателейЗависитОтКонтекста;
	Иначе
		ХранилищеКеша = Неопределено;
	КонецЕсли;
	
	ДоступныеНаборы = СправкиРасчетыВызовСервера.ДоступныеПользователюНаборыСуммовыхПоказателей(
		ИмяОтчета,
		Форма.Отчет.НачалоПериода,
		Форма.Отчет.КонецПериода,
		Форма.Отчет.Организация,
		ХранилищеКеша);
		
	ИсправитьНаборСуммовыхПоказателей(Форма.Отчет.НаборПоказателейОтчета, ДоступныеНаборы);
	
	Если ДоступенКешНаборПоказателейЗависитОтКонтекста Тогда
		Форма.НаборПоказателейЗависитОтКонтекста = ХранилищеКеша;
	КонецЕсли;
	
	ТребуетсяНастроитьСписок = ТребуетсяНастроитьСписокВыбораНабораСуммовыхПоказателей(
		ЭлементВыбораНабораПоказателей.СписокВыбора,
		ДоступныеНаборы);
		
	Если Не ТребуетсяНастроитьСписок Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбработкаНаСервере = Неопределено Тогда
		УстановитьСписокВыбораНабораСуммовыхПоказателей(Форма, ДоступныеНаборы, ЭлементВыбораНабораПоказателей.СписокВыбора);
	Иначе
		ОбработкаНаСервере.Вставить("УстановитьСписокВыбораНабораСуммовыхПоказателей", ДоступныеНаборы);
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьСписокВыбораНабораСуммовыхПоказателей(Форма, ДоступныеНаборы, СписокВыбора = Неопределено) Экспорт
	
	Если СписокВыбора = Неопределено Тогда
		СписокВыбора = Форма.Элементы.Переключатель.СписокВыбора;
	КонецЕсли;
	
	СписокВыбора.Очистить();
	
	ПредставленияНаборов = ПредставленияНаборовСуммовыхПоказателей();
	Для Каждого НомерНабора Из ДоступныеНаборы Цикл
		СписокВыбора.Добавить(НомерНабора, ПредставленияНаборов[НомерНабора]);
	КонецЦикла;
	
	НастроитьКнопкиСохраненияРегистровБухгалтерскогоУчета(Форма, Форма.Отчет.НаборПоказателейОтчета);
	
КонецПроцедуры

#КонецОбласти

#Область Формы // с контекстом

// Вызываются в контексте формы на клиенте или на сервере

#Область ОбщаяФорма

Функция ОбщаяФорма(Форма) Экспорт
	
	Возврат (Форма.ИмяФормы	= "ОбщаяФорма.СправкаРасчет");
	
КонецФункции

Функция БазовыеРеквизиты(Форма) Экспорт
	
	Если ОбщаяФорма(Форма) Тогда
		// В контексте формы реквизит Отчет не имеет свойств,
		// соответствующих реквизитам конкретного объекта (отчета),
		// потому что объявлен как ОтчетОбъект.
		// Поэтому базовые реквизиты (Организация, НачалоПериода, КонецПериода)
		// продублированы на форме.
		Возврат Форма;
	Иначе
		// В отчетах с отдельной формой доступны реквизиты отчета.
		Возврат Форма.Отчет;
	КонецЕсли;
	
КонецФункции

Функция Организация(Форма) Экспорт
	
	Возврат БазовыеРеквизиты(Форма).Организация;
	
КонецФункции


#КонецОбласти

// Определяет имя отчета.
//
// Параметры:
//  Форма - УправляемаяФорма - форма отчета, подключенного к подсистеме, или общая форма СправкаРасчет
// 
// Возвращаемое значение:
//  Строка - имя отчета
//
Функция ИмяОтчета(Форма) Экспорт
	
	ИмяОтчета = БухгалтерскиеОтчетыКлиентСервер.ИмяОтчетаПоИмениФормы(Форма);
	Если ИмяОтчета <> Неопределено Тогда
		Возврат ИмяОтчета;
	КонецЕсли;
	
	// В общей форме СправкаРасчет для обращения с клиента имя отчета кешируется в реквизит формы
	Возврат Форма.ИмяОтчета;
	
КонецФункции

Процедура УстановитьЗаголовокФормы(Форма) Экспорт
	
	Форма.Заголовок = ТекстЗаголовка(
		Форма.ПредставлениеТекущегоВарианта, // свойство расширения отчета
		Форма.ПредставлениеПериодаЗаголовок,
		Форма.ПредставлениеОрганизации); // может быть не заполнено, если организация одна
	
КонецПроцедуры

#Область НастройкаПоПериоду

Функция ОтчетЗаЦелыйНалоговыйПериод(Форма) Экспорт
	
	Если Не ОтчетПоддерживаетВыборСНачалаГода(Форма) Тогда
		Возврат Истина;
	КонецЕсли;
	
	Возврат Форма.Отчет.СНачалаГода;
	
КонецФункции

Процедура НастроитьДиалогВыбораПериода(Форма) Экспорт
	
	БазовыеРеквизиты = БазовыеРеквизиты(Форма);
	
	Если БазовыеРеквизиты.КонецПериода < Форма.ДатаРегистрацииОрганизации Тогда
		
		БазовыеРеквизиты.КонецПериода  = КонецМесяца(Форма.ДатаРегистрацииОрганизации);
		БазовыеРеквизиты.НачалоПериода = НачалоМесяца(БазовыеРеквизиты.КонецПериода);
		
		Если ОтчетПоддерживаетВыборСНачалаГода(Форма) Тогда
			БазовыеРеквизиты.СНачалаГода = Ложь;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ОтчетПоддерживаетВыборПроизвольногоИнтервала(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	Форма.ПредставлениеПериодаВыбор = ВыборПериодаКлиентСервер.ПолучитьПредставлениеПериодаОтчета(
		ВидПериодаМесяц(),
		НачалоМесяца(БазовыеРеквизиты.КонецПериода),
		БазовыеРеквизиты.КонецПериода);
	
КонецПроцедуры

Функция ОпределитьПериодОтчета(Форма, ЦелыйИнтервал, ИмяОтчета) Экспорт
	
	ИнформацияНалоговыйПериод = Неопределено;
	
	БазовыеРеквизиты = БазовыеРеквизиты(Форма);
	
	Если ОтчетПоддерживаетВыборПроизвольногоИнтервала(Форма) Тогда
		
		ОписаниеФормы = НовыйОписаниеФормыПериодОтчета();
		ОписаниеФормы.ИмяОтчета     = ИмяОтчета;
		ОписаниеФормы.ЦелыйИнтервал = ЦелыйИнтервал;
		
		ОпределитьИнтервалОтчета(
			Форма.ПредставлениеПериодаЗаголовок,
			ИнформацияНалоговыйПериод,
			БазовыеРеквизиты.НачалоПериода,
			БазовыеРеквизиты.КонецПериода,
			ОписаниеФормы,
			БазовыеРеквизиты.Организация,
			Форма.ДатаРегистрацииОрганизации);
			
	Иначе
		
		ЦелыйИнтервал         = ОтчетЗаЦелыйНалоговыйПериод(Форма);
		ЗарегистрированаДавно = Не ЗначениеЗаполнено(Форма.ДатаРегистрацииОрганизации)
			Или КонецГода(Форма.ДатаРегистрацииОрганизации) + 1 < НачалоГода(БазовыеРеквизиты.КонецПериода);
		
		Если Не ЦелыйИнтервал И ЗарегистрированаДавно Тогда
			
			// Простой случай - дата регистрации уже не важна
			
			БазовыеРеквизиты.НачалоПериода = НачалоМесяца(БазовыеРеквизиты.КонецПериода);
				
			Форма.ПредставлениеПериодаЗаголовок = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(
				БазовыеРеквизиты.НачалоПериода,
				БазовыеРеквизиты.КонецПериода,
				Истина);
					
		Иначе
			
			ОписаниеНалоговогоПериода = СправкиРасчетыВызовСервера.ОписаниеНалоговогоПериода(
				БазовыеРеквизиты.КонецПериода,
				БазовыеРеквизиты.Организация,
				ИмяОтчета);
				
			Если ЦелыйИнтервал Или НачалоМесяца(БазовыеРеквизиты.КонецПериода) <= ОписаниеНалоговогоПериода.НачалоПериода Тогда
				
				БазовыеРеквизиты.НачалоПериода      = ОписаниеНалоговогоПериода.НачалоПериода;
				Форма.ПредставлениеПериодаЗаголовок = ОписаниеНалоговогоПериода.ПредставлениеПериода;
				
				// может требоваться отобразить особенности налогового периода
				ИнформацияНалоговыйПериод = ОписаниеНалоговогоПериода.ИнформацияНалоговыйПериод;
				
			Иначе
				
				БазовыеРеквизиты.НачалоПериода = НачалоМесяца(БазовыеРеквизиты.КонецПериода);
					
				Форма.ПредставлениеПериодаЗаголовок = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(
					БазовыеРеквизиты.НачалоПериода,
					БазовыеРеквизиты.КонецПериода,
					Истина);
					
				Если БазовыеРеквизиты.НачалоПериода = НачалоГода(БазовыеРеквизиты.НачалоПериода) Тогда
					// С точки зрения уплаты налогов, это не совсем начало года. Выведем об этом оповещение.
					ИнформацияНалоговыйПериод = ОписаниеНалоговогоПериода.ИнформацияНалоговыйПериод;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	УстановитьЗаголовокФормы(Форма);
	
	Возврат ИнформацияНалоговыйПериод;
	
КонецФункции

// Конструктор параметра ОписаниеФормы в ОпределитьИнтервалОтчета
//
Функция НовыйОписаниеФормыПериодОтчета() Экспорт
	
	ОписаниеФормы = Новый Структура;
	ОписаниеФормы.Вставить("ИмяОтчета",     "");
	ОписаниеФормы.Вставить("ЦелыйИнтервал", Истина);
	Возврат ОписаниеФормы;
	
КонецФункции

Процедура ОпределитьИнтервалОтчета(ПредставлениеПериода, ИнформацияНалоговыйПериод, НачалоПериода, КонецПериода, ОписаниеФормы, Организация, ДатаРегистрацииОрганизации) Экспорт
	
	ЦелыйИнтервал = ОписаниеФормы.ЦелыйИнтервал;
	
	// дата регистрации важна в первые месяцы регистрации - т.е. для отчетов, начинающихся ранее февраля года, следующего за годом регистрации
	ЗарегистрированаДавно = Не ЗначениеЗаполнено(ДатаРегистрацииОрганизации)
		Или КонецГода(ДатаРегистрацииОрганизации) < ДобавитьМесяц(НачалоПериода, -1);
		
	Если ЗарегистрированаДавно Тогда
		
		// Не важны особенности определения налогового периода
		ПредставлениеПериода = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(
			НачалоПериода,
			КонецПериода,
			Истина);
			
		Возврат;
		
	КонецЕсли;
		
	СНачалаГода = (НачалоПериода = НачалоГода(НачалоПериода));
	
	ОписаниеНалоговогоПериода = СправкиРасчетыВызовСервера.ОписаниеНалоговогоПериода(
		КонецПериода,
		Организация,
		ОписаниеФормы.ИмяОтчета);
	
	ИнформацияНалоговыйПериод = ОписаниеНалоговогоПериода.ИнформацияНалоговыйПериод;
	
	Если СНачалаГода И ЦелыйИнтервал И НачалоПериода >= ОписаниеНалоговогоПериода.НачалоПериода Тогда
		
		// Приведем дату к началу налогового периода, так, чтобы период включал целый интервал
		НачалоПериода        = ОписаниеНалоговогоПериода.НачалоПериода;
		ПредставлениеПериода = ОписаниеНалоговогоПериода.ПредставлениеПериода;
		
	ИначеЕсли НачалоПериода = ОписаниеНалоговогоПериода.НачалоПериода
		И КонецДня(КонецПериода) > КонецМесяца(ОписаниеНалоговогоПериода.Период)
		И КонецДня(КонецПериода) = КонецМесяца(КонецПериода) Тогда
		
		// Покажем, что речь идет о целом отчетном периоде
		ПредставлениеПериода = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(
			НачалоГода(КонецПериода),
			КонецПериода,
			Истина);
		
	ИначеЕсли СНачалаГода И НачалоПериода > ОписаниеНалоговогоПериода.НачалоПериода Тогда
		
		// Покажем, что несмотря на совпадение даты с началом календарного года,
		// отчет включает не все операции, относящиеся к этому году
		
		ПредставлениеПериода = СтрШаблон(
			НСтр("ru = '%1 - %2'"),
			Формат(НачалоПериода, "ДЛФ=D"),
			Формат(КонецПериода,  "ДЛФ=D"));
		
	Иначе
		
		ПредставлениеПериода = БухгалтерскиеОтчетыКлиентСервер.ПолучитьПредставлениеПериода(
			НачалоПериода,
			КонецПериода,
			Истина);
		
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область КонтрольПовторногоВыбораОрганизации

// Контроль повторного выбора организации используется по двум причинам:
// 1. обработка выбора организации требует контекстного вызова сервера.
//    Если повторно выбрана та же организация, то вызова можно избежать.
// 2. в СправкиРасчеты.НастроитьОтборПоОрганизации() при смене организации очищаются значения
//    полей отбора, которые могут не соответствовать организации.
//    Это действие подсистема БухгалтерскиеОтчеты выполняет без фактического контроля,
//    соответствуют они или нет.

Функция ФормаПоддерживаетКонтрольПовторногоВыбораОрганизации(Форма) Экспорт
	
	// Требования к отчету для этой поддержки
	// - реквизит формы ОрганизацияПредыдущееЗначение
	//
	// Для форм с ПоддерживаетсяВыборВсяОрганизация реквизит хранит значение ключа из СоответствиеОрганизаций,
	// соответствующее предыдущему значению сочетания выбранной организации и флага ВключатьОбособленныеПодразделения.
	//
	// Для форм без ПоддерживаетсяВыборВсяОрганизация реквизит хранит предыдущее значение ссылки на организацию.
	//
	// Тип реквизита должен соответствовать этим значениям.
	
	Возврат ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ОрганизацияПредыдущееЗначение");
	
КонецФункции

Функция ОрганизацияВыбранаПовторно(Организация, Форма) Экспорт
	
	Если Не ФормаПоддерживаетКонтрольПовторногоВыбораОрганизации(Форма) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если ТипЗнч(Форма.ОрганизацияПредыдущееЗначение) <> ТипЗнч(Организация) Тогда
		// Если в форме ПоддерживаетсяВыборВсяОрганизация,
		// то в ОрганизацияПредыдущееЗначение сохраняется значение ключа из СоответствиеОрганизаций.
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Форма.ОрганизацияПредыдущееЗначение = Организация;
	
КонецФункции

Процедура УстановитьОрганизацияПредыдущееЗначение(Форма, Организация) Экспорт
	
	Если Не ФормаПоддерживаетКонтрольПовторногоВыбораОрганизации(Форма) Тогда
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Форма.ОрганизацияПредыдущееЗначение) <> ТипЗнч(Организация) Тогда
		// Если в форме ПоддерживаетсяВыборВсяОрганизация,
		// то в ОрганизацияПредыдущееЗначение сохраняется значение ключа из СоответствиеОрганизаций.
		Возврат;
	КонецЕсли;
	
	Форма.ОрганизацияПредыдущееЗначение = Организация;
	
КонецПроцедуры

#КонецОбласти

Процедура ОтметитьОтчетНеАктуальный(Форма) Экспорт
	
	ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Форма.Элементы.Результат, "НеАктуальность");
	
	Если ЗакрытиеМесяцаКлиентСервер.ОтчетИспользуетМеханизмАктуализации(Форма) Тогда
		ЗакрытиеМесяцаКлиентСервер.СкрытьПанельАктуализации(Форма);
	КонецЕсли;
	
КонецПроцедуры

Процедура НастроитьКнопкиСохраненияРегистровБухгалтерскогоУчета(Форма, НомерНабораСуммовыхПоказателей) Экспорт
	
	КнопкаСохранитьРегистрУчетаИПодписатьЭЦП 	= Форма.Элементы.Найти("СохранитьРегистрУчетаИПодписатьЭЦП");
	КнопкаСохранитьРегистрБухгалтерскогоУчета 	= Форма.Элементы.Найти("СохранитьРегистрБухгалтерскогоУчета");
	
	Если КнопкаСохранитьРегистрУчетаИПодписатьЭЦП = Неопределено 
		Или КнопкаСохранитьРегистрБухгалтерскогоУчета = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЕстьБухгалтерскийУчет = НаборСуммовыхПоказателейВключаетБухгалтерскийУчет(НомерНабораСуммовыхПоказателей);
	
	Форма.Элементы.СохранитьРегистрБухгалтерскогоУчета.Доступность            = ЕстьБухгалтерскийУчет;
	Форма.Элементы.СохранитьРегистрУчетаИПодписатьЭЦП.Доступность             = ЕстьБухгалтерскийУчет;
	Форма.Элементы.СохранитьРегистрБухгалтерскогоУчетаВсеДействия.Доступность = ЕстьБухгалтерскийУчет;
	Форма.Элементы.СохранитьРегистрУчетаИПодписатьЭЦПВсеДействия.Доступность  = ЕстьБухгалтерскийУчет;
	
КонецПроцедуры	

#Область ДлительныеОперации

// РезультатЗапуска - см. ДлительныеОперации.ВыполнитьВФоне()
//
Функция ЗавершитьФормированиеОтчета(Форма, РезультатЗапуска) Экспорт
	
	Если РезультатЗапуска = Неопределено Тогда
		// Пользователь устал ждать
		Возврат Ложь;
	КонецЕсли;
		
	Если РезультатЗапуска.Статус = "Выполнено" Тогда
		
		// Все действия выполним на сервере для оптимизации клиент-серверного взаимодействия.
		// Будет выполнена СправкиРасчеты.ЗавершитьФормированиеОтчета().
		
		Возврат Истина;
		
	КонецЕсли;
		
	Если РезультатЗапуска.Статус = "Ошибка" Тогда
		
		ОтобразитьОшибкуФормированияОтчета(Форма.Элементы.Результат, РезультатЗапуска.КраткоеПредставлениеОшибки);
		
	ИначеЕсли РезультатЗапуска.Статус = "Отменено" Тогда
		
		ОбщегоНазначенияКлиентСервер.УстановитьСостояниеПоляТабличногоДокумента(Форма.Элементы.Результат, "Неактуальность");
		
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ТребуетсяНастроитьСписокВыбораНабораСуммовыхПоказателей(СписокВыбора, ДоступныеНаборы)
	
	НастроенныеНаборы = СписокВыбора.ВыгрузитьЗначения();
	Если НастроенныеНаборы.Количество() <> ДоступныеНаборы.Количество() Тогда
		Возврат Истина;
	КонецЕсли;
	
	НедостающиеНаборы = ОбщегоНазначенияКлиентСервер.РазностьМассивов(ДоступныеНаборы, НастроенныеНаборы);
	Возврат ЗначениеЗаполнено(НедостающиеНаборы);
	
КонецФункции

Функция ПредставленияНаборовСуммовыхПоказателей()
	
	// См. также НазваниеНабораСуммовыхПоказателей
	
	Представления = Новый Соответствие;
	
	Представления.Вставить(
		НомерНабораСуммовыхПоказателейПоУмолчанию(),
		НСтр("ru = 'БУ (данные бухгалтерского учета)'"));
		
	Представления.Вставить(
		НомерНабораСуммовыхПоказателейНалоговыйУчет(),
		НСтр("ru = 'НУ (данные налогового учета)'"));
	
	Представления.Вставить(
		НомерНабораСуммовыхПоказателейОтложенногоНалога(),
		НСтр("ru = 'БУ, ПР, ВР (данные бухгалтерского учета с постоянными и временными разницами)'"));
	
	Представления.Вставить(
		НомерНабораСуммовыхПоказателейСверкиНалоговогоУчета(),
		НСтр("ru = 'БУ, НУ (данные бухгалтерского и налогового учета)'"));
		
	Возврат Представления;
		
КонецФункции

#Область ДлительныеОперации

Процедура ОтобразитьОшибкуФормированияОтчета(ПолеРезультат, ОписаниеОшибки)
	
	Если ПустаяСтрока(ОписаниеОшибки) Тогда
		Возврат;
	КонецЕсли;
	
	ШаблонИнформации = НСтр("ru = 'Ошибка при формировании отчета:
                             |%1
							 |Детальная информация записана в журнал регистрации.'");
	
	ИнформацияДляПользователя = СтрШаблон(ШаблонИнформации, ОписаниеОшибки);
	
	ОтображениеСостояния = ПолеРезультат.ОтображениеСостояния;
	ОтображениеСостояния.Видимость                      = Истина;
	ОтображениеСостояния.ДополнительныйРежимОтображения = ДополнительныйРежимОтображения.Неактуальность;
	ОтображениеСостояния.Картинка                       = Новый Картинка;
	ОтображениеСостояния.Текст                          = ОписаниеОшибки;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
