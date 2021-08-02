#Область ПрограммныйИнтерфейс

// В данной процедуре необходимо добавить описания ролей подписантов конфигурации.
//
// Параметры:
//   РолиПодписантов - Массив - Элементы создаются функцией ПодписиДокументов.ИменаРеквизитовРолиПодписанта().
//
Процедура ПриОпределенииРолейПодписантов(РолиПодписантов) Экспорт
	
КонецПроцедуры

// Формирует структуру значений подписей документов по переданному описанию имен реквизитов.
//
// Параметры:
//   ОписаниеПодписей - Соответствие - коллекция, описывающая состав ответственных и их размещение в реквизитах
//       * Ключ - имена ролей подписантов
//       * Значение - Структура - содержит 3 поля - "ФизическоеЛицо", "ОписаниеПолномочий", "Должность",
//                    в которых содержатся имена переменных для возвращаемых значений реквизитов подписантов.
//   Организация - СправочникСсылка.Организации - организация, по которой будут получаться значения.
//   ЗначенияПодписей - Структура - содержит имена (ключи) и значения затребованных реквизитов.
//   СтандартнаяОбработка - Булево - флаг необходимости дальнейшего заполнения значений подписей документов.
//
// Пример:
//
//	Процедура ЗаполнитьСведенияОПодписяхДокументов(ОписаниеПодписей, Организация, ЗначенияПодписей, СтандартнаяОбработка) Экспорт
//
//		ОтветственныеОрганизации = ОтветственныеЛица.ОтветственныеЛицаОрганизации(Организация, ТекущаяДатаСеанса());
//
//		ОписаниеРуководителя = ОписаниеПодписей["Руководитель"];
//		Если ОписаниеРуководителя <> Неопределено Тогда
//			ЗначенияПодписей.Вставить(ОписаниеРуководителя["ФизическоеЛицо"], ОтветственныеОрганизации.Руководитель);
//			ЗначенияПодписей.Вставить(ОписаниеРуководителя["Должность"], ОтветственныеОрганизации.ДолжностьРуководителя);
//		КонецЕсли;
//
//		СтандартнаяОбработка = Ложь;
//
//	КонецПроцедуры
//
Процедура ЗаполнитьСведенияОПодписяхДокументов(ОписаниеПодписей, Организация, ЗначенияПодписей, СтандартнаяОбработка, ДатаСведений = Неопределено) Экспорт
	
	УчетЗарплаты.ЗаполнитьСведенияОбОтветственных(ОписаниеПодписей, Организация, ЗначенияПодписей);
	СтандартнаяОбработка = Ложь;

КонецПроцедуры

#КонецОбласти