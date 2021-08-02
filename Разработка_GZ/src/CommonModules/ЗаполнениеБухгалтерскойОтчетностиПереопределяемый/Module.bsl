////////////////////////////////////////////////////////////////////////////////
// ЗАПОЛНЕНИЕ БУХГАЛТЕРСКОЙ ОТЧЕТНОСТИ.
// Модуль содержит переопределяемые процедуры и функции.
// Предназначен для заполнения регламентированного отчета
// "Бухгалтерская отчетность организаций" и финансовой отчетности в банки.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

#Область ЗаполнениеБухгалтерскойОтчетностиПоказатели

// Возвращает признак учета расходов по элементам затрат организацией в течении указанного периода.
//
// Параметры:
//   НачалоПериодаОтчета - Дата - дата начала периода, за который проводится проверка вида учета расходов;
//   КонецПериодаОтчета - Дата - дата конца периода, за который проводится проверка вида учета расходов;
//   Организация - СправочникСсылка.Организация - организация, для которой нужно получить признак.
//
// Возвращаемое значение:
//   Булево - Истина, если в течении проверяемого периода организация вела учет расходов
//     по элементам затрат.
//
// Пример реализации:
//   Возврат ЭлементыЗатратНастройкаПараметровУчета.РасходыУчитываютсяПоЭлементамЗатрат(
//     НачалоПериодаОтчета, КонецПериодаОтчета, Организация);
//
Функция РасходыУчитываютсяПоЭлементамЗатрат(НачалоПериодаОтчета, КонецПериодаОтчета, Организация) Экспорт
	
	Возврат ЭлементыЗатратНастройкаПараметровУчета.РасходыУчитываютсяПоЭлементамЗатрат(
		НачалоПериодаОтчета, КонецПериодаОтчета, Организация);
	
КонецФункции

// Заполняет описание структуры отчета о целевом использовании полученных средств - состав ее граф и строк
//
// Параметры:
//  Строки		 - Строка - возвращаемый параметр - перечень четырехзначных номеров строк отчета, разделенных запятыми
//  Упрощенная	 - Булево - Истина для упрощенной отчетности (содержащей сокращенный перечень строк)
//
Процедура ЗаполнитьОписаниеСтрокОЦИС(Строки, Упрощенная) Экспорт
	
КонецПроцедуры

// Предоставляет данные для заполнения отчета об использовании целевых поступивших средств.
// Данные собираются по одной организации, без учета входящих в нее филиалов.
//
// Параметры:
//  ПоказателиОтчета  - Соответствие - возвращаемый параметр, значения для заполнения строк отчета
//                      * Ключ - Строка - четырехсимвольный код строки
//                      * Значение - Число - значение показателя
//  РасшифровкаОтчета - ТаблицаЗначений - см. ЗаполнениеРасшифровкаРегламентированнойОтчетности.НовыйРасшифровка
//                      В таблице
//                       - в поле ИмяПоказателя указывается четырехсимвольный код строки
//                       - не заполняется поле ИмяРаздела, определяемое кодом строки отчета
//  НачалоПериода - Дата (без времени) - начало периода отчета
//  КонецПериода  - Дата (без времени) - конец периода отчета
//  Организация   - СправочникСсылка.Организации - организация, по которой собираются данные
//  Упрощенная    - Булево - Истина для упрощенной отчетности (с меньшей детализацией)
//
Процедура ПолучитьДанныеЗаполненияОЦИС(ПоказателиОтчета, РасшифровкаОтчета, НачалоПериода, КонецПериода, Организация, Упрощенная) Экспорт
	
КонецПроцедуры

#КонецОбласти

#Область ЗаполнениеБухгалтерскойОтчетностиПояснения

// Проверяет, должны для организации в отчетном периоде применяться правила учета обесценения в соответствии с ФСБУ 5
// или в соответствии с предыдущим стандартом.
//
// Параметры:
//  Применяется  - Булево - возвращаемый параметр; Истина, если действует ФСБУ 5, Ложь - если ПБУ 5
//  Организация  - СправочникСсылка.Организации
//  Период       - Дата - любая дата из отчетного периода
//
Процедура ПроверитьПрименяетсяОбесценениеФСБУ5(Применяется, Организация, Период) Экспорт
	
	ПервоеПрименение = РегистрыСведений.УчетнаяПолитика.ГодПервогоПримененияФСБУ5(Организация);
	Если Период > ПервоеПрименение Тогда
		Применяется = Истина;
	Иначе
		// Возможно, речь идет о первом периоде после создания организации
		ОписаниеПериода  = БухгалтерскийУчет.БлижайшийОтчетныйПериод(Период, Организация);
		Применяется      = (ОписаниеПериода.Период >= ПервоеПрименение);
	КонецЕсли;
	
КонецПроцедуры

// Рассчитывает сумму выбытия обесценения запасов алгоритмом, специфичным для конкретного прикладного решения.
//
// Параметры:
//  Выбытие       - Число - возвращаемый параметр, сумма выбытия обесценения
//                - Неопределено - в прикладном решении алгоритм расчета не определен
//  Организация   - СправочникСсылка.Организации - организация, по которой заполняется отчетность
//  НачалоПериода - Дата (без времени) - начало периода отчета
//  КонецПериода  - Дата (без времени) - конец периода отчета
//  Счет          - ПланСчетовСсылка.Хозрасчетный - счет резерва (субсчет счета 14 или счет 14 в целом)
//
Процедура РассчитатьВыбытиеОбесцененияЗапасов(Выбытие, Организация, НачалоПериода, КонецПериода, Счет) Экспорт
	
	УчетОбесцененияЗапасов.РассчитатьВыбытиеОбесцененияЗапасов(Выбытие, Организация, НачалоПериода, КонецПериода, Счет);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Заполняет переменную ссылкой на предопределенный счет по его условному коду.
//
// Параметры:
//   УсловныйКодСчета - Строка - условный код счета, используемый в алгоритмах заполнения;
//   Результат - Произвольный - переменная, в которую помещается ссылка на найденный счет плана счетов.
//
// Пример:
//   Если УсловныйКодСчета = "76.51" Тогда
//       Результат = ПланыСчетов.Хозрасчетный.РасчетыПоЦелевомуФинансированию;
//   КонецЕсли;
//
Процедура ЗаполнитьСчетПоУсловномуКоду(УсловныйКодСчета, Результат) Экспорт
	
КонецПроцедуры

#Область ДополненияАлгоритмов

Процедура ДополнитьБО2019Кв1Баланс(КонтекстДополнения, ИмяОбластиПоказателя, ЗначениеПоказателя) Экспорт
	
КонецПроцедуры

Процедура ДополнитьУБО2015Кв1Баланс(КонтекстДополнения, ИмяОбластиПоказателя, ЗначениеПоказателя) Экспорт
	
КонецПроцедуры

Процедура ДополнитьСпособыОбработкиСчетов(СпособыОбработки, СпособыОбработкиСчетов) Экспорт
	
КонецПроцедуры

Процедура ДополнитьБО2011Кв4Пояснения5_Строки5510и5530(КонтекстСтроки) Экспорт
	
КонецПроцедуры

Процедура ДополнитьБО2011Кв4Пояснения5_Строки5513и5533(КонтекстСтроки) Экспорт
	
КонецПроцедуры

Процедура ДополнитьБО2011Кв4Пояснения5_Строки5560и5580(КонтекстСтроки) Экспорт
	
КонецПроцедуры

Процедура ДополнитьБО2011Кв4Пояснения5_Строки5566и5586(КонтекстСтроки) Экспорт
	
КонецПроцедуры

Процедура УстановитьТекстЗапросаПоПереопределяемымТаблицамПояснения51Краткосрочная(ТекстЗапроса) Экспорт
	
КонецПроцедуры

Процедура ДополнитьПараметрыЗапросаПояснения51Краткосрочная(Запрос) Экспорт
	
КонецПроцедуры

Процедура УстановитьТекстЗапросаПоПереопределяемымТаблицамПояснения53Краткосрочная(ТекстЗапроса) Экспорт
	
КонецПроцедуры

Процедура ДополнитьПараметрыЗапросаПояснения53Краткосрочная(Запрос) Экспорт
	
КонецПроцедуры

Процедура УстановитьНаименованиеСоставляющейДополнительногоСчета(НаименованиеСоставляющейДополнительногоСчета,
	ПараметрыСоставляющих, ИмяТаблицыСоставляющих, СчетСоставляющей) Экспорт
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
