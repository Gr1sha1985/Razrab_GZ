////////////////////////////////////////////////////////////////////////////////
// Отражение зарплаты в учете
// Базовая реализация изменяемого поведения.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Дополняет записи набора записей регистра СведенияОДоходахНДФЛ
// аналитикой: Статьи финансирования и/или Статьи расходов
//
// Параметры: 
//		Движения - коллекции наборов записей движений документа, должна содержать коллекции еще не записанных наборов
//			СведенияОДоходахНДФЛ
//			НачисленияУдержанияПоСотрудникамАвансом - коллекция может отсутствовать или быть пустой.
//			НачисленияУдержанияПоСотрудникам - коллекция может отсутствовать или быть пустой.
//		
Процедура ДополнитьСведенияОДоходахНДФЛСведениямиОРаспределенииПоСтатьям(Движения) Экспорт

	Если Движения.Найти("НачисленияУдержанияПоСотрудникам") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	РаспределениеНачислений = Движения["НачисленияУдержанияПоСотрудникам"].Выгрузить();
	Если РаспределениеНачислений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("РаспределениеНачислений", РаспределениеНачислений);
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РаспределениеНачислений.ФизическоеЛицо КАК ФизическоеЛицо,
	|	РаспределениеНачислений.НачислениеУдержание КАК Начисление,
	|	РаспределениеНачислений.ДатаНачала КАК ДатаНачала,
	|	РаспределениеНачислений.Подразделение КАК Территория,
	|	РаспределениеНачислений.Сотрудник КАК Сотрудник,
	|	РаспределениеНачислений.Подразделение КАК Подразделение,
	|	РаспределениеНачислений.СтатьяФинансирования КАК СтатьяФинансирования,
	|	РаспределениеНачислений.СтатьяРасходов КАК СтатьяРасходов,
	|	РаспределениеНачислений.Сумма КАК Сумма
	|ПОМЕСТИТЬ ВТРаспределениеНачислений
	|ИЗ
	|	&РаспределениеНачислений КАК РаспределениеНачислений
	|ГДЕ
	|	РаспределениеНачислений.ГруппаНачисленияУдержанияВыплаты = ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Начислено)
	|	И РаспределениеНачислений.Сумма <> 0";
	Запрос.Выполнить();
	
	СведенияОДоходах = Движения.СведенияОДоходахНДФЛ.Выгрузить();
	
	НовыеСведенияОДоходах = ОтражениеЗарплатыВУчете.НовыеСведенияОДоходахДополненныеСтатьями(СведенияОДоходах, Запрос.МенеджерВременныхТаблиц);
	Если НовыеСведенияОДоходах.Количество()>0 Тогда
		Движения.СведенияОДоходахНДФЛ.Загрузить(НовыеСведенияОДоходах);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Создает временную таблицу с полями
//  ФизическоеЛицо
//  ДокументОснование.
//  Контрагент
//  Удержание
//
Процедура СоздатьВТУдержанияПоСотрудникамКонтрагент(МенеджерВременныхТаблиц) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	УдержанияПоСотрудникам.ФизическоеЛицо,
	|	УдержанияПоСотрудникам.ДокументОснование,
	|	УдержанияПоСотрудникам.Удержание,
	|	ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка) КАК Контрагент
	|ПОМЕСТИТЬ ВТУдержанияПоСотрудникамКонтрагент
	|ИЗ
	|	ВТУдержанияПоСотрудникам КАК УдержанияПоСотрудникам";
	
	Запрос.Выполнить();

КонецПроцедуры

Процедура СоздатьВТРаспределениеНачисленийДляУдержаний(ОтборФизическиеЛица, ИсключаемыеРегистраторы, ПараметрыРаспределения) Экспорт
	
	Организация 			= ПараметрыРаспределения.Организация;
	ПериодРегистрации 		= ПараметрыРаспределения.ПериодРегистрации;
	МенеджерВременныхТаблиц = ПараметрыРаспределения.МенеджерВременныхТаблиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ДатаНачала", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("ФизическиеЛица", ОтборФизическиеЛица);
	Запрос.УстановитьПараметр("ИсключаемыеРегистраторы", ИсключаемыеРегистраторы);
	
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Начисления.Сотрудник КАК Сотрудник,
	|	Начисления.Подразделение КАК Подразделение,
	|	ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка) КАК ПодразделениеУчетаЗатрат,
	|	Начисления.НачислениеУдержание КАК НачислениеУдержание,
	|	Начисления.СтатьяФинансирования КАК СтатьяФинансирования,
	|	Начисления.СтатьяРасходов КАК СтатьяРасходов,
	|	Начисления.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
	|	Начисления.ДатаНачала КАК ДатаНачала,
	|	Начисления.Сумма КАК Сумма
	|ПОМЕСТИТЬ ВТРаспределениеНачисленийДляУдержаний
	|ИЗ
	|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК Начисления
	|ГДЕ
	|	Начисления.Организация = &Организация
	|	И Начисления.Период МЕЖДУ &ДатаНачала И &ДатаОкончания
	|	И Начисления.ГруппаНачисленияУдержанияВыплаты = ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Начислено)
	|	И Начисления.ФизическоеЛицо В(&ФизическиеЛица)
	|	И НЕ Начисления.ДанныеМежрасчетногоПериода
	|	И НЕ Начисления.Регистратор В (&ИсключаемыеРегистраторы)";
	
	Запрос.Выполнить();
	
КонецПроцедуры

Функция ТипыПоляДокументОснование() Экспорт
	
	Возврат Метаданные.ОпределяемыеТипы.ОснованиеНачисленияУдержания.Тип.Типы();
	
КонецФункции

Функция ТипыПоляПервичныйРегистратор() Экспорт

	Возврат Неопределено;

КонецФункции

// Возвращает структуру с данными для распределения НДФЛ по статьям.
//
// Параметры:
// 		ПараметрыРаспределения - Структура, описание см НовоеОписаниеПараметровРаспределенияНДФЛ.
//
// Возвращаемое значение:
// 		Структура - Ключ содержит имя данных
// 			* БазаВсеНачисления - ТаблицаЗначений
// 			* СтрокиУжеУдержано - Соответствие.
//
Функция ДанныеДляРаспределенияНДФЛ(ПараметрыРаспределения) Экспорт

	ДанныеДляРаспределенияНДФЛ = Новый Структура("БазаВсеНачисления, СтрокиУжеУдержано");
	ДанныеДляРаспределенияНДФЛ.СтрокиУжеУдержано = Новый Соответствие;
	
	МенеджерВременныхТаблиц = ПараметрыРаспределения.МенеджерВременныхТаблиц;
	Организация 			= ПараметрыРаспределения.Организация;
	ПериодРегистрации 		= ПараметрыРаспределения.ПериодРегистрации;
	МассивФизическихЛиц 	= ПараметрыРаспределения.МассивФизическихЛиц;
	МассивУдержаний 		= ПараметрыРаспределения.МассивУдержаний;
	ИсключаемыйРегистратор 	= ПараметрыРаспределения.ИсключаемыйРегистратор;
	ОкончательныйРасчет 	= ПараметрыРаспределения.ОкончательныйРасчет;
	ИмяВТДанныеТекущегоДокумента = ПараметрыРаспределения.ИмяВТДанныеТекущегоДокумента;
	
	Запрос = Новый Запрос();
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	
	Запрос.УстановитьПараметр("ДатаНачала", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ФизическиеЛица", МассивФизическихЛиц);
	
	УдалитьВТ = Новый Массив;
	
	Если ОкончательныйРасчет Тогда
		
		// Если таблица существует, отбор выполняем по ней,
		// иначе будем использовать отбор по ИсключаемыеРегистраторы.
		СуществуетТаблицаУсловий = ЗарплатаКадры.ВТСуществует(МенеджерВременныхТаблиц, "ВТУсловияОтбораДляРаспределенияНДФЛ");
		ТаблицаУсловийПустая = Истина;
		Если СуществуетТаблицаУсловий Тогда
			ТаблицаУсловийПустая = Не ЗарплатаКадры.ВТСодержитСтроки(МенеджерВременныхТаблиц, "ВТУсловияОтбораДляРаспределенияНДФЛ");
		КонецЕсли;
		
		// Массив будет использоваться в условиях отбора,
		// если не переданы основания, учтенные при расчете НДФЛ.
		ИсключаемыеРегистраторы = Новый Массив;
		ИсключаемыеРегистраторы.Добавить(ИсключаемыйРегистратор);
		
		// Получим уже зарегистрированное распределение начислений.
		// Если есть основания, учтенные при расчете НДФЛ, то по ним,
		// иначе без учета исключаемых регистраторов и без учета начислений межрасчетного периода.
		СоздатьВТРаспределениеНачисленийДляНДФЛ(ПараметрыРаспределения, СуществуетТаблицаУсловий, ИсключаемыеРегистраторы);
		УдалитьВТ.Добавить("ВТРаспределениеНачисленийДляНДФЛ");

		// Получение сведений об уже выполненных удержаниях.
		Если Не СуществуетТаблицаУсловий Или Не ТаблицаУсловийПустая Тогда
			
			// Определим условия отбора данных.
			Если СуществуетТаблицаУсловий Тогда
				УсловиеОтбора = "
				|	ВТУсловияОтбораДляРаспределенияНДФЛ КАК УсловияОтбора
				|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержания
				|		ПО УсловияОтбора.Регистратор = НачисленияУдержания.Регистратор
				|			И УсловияОтбора.ФизическоеЛицо = НачисленияУдержания.ФизическоеЛицо
				|			И НачисленияУдержания.НачислениеУдержание В(&Удержания)";
			Иначе
				Запрос.УстановитьПараметр("ИсключаемыеРегистраторы", ИсключаемыеРегистраторы);
				УсловиеОтбора = "
				|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержания
				|ГДЕ
				|	НачисленияУдержания.Организация = &Организация
				|	И НачисленияУдержания.НачислениеУдержание В(&Удержания)
				|	И НачисленияУдержания.Период МЕЖДУ &ДатаНачала И &ДатаОкончания
				|	И НачисленияУдержания.ФизическоеЛицо В(&ФизическиеЛица)
				|	И НЕ НачисленияУдержания.ДанныеМежрасчетногоПериода
				|	И НЕ НачисленияУдержания.Регистратор В (&ИсключаемыеРегистраторы)";
			КонецЕсли;
			
			Запрос.УстановитьПараметр("Удержания", МассивУдержаний);
			Запрос.Текст = 
			"ВЫБРАТЬ
			|	НачисленияУдержания.Сотрудник КАК Сотрудник,
			|	НачисленияУдержания.ФизическоеЛицо КАК ФизическоеЛицо,
			|	НачисленияУдержания.Подразделение КАК Территория,
			|	НачисленияУдержания.Подразделение КАК Подразделение,
			|	НачисленияУдержания.НачислениеУдержание КАК ВидУдержания,
			|	НачисленияУдержания.ДатаПолученияДохода КАК ДатаПолученияДохода,
			|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
			|	НачисленияУдержания.СтатьяРасходов КАК СтатьяРасходов,
			|	НачисленияУдержания.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
			|	НачисленияУдержания.КатегорияДохода КАК КатегорияДохода,
			|	СУММА(НачисленияУдержания.Сумма) КАК Сумма
			|ИЗ
			|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержания
			|
			|СГРУППИРОВАТЬ ПО
			|	НачисленияУдержания.Сотрудник,
			|	НачисленияУдержания.ФизическоеЛицо,
			|	НачисленияУдержания.Подразделение,
			|	НачисленияУдержания.НачислениеУдержание,
			|	НачисленияУдержания.СтатьяРасходов,
			|	НачисленияУдержания.ДатаПолученияДохода,
			|	НачисленияУдержания.КатегорияДохода,
			|	НачисленияУдержания.Подразделение,
			|	НачисленияУдержания.ВидДоходаИсполнительногоПроизводства
			|
			|ИМЕЮЩИЕ
			|	СУММА(НачисленияУдержания.Сумма) <> 0";
			
			Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержания", УсловиеОтбора);
			
			ДанныеДляРаспределенияНДФЛ.СтрокиУжеУдержано = ОтражениеЗарплатыВУчете.СтрокиТаблицыЗначенийПоФизическимЛицам(Запрос.Выполнить().Выгрузить());
			
		КонецЕсли;
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РаспределениеНачислений.Сотрудник КАК Сотрудник,
		|	РаспределениеНачислений.Территория КАК Территория,
		|	РаспределениеНачислений.Подразделение КАК Подразделение,
		|	РаспределениеНачислений.Начисление КАК Начисление,
		|	РаспределениеНачислений.ДатаНачала КАК ДатаНачала,
		|	РаспределениеНачислений.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
		|	РаспределениеНачислений.СтатьяРасходов КАК СтатьяРасходов,
		|	РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
		|	СУММА(РаспределениеНачислений.Сумма) КАК Сумма
		|ПОМЕСТИТЬ ВТРаспределениеНачисленийДляБазыНДФЛ
		|ИЗ
		|	(ВЫБРАТЬ
		|		РаспределениеНачислений.Сотрудник КАК Сотрудник,
		|		РаспределениеНачислений.Подразделение КАК Территория,
		|		РаспределениеНачислений.НачислениеУдержание КАК Начисление,
		|		РаспределениеНачислений.ФизическоеЛицо КАК ФизическоеЛицо,
		|		РаспределениеНачислений.СтатьяРасходов КАК СтатьяРасходов,
		|		РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
		|		РаспределениеНачислений.ДатаНачала КАК ДатаНачала,
		|		РаспределениеНачислений.Сумма КАК Сумма,
		|		РаспределениеНачислений.Подразделение КАК Подразделение
		|	ИЗ
		|		ВТРаспределениеНачисленийДляНДФЛ КАК РаспределениеНачислений
		|	
		|	ОБЪЕДИНИТЬ ВСЕ
		|	
		|	ВЫБРАТЬ
		|		РаспределениеНачислений.Сотрудник,
		|		РаспределениеНачислений.Подразделение,
		|		РаспределениеНачислений.Начисление,
		|		РаспределениеНачислений.ФизическоеЛицо,
		|		РаспределениеНачислений.СтатьяРасходов,
		|		РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства,
		|		РаспределениеНачислений.ДатаНачала,
		|		РаспределениеНачислений.Сумма,
		|		РаспределениеНачислений.Подразделение
		|	ИЗ
		|		ВТРаспределениеНачисленийТекущегоДокумента КАК РаспределениеНачислений
		|	ГДЕ
		|		РаспределениеНачислений.ФизическоеЛицо В(&ФизическиеЛица)) КАК РаспределениеНачислений
		|
		|СГРУППИРОВАТЬ ПО
		|	РаспределениеНачислений.Сотрудник,
		|	РаспределениеНачислений.Подразделение,
		|	РаспределениеНачислений.Начисление,
		|	РаспределениеНачислений.ФизическоеЛицо,
		|	РаспределениеНачислений.СтатьяРасходов,
		|	РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства,
		|	РаспределениеНачислений.Территория,
		|	РаспределениеНачислений.ДатаНачала
		|
		|ИМЕЮЩИЕ
		|	СУММА(РаспределениеНачислений.Сумма) <> 0
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	РаспределениеНачисленийДляБазыНДФЛ.Сотрудник КАК Сотрудник,
		|	РаспределениеНачисленийДляБазыНДФЛ.Территория КАК Территория,
		|	РаспределениеНачисленийДляБазыНДФЛ.Подразделение КАК Подразделение,
		|	РаспределениеНачисленийДляБазыНДФЛ.Начисление КАК Начисление,
		|	РаспределениеНачисленийДляБазыНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
		|	РаспределениеНачисленийДляБазыНДФЛ.СтатьяФинансирования КАК СтатьяФинансирования,
		|	РаспределениеНачисленийДляБазыНДФЛ.СтатьяРасходов КАК СтатьяРасходов,
		|	РаспределениеНачисленийДляБазыНДФЛ.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
		|	РаспределениеНачисленийДляБазыНДФЛ.Сумма КАК Сумма
		|ИЗ
		|	ВТРаспределениеНачисленийДляБазыНДФЛ КАК РаспределениеНачисленийДляБазыНДФЛ";
		
	Иначе
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РаспределениеНачислений.Сотрудник КАК Сотрудник,
		|	РаспределениеНачислений.Подразделение КАК Территория,
		|	РаспределениеНачислений.Подразделение КАК Подразделение,
		|	РаспределениеНачислений.Начисление КАК Начисление,
		|	РаспределениеНачислений.ФизическоеЛицо КАК ФизическоеЛицо,
		|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
		|	РаспределениеНачислений.СтатьяРасходов КАК СтатьяРасходов,
		|	РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
		|	РаспределениеНачислений.ДатаНачала КАК ДатаНачала,
		|	СУММА(РаспределениеНачислений.Сумма) КАК Сумма
		|ПОМЕСТИТЬ ВТРаспределениеНачисленийДляБазыНДФЛ
		|ИЗ
		|	ВТРаспределениеНачисленийТекущегоДокумента КАК РаспределениеНачислений
		|ГДЕ
		|	РаспределениеНачислений.ФизическоеЛицо В(&ФизическиеЛица)
		|
		|СГРУППИРОВАТЬ ПО
		|	РаспределениеНачислений.Подразделение,
		|	РаспределениеНачислений.Начисление,
		|	РаспределениеНачислений.ДатаНачала,
		|	РаспределениеНачислений.ФизическоеЛицо,
		|	РаспределениеНачислений.Сотрудник,
		|	РаспределениеНачислений.СтатьяРасходов,
		|	РаспределениеНачислений.ВидДоходаИсполнительногоПроизводства,
		|	РаспределениеНачислений.Подразделение
		|
		|ИМЕЮЩИЕ
		|	СУММА(РаспределениеНачислений.Сумма) <> 0
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	РаспределениеНачисленийДляБазыНДФЛ.Сотрудник КАК Сотрудник,
		|	РаспределениеНачисленийДляБазыНДФЛ.Территория КАК Территория,
		|	РаспределениеНачисленийДляБазыНДФЛ.Подразделение КАК Подразделение,
		|	РаспределениеНачисленийДляБазыНДФЛ.Начисление КАК Начисление,
		|	РаспределениеНачисленийДляБазыНДФЛ.ФизическоеЛицо КАК ФизическоеЛицо,
		|	РаспределениеНачисленийДляБазыНДФЛ.СтатьяФинансирования КАК СтатьяФинансирования,
		|	РаспределениеНачисленийДляБазыНДФЛ.СтатьяРасходов КАК СтатьяРасходов,
		|	РаспределениеНачисленийДляБазыНДФЛ.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
		|	РаспределениеНачисленийДляБазыНДФЛ.Сумма КАК Сумма
		|ИЗ
		|	ВТРаспределениеНачисленийДляБазыНДФЛ КАК РаспределениеНачисленийДляБазыНДФЛ";
		
	КонецЕсли;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "ВТРаспределениеНачисленийТекущегоДокумента", ИмяВТДанныеТекущегоДокумента);
	ДанныеДляРаспределенияНДФЛ.БазаВсеНачисления = Запрос.Выполнить().Выгрузить();
	
	ЗарплатаКадры.УничтожитьВТ(МенеджерВременныхТаблиц, УдалитьВТ);
	
	Возврат ДанныеДляРаспределенияНДФЛ;

КонецФункции

Процедура СоздатьВТРаспределениеНачисленийДляНДФЛ(ПараметрыРаспределения, СуществуетТаблицаУсловий, ИсключаемыеРегистраторы)
	
	Организация 			= ПараметрыРаспределения.Организация;
	ПериодРегистрации 		= ПараметрыРаспределения.ПериодРегистрации;
	МенеджерВременныхТаблиц = ПараметрыРаспределения.МенеджерВременныхТаблиц;
	МассивФизическихЛиц 	= ПараметрыРаспределения.МассивФизическихЛиц;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.УстановитьПараметр("ДатаНачала", НачалоМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("ДатаОкончания", КонецМесяца(ПериодРегистрации));
	Запрос.УстановитьПараметр("ФизическиеЛица", МассивФизическихЛиц);
	
	Если Не СуществуетТаблицаУсловий Тогда
		Запрос.УстановитьПараметр("ИсключаемыеРегистраторы", ИсключаемыеРегистраторы);
		УсловиеОтбора = "
		|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК Начисления
		|ГДЕ
		|	Начисления.Организация = &Организация
		|	И Начисления.Период МЕЖДУ &ДатаНачала И &ДатаОкончания
		|	И Начисления.ГруппаНачисленияУдержанияВыплаты = ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Начислено)
		|	И Начисления.ФизическоеЛицо В(&ФизическиеЛица)
		|	И НЕ Начисления.ДанныеМежрасчетногоПериода
		|	И НЕ Начисления.Регистратор В (&ИсключаемыеРегистраторы)";
	Иначе
		УсловиеОтбора = "
		|	ВТУсловияОтбораДляРаспределенияНДФЛ КАК УсловияОтбора
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК Начисления
		|		ПО УсловияОтбора.Регистратор = Начисления.Регистратор
		|			И УсловияОтбора.ФизическоеЛицо = Начисления.ФизическоеЛицо
		|			И Начисления.ГруппаНачисленияУдержанияВыплаты = ЗНАЧЕНИЕ(Перечисление.ГруппыНачисленияУдержанияВыплаты.Начислено)";
	КонецЕсли;
		
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	Начисления.ФизическоеЛицо КАК ФизическоеЛицо,
	|	Начисления.Сотрудник КАК Сотрудник,
	|	Начисления.Подразделение КАК Подразделение,
	|	Начисления.НачислениеУдержание КАК НачислениеУдержание,
	|	Начисления.СтатьяРасходов КАК СтатьяРасходов,
	|	Начисления.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
	|	Начисления.ДатаНачала КАК ДатаНачала,
	|	Начисления.Сумма КАК Сумма
	|ПОМЕСТИТЬ ВТРаспределениеНачисленийДляНДФЛ
	|ИЗ
	|	РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК Начисления";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК Начисления", УсловиеОтбора);
	Запрос.Выполнить();
	
КонецПроцедуры

Функция БазаРаспределенияНДФЛКУдержанию(ТаблицаУсловийОтбора, ПоСотрудникам) Экспорт

	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
	Запрос.УстановитьПараметр("ТаблицаУсловийОтбора", ТаблицаУсловийОтбора);
	
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ТаблицаУсловийОтбора.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ТаблицаУсловийОтбора.ДокументОснование КАК ДокументОснование
	|ПОМЕСТИТЬ ВТСписокУсловий
	|ИЗ
	|	&ТаблицаУсловийОтбора КАК ТаблицаУсловийОтбора
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаУсловийОтбора.ФизическоеЛицо КАК ФизическоеЛицо,
	|	ТаблицаУсловийОтбора.ДокументОснование КАК ДокументОснование,
	|	НачисленияУдержания.Подразделение КАК Подразделение,
	|	НачисленияУдержания.КатегорияДохода КАК КатегорияДохода,
	|	ЗНАЧЕНИЕ(Справочник.СтатьиФинансированияЗарплата.ПустаяСсылка) КАК СтатьяФинансирования,
	|	НачисленияУдержания.СтатьяРасходов КАК СтатьяРасходов,
	|	НачисленияУдержания.ВидДоходаИсполнительногоПроизводства КАК ВидДоходаИсполнительногоПроизводства,
	|	НачисленияУдержания.НачислениеУдержание КАК ВидУдержания,
	|	СУММА(НачисленияУдержания.Сумма) КАК Сумма
	|ИЗ
	|	ВТСписокУсловий КАК ТаблицаУсловийОтбора
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрНакопления.НачисленияУдержанияПоСотрудникам КАК НачисленияУдержания
	|		ПО ТаблицаУсловийОтбора.ДокументОснование = НачисленияУдержания.Регистратор
	|			И ТаблицаУсловийОтбора.ФизическоеЛицо = НачисленияУдержания.ФизическоеЛицо
	|			И (НачисленияУдержания.НачислениеУдержание В (ЗНАЧЕНИЕ(Перечисление.ВидыОсобыхНачисленийИУдержаний.НДФЛ), ЗНАЧЕНИЕ(Перечисление.ВидыОсобыхНачисленийИУдержаний.НДФЛСПревышения)))
	|			И (НЕ НачисленияУдержания.Сторно)
	|
	|СГРУППИРОВАТЬ ПО
	|	ТаблицаУсловийОтбора.ФизическоеЛицо,
	|	ТаблицаУсловийОтбора.ДокументОснование,
	|	НачисленияУдержания.Подразделение,
	|	НачисленияУдержания.КатегорияДохода,
	|	НачисленияУдержания.СтатьяРасходов,
	|	НачисленияУдержания.ВидДоходаИсполнительногоПроизводства,
	|	НачисленияУдержания.НачислениеУдержание
	|
	|ИМЕЮЩИЕ
	|	СУММА(НачисленияУдержания.Сумма) <> 0";
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

Процедура ДополнитьБазуУдержанийПоУмолчаниюСтатьями(БазаПоУмолчанию, Организация, ПериодРегистрации) Экспорт

	БазаПоУмолчанию.Колонки.Добавить("СтатьяФинансирования", Новый ОписаниеТипов("СправочникСсылка.СтатьиФинансированияЗарплата"));
	БазаПоУмолчанию.Колонки.Добавить("СтатьяРасходов", Новый ОписаниеТипов("СправочникСсылка.СтатьиРасходовЗарплата"));
	
	СтатьиРасходовПоСпособамРасчетов  = ЗарплатаКадры.СтатьиРасходовПоСпособамРасчетовСФизическимиЛицами();
	РасчетыПоОплатеТруда = СтатьиРасходовПоСпособамРасчетов[Перечисления.СпособыРасчетовСФизическимиЛицами.ОплатаТруда];
	
	БазаПоУмолчанию.ЗаполнитьЗначения(РасчетыПоОплатеТруда, "СтатьяРасходов");

КонецПроцедуры

// Возвращает результат распределения НДФЛ по рабочим местам и статьям.
//
// Параметры:
//  ТаблицаНДФЛ       - ТаблицаЗначений - структура таблицы см НоваяТаблицаРезультатРасчетаНДФЛ.
//  База              - ТаблицаЗначений - рассчитанная база для распределения.
//  БазаВсеНачисления - ТаблицаЗначений - сведения для распределения тех строк, для которых нет базы.
//  СтрокиУжеУдержано - Соответствие    - сведения об уже зарегистрированных распределения НДФЛ в разрезе физических лиц.
//  Организация       - СправочникСсылка.Организации.
//  ПериодРегистрации - Дата.
//
// Возвращаемое значение:
//  ТаблицаЗначений - описание см НоваяТаблицаРаспределениеРезультатовУдержаний.
//
Функция НДФЛПоРабочимМестамИСтатьям(ТаблицаНДФЛ, База, БазаВсеНачисления,
										СтрокиУжеУдержано, Организация, ПериодРегистрации) Экспорт
										
										
	РезультатыРаспределения = ОтражениеЗарплатыВУчете.НоваяТаблицаРаспределениеРезультатовУдержаний();
	Если ТаблицаНДФЛ.Количество() = 0 Тогда
		Возврат РезультатыРаспределения;
	КонецЕсли;
	
	ОбщегоНазначенияБЗК.ДобавитьИндексКоллекции(База, "ФизическоеЛицо");
	ОбщегоНазначенияБЗК.ДобавитьИндексКоллекции(БазаВсеНачисления, "ФизическоеЛицо");
	
	СтрокиБезБазы = Новый Массив;
	Отбор = Новый Структура("ФизическоеЛицо");
	
	ДатаИзмененияПорядкаИсчисленияНалога = УчетНДФЛ.ДатаИзмененияПорядкаИсчисленияНалогаДляИностранцев();
	
	Для Каждого СтрокаНДФЛ Из ТаблицаНДФЛ Цикл
		
		УчитыватьДатуПолученияДохода = ЗначениеЗаполнено(СтрокаНДФЛ.ДатаПолученияДохода) И СтрокаНДФЛ.ДатаПолученияДохода >= ДатаИзмененияПорядкаИсчисленияНалога;
		УчитыватьКатегориюДохода     = УчитыватьДатуПолученияДохода И ЗначениеЗаполнено(СтрокаНДФЛ.КатегорияДохода) И СтрокаНДФЛ.ДатаПолученияДохода >= '20170101';
		УчитыватьУжеРаспределенные   = (СтрокаНДФЛ.Сумма <> 0);
		
		СтрокиУжеУдержаноПоФизическомуЛицу = СтрокиУжеУдержано[СтрокаНДФЛ.ФизическоеЛицо];
		СтрокиРанееУдержано = Новый Массив;
		СтарыйАлгоритм = Ложь;
		РанееУдержано = 0;
		Если УчитыватьУжеРаспределенные И СтрокиУжеУдержаноПоФизическомуЛицу <> Неопределено Тогда
			
			СтрокиРанееУдержаноСтарыйАлгоритм = Новый Массив;
			РанееУдержаноСтарыйАлгоритм = 0;
			
			Для Каждого СтрокаУжеУдержано Из СтрокиУжеУдержаноПоФизическомуЛицу Цикл
				
				Если СтрокаУжеУдержано.ВидУдержания = СтрокаНДФЛ.ВидУдержания 
						И СтрокаУжеУдержано.Территория = СтрокаНДФЛ.Территория Тогда
						
					Если СтрокаУжеУдержано.КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ДоходыПредыдущихРедакций Тогда
						СтарыйАлгоритм = Истина;
					КонецЕсли;
					
					Если (Не УчитыватьДатуПолученияДохода Или СтрокаУжеУдержано.ДатаПолученияДохода = СтрокаНДФЛ.ДатаПолученияДохода)
								И (Не УчитыватьКатегориюДохода Или СтрокаУжеУдержано.КатегорияДохода = СтрокаНДФЛ.КатегорияДохода) Тогда
						СтрокиРанееУдержано.Добавить(СтрокаУжеУдержано);
						РанееУдержано = РанееУдержано + СтрокаУжеУдержано.Сумма;
					КонецЕсли;
					
					СтрокиРанееУдержаноСтарыйАлгоритм.Добавить(СтрокаУжеУдержано);
					РанееУдержаноСтарыйАлгоритм = РанееУдержаноСтарыйАлгоритм + СтрокаУжеУдержано.Сумма;
						
				КонецЕсли;
				
			КонецЦикла;
			
			Если СтарыйАлгоритм Тогда
				СтрокиРанееУдержано = СтрокиРанееУдержаноСтарыйАлгоритм;
				РанееУдержано = РанееУдержаноСтарыйАлгоритм;
			КонецЕсли;
			
		КонецЕсли;
		
		СтрокиРаспределения = Новый Массив;
		Отбор.ФизическоеЛицо = СтрокаНДФЛ.ФизическоеЛицо;
		СтрокиБазыПоФизлицу  = База.НайтиСтроки(Отбор);
		
		Если СтарыйАлгоритм Или Не УчитыватьДатуПолученияДохода Тогда
			
			СтрокиРаспределенияБезТерритории = Новый Массив;
			Для каждого СтрокаТЗ Из СтрокиБазыПоФизлицу Цикл
				Если Не СтрокаТЗ.ДоходМежрасчетногоПериода Тогда 
					Если СтрокаТЗ.Территория = СтрокаНДФЛ.Территория Тогда
						СтрокиРаспределения.Добавить(СтрокаТЗ);
					КонецЕсли;
					СтрокиРаспределенияБезТерритории.Добавить(СтрокаТЗ);
				КонецЕсли;
			КонецЦикла;
			
			Если СтрокиРаспределения.Количество() = 0 Тогда
				СтрокиРаспределения = СтрокиРаспределенияБезТерритории;
			КонецЕсли;
			
		ИначеЕсли Не УчитыватьКатегориюДохода Тогда
			
			СтрокиРаспределенияБезДаты = Новый Массив;
			Для каждого СтрокаТЗ Из СтрокиБазыПоФизлицу Цикл
				Если СтрокаТЗ.Территория = СтрокаНДФЛ.Территория И СтрокаТЗ.ДатаПолученияДохода = СтрокаНДФЛ.ДатаПолученияДохода Тогда
					СтрокиРаспределения.Добавить(СтрокаТЗ);	
				ИначеЕсли СтрокаТЗ.Территория = СтрокаНДФЛ.Территория Тогда
					СтрокиРаспределенияБезДаты.Добавить(СтрокаТЗ);
				КонецЕсли;
			КонецЦикла;
			
			Если СтрокиРаспределения.Количество() = 0 Тогда
				СтрокиРаспределения = СтрокиРаспределенияБезДаты;
				Если СтрокиРаспределения.Количество() = 0 Тогда
					СтрокиРаспределения = СтрокиБазыПоФизлицу;
				КонецЕсли;
			КонецЕсли;
			
		Иначе // учитываем дату получения дохода и категорию дохода
			
			СтрокиРаспределенияБезДатыИКатегорий = Новый Массив;
			СтрокиРаспределенияБезКатегорий = Новый Массив;
			Для каждого СтрокаТЗ Из СтрокиБазыПоФизлицу Цикл
				Если СтрокаТЗ.Территория = СтрокаНДФЛ.Территория И СтрокаТЗ.ДатаПолученияДохода = СтрокаНДФЛ.ДатаПолученияДохода  И СтрокаТЗ.КатегорияДохода = СтрокаНДФЛ.КатегорияДохода Тогда
					СтрокиРаспределения.Добавить(СтрокаТЗ);
				ИначеЕсли СтрокаТЗ.Территория = СтрокаНДФЛ.Территория И СтрокаТЗ.ДатаПолученияДохода = СтрокаНДФЛ.ДатаПолученияДохода Тогда
					СтрокиРаспределенияБезКатегорий.Добавить(СтрокаТЗ);	
				ИначеЕсли СтрокаТЗ.Территория = СтрокаНДФЛ.Территория Тогда
					СтрокиРаспределенияБезДатыИКатегорий.Добавить(СтрокаТЗ);
				КонецЕсли;
			КонецЦикла;
			
			Если СтрокиРаспределения.Количество() = 0 Тогда
				СтрокиРаспределения = СтрокиРаспределенияБезКатегорий;
				Если СтрокиРаспределения.Количество() = 0 Тогда
					СтрокиРаспределения = СтрокиРаспределенияБезДатыИКатегорий;
					Если СтрокиРаспределения.Количество() = 0 Тогда
						СтрокиРаспределения = СтрокиБазыПоФизлицу;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
			
		КонецЕсли;
		
		Если СтрокиРаспределения.Количество() = 0 Тогда
			// не нашли строки распределения по базе
			СтрокиБазыПоФизлицу = БазаВсеНачисления.НайтиСтроки(Отбор);
			Для каждого СтрокаТЗ Из СтрокиБазыПоФизлицу Цикл
				Если СтрокаТЗ.Территория = СтрокаНДФЛ.Территория Тогда
					СтрокиРаспределения.Добавить(СтрокаТЗ);
				КонецЕсли;
			КонецЦикла;
			Если СтрокиРаспределения.Количество() = 0 Тогда
				СтрокиРаспределения = СтрокиБазыПоФизлицу;
			КонецЕсли;
		КонецЕсли;
		
		Если СтрокиРаспределения.Количество() = 0 Тогда
			СтрокиБезБазы.Добавить(СтрокаНДФЛ);
			Продолжить;
		КонецЕсли;
		
		// Распределяем пропорционально суммам в найденных строках.
		Коэффициенты = ОбщегоНазначения.ВыгрузитьКолонку(СтрокиРаспределения, "Сумма");
		// распределяем суммы с учетом ранее удержанного
		РаспределенныеСуммы = ЗарплатаКадры.РаспределитьСуммуПропорциональноБазе(СтрокаНДФЛ.Сумма + РанееУдержано, Коэффициенты, 0);
		
		Если РаспределенныеСуммы = Неопределено Тогда
			
			НоваяСтрока = РезультатыРаспределения.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокиРаспределения[0]);
			
			НоваяСтрока.ВидУдержания        = СтрокаНДФЛ.ВидУдержания;
			НоваяСтрока.ИдентификаторСтроки = СтрокаНДФЛ.ИдентификаторСтроки;
			НоваяСтрока.Результат           = СтрокаНДФЛ.Сумма;
			
		Иначе	
			
			// вычитаем уже удержанные суммы
			Если СтрокиРанееУдержано.Количество() > 0 Тогда
				
				Для Каждого СтрокаУжеУдержано Из СтрокиРанееУдержано Цикл
					
					НоваяСтрока = РезультатыРаспределения.Добавить();
					ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаУжеУдержано);
					
					НоваяСтрока.Результат 			= - СтрокаУжеУдержано.Сумма;
					НоваяСтрока.ИдентификаторСтроки = СтрокаНДФЛ.ИдентификаторСтроки;
					
				КонецЦикла;
				
			КонецЕсли;
			
			// добавляем распределенные суммы
			Для Индекс = 0 По СтрокиРаспределения.Количество() - 1 Цикл
				
				СтрокаРаспределения = СтрокиРаспределения[Индекс];
				НоваяСтрока = РезультатыРаспределения.Добавить();
				ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаРаспределения);
				
				НоваяСтрока.ВидУдержания        = СтрокаНДФЛ.ВидУдержания;
				НоваяСтрока.ИдентификаторСтроки = СтрокаНДФЛ.ИдентификаторСтроки;
				НоваяСтрока.Результат           = РаспределенныеСуммы[Индекс];
				
				Если СтарыйАлгоритм Тогда
					НоваяСтрока.КатегорияДохода = Перечисления.КатегорииДоходовНДФЛ.ДоходыПредыдущихРедакций;
					НоваяСтрока.ДатаПолученияДохода = Дата(1,1,1);
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ОтражениеЗарплатыВУчете.СвернутьТаблицу(РезультатыРаспределения);
	
	Если СтрокиБезБазы.Количество() > 0 Тогда
		ОтражениеЗарплатыВУчете.РаспределитьУдержанияПоБазеПоУмолчанию(РезультатыРаспределения, СтрокиБезБазы, Организация, ПериодРегистрации);
	КонецЕсли;
	
	Возврат РезультатыРаспределения;
	
КонецФункции

#КонецОбласти
