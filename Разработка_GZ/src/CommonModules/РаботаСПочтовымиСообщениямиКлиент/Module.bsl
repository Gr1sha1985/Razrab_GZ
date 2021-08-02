///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Открывает форму создания нового письма.
//
// Параметры:
//  ПараметрыОтправкиПисьма  - см. РаботаСПочтовымиСообщениямиКлиент.ПараметрыОтправкиПисьма.
//  ОповещениеОЗакрытииФормы - ОписаниеОповещения - процедура, в которую необходимо передать управление после закрытия
//                                                  формы отправки письма.
//
Процедура СоздатьНовоеПисьмо(ПараметрыОтправкиПисьма = Неопределено, ОповещениеОЗакрытииФормы = Неопределено) Экспорт
	
	ПараметрыОтправки = ПараметрыОтправкиПисьма();
	Если ПараметрыОтправкиПисьма <> Неопределено Тогда
		ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(ПараметрыОтправки, ПараметрыОтправкиПисьма, Истина);
	КонецЕсли;
	
	СведенияДляОтправки = РаботаСПочтовымиСообщениямиВызовСервера.СведенияДляОтправки(ПараметрыОтправки);
	ПараметрыОтправки.Вставить("ПоказыватьДиалогВыбораФорматаСохраненияВложений", СведенияДляОтправки.ПоказыватьДиалогВыбораФорматаСохраненияВложений);
	ПараметрыОтправки.Вставить("ОповещениеОЗакрытииФормы", ОповещениеОЗакрытииФормы);
	
	Если СведенияДляОтправки.ЕстьДоступныеУчетныеЗаписиДляОтправки Тогда
		СоздатьНовоеПисьмоПроверкаУчетнойЗаписиВыполнена(Истина, ПараметрыОтправки);
	Иначе
		ОбработчикРезультата = Новый ОписаниеОповещения("СоздатьНовоеПисьмоПроверкаУчетнойЗаписиВыполнена", ЭтотОбъект, ПараметрыОтправки);
		Если СведенияДляОтправки.ДоступноПравоДобавленияУчетныхЗаписей Тогда
			ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПомощникНастройкиУчетнойЗаписи", 
				Новый Структура("КонтекстныйРежим", Истина), , , , , ОбработчикРезультата);
		Иначе
			ТекстСообщения = НСтр("ru = 'Для отправки письма требуется настройка учетной записи электронной почты.
				|Обратитесь к администратору.'");
			ОписаниеОповещения = Новый ОписаниеОповещения("ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочтыЗавершение", ЭтотОбъект, ОбработчикРезультата);
			ПоказатьПредупреждение(ОписаниеОповещения, ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Возвращает пустую структуру с параметрами отправки письма.
//
// Возвращаемое значение:
//  Структура - параметры для заполнения в форме отправки нового письма (все необязательные):
//   * Отправитель - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - учетная запись, с которой может
//                   быть отправлено почтовое сообщение;
//                 - СписокЗначений - список учетных записей, доступных для выбора в форме:
//                     ** Представление - Строка- наименование учетной записи;
//                     ** Значение - СправочникСсылка.УчетныеЗаписиЭлектроннойПочты - учетная запись.
//    
//   * Получатель - Строка - список адресов в формате:
//                           [ПредставлениеПолучателя1] <Адрес1>; [[ПредставлениеПолучателя2] <Адрес2>;...]
//                - СписокЗначений:
//                   ** Представление - Строка - представление получателя,
//                   ** Значение      - Строка - почтовый адрес.
//                - Массив - массив структур, описывающий получателей:
//                   ** Адрес                        - Строка - почтовый адрес получателя сообщения;
//                   ** Представление                - Строка - представление адресата;
//                   ** ИсточникКонтактнойИнформации - СправочникСсылка - владелец контактной информации.
//   
//   * Копии - СписокЗначений
//           - Строка - см. описание поля Получатель.
//   * СкрытыеКопии - СписокЗначений
//                  - Строка - см. описание поля Получатель.
//   * Тема - Строка - тема письма.
//   * Текст - Строка - тело письма.
//
//   * Вложения - Массив - файлы, которые необходимо приложить к письму (описания в виде структур):
//     ** Представление - Строка - имя файла вложения;
//     ** АдресВоВременномХранилище - Строка - адрес двоичных данных либо табличного документа во временном хранилище.
//     ** Кодировка - Строка - кодировка вложения (используется, если отличается от кодировки письма).
//     ** Идентификатор - Строка - (необязательный) используется для отметки картинок, отображаемых в теле письма.
//   
//   * УдалятьФайлыПослеОтправки - Булево - удалять временные файлы после отправки сообщения.
//   * Предмет - ЛюбаяСсылка - предмет письма.
//
Функция ПараметрыОтправкиПисьма() Экспорт
	ПараметрыПисьма = Новый Структура;
	
	ПараметрыПисьма.Вставить("Отправитель", Неопределено);
	ПараметрыПисьма.Вставить("Получатель", Неопределено);
	ПараметрыПисьма.Вставить("Копии", Неопределено);
	ПараметрыПисьма.Вставить("СкрытыеКопии", Неопределено);
	ПараметрыПисьма.Вставить("Тема", Неопределено);
	ПараметрыПисьма.Вставить("Текст", Неопределено);
	ПараметрыПисьма.Вставить("Вложения", Неопределено);
	ПараметрыПисьма.Вставить("УдалятьФайлыПослеОтправки", Неопределено);
	ПараметрыПисьма.Вставить("Предмет", Неопределено);
	
	Возврат ПараметрыПисьма;
КонецФункции

// Если у пользователя нет настроенной учетной записи для отправки писем, то в зависимости от прав либо показывает
// помощник настройки новой учетной записи, либо выводит сообщение о невозможности отправки.
// Предназначена для сценариев, в которых требуется выполнить настройку учетной записи перед запросом дополнительных
// параметров отправки.
//
// Параметры:
//  ОбработчикРезультата - ОписаниеОповещение - процедура, в которую необходимо передать выполнение кода после проверки.
//                                              В качестве результата возвращается Истина, если есть доступная учетная
//                                              запись для отправки почты. Иначе возвращается Ложь.
//
Процедура ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочты(ОбработчикРезультата) Экспорт
	Если РаботаСПочтовымиСообщениямиВызовСервера.ЕстьДоступныеУчетныеЗаписиДляОтправки() Тогда
		ВыполнитьОбработкуОповещения(ОбработчикРезультата, Истина);
	Иначе
		Если РаботаСПочтовымиСообщениямиВызовСервера.ДоступноПравоДобавленияУчетныхЗаписей() Тогда
			ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПомощникНастройкиУчетнойЗаписи", 
				Новый Структура("КонтекстныйРежим", Истина), , , , , ОбработчикРезультата);
		Иначе	
			ТекстСообщения = НСтр("ru = 'Для отправки письма требуется настройка почты.
				|Обратитесь к администратору.'");
			ОписаниеОповещения = Новый ОписаниеОповещения("ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочтыЗавершение", ЭтотОбъект, ОбработчикРезультата);
			ПоказатьПредупреждение(ОписаниеОповещения, ТекстСообщения);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПерейтиКДокументацииПоВводуУчетнойЗаписиЭлектроннойПочты() Экспорт
	
	ФайловаяСистемаКлиент.ОткрытьНавигационнуюСсылку("https://its.1c.ru/bmk/bsp_email_account");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Продолжение процедуры СоздатьНовоеПисьмо.
Процедура СоздатьНовоеПисьмоПроверкаУчетнойЗаписиВыполнена(УчетнаяЗаписьНастроена, ПараметрыОтправки) Экспорт
	
	Если УчетнаяЗаписьНастроена <> Истина Тогда
		Возврат;
	КонецЕсли;
	
	Если ПараметрыОтправки.ПоказыватьДиалогВыбораФорматаСохраненияВложений Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("СоздатьНовоеПисьмоПодготовитьВложения", ЭтотОбъект, ПараметрыОтправки);
		ОткрытьФорму("ОбщаяФорма.ВыборФорматаВложений", , , , , , ОписаниеОповещения);
		Возврат;
	КонецЕсли;
	
	СоздатьНовоеПисьмоВложенияПодготовлены(Истина, ПараметрыОтправки);
	
КонецПроцедуры

Процедура СоздатьНовоеПисьмоПодготовитьВложения(НастройкиСохранения, ПараметрыОтправки) Экспорт
	Если ТипЗнч(НастройкиСохранения) <> Тип("Структура") Тогда
		Возврат;
	КонецЕсли;
	
	РаботаСПочтовымиСообщениямиВызовСервера.ПодготовитьВложения(ПараметрыОтправки.Вложения, НастройкиСохранения);
	
	СоздатьНовоеПисьмоВложенияПодготовлены(Истина, ПараметрыОтправки);
КонецПроцедуры

// Продолжение процедуры СоздатьНовоеПисьмо.
Процедура СоздатьНовоеПисьмоВложенияПодготовлены(ВложенияПодготовлены, ПараметрыОтправки)

	Если ВложенияПодготовлены <> Истина Тогда
		Возврат;
	КонецЕсли;
	
	ОповещениеОЗакрытииФормы = ПараметрыОтправки.ОповещениеОЗакрытииФормы;
	ПараметрыОтправки.Удалить("ОповещениеОЗакрытииФормы");
	
	СтандартнаяОбработка = Истина;
	РаботаСПочтовымиСообщениямиКлиентПереопределяемый.ПередОткрытиемФормыОтправкиПисьма(ПараметрыОтправки, ОповещениеОЗакрытииФормы, СтандартнаяОбработка);
	
	Если Не СтандартнаяОбработка Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия") 
		И СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента().СозданиеИсходящихПисемДоступно Тогда
		МодульВзаимодействияКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ВзаимодействияКлиент");
		МодульВзаимодействияКлиент.ОткрытьФормуОтправкиПисьма(ПараметрыОтправки, ОповещениеОЗакрытииФормы);
	Иначе
		ОткрытьПростуюФормуОтправкиПочтовогоСообщения(ПараметрыОтправки, ОповещениеОЗакрытииФормы);
	КонецЕсли;
	
КонецПроцедуры

// Интерфейсная клиентская функция, поддерживающая упрощенный вызов простой
// формы редактирования нового письма. При отправке письма через простую
// форму сообщения не сохраняются в информационной базе.
//
// Параметры см. в описании функции СоздатьНовоеПисьмо.
//
Процедура ОткрытьПростуюФормуОтправкиПочтовогоСообщения(ПараметрыПисьма, ОписаниеОповещенияОЗакрытии)
	ОткрытьФорму("ОбщаяФорма.ОтправкаСообщения", ПараметрыПисьма, , , , , ОписаниеОповещенияОЗакрытии);
КонецПроцедуры

Процедура ПроверитьНаличиеУчетнойЗаписиДляОтправкиПочтыЗавершение(ОбработчикРезультата) Экспорт
	ВыполнитьОбработкуОповещения(ОбработчикРезультата, Ложь);
КонецПроцедуры

Функция ПроверитьНастройкиУчетнойЗаписи(УчетнаяЗапись) Экспорт
	
	Параметры = Новый Структура("УчетнаяЗапись", УчетнаяЗапись);
	ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.Форма.ПроверкаНастроекУчетнойЗаписи", Параметры);
	
КонецФункции

Процедура ПолеПароляНачалоВыбора(Элемент, Реквизит, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Реквизит = Элемент.ТекстРедактирования;
	Элемент.РежимПароля = Не Элемент.РежимПароля;
	Если Элемент.РежимПароля Тогда
		Элемент.КартинкаКнопкиВыбора = БиблиотекаКартинок.ВводимыеСимволыСкрыты;
	Иначе
		Элемент.КартинкаКнопкиВыбора = БиблиотекаКартинок.ВводимыеСимволыВидны;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
