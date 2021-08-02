#Область ПрограммныйИнтерфейс

#Область Локализация

Процедура МодификацияРеквизитовФормы(Форма, ПараметрыИнтеграции, ДобавляемыеРеквизиты) Экспорт
	
	ДобавитьОбщиеНастройкиВстраивания(Форма, ПараметрыИнтеграции);
	ДобавитьРеквизитТекстСостояниеГИСМ(Форма, ПараметрыИнтеграции, ДобавляемыеРеквизиты);
	ДобавитьРеквизитТекстОбменГИСМ(Форма, ПараметрыИнтеграции, ДобавляемыеРеквизиты);
	
КонецПроцедуры

Процедура МодификацияЭлементовФормы(Форма) Экспорт
	
	СобытияФормИС.ВстроитьСтрокуИнтеграцииВДокументОснованиеПоПараметрам(Форма, "ГИСМ.ДокументОснование");
	СобытияФормИС.ВстроитьСтрокуИнтеграцииВДокументОснованиеПоПараметрам(Форма, "ГИСМ.Обмен");
	
КонецПроцедуры

Процедура ЗаполнениеРеквизитовФормы(Форма) Экспорт
	
	ИмяРеквизитаФормыОбъект = Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ").ИмяРеквизитаФормыОбъект;
	
	ПараметрыИнтеграции = Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ.ДокументОснование");
	Если ПараметрыИнтеграции <> Неопределено И ЗначениеЗаполнено(ПараметрыИнтеграции.ИмяРеквизитаФормы) Тогда
		ТипНадписи   = "";
		ТекстНадписи = "";
		СобытияФормГИСМПереопределяемый.ПриОпределенииТипаНадписиПоФорме(Форма, ТипНадписи);
		Если ЗначениеЗаполнено(ТипНадписи) Тогда
			Ссылка = Форма[ИмяРеквизитаФормыОбъект].Ссылка;
			ТекстНадписи = ИнтеграцияГИСМВызовСервера.ТекстГиперссылкиВДокументеОсновании(Ссылка, ТипНадписи);
		КонецЕсли;
		Форма[ПараметрыИнтеграции.ИмяРеквизитаФормы] = ТекстНадписи;
		Форма.Элементы[ПараметрыИнтеграции.ИмяЭлементаФормы].Видимость = ЗначениеЗаполнено(ТекстНадписи);
	КонецЕсли;
	
	ПараметрыИнтеграции = Форма.ПараметрыИнтеграцииГосИС.Получить("ГИСМ.Обмен");
	Если ПараметрыИнтеграции <> Неопределено И ЗначениеЗаполнено(ПараметрыИнтеграции.ИмяРеквизитаФормы) Тогда
		ТипНадписи   = "";
		ТекстСтатусаОбмена = "";
		СобытияФормГИСМПереопределяемый.ПриОпределенииТипаСтатусаОбмена(Форма, ТипНадписи);
		Если ЗначениеЗаполнено(ТипНадписи) Тогда
			Ссылка = Форма[ИмяРеквизитаФормыОбъект].Ссылка;
			ТекстСтатусаОбмена = ИнтеграцияГИСМВызовСервера.ТекстСтатусДокумента(Ссылка);
		КонецЕсли;
		Форма[ПараметрыИнтеграции.ИмяРеквизитаФормы] = ТекстСтатусаОбмена;
		Форма.Элементы[ПараметрыИнтеграции.ИмяЭлементаФормы].Видимость = ЗначениеЗаполнено(ТекстСтатусаОбмена);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписиНаСервере(Форма) Экспорт
	
	СобытияФормГИСМПереопределяемый.ПослеЗаписиНаСервере(Форма);
	
КонецПроцедуры

Процедура ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка) Экспорт
	
	СобытияФормГИСМПереопределяемый.ПриСозданииНаСервере(Форма, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ПриЧтенииНаСервере(Форма, ТекущийОбъект) Экспорт
	
	СобытияФормГИСМПереопределяемый.ПриЧтенииНаСервере(Форма, ТекущийОбъект);
	
КонецПроцедуры

#Область СобытияЭлементовФорм

// Серверная переопределяемая процедура, вызываемая из обработчика события элемента.
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - Строка           - имя элемента-источника события "При изменении"
//   ДополнительныеПараметры - Структура        - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	СобытияФормГИСМПереопределяемый.ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ФормыСписковДокументовГИСМ

// Дорабатывает форму списка документов:
//   * Добавляет необходимые отборы
//   * Скрывает списки к оформлению при необходимости
//
// Параметры:
//   Форма     - ФормаКлиентскогоПриложения - форма списка документов ИСМП
//   Настройки - Структура        - (См. ИнтеграцияИС.НастройкиФормыСпискаДокументов)
//             - Неопределено     - будут использованы значения по умолчанию описанные здесь
//
Процедура ПриСозданииНаСервереФормыСпискаДокументов(Форма, Настройки = Неопределено) Экспорт
	
	Если Настройки = Неопределено Тогда
		Настройки = ИнтеграцияИС.НастройкиФормыСпискаДокументов();
		Настройки.ТипыКОформлению = ТипыДокументовГИСМПоддерживающиеСтатусыОформления();
	КонецЕсли;
	ИнтеграцияГИСМ.ПриСозданииНаСервереФормыСпискаДокументов(Форма, Настройки);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьОбщиеНастройкиВстраивания(Форма, ПараметрыИнтеграции)
	
	ОбщиеНастройки = СобытияФормИС.ОбщиеПараметрыИнтеграции("СобытияФормГИСМ");
	ПараметрыИнтеграции.Вставить("ГИСМ", ОбщиеНастройки);
	
КонецПроцедуры

// Встраивает реквизит - форматированную строку перехода к ГИСМ в прикладные формы
// 
// Параметры:
//   Форма                - ФормаКлиентскогоПриложения - форма в которую происходит встраивание
//   ПараметрыИнтеграции  - Структура        - (См. ПараметрыИнтеграцииГИСМ)
//   ДобавляемыеРеквизиты - Массив           - массив реквизитов формы к добавлению

Процедура ДобавитьРеквизитТекстСостояниеГИСМ(Форма, ПараметрыИнтеграции, ДобавляемыеРеквизиты)
	
	ПараметрыИнтеграцииГИСМ = ПараметрыИнтеграцииГИСМСвязанныеДокументы(Форма);
	
	Если ЗначениеЗаполнено(ПараметрыИнтеграцииГИСМ.ИмяРеквизитаФормы) Тогда
		ПараметрыИнтеграции.Вставить("ГИСМ.ДокументОснование", ПараметрыИнтеграцииГИСМ);
		Реквизит = Новый РеквизитФормы(
			ПараметрыИнтеграцииГИСМ.ИмяРеквизитаФормы,
			Новый ОписаниеТипов("ФорматированнаяСтрока"),,
			ПараметрыИнтеграцииГИСМ.Заголовок);
		ДобавляемыеРеквизиты.Добавить(Реквизит);
	КонецЕсли;
	
КонецПроцедуры

// Встраивает реквизит - форматированную строку статуса обмена ГИСМ в прикладные формы
// 
// Параметры:
//   Форма                - ФормаКлиентскогоПриложения - форма в которую происходит встраивание
//   ПараметрыИнтеграции  - Структура        - (См. ПараметрыИнтеграцииГИСМ)
//   ДобавляемыеРеквизиты - Массив           - массив реквизитов формы к добавлению

Процедура ДобавитьРеквизитТекстОбменГИСМ(Форма, ПараметрыИнтеграции, ДобавляемыеРеквизиты)
	
	ПараметрыИнтеграцииГИСМ = ПараметрыИнтеграцииГИСМОбмен(Форма);
	
	Если ЗначениеЗаполнено(ПараметрыИнтеграцииГИСМ.ИмяРеквизитаФормы) Тогда
		ПараметрыИнтеграции.Вставить("ГИСМ.Обмен", ПараметрыИнтеграцииГИСМ);
		Реквизит = Новый РеквизитФормы(
			ПараметрыИнтеграцииГИСМ.ИмяРеквизитаФормы,
			Новый ОписаниеТипов("ФорматированнаяСтрока"),,
			ПараметрыИнтеграцииГИСМ.Заголовок);
		ДобавляемыеРеквизиты.Добавить(Реквизит);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает структуру, заполненную значениями по умолчанию, используемую для интеграции реквизитов ГИСМ
//   в прикладные формы конфигурации - потребителя библиотеки ГосИС. Если передана форма - сразу заполняет ее
//   специфику в переопределяемом модуле.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения, Неопределено - форма для которой возвращаются параметры интеграции
//
// ВозвращаемоеЗначение:
//   Структура - (См. СобытияФормИС.ПараметрыИнтеграцииДляДокументаОснования).
//
Функция ПараметрыИнтеграцииГИСМСвязанныеДокументы(Форма = Неопределено)
	
	ПараметрыНадписи = СобытияФормИС.ПараметрыИнтеграцииДляДокументаОснования();
	ПараметрыНадписи.Вставить("Ключ",                       "ЗаполнениеТекстаДокументаГИСМ");
	ПараметрыНадписи.Вставить("ИмяЭлементаФормы",           "ТекстДокументаГИСМ");
	ПараметрыНадписи.Вставить("ИмяРеквизитаФормы",          "ТекстДокументаГИСМ");
	
	Если НЕ(Форма = Неопределено) Тогда
		СобытияФормГИСМПереопределяемый.ПриОпределенииПараметровИнтеграцииДляДокументаОснования(Форма, ПараметрыНадписи);
	КонецЕсли;
	
	Возврат ПараметрыНадписи;
	
КонецФункции

// Возвращает структуру, заполненную значениями по умолчанию, используемую для интеграции реквизитов ГИСМ
//   в прикладные формы конфигурации - потребителя библиотеки ГосИС. Если передана форма - сразу заполняет ее
//   специфику в переопределяемом модуле.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения, Неопределено - форма для которой возвращаются параметры интеграции
//
// ВозвращаемоеЗначение:
//   Структура - (См. СобытияФормИС.ПараметрыИнтеграцииДляДокументаОснования).
//
Функция ПараметрыИнтеграцииГИСМОбмен(Форма = Неопределено)
	
	ПараметрыНадписи = СобытияФормИС.ПараметрыИнтеграцииДляДокументаОснования();
	ПараметрыНадписи.Вставить("Ключ", "ЗаполнениеСтатусаОбменаГИСМ");
	
	Если НЕ(Форма = Неопределено) Тогда
		СобытияФормГИСМПереопределяемый.ПриОпределенииПараметровИнтеграцииДляОбмена(Форма, ПараметрыНадписи);
	КонецЕсли;
	
	Возврат ПараметрыНадписи;
	
КонецФункции

Функция ТипыДокументовГИСМПоддерживающиеСтатусыОформления()
	
	МассивИменТипов = Новый Массив;
	МассивИменТипов.Добавить("ДокументСсылка.ЗаявкаНаВыпускКиЗГИСМ");
	МассивИменТипов.Добавить("ДокументСсылка.УведомлениеОбИмпортеМаркированныхТоваровГИСМ");
	МассивИменТипов.Добавить("ДокументСсылка.УведомлениеОбОтгрузкеМаркированныхТоваровГИСМ");
	МассивИменТипов.Добавить("ДокументСсылка.УведомлениеОВвозеМаркированныхТоваровИзЕАЭСГИСМ");
	МассивИменТипов.Добавить("ДокументСсылка.УведомлениеОСписанииКиЗГИСМ");
	
	Результат = Новый Структура("Тип");
	
	Результат.Тип = Новый ОписаниеТипов(СтрСоединить(МассивИменТипов, ","));
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

