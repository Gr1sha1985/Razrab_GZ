
#Область ОбработчикиБаннераНДП

&НаКлиенте
Процедура ОбработатьСсылкуБаннераПредупреждениеОЗаполненииРеквизитовПлатежаНПД(Организация, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	Если НавигационнаяСсылкаФорматированнойСтроки = "ОткрытьПомощникНПД" Тогда
		СтандартнаяОбработка = Ложь;
		ПараметрыФормы = Новый Структура("КонтекстныйВызов,Организация", Ложь, Организация);
		ОткрытьФорму("Обработка.ПомощникУплатыНПД.Форма.Форма", ПараметрыФормы);
	ИначеЕсли НавигационнаяСсылкаФорматированнойСтроки = "ПерейтиВЛичныйКабинетНПД" Тогда
		СтандартнаяОбработка = Ложь;
		ОбщегоНазначенияКлиент.ОткрытьНавигационнуюСсылку(
			ИнтеграцияСПлатформойСамозанятыеКлиентСервер.АдресСервиса());
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура ПолучитьВыпискуБанка(Форма, НастройкиБанковскогоСчета, СтруктураПериода) Экспорт
	
	Форма.СоглашениеЭД    = НастройкиБанковскогоСчета.СоглашениеПрямогоОбменаСБанками;
	Форма.ПериодНачало    = СтруктураПериода.ДатаНачала;
	Форма.ПериодОкончание = СтруктураПериода.ДатаОкончания;
	
	ДополнительныеПараметры = ОбщегоНазначенияКлиентСервер.СкопироватьСтруктуру(СтруктураПериода);
	ДополнительныеПараметры.Вставить("БанковскийСчет", НастройкиБанковскогоСчета.БанковскийСчет);
	
	Если СтруктураПериода.Свойство("ОткрыватьФормуУточненияПериода") Тогда
		Если НастройкиБанковскогоСчета.ПрограммаБанка = ПредопределенноеЗначение("Перечисление.ПрограммыБанка.СбербанкОнлайн")
			И УчетДенежныхСредствВызовСервера.НетДокументовДиректБанкСбербанк(
				НастройкиБанковскогоСчета.Организация, НастройкиБанковскогоСчета.БанковскийСчет) Тогда
			Оповещение = Новый ОписаниеОповещения("ПолучитьВыпискиПоПрямомуОбменуСБанкомЗавершение", Форма, ДополнительныеПараметры);
			ТекстПредупреждения =
				НСтр("ru = 'Запрос выписки за большой период может привести к длительному ожиданию и быть прерван банком,
				|если потребуется значительное время соединения.
				|
				|Рекомендуется разбить большой период загрузки на интервалы не более двух недель.'");
			ПоказатьПредупреждение(Оповещение, ТекстПредупреждения);
		Иначе
			Форма.ОткрытьФормуКлиентБанка(ДополнительныеПараметры);
		КонецЕсли;
	Иначе
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Форма", Форма);
		Оповещение = Новый ОписаниеОповещения("ПолучитьВыпискуБанкаЗавершение", ЭтотОбъект, ДополнительныеПараметры);
		ОбменСБанкамиКлиент.ПолучитьВыписку(Оповещение, НастройкиБанковскогоСчета.БанковскийСчет, Форма.ПериодНачало, Форма.ПериодОкончание);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовОтражениеДоходов

Процедура ОтражениеДоходаОбработкаВыбора(Форма, Элемент, ВыбранноеЗначение, СтандартнаяОбработка) Экспорт
	
	// Обработчик не должен вызываться из неподготовленных форм, поэтому вызовем исключение,
	// если вызывающая форма не соответствует требованиям.
	БанкИКассаФормыКлиентСервер.ПроверитьВозможностьОтраженияДоходов(Форма);
	
	УчетПСНКлиент.ОтражениеДоходаОбработкаВыбора(Форма, Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

Процедура ОтражениеДоходаПриИзменении(Форма, ИзменяемыйРеквизит, НовоеПредставление, ЗначениеПоУмолчанию = Неопределено) Экспорт
	
	// Обработчик не должен вызываться из неподготовленных форм, поэтому вызовем исключение,
	// если вызывающая форма не соответствует требованиям.
	БанкИКассаФормыКлиентСервер.ПроверитьВозможностьОтраженияДоходов(Форма);
	
	ВариантыОтраженияДоходов = БанкИКассаФормыКлиентСервер.ВариантыОтраженияДоходов(Форма);
	
	Если ЗначениеЗаполнено(НовоеПредставление) Тогда
		
		// Пользователь выбрал представление - обновим значение связанного реквизита.
		ИзменяемыйРеквизит = БанкИКассаФормыКлиентСервер.ВариантОтраженияДоходовЗначение(
			НовоеПредставление,
			ВариантыОтраженияДоходов);
		
	Иначе
		
		// Если новое представление пользователем не выбрано - заполним отражение дохода значением по умолчанию.
		ИзменяемыйРеквизит = ЗначениеПоУмолчанию;
		
		НовоеПредставление = БанкИКассаФормыКлиентСервер.ВариантОтраженияДоходовПредставление(
			ИзменяемыйРеквизит,
			ВариантыОтраженияДоходов);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ПолучитьВыпискуБанкаЗавершение(Результат, ДополнительныеПараметры) Экспорт
	
	Если Не (ЗначениеЗаполнено(Результат) И Результат.Успех = Истина) Тогда
		Возврат;
	КонецЕсли;
	
	Если Не (ЗначениеЗаполнено(Результат) И Результат.Успех = Истина) Тогда
		Возврат;
	КонецЕсли;
	
	Форма = ДополнительныеПараметры.Форма;
	
	Форма.ВыпискиБанка.Очистить();
	Если Результат.Выписки.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Форма.ВыпискиБанка.Очистить();
	Форма.ВыпискиБанка.ЗагрузитьЗначения(Результат.Выписки);
	АдресФайла = ЭлектронноеВзаимодействиеБПВызовСервера.ДанныеВыпискиБанкаВТекстовомФормате(Результат.Выписки);
	Форма.ПрочитатьФайлВыпискиНаКлиенте(Новый ОписаниеПередаваемогоФайла(, АдресФайла));
	
КонецПроцедуры

#КонецОбласти