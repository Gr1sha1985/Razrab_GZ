////////////////////////////////////////////////////////////////////////////////
// 
// Процедуры, переопределяемые при модификации конфигурации.
// Позволяют гибко устанавливать правила распределения расходов.
// Вызываются из модуля ПравилаРаспределенияРасходов
// 
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Переопределяет настройки распределения.
// Позволяет учесть настройки, предусмотренные на проекте автоматизации конкретного предприятия.
//
// Параметры:
//  Настройки - Структура - см. ПравилаРаспределенияРасходов.НовыйНастройкиУчетаЗатрат, заполненные настройки
//
Процедура ПриЗаполненииНастроекУчетаЗатрат(Настройки) Экспорт
	
	// Пример модификации приведен в ЗакрыватьОбщехозяйственныеРасходыНаКалькуляционныйСчет()
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Позволяет добавить свои правила так, чтобы их налоговые последствия были обработаны автоматически.
// Вызывается после заполнения таблицы основными предопределенными правилами по конкретному счету расходов,
// но до заполнения налоговыми правилами.
//
// Параметры:
//  Процессор  - Структура - см. ПравилаРаспределенияРасходов.НовыйПроцессорЗаполненияПравилРаспределения
//               Правила следует добавлять с помощью ПравилаРаспределенияРасходов.ДобавитьПравилоРаспределения
//               Не рекомендуется удалять правила, менять порядок предопределенных правил, менять в них отбор по счету.
//  СтандартнаяОбработка 
//             - Булево - действие после выполнения обработчика
//               * Истина - Значение по умолчанию. После правил, добавленных в этой процедуре,
//                          будут добавлены предопределенные правила.  
//               * Ложь   - Применяются только правила, добавленные в этой процедуре.
//                          Позволяет полностью переопределить логику типового решения, 
//                          отказаться от использования предопределенных правил
// 
Процедура ПередДобавлениемПравилПоСчету(Процессор, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Позволяет добавить свои правила так, чтобы их налоговые последствия были обработаны автоматически.
// Вызывается после заполнения таблицы основными предопределенными правилами,
// но до заполнения налоговыми правилами.
//
// Параметры:
//  Процессор - Структура - см. ПравилаРаспределенияРасходов.НовыйПроцессорЗаполненияПравилРаспределения
//              Правила следует добавлять с помощью ПравилаРаспределенияРасходов.ДобавитьПравилоРаспределения
//              или ПравилаРаспределенияРасходов.СкопироватьПравилоРаспределения
//              Не рекомендуется удалять правила, менять порядок предопределенных правил, менять в них отбор по счету.
//
Процедура ПриДобавленииПравилПоСчету(Процессор) Экспорт
	
	// О структуре правила см. комментарий в ПравилаРаспределенияРасходов.НовыеПравилаРаспределения
	
	// Для поиска предопределенного правила, подлежащего модификации, можно использовать ФункциональноеИмя предопределенных правил.
	// Однако, надежнее опираться на свойства предопределенных правил, как показано ниже.
	
	// Пример модификации правила, позволяющего ограничить распределение косвенных затрат на другие подразделения,
	// приведен в ОграничитьРаспределениеНаДругиеПодразделения()
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Вызывается до заполнения таблицы предопределенными правилами.
// 
// Параметры:
//  ПравилаРаспределения - ТаблицаЗначений - заполняемая таблица; 
//                         структура таблицы описана в ПравилаРаспределенияРасходов.НовыеПравилаРаспределения()
//  Период               - Дата - указывает на период, расходы которого распределяются
//  Организация          - СправочникСсылка.Организации - организация, расходы которой распределяются
//  СтандартнаяОбработка - Булево - действие после выполнения обработчика
//                         * Истина - Значение по умолчанию. После правил, добавленных в этой процедуре,
//                                    будут добавлены предопределенные правила.  
//                         * Ложь   - Применяются только правила, добавленные в этой процедуре.
//                                    Позволяет полностью переопределить логику типового решения, 
//                                    отказаться от использования предопределенных правил
// 
Процедура ПередДобавлениемПравилРаспределенияРасходовНаПроизводство(ПравилаРаспределения, Период, Организация, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Вызывается после заполнения таблицы предопределенными правилами.
// 
// Параметры:
//  ПравилаРаспределения - ТаблицаЗначений - заполняемая таблица; 
//                         структура таблицы описана в ПравилаРаспределенияРасходов.НовыеПравилаРаспределения()
//  Период               - Дата - указывает на период, расходы которого распределяются
//  Организация          - СправочникСсылка.Организации - организация, расходы которой распределяются
// 
Процедура ПриДобавлениПравилРаспределенияРасходовНаПроизводство(ПравилаРаспределения, Период, Организация) Экспорт
	
	// См. комментарии в ПриДобавленииПравилПоСчету()
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Вызывается до заполнения таблицы предопределенными правилами.
// 
// Параметры:
//  ПравилаРаспределения - ТаблицаЗначений - заполняемая таблица; 
//                         структура таблицы описана в ПравилаРаспределенияРасходов.НовыеПравилаРаспределения()
//  Период               - Дата - указывает на период, расходы которого распределяются
//  Организация          - СправочникСсылка.Организации - организация, расходы которой распределяются
//  СтандартнаяОбработка - Булево - действие после выполнения обработчика
//                         * Истина - Значение по умолчанию. После правил, добавленных в этой процедуре,
//                                    будут добавлены предопределенные правила.  
//                         * Ложь   - Применяются только правила, добавленные в этой процедуре.
//                                    Позволяет полностью переопределить логику типового решения, 
//                                    отказаться от использования предопределенных правил
// 
Процедура ПередДобавлениемПравилРаспределенияРасходовНаПродажу(ПравилаРаспределения, Период, Организация, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Переопределяет таблицу правил распределения.
// Вызывается после заполнения таблицы предопределенными правилами.
// 
// Параметры:
//  ПравилаРаспределения - ТаблицаЗначений - заполняемая таблица; 
//                         структура таблицы описана в ПравилаРаспределенияРасходов.НовыеПравилаРаспределения()
//  Период               - Дата - указывает на период, расходы которого распределяются
//  Организация          - СправочникСсылка.Организации - организация, расходы которой распределяются
// 
Процедура ПриДобавленииПравилРаспределенияРасходовНаПродажу(ПравилаРаспределения, Период, Организация) Экспорт
	
	// См. комментарии в ПриДобавленииПравилПоСчету()
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Примеры

Процедура ЗакрыватьОбщехозяйственныеРасходыНаКалькуляционныйСчет(Настройки)  Экспорт // для обхода проверки конфигурации
	
	// С 2021 года обязательно для применения ФСБУ 5, для исполнения требований которого в типовом решении
	// счет 26 "Общехозяйственные расходы" закрывается на счет финансового результата периода.
	
	// Однако, специфика деятельности отдельных организаций может требовать продолжать закрывать
	// этот счет на калькуляционные счета (20, 23),
	// например, в связи с особенностями финансирования заключенных договоров.
	
	// Это допустимо в случаях, не входящих в сферу регулирования ФСБУ 5, например,
	// когда речь идет о выполнении строительных работ, по которым выручка и расходы признаются по мере готовности.
	
	Если Настройки.Контекст.Период < '2021-01-01' Тогда
		Возврат;
	КонецЕсли;
	
	Настройки.Закрытие[ПланыСчетов.Хозрасчетный.ОбщехозяйственныеРасходы].Направление = "КалькуляционныйСчет";
	
КонецПроцедуры

Процедура ОграничитьРаспределениеНаДругиеПодразделения(Процессор) Экспорт // для обхода проверки конфигурации
	
	// Пример модификации правила, позволяющего ограничить распределение косвенных затрат на другие подразделения.
	
	// В типовом решении косвенные затраты распределяются по указанной базе
	// - прежде всего в рамках одного подразделения
	// - если это невозможно - в рамках всех подразделений, для которых расчитана эта база.
	//
	// Например, если база распределения - "объем выпуска" и выпуск есть в подразделениях "Цех 1" и "Цех 2",
	// то затраты Цеха 1 будут распределены только на выпуск Цеха 1, а затраты Лаборатории - на оба цеха.
	//
	// На предприятиях, результаты работы которого оплачиваются заказчиком в виде компенсации затрат,
	// могут быть ограничения такого распределения:
	// - с одной стороны, следует использовать единую базу распределения для всех затрат
	// - с другой, некоторые затраты нельзя включать в себестоимость результата деятельности, оплачиваемого заказчиком.
	//
	// В описанном выше примере может появиться подразделение "Цех специальных изделий", в себестоимость продукции которого
	// не следует включать затраты лаборатории.
	//
	// Для настройки такого ограничения используем иерархию и последовательность подразделений в списке:
	// Косвенные затраты подразделений не могут быть распределены на первое в списке.
	//
	// Например, список подразделений может выглядеть так:
	// - Цех специальных изделий
	// - Цех 1
	// - Цех 2
	// - Лаборатория
	// Косвенные затраты Лаборатории распределяются на Цех 1 и Цех 2
	//
	// Такой способ настройки приведен в демонстрационных целях.
	// На проектах рекомендуется с помощью расширения добавлять в прикладное решение объекты метаданных,
	// описывающие специфику взаимосвязей подразделений, видов деятельности, видов выпуска конкретного предприятия.
	
	Если Процессор.КлассСчетов <> "КосвенныеРасходы" Тогда
		Возврат;
	КонецЕсли;
	
	Если Процессор.Закрытие.Направление <> "КалькуляционныйСчет" Тогда
		Возврат;
	КонецЕсли;
	
	ПравилаДляМодификации = Новый Массив;
	Для Каждого Правило Из Процессор.Правила Цикл
		
		Если Правило.Действие <> "РаспределитьНаСубконто" И Не Правило.ПоляПриемника.Свойство("Подразделение") Тогда
			// Распределение между подразделениями не может быть выполнено таким правилом
			Продолжить;
		КонецЕсли;
		
		Если Правило.ПоляИсточника.Свойство("Подразделение") Тогда
			// Распределение уже ограничено одним или несколькими подразделениями
			Продолжить;
		КонецЕсли;
		
		ПравилаДляМодификации.Добавить(Правило);
		
	КонецЦикла;
	
	Если Не ЗначениеЗаполнено(ПравилаДляМодификации) Тогда
		Возврат;
	КонецЕсли;
	
	// Определим запрещенное подразделение.
	// На проектах может оказаться уместным читать такие настройки заранее и помещать в коллекцию Настройки
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("Организация", Процессор.Настройки.Контекст.Организация);
	Запрос.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	Подразделения.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ПодразделенияОрганизаций КАК Подразделения
	|ГДЕ
	|	Подразделения.Владелец = &Организация
	|	И Подразделения.Родитель = ЗНАЧЕНИЕ(Справочник.ПодразделенияОрганизаций.ПустаяСсылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	Подразделения.РеквизитДопУпорядочивания,
	|	Подразделения.Ссылка";
	Выборка = Запрос.Выполнить().Выбрать();
	Если Не Выборка.Следующий() Тогда
		Возврат;
	КонецЕсли;
	
	ЗапрещенноеПодразделение = Выборка.Ссылка;
	
	// Модифицируем запросы базы распределения, добавив условие, ограничивающее данные базы.
	// На проектах связи могут быть сложнее:
	// одни "косвенные" подразделения могут быть ограничены в распределении одним набором подразделений или наименований продукции,
	// а другие - другим.
	// В этом случае следует использовать ПоляИсточника правила, дополняя текст запроса соединением с таблицей таких связей.
	
	Для Каждого Правило Из ПравилаДляМодификации Цикл
		
		ЗапросБазыРаспределения = СхемыЗапросов.НайтиЗапросСозданияТаблицы(
			Правило.БазаРаспределения.ТекстЗапроса,
			Правило.БазаРаспределения.Имя);
			
		КолонкаПодразделение = ЗапросБазыРаспределения.Запрос.Колонки.Найти("Подразделение");
			
		Для Каждого Оператор Из ЗапросБазыРаспределения.Запрос.Операторы Цикл
			ИндексОператора = ЗапросБазыРаспределения.Запрос.Операторы.Индекс(Оператор);
			ВыражениеПодразделение = КолонкаПодразделение.Поля[ИндексОператора];
			Оператор.Отбор.Добавить(СтрШаблон("%1 <> &ЗапрещенноеПодразделение", ВыражениеПодразделение));
		КонецЦикла;
			
		Правило.БазаРаспределения.ПараметрыЗапроса.Вставить("ЗапрещенноеПодразделение", ЗапрещенноеПодразделение);
		
		// Изменение текста или параметров запроса требует изменить имя временной таблицы - так, чтобы не оказалось,
		// что различные правила предусматривают создание разных таблиц с одинаковым именем.
		ЗапросБазыРаспределения.Запрос.ТаблицаДляПомещения = "";
		Правило.БазаРаспределения.Имя                      = "";
		ПравилаРаспределенияРасходов.НастроитьТекстБазыРаспределения(Правило, ЗапросБазыРаспределения);
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
	
#КонецОбласти
