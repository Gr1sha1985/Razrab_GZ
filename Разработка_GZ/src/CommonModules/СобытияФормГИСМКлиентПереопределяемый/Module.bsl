#Область Локализация

Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник, ДополнительныеПараметры) Экспорт
	
	Возврат;

КонецПроцедуры

Процедура ПослеЗаписи(Форма, ПараметрыЗаписи) Экспорт
	
	Возврат;
	
КонецПроцедуры

#Область СобытияЭлементовФорм

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
// Параметры:
//   Форма                   - ФормаКлиентскогоПриложения - форма, из которой происходит вызов процедуры.
//   Элемент                 - ЭлементФормы     - элемент-источник события "При изменении"
//   ДополнительныеПараметры - Структура        - значения дополнительных параметров влияющих на обработку.
//
Процедура ПриИзмененииЭлемента(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриВыбореЭлемента(Форма, Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриАктивизацииЯчейки(Форма, Элемент, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Переопределяемая процедура, вызываемая из одноименного обработчика события элемента.
//
Процедура ПриНачалеРедактирования(Форма, Элемент, НоваяСтрока, Копирование, ДополнительныеПараметры) Экспорт
	
	Возврат;
	
КонецПроцедуры

// Заполняет требуемый тип надписи в прикладной форме из фиксированного списка:
//   УведомлениеОбОтгрузке
//   УведомлениеОСписании
//   <пустая строка> (надпись не требуется)
// 
// Параметры:
//   Форма      - ФормаКлиентскогоПриложения - форма для размещения надписи
//   ТипНадписи - Строка           - тип надписи связанных документов ГИСМ
Процедура ПриОпределенииТипаНадписиПоФорме(Форма, ТипНадписи) Экспорт
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

// Выполняет действия при создании характеристики в таблице Товары.
//
// Параметры:
//  Форма                - ФормаКлиентскогоПриложения            - форма, в которой произошло событие,
//  ТекущаяСтрока        - ДанныеФормыЭлементКоллекции - строка таблицы товаров,
//  Элемент              - ПолеФормы                   - поле, в котором происходит создание характеристики,
//  СтандартнаяОбработка - Булево                      - признак отказа от стандартной обработки события.
Процедура ХарактеристикаСоздание(Форма, ТекущаяСтрока, Элемент, СтандартнаяОбработка) Экспорт
	
	
	Возврат;
	
КонецПроцедуры

#КонецОбласти
