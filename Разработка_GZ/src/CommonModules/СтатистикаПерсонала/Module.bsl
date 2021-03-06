////////////////////////////////////////////////////////////////////////////////
// Подсистема "Статистика персонала".
// Процедуры и функции, предназначенные для форм статистической отчетности.
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает объект для хранения данных о численности
// Возвращаемое значение:
//   Структура:
//   * СреднесписочнаяЧисленностьРаботников - Число
//   * СреднесписочнаяЧисленностьЖенщин - Число
//   * СреднесписочнаяЧисленностьИнвалидов - Число
//   * ЧисленностьРаботников - Число
//   * ЧисленностьЖенщин - Число
//   * ЧисленностьИнвалидов - Число
//
Функция ДанныеОЧисленности() Экспорт
	
	ДанныеОЧисленности = Новый Структура;
	ДанныеОЧисленности.Вставить("СреднесписочнаяЧисленностьРаботников", 0);
	ДанныеОЧисленности.Вставить("СреднесписочнаяЧисленностьЖенщин", 0);
	ДанныеОЧисленности.Вставить("СреднесписочнаяЧисленностьИнвалидов", 0);
	ДанныеОЧисленности.Вставить("ЧисленностьРаботников", 0);
	ДанныеОЧисленности.Вставить("ЧисленностьЖенщин", 0);
	ДанныеОЧисленности.Вставить("ЧисленностьИнвалидов", 0); 
	
	Возврат ДанныеОЧисленности;
	
КонецФункции

// Рассчитывает численность всех работников, женщин и инвалидов.
// При этом за переданный период считается среднесписочная численность, 
// а на конец заданного периода - списочная численность.
//
// Параметры:
//		Организация				- СправочникСсылка.Организации
//		НачалоПериода			- Дата
//		КонецПериода			- Дата
//		ПоГоловнойОрганизации	- Булево - если Истина, то отбор по головной организации, иначе по текущей организации
//
// Возвращаемое значение:
//		Структура - см. СтатистикаПерсонала.ДанныеОЧисленности 
//	
Функция СреднесписочнаяЧисленностьРаботающих(Организация, НачалоПериода, КонецПериода, ПоГоловнойОрганизации = Ложь) Экспорт 
	Возврат СтатистикаПерсоналаВнутренний.СреднесписочнаяЧисленностьРаботающих(Организация, НачалоПериода, КонецПериода, ПоГоловнойОрганизации);
КонецФункции

#Область РегламентированнаяОтчетность

// См. РегламентированнаяОтчетностьПереопределяемый.ПолучитьСведенияОПоказателяхОтчета.
Процедура ПриПолученииСведенийОПоказателяхОтчета(ПоказателиОтчета, ИДОтчета, ИДРедакцииОтчета, ПараметрыОтчета) Экспорт
	
	Если ИДОтчета = "РегламентированныйОтчетСтатистикаФормаП4" Тогда
		Если ИДРедакцииОтчета >= "ФормаОтчета2013Кв1" Тогда
			ДобавитьПоказателиФормыП4_2013Кв1(ПоказателиОтчета);
		КонецЕсли;
	ИначеЕсли ИДОтчета = "РегламентированныйОтчетСтатистикаФормаП4НЗ" Тогда
		Если ИДРедакцииОтчета >= "ФормаОтчета2021Кв1" Тогда
			ДобавитьПоказателиФормыП4НЗ_2021Кв1(ПоказателиОтчета);
		ИначеЕсли ИДРедакцииОтчета >= "ФормаОтчета2015Кв1" Тогда
			ДобавитьПоказателиФормыП4НЗ_2015Кв1(ПоказателиОтчета);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// См. РегламентированнаяОтчетностьПереопределяемый.ЗаполнитьОтчет.
Процедура ПриЗаполненииРегламентированногоОтчета(ИДОтчета, ИДРедакцииОтчета, ПараметрыОтчета, Контейнер) Экспорт
	
	Если ИДОтчета = "РегламентированныйОтчетСтатистикаФормаП4" Тогда
		Если ИДРедакцииОтчета >= "ФормаОтчета2017Кв1" Тогда
			ЗаполнитьПоказателиФормыП4_2017Кв1(ПараметрыОтчета, Контейнер);
		ИначеЕсли ИДРедакцииОтчета >= "ФормаОтчета2013Кв1" Тогда
			ЗаполнитьПоказателиФормыП4_2013Кв1(ПараметрыОтчета, Контейнер);
		КонецЕсли;
	ИначеЕсли ИДОтчета = "РегламентированныйОтчетСтатистикаФормаП4НЗ" Тогда
		Если ИДРедакцииОтчета >= "ФормаОтчета2021Кв1" Тогда
			ЗаполнитьПоказателиФормыП4НЗ_2021Кв1(ПараметрыОтчета, Контейнер);
		ИначеЕсли ИДРедакцииОтчета >= "ФормаОтчета2015Кв1" Тогда
			ЗаполнитьПоказателиФормыП4НЗ_2015Кв1(ПараметрыОтчета, Контейнер);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

#Область БазовыйКонтракт

// П-4

// Получает показатели, которые могут быть заполнены при заполнении отчета.
// 
// Параметры:
//  ПоказателиОтчета - структура
//
Процедура ДобавитьПоказателиФормыП4_2013Кв1(ПоказателиОтчета)
	
	СтатистикаПерсоналаВнутренний.ДобавитьПоказателиФормыП4_2013Кв1(ПоказателиОтчета);
	
КонецПроцедуры

// Заполняет показатели отчета.
// 
// Параметры:
//  ПараметрыОтчета - структура.
//  Контейнер - структура - содержит все показатели отчета и их значения.
//
Процедура ЗаполнитьПоказателиФормыП4_2013Кв1(ПараметрыОтчета, Контейнер)
	
	СтатистикаПерсоналаВнутренний.ЗаполнитьПоказателиФормыП4_2013Кв1(ПараметрыОтчета, Контейнер);
	
КонецПроцедуры

// Заполняет показатели отчета.
// 
// Параметры:
//  ПараметрыОтчета - структура.
//  Контейнер - структура - содержит все показатели отчета и их значения.
//
Процедура ЗаполнитьПоказателиФормыП4_2017Кв1(ПараметрыОтчета, Контейнер)
	
	СтатистикаПерсоналаВнутренний.ЗаполнитьПоказателиФормыП4_2017Кв1(ПараметрыОтчета, Контейнер);
	
КонецПроцедуры

// П-4 (НЗ)

// Получает показатели, которые могут быть заполнены при заполнении отчета.
// 
// Параметры:
//  ПоказателиОтчета - структура
//
Процедура ДобавитьПоказателиФормыП4НЗ_2015Кв1(ПоказателиОтчета)
	
	СтатистикаПерсоналаВнутренний.ДобавитьПоказателиФормыП4НЗ_2015Кв1(ПоказателиОтчета);
	
КонецПроцедуры

// Заполняет показатели отчета.
// 
// Параметры:
//  ПараметрыОтчета - структура.
//  Контейнер - структура - содержит все показатели отчета и их значения.
//
Процедура ЗаполнитьПоказателиФормыП4НЗ_2015Кв1(ПараметрыОтчета, Контейнер)
	
	СтатистикаПерсоналаВнутренний.ЗаполнитьПоказателиФормыП4НЗ_2015Кв1(ПараметрыОтчета, Контейнер);
	
КонецПроцедуры

// Получает показатели, которые могут быть заполнены при заполнении отчета.
// 
// Параметры:
//  ПоказателиОтчета - структура
//
Процедура ДобавитьПоказателиФормыП4НЗ_2021Кв1(ПоказателиОтчета)
	
	СтатистикаПерсоналаВнутренний.ДобавитьПоказателиФормыП4НЗ_2021Кв1(ПоказателиОтчета);
	
КонецПроцедуры

// Заполняет показатели отчета.
// 
// Параметры:
//  ПараметрыОтчета - структура.
//  Контейнер - структура - содержит все показатели отчета и их значения.
//
Процедура ЗаполнитьПоказателиФормыП4НЗ_2021Кв1(ПараметрыОтчета, Контейнер)
	
	СтатистикаПерсоналаВнутренний.ЗаполнитьПоказателиФормыП4НЗ_2021Кв1(ПараметрыОтчета, Контейнер);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
