///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Определяет наличие подсистемы АдресныйКлассификатор и наличие записей о регионах в регистре сведений
// АдресныеОбъекты.
//
// Возвращаемое значение:
//  ФиксированноеСоответствие:
//   * КлассификаторДоступен   - Булево - классификатор доступен через веб-сервис.
//   * ИспользоватьЗагруженные - Булево - в программу загружен классификатор.
//   * ИспользуетсяАдресныйКлассификатор - Булево - в программе присутствует подсистема АдресныйКлассификатор.
//
Функция СведенияОДоступностиАдресногоКлассификатора() Экспорт
	
	Результат = Новый Соответствие;
	Результат.Вставить("КлассификаторДоступен",             Ложь);
	Результат.Вставить("ИспользоватьЗагруженные",           Ложь);
	Результат.Вставить("ИспользуетсяАдресныйКлассификатор", Ложь);
	
	Результат["ИспользуетсяАдресныйКлассификатор"] = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.АдресныйКлассификатор");
	Если Не Результат["ИспользуетсяАдресныйКлассификатор"] Тогда
		Возврат Новый ФиксированноеСоответствие(Результат);
	КонецЕсли;
	
	МодульАдресныйКлассификаторСлужебный = ОбщегоНазначения.ОбщийМодуль("АдресныйКлассификаторСлужебный");
	СведенияОДоступностиАдресныхСведений = МодульАдресныйКлассификаторСлужебный.СведенияОДоступностиАдресныхСведений();
	
	Результат["КлассификаторДоступен"]   = СведенияОДоступностиАдресныхСведений.Получить("КлассификаторДоступен");
	Результат["ИспользоватьЗагруженные"] = СведенияОДоступностиАдресныхСведений.Получить("ИспользоватьЗагруженные");
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции

// Возвращает значение перечисления тип вида контактной информации.
//
//  Параметры:
//    ВидИнформации - СправочникСсылка.ВидыКонтактнойИнформации
//                  - Структура - источник данных.
//
Функция ТипВидаКонтактнойИнформации(Знач ВидИнформации) Экспорт
	Результат = Неопределено;
	
	Тип = ТипЗнч(ВидИнформации);
	Если Тип = Тип("ПеречислениеСсылка.ТипыКонтактнойИнформации") Тогда
		Результат = ВидИнформации;
	ИначеЕсли Тип = Тип("СправочникСсылка.ВидыКонтактнойИнформации") Тогда
		Результат = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидИнформации, "Тип");
	ИначеЕсли ВидИнформации <> Неопределено Тогда
		Данные = Новый Структура("Тип");
		ЗаполнитьЗначенияСвойств(Данные, ВидИнформации);
		Результат = Данные.Тип;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Функция НаименованияВидовКонтактнойИнформации() Экспорт
	
	Результат = Новый Соответствие;
	Для каждого Язык Из Метаданные.Языки Цикл
		Наименования = Новый Соответствие;
		УправлениеКонтактнойИнформациейПереопределяемый.ПриПолученииНаименованийВидовКонтактнойИнформации(Наименования, Язык.КодЯзыка);
		Результат[Язык.КодЯзыка] = Наименования;
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(Результат);
	
КонецФункции

// Возвращает список предопределенных видов контактной информации.
//
// Возвращаемое значение:
//  ФиксированноеСоответствие:
//   * Ключ - Строка - имя предопределенного вида.
//   * Значение - СправочникСсылка.ВидыКонтактнойИнформации - ссылка на элемент справочника ВидыКонтактнойИнформации.
//
Функция ВидыКонтактнойИнформацииПоИмени() Экспорт
	
	Виды = Новый Соответствие;
	ПредопределенныеВиды = УправлениеКонтактнойИнформацией.ПредопределенныеВидыКонтактнойИнформации();
	
	Для каждого ПредопределенныеВид Из ПредопределенныеВиды Цикл
		Виды.Вставить(ПредопределенныеВид.Имя, ПредопределенныеВид.Ссылка);
	КонецЦикла;
	
	Возврат Новый ФиксированноеСоответствие(Виды);
	
КонецФункции

Функция КонтактнаяИнформацияОбъектаСодержитКолонкуДействуетС(ОбъектСсылка) Экспорт
	Возврат ОбъектСсылка.Метаданные().ТабличныеЧасти.КонтактнаяИнформация.Реквизиты.Найти("ДействуетС") <> Неопределено;
КонецФункции

Функция ГруппаВидаКонтактнойИнформацииПоИмениОбъекта(ПолноеИмяОбъектаМетаданных) Экспорт
	ИмяГруппыВидовКИ = СтрЗаменить(ПолноеИмяОбъектаМетаданных, ".", "");
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	ВидыКонтактнойИнформации.Ссылка КАК Ссылка,
	|ВЫБОР
	|	КОГДА ВидыКонтактнойИнформации.ИмяПредопределенногоВида <> """"
	|	ТОГДА ВидыКонтактнойИнформации.ИмяПредопределенногоВида
	|	ИНАЧЕ ВидыКонтактнойИнформации.ИмяПредопределенныхДанных
	|КОНЕЦ КАК ИмяПредопределенногоВида
	|ИЗ
	|	Справочник.ВидыКонтактнойИнформации КАК ВидыКонтактнойИнформации
	|ГДЕ
	|	ВидыКонтактнойИнформации.ЭтоГруппа = ИСТИНА
	|	И ВидыКонтактнойИнформации.ПометкаУдаления = ЛОЖЬ
	|	И ВидыКонтактнойИнформации.Используется = ИСТИНА";
	
	РезультатЗапроса = Запрос.Выполнить().Выбрать();
	Пока РезультатЗапроса.Следующий() Цикл
		Если СтрСравнить(РезультатЗапроса.ИмяПредопределенногоВида, ИмяГруппыВидовКИ) = 0 Тогда
			Возврат РезультатЗапроса.Ссылка;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Неопределено;
	
КонецФункции

#КонецОбласти
