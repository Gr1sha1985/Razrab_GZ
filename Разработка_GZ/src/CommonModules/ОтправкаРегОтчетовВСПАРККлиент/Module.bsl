#Область ПрограммныйИнтерфейс

Процедура ПодключитьОбработчикСПАРК(Отправить = Истина, Предупредить = Истина, Интервал = Неопределено) Экспорт
	
	Если Отправить Тогда
		
		Если Интервал = Неопределено Тогда
			Если ДокументооборотСКОВызовСервера.ИспользуетсяРежимТестирования() Тогда
				Интервал = 10;
			Иначе
				Интервал = 2 * 60 * 60; // раз в 2 часа
			КонецЕсли;
		КонецЕсли;
		
		ОтключитьОбработчик("ОтправкаБухОтчетовВСПАРК");
		// Подключаем однократно.
		// Внутри процедуры по результату проверки будет принято решение, включить ли его еще раз или нет.
		
		ПодключитьОбработчикОжидания("ОтправкаБухОтчетовВСПАРК", Интервал, Истина);
		
	КонецЕсли;
	
	// Предупреждение показывается один раз при входе 
	Если Предупредить Тогда
		
		Если Интервал = Неопределено Тогда
			Если ДокументооборотСКОВызовСервера.ИспользуетсяРежимТестирования() Тогда
				Интервал = 10;
			Иначе
				Интервал = 6 * 60; // через 6 мин
			КонецЕсли;
		КонецЕсли;
		
		ОтключитьОбработчик("ПоказатьПредупреждениеСПАРК");
		ПодключитьОбработчикОжидания("ПоказатьПредупреждениеСПАРК", Интервал + 2, Истина);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОтключитьОбработчик(Имя) Экспорт
	
	ОтключитьОбработчикОжидания(Имя);
	
КонецПроцедуры

Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	Если ИмяСобытия = "ОбновитьРезультатОтправкиСПАРК" ИЛИ ИмяСобытия = "СПАРК_БольшеНеНапоминать" Тогда
		Форма.ИзменитьОформлениеЭлементовСПАРКВОтчете();
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаНавигационнойСсылкиВОтчете(Форма, Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	ПоказатьРезультатОтправкиОтчетаВСПАРКИзФормыОтчета(Форма);
	
КонецПроцедуры

Процедура ПовторитьОтправкуВСПАРКИзОтчета(Форма) Экспорт
	
	ПоказатьРезультатОтправкиОтчетаВСПАРКИзФормыОтчета(Форма, Истина);
	
КонецПроцедуры

Процедура ПоказатьРезультатОтправкиОтчетаВСПАРКИзФормыОтчета(Форма, СразуПререотправить = Ложь, ОткрытьПредложение = Ложь) Экспорт
	
	Отчет  = ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСервер.СсылкаНаОтчетПоФорме(Форма);
	ВсеОтчеты = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Отчет);
	
	ПоказатьРезультатОтправкиОтчетаВСПАРК(ВсеОтчеты, 0, СразуПререотправить, ОткрытьПредложение);
	
КонецПроцедуры

Процедура ОтправитьВСПАРКИзОтчета(Форма) Экспорт
	
	Отчет = ЭлектронныйДокументооборотСКонтролирующимиОрганамиКлиентСервер.СсылкаНаОтчетПоФорме(Форма);
	
	ОтправкаРегОтчетовВСПАРКВызовСервера.ЗаписатьОтчетСПАРКВРегистр(
		Отчет, 
		ПредопределенноеЗначение("Перечисление.СтатусыОтправкиВСПАРК.ОтправкаРазрешена"));
	
	ПоказатьРезультатОтправкиОтчетаВСПАРКИзФормыОтчета(Форма, , Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОткрытьРегистрСПАРК(Организация,  Ссылка) Экспорт
	
	Отбор = Новый Структура; 
	Отбор.Вставить("Организация", Организация);
	Отбор.Вставить("Отчет", Ссылка);
	
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("Отбор", Отбор);
	
	ФормаПодбора = ОткрытьФорму("РегистрСведений.ОтчетыПереданныеВСПАРК.ФормаСписка", ДопПараметры);
	
КонецПроцедуры

Процедура ОткрытьФормуПодтверждениеОтправкиОтчетаСПАРК(Отчет, ОповещениеОЗавершении) Экспорт
	
	// запрашиваем подтверждение
	ПараметрыФормы = Новый Структура("СсылкаНаОтчет", Отчет);
	
	ОткрытьФорму("ОбщаяФорма.ПодтверждениеОтправкиОтчетаСПАРК",
		ПараметрыФормы,
		,
		,
		,
		,
		ОповещениеОЗавершении,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

Процедура ОтправитьОтчетВСПАРКПриНеобходимостиПоТранспортномуСообщению(ТранспортноеСообщение) Экспорт
	
	ОтправкаРегОтчетовВСПАРКВызовСервера.ОтправитьОтчетВСПАРКПриНеобходимостиПоТранспортномуСообщениюСервер(ТранспортноеСообщение);
	ПодключитьОбработчикСПАРКПриНеобходимости();
	
КонецПроцедуры

Процедура ОтправитьНеотправленныеВСПАРК(Отчет = Неопределено) Экспорт
	
	Если ЗначениеЗаполнено(Отчет) Тогда
		ВсеОтчеты = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Отчет);
	Иначе
		ВсеОтчеты = ОтправкаРегОтчетовВСПАРКВызовСервера.ОтчетКОтправкеВСПАРК();
	КонецЕсли;
	
	Если ВсеОтчеты.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ОповещениеОЗавершении = Новый ОписаниеОповещения(
		"ОтправитьНеотправленныеВСПАРК_ПроверитьСостояние", 
		ЭтотОбъект);
		
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Неопределено);
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.Интервал = 1;
	
	ДополнительныеПараметры = Новый Структура();
	ДополнительныеПараметры.Вставить("Отчеты", ВсеОтчеты);
	
	ДлительнаяОперация = ОтправкаРегОтчетовВСПАРКВызовСервера.НачатьОтправкуОтчетовВСПАРКВФоне(ДополнительныеПараметры);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, ОповещениеОЗавершении, ПараметрыОжидания);
	
КонецПроцедуры

Процедура ОтправитьНеотправленныеВСПАРК_ПроверитьСостояние(ДлительнаяОперация, ВходящийКонтекст) Экспорт
	
	Если ДлительнаяОперация = Неопределено Тогда
		
		ПодключитьОбработчикСПАРКПриНеобходимости();
		
	Иначе
		
		Если ДлительнаяОперация.Статус = "Выполнено" ИЛИ ДлительнаяОперация.Статус = "Ошибка" Тогда
		
			ОповеститьОРезультатеОтправкиОтчетовВСПАРК();
			ПодключитьОбработчикСПАРКПриНеобходимости();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПодключитьОбработчикСПАРКПриНеобходимости()
	
	НеотправленныеОтчеты = ОтправкаРегОтчетовВСПАРКВызовСервера.ОтчетКОтправкеВСПАРК();
	Если НеотправленныеОтчеты.Количество() > 0 Тогда
		ПодключитьОбработчикСПАРК(Истина, Ложь);
	Иначе
		ОтключитьОбработчик("ОтправкаБухОтчетовВСПАРК");
	КонецЕсли;
	
КонецПроцедуры

Процедура ОповеститьОРезультатеОтправкиОтчетовВСПАРК()
	
	Если ДлительнаяОтправкаКлиент.ФормаЕстьСредиОткрытых("ОтправкаОтчетаВСПАРК") Тогда
		
		Оповестить("ОбновитьРезультатОтправкиСПАРК");
		
	КонецЕсли;
		
КонецПроцедуры

Процедура ПоказатьРезультатОтправкиОтчетовВСПАРК(Результат = Неопределено, ВходящийКонтекст = Неопределено) Экспорт
	
	Если ВходящийКонтекст = Неопределено Тогда
		ВсеОтчеты = ОтправкаРегОтчетовВСПАРКВызовСервера.ОтчетыКоторыеНеУдаетсяОтправитьВСПАРК();
		Номер     = 0;
	Иначе
		ВсеОтчеты = ВходящийКонтекст.Отчеты;
		Номер     = ВходящийКонтекст.Номер + 1;
	КонецЕсли;
	
	Если ВсеОтчеты.Количество() > 0 И Номер < ВсеОтчеты.Количество() Тогда
		
		ПоказатьРезультатОтправкиОтчетаВСПАРК(ВсеОтчеты, Номер);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПоказатьРезультатОтправкиОтчетаВСПАРК(ВсеОтчеты, Номер, СразуПререотправить = Ложь, ОткрытьПредложение = Ложь) Экспорт
	
	Ссылка = ВсеОтчеты[Номер];
	
	ДопПараметры = Новый Структура();
	ДопПараметры.Вставить("Ссылка", Ссылка);
	ДопПараметры.Вставить("Отчеты", ВсеОтчеты);
	ДопПараметры.Вставить("Номер",  Номер);
	ДопПараметры.Вставить("СразуПререотправить", СразуПререотправить);
	ДопПараметры.Вставить("ОткрытьПредложение",  ОткрытьПредложение);
	
	ОписаниеОповещения = Новый ОписаниеОповещения(
		"ПоказатьРезультатОтправкиОтчетовВСПАРК", 
		ЭтотОбъект, 
		ДопПараметры);

	ОткрытьФорму("ОбщаяФорма.ОтправкаОтчетаВСПАРК", 
		ДопПараметры,
		,
		Новый УникальныйИдентификатор,
		,
		,
		ОписаниеОповещения,
		РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	
КонецПроцедуры

#КонецОбласти

