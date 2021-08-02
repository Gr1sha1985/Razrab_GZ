#Область ПрограммныйИнтерфейс

#Область Локализация

// Выполняет переопределяемую команду
//
// Параметры:
//  Форма	- ФормаКлиентскогоПриложения - форма, в которой расположена команда
//  Команда	- КомандаФормы - команда формы
//  ДополнительныеПараметры	- Структура - дополнительные параметры.
//
Процедура ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСКлиентПереопределяемый.ВыполнитьПереопределяемуюКомандуИС(Форма, Команда, ДополнительныеПараметры);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ВыполнитьПереопределяемуюКоманду(Форма, Команда, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ОбработкаНавигационнойСсылки(Форма, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСКлиентПереопределяемый.ОбработкаОповещенияИС(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписи(Форма, ПараметрыЗаписи) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ПослеЗаписи(Форма, ПараметрыЗаписи);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ПослеЗаписи(Форма, ПараметрыЗаписи);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ПослеЗаписи(Форма, ПараметрыЗаписи);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПослеЗаписи(Форма, ПараметрыЗаписи);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#Область СобытияЭлементовФорм

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//   Ограничения: не предполагает контекстный серверный вызов
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - ЭлементФормы     - элемент-источник события "При изменении"
//   ДополнительныеПараметры - Структура        - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		СобытияФормИСКлиентПереопределяемый.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриАктивизацииСтроки(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПриАктивизацииСтроки(Форма, Элемент, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры) Экспорт
	
	Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(Форма, "ПараметрыИнтеграцииГосИС") Тогда
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ЕГАИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормЕГАИСКлиент");
			Модуль.ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ВЕТИС")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормВЕТИСКлиент");
			Модуль.ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормГИСМКлиент");
			Модуль.ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры);
		КонецЕсли;
		
		Если Форма.ПараметрыИнтеграцииГосИС.Получить("ИСМП")<>Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("СобытияФормИСМПКлиент");
			Модуль.ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры
#КонецОбласти

#Область ОбщиеДействияТребующиеЗаписиОбъекта

Процедура ВыполнитьДействиеСЗаписьюОбъекта(Форма, Объект, Действие) Экспорт
	
	ТребуетсяЗапись = Ложь;
	ТекстВопроса = "";
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ТребуетсяЗапись = Истина;
		ТекстВопроса = НСтр("ru = 'Документ не записан. Записать?'");
	ИначеЕсли Форма.Модифицированность Тогда
		ТребуетсяЗапись = Истина;
		ТекстВопроса = НСтр("ru = '%1 был изменен. Записать?'");
	КонецЕсли;
	
	Если ТребуетсяЗапись Тогда
		ОписаниеОповещенияВопрос = Новый ОписаниеОповещения("ВыполнитьЗаписьОбъекта",
			ЭтотОбъект,
			Новый Структура("Форма, Действие", Форма, Действие));
		ПоказатьВопрос(ОписаниеОповещенияВопрос, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	Иначе
		ВыполнитьОбработкуОповещения(Действие);
	КонецЕсли;
	
КонецПроцедуры

Процедура ВыполнитьЗаписьОбъекта(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если Не РезультатВопроса = КодВозвратаДиалога.Да Тогда
		 Возврат;
	КонецЕсли;
	
	ОбъектЗаписан = Ложь;
	Форма = ДополнительныеПараметры.Форма;
	
	Если Форма.ПроверитьЗаполнение() Тогда
		ОбъектЗаписан = Форма.Записать();
	КонецЕсли;
	
	Если ОбъектЗаписан Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.Действие);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти


#Область СлужебныйПрограммныйИнтерфейс

Функция ВнешнееСобытиеПреобразоватьДанныеСоСканераВСтруктуру(Форма, Источник, Событие, Данные) Экспорт
	
	Если Не Форма.ВводДоступен() Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ОписаниеСобытия = Новый Структура;
	ОписаниеСобытия.Вставить("Источник", Источник);
	ОписаниеСобытия.Вставить("Событие" , Событие);
	ОписаниеСобытия.Вставить("Данные"  , Данные);
	
	Результат = МенеджерОборудованияКлиент.ПолучитьСобытиеОтУстройства(ОписаниеСобытия);
	
	ДанныеСоСканера = Неопределено;
	
	Если Результат <> Неопределено
		И Результат.Источник = "ПодключаемоеОборудование"
		И Результат.ИмяСобытия = "ScanData"
		И Найти(Форма.ПоддерживаемыеТипыПодключаемогоОборудования, "СканерШтрихкода") > 0 Тогда
		
		ОценкаПроизводительностиКлиент.ЗамерВремени("ОбщийМодуль.СобытияФормИСКлиент.ВнешнееСобытиеОбработатьВводШтрихкода");
		ДанныеСоСканера = ПреобразоватьДанныеСоСканераВСтруктуру(Результат.Параметр);
		
	КонецЕсли;
	
	Возврат ДанныеСоСканера;
	
КонецФункции

//Типовой сценарий обработки оповещения прикладных объектов об изменениях в библиотечных.
//   Вызывается для обновления гиперссылок в прикладных документах.
// 
// Параметры:
//   МестоВызова - Структура - сведения о месте в котором требуется обработка:
//    * Форма  - ФормаКлиентскогоПриложения     - источник вызова
//    * Объект - ДанныеФормыСтруктура - основной реквизит формы
//   Событие     - Структура - сведения о событии:
//    * Имя        - Строка       - имя события формы
//    * Параметр   - Произвольный - параметр события формы
//    * Источник   - Произвольный - источник события формы
//    * Обработано - Булево       - признак что событие уже обработано
//   Подсистема  - Структура - сведения о подсистеме ГосИС - источнике события:
//    * Имя       - Строка           - имя подсистемы
//    * Документы - Массив Из Строка - имена документов, для которых требуется обработка оповещения
//
Процедура ОбработкаОповещенияВФормеДокументаОснования(МестоВызова, Событие, Подсистема) Экспорт
	
	ОписаниеСобытия = ИнтеграцияИСКлиентСервер.ПреобразоватьИмяСобытияОповещенияВоВнутреннийФормат(Событие.Имя);
	
	// Проверим корректность имени события оповещения.
	Если ИнтеграцияИСКлиентСервер.ЭтоСобытиеОповещенияИзмененоСостояние(ОписаниеСобытия)
	 ИЛИ ИнтеграцияИСКлиентСервер.ЭтоСобытиеОповещенияВыполненОбмен(ОписаниеСобытия) Тогда
		
		Событие.Обработано = Истина;
		
	ИначеЕсли ИнтеграцияИСКлиентСервер.ЭтоСобытиеОповещенияИзмененОбъект(ОписаниеСобытия) Тогда
		
		ИмяИзмененногоОбъекта = ИнтеграцияИСКлиентСервер.ИмяИзмененногоОбъектаИзВнутреннегоФорматаСобытияОповещения(ОписаниеСобытия);
		ЧастиИмениОбъекта     = СтроковыеФункцииКлиентСервер.РазложитьСтрокуВМассивПодстрок(ИмяИзмененногоОбъекта, ".");
		
		Если ЧастиИмениОбъекта.Количество() = 2 
			И ЧастиИмениОбъекта[0] = "Документ" Тогда
			ОбрабатываютсяДокументы = Подсистема.МодульВызовСервера.ИменаДокументовДляДокументаОснования(МестоВызова.Объект.Ссылка);
			Если ОбрабатываютсяДокументы.Найти(ЧастиИмениОбъекта[1]) <> Неопределено Тогда
				Событие.Обработано = Истина; // будет обработано далее по коду
			КонецЕсли;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Событие.Обработано Тогда
		
		// Проверим, что оповещение относится к объекту указанной формы.
		ОбязательныеПараметрыОповещения = Новый Структура("Основание");
		Если Событие.Параметр <> Неопределено Тогда
			ЗаполнитьЗначенияСвойств(ОбязательныеПараметрыОповещения, Событие.Параметр);
		КонецЕсли;
		
		Если Событие.Параметр = Неопределено ИЛИ ОбязательныеПараметрыОповещения.Основание = МестоВызова.Объект.Ссылка Тогда
			
			ИнтеграцияИСКлиент.ОбновитьПолеИнтеграцииВФормеДокументаОснования(
				МестоВызова.Форма,
				Подсистема);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

// Вызывается при сканировании штрихкода в форме объекта.
//
// Параметры:
//  ОповещениеПриЗавершении - ОписаниеОповещения - процедура, вызываемая при завершении обработки,
//  Форма - ФормаКлиентскогоПриложения - форма, в которой отсканирован штрихкод,
//  Источник - Строка - источник внешнего события,
//  Событие - Строка - наименование события,
//  Данные - Строка - данные для события,
//  ПараметрыСканирования - Структура - параметры сканирования акцизных марок.
//
Процедура ВнешнееСобытиеПолученыШтрихкоды(ОповещениеПриЗавершении, Форма, Источник, Событие, Данные, ПараметрыСканирования = Неопределено) Экспорт
	
	Если Не Форма.ВводДоступен() Тогда
		Возврат;
	КонецЕсли;
	
	ОписаниеСобытия = Новый Структура;
	ОписаниеСобытия.Вставить("Источник", Источник);
	ОписаниеСобытия.Вставить("Событие" , Событие);
	ОписаниеСобытия.Вставить("Данные"  , Данные);
	
	Результат = МенеджерОборудованияКлиент.ПолучитьСобытиеОтУстройства(ОписаниеСобытия);
	
	Если Результат <> Неопределено
		И Результат.Источник = "ПодключаемоеОборудование"
		И Результат.ИмяСобытия = "ScanData"
		И Найти(Форма.ПоддерживаемыеТипыПодключаемогоОборудования, "СканерШтрихкода") > 0 Тогда
		
		ОценкаПроизводительностиКлиент.ЗамерВремени("ОбщийМодуль.СобытияФормИСКлиент.ВнешнееСобытиеПолученыШтрихкоды");
		
		ДанныеШтрихкода = ПреобразоватьДанныеСоСканераВСтруктуру(Результат.Параметр);
		
		// Печатает новый код маркировки. Подменяет отсканированный код номенклатуры кодом маркировки.
		Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ГосИС.ИСМП")
				И ПараметрыСканирования <> Неопределено Тогда
			Модуль = ОбщегоНазначенияКлиент.ОбщийМодуль("ШтрихкодированиеИСМПКлиент");
			Модуль.ОбработатьСобытиеПотоковойПечати(Форма, ДанныеШтрихкода, ПараметрыСканирования)
		КонецЕсли;
		
		// Обрабатывает сканирование существующего кода маркировки в формах проверки и подбора.
		Если ПараметрыСканирования <> Неопределено
			И ПараметрыСканирования.ИспользуетсяСоответствиеШтрихкодовСтрокДерева
			И ПараметрыСканирования.ДопустимыеВидыПродукции.Количество() = 1 Тогда
			
			ВидПродукции = ПараметрыСканирования.ДопустимыеВидыПродукции[0];
			
			Если ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак") Тогда
				
				ПримечаниеКРазборуШтрихкода = Неопределено;
				ДанныеРазбора = РазборКодаМаркировкиИССлужебныйКлиент.РазобратьКодМаркировки(ДанныеШтрихкода.Штрихкод, ВидПродукции, ПримечаниеКРазборуШтрихкода);
				
				ДанныеРазбораИРезультат = Новый Структура;
				ДанныеРазбораИРезультат.Вставить("ДанныеРазбора",               ДанныеРазбора);
				ДанныеРазбораИРезультат.Вставить("ПримечаниеКРазборуШтрихкода", ПримечаниеКРазборуШтрихкода);
				
				КешДанныхРазбора = Новый Соответствие;
				КешДанныхРазбора.Вставить(ДанныеШтрихкода.Штрихкод, ДанныеРазбораИРезультат);
				
				НормализованныйШтрихкод = РазборКодаМаркировкиИССлужебныйКлиент.НормализованныйШтрихкод(
					ДанныеШтрихкода.Штрихкод, ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Табак"), КешДанныхРазбора);
				
			ИначеЕсли ВидПродукции = ПредопределенноеЗначение("Перечисление.ВидыПродукцииИС.Алкогольная") Тогда
				
				НормализованныйШтрихкод = ДанныеШтрихкода.Штрихкод;
				
			Иначе
				
				ДанныеРазбора = РазборКодаМаркировкиИССлужебныйКлиент.РазобратьКодМаркировки(ДанныеШтрихкода.Штрихкод, ВидПродукции);
				Если ДанныеРазбора = Неопределено Тогда
					НормализованныйШтрихкод = ДанныеШтрихкода.Штрихкод;
				Иначе
					НормализованныйШтрихкод = ДанныеРазбора.НормализованныйКодМаркировки;
				КонецЕсли;
				
			КонецЕсли;
			
			Если Форма.СоответствиеШтрихкодовСтрокДерева.Получить(НормализованныйШтрихкод) <> Неопределено Тогда
				ДанныеШтрихкода.Штрихкод = НормализованныйШтрихкод;
				ВыполнитьОбработкуОповещения(ОповещениеПриЗавершении, ДанныеШтрихкода);
				Возврат;
			КонецЕсли;
			
		КонецЕсли;
		
		ШтрихкодированиеИСКлиент.ОбработатьДанныеШтрихкода(
			ОповещениеПриЗавершении, Форма, ДанныеШтрихкода, ПараметрыСканирования, ДанныеРазбора);
		
	КонецЕсли;
	
КонецПроцедуры

// Инициализирует параметры для обработки штрихкода через внешнее событие.
// 
// Возвращаемое значение:
//  Структура - Описание:
// * ВидПродукции - ПеречислениеСсылка.ВидыПродукцииИС - Необязательный параметр. Нужно заполнять в случае необходимости
//       отбора по виду продукции и при отсутствии параметров сканирования.
// * ПараметрыСканирования - (См. ШтрихкодированиеИСКлиент.ПараметрыСканирования). Параметр необязателен.
// * Оповещение - ОписаниеОповещения - после обработки штрихкода по данному оповещению будет передан результат обработки
//       штрихкода. Параметр необязателен.
// * КэшированныеЗначения - Структура - закэшированные значения.
// * Данные - Строка - данные для события.
// * Событие - Строка - наименование события.
// * Источник - Строка - источник внешнего события.
Функция ПараметрыОбработкиВводаШтрихкода() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Источник");
	Параметры.Вставить("Событие");
	Параметры.Вставить("Данные");
	Параметры.Вставить("КэшированныеЗначения");
	Параметры.Вставить("Оповещение");
	Параметры.Вставить("ПараметрыСканирования");
	Параметры.Вставить("ВидПродукции");
	
	Возврат Параметры;
	
КонецФункции

// В процедуре нужно реализовать алгоритм преобразования данных из подсистемы подключаемого оборудования.
//
// Параметры:
//  Параметр - Массив - входящие данные.
//
// Возвращаемое значение:
//  Массив - Массив структур со свойствами:
//   * Штрихкод
//   * Количество
Функция ПреобразоватьДанныеСоСканераВМассив(Параметр) Экспорт
	
	Результат = Новый Массив;
	СобытияФормИСКлиентПереопределяемый.ПреобразоватьДанныеСоСканераВМассив(Результат, Параметр);
	Возврат Результат;
	
КонецФункции

// В процедуре нужно реализовать алгоритм преобразования данных из подсистемы подключаемого оборудования.
//
// Параметры:
//  Параметр - Массив - входящие данные.
//
// Возвращаемое значение:
//  Структура - структура со свойствами:
//   * Штрихкод
//   * Количество
Функция ПреобразоватьДанныеСоСканераВСтруктуру(Параметр) Экспорт
	
	Результат = Новый Структура("Штрихкод, Количество");
	СобытияФормИСКлиентПереопределяемый.ПреобразоватьДанныеСоСканераВСтруктуру(Результат, Параметр);
	Возврат Результат;
	
КонецФункции

Процедура СообщитьОбОшибке(РезультатВыполнения) Экспорт
	
	ТекстСообщения = НСтр("ru = 'При выполнении операции произошла ошибка:""%ОписаниеОшибки%"".'");
	ТекстСообщения = СтрЗаменить(ТекстСообщения, "%ОписаниеОшибки%", РезультатВыполнения.ОписаниеОшибки);
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	
КонецПроцедуры

#КонецОбласти
