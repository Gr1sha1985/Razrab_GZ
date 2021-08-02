////////////////////////////////////////////////////////////////////////////////
// Проверка контрагентов в Декларации по НДС
//  
////////////////////////////////////////////////////////////////////////////////
#Область ПрограммныйИнтерфейс

// Процедура - Действия при создании на сервере декларация по НДС:
//		- Инициализируются реквизиты проверки контрагентов.
//		- Управляется видимостью и свойствами элементов формы, относящихся к проверке.
//
// Параметры:
//  Форма	 - ФормаКлиентскогоПриложения - Форма декларации по НДС с 2015 г.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
//		Значение по умолчанию - Истина.
Процедура ПриСозданииНаСервереДекларацияПоНДС(Форма, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Определяет наличие права на использование проверки контрагентов.
//
// Параметры:
//  Результат - Булево - наличие права на использование проверки контрагентов.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура ЕстьПравоНаИспользованиеПроверки(Результат, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Определяет наличие права на включение проверки контрагентов.
//
// Параметры:
//  Результат - Булево - наличие права на включение проверки контрагентов.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура ЕстьПравоНаРедактированиеНастроек(Результат, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Проверяет наличие доступа к веб-сервису ФНС.
//
// Параметры:
//  Результат - Булево - наличие доступа к веб-сервису ФНС.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура ЕстьДоступКВебСервисуФНС(Результат, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	
	Результат = Истина;
	
КонецПроцедуры

// Показывает, включена ли проверка контрагентов.
//
// Параметры:
//  Результат - Булево - Значение константы ИспользоватьПроверкуКонтрагентов - включена ли проверка контрагентов в базе.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура ПроверкаКонтрагентовВключена(Результат, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Перечень состояний недействующего контрагента.
//
// Параметры:
//  ДополнятьСостояниемСОшибкой	 - Булево - Если Истина, то контрагент с ошибкой считается действующим.
//  ДополнятьПустымСостоянием	 - Булево - Если Истина, то контрагент с пустым состоянием считается действующим.
//  Результат - Массив - Состояния контрагента, при которых он является действующим.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура СостоянияНедействующегоКонтрагента(ДополнятьСостояниемСОшибкой = Ложь, ДополнятьПустымСостоянием = Ложь, Результат, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Ссылка на инструкцию по проверке контрагентов.
//
// Параметры:
//  Результат - ФорматированнаяСтрока - Ссылка на инструкцию.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура СсылкаНаИнструкцию(Результат, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Процедура - Включение или отключение использования сервиса путем установки значения константе
//             ИспользоватьПроверкуКонтрагентов.
//
// Параметры:
//  ИспользоватьСервис	 - Булево - Истина, чтобы включить использование сервиса. Ложь - чтобы отключить.
//  СтандартнаяОбработка - Булево - Если истина, то выполняется стандартная процедура.
Процедура ВключитьВыключитьПроверкуКонтрагентов(ВключитьПроверку, СтандартнаяОбработка) Экспорт
	
КонецПроцедуры

// Процедура - Запуск фонового задания по проверке контрагентов после 
//			   включения проверки в предложении на подключение или из настроек.
Процедура ПроверитьКонтрагентовПослеВключенияПроверкиФоновоеЗадание(СтандартнаяОбработка) Экспорт
		
КонецПроцедуры

#КонецОбласти