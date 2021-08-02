#Область СлужебныйПрограммныйИнтерфейс

#Область ФормаБизнесПроцесса

#Область ОбработчикиСобытийФормы

Процедура ПриОткрытии(Форма, Отказ) Экспорт
	
	ОбновитьДоступностьКомандОстановки(Форма);
	
КонецПроцедуры

Процедура ОбработкаВыбора(Форма, ВыбранноеЗначение, ИсточникВыбора, КонтекстВыбора) Экспорт
	
	Если ВРег(ИсточникВыбора.ИмяФормы) = ВРег("ОбщаяФорма.ВыборРолиИсполнителя") Тогда
		
		Если КонтекстВыбора = "ИсполнительПриИзменении" Тогда
			
			Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
				Форма.Объект.Исполнитель = ВыбранноеЗначение.РольИсполнителя;
			КонецЕсли;
			
		ИначеЕсли КонтекстВыбора = "ПроверяющийПриИзменении" Тогда
			
			Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
				Форма.Объект.Проверяющий = ВыбранноеЗначение.РольИсполнителя;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаОповещения(Форма, ИмяСобытия, Параметр, Источник) Экспорт
	
	Если ИмяСобытия = "ИзмененаНастройкаОтложенногоСтарта" Тогда
		Форма.Отложен = (Параметр.Отложен И Параметр.Состояние = ПредопределенноеЗначение("Перечисление.СостоянияПроцессовДляЗапуска.ГотовКСтарту"));
		Форма.ДатаОтложенногоСтарта = Параметр.ДатаОтложенногоСтарта;
		БизнесПроцессыЗаявокСотрудниковКлиентСервер.УстановитьСвойстваЭлементовФормы(Форма);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПослеЗаписи(Форма, ПараметрыЗаписи) Экспорт
	Оповестить("Запись_Задание", ПараметрыЗаписи, Форма.Объект.Ссылка);
	Оповестить("Запись_ЗадачаИсполнителя", ПараметрыЗаписи, Неопределено);
	ОбновитьФорму(Форма);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

Процедура ПредметНажатие(Форма, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	ПоказатьЗначение(, Форма.Объект.Предмет);
	
КонецПроцедуры

Процедура ИнфоНадписьЗаголовокОбработкаНавигационнойСсылки(Форма, СтандартнаяОбработка) Экспорт
	СтандартнаяОбработка = Ложь;
	ОткрытьНастройкуОтложенногоСтарта(Форма);
КонецПроцедуры

Процедура ИсполнительНачалоВыбора(Форма, Элемент, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	БизнесПроцессыИЗадачиКлиент.ВыбратьИсполнителя(Элемент, Форма.Объект.Исполнитель);
	
КонецПроцедуры

Процедура ИсполнительПриИзменении(Форма, ОткрытаФормаВыбораИсполнителя, КонтекстВыбора, ИспользуетсяСОбъектамиАдресации) Экспорт
	
	Если ОткрытаФормаВыбораИсполнителя = Истина Тогда
		Возврат;
	КонецЕсли;
	
	ОсновнойОбъектАдресации = Неопределено;
	ДополнительныйОбъектАдресации = Неопределено;
	
	Если ТипЗнч(Форма.Объект.Исполнитель) = Тип("СправочникСсылка.РолиИсполнителей") И ЗначениеЗаполнено(Форма.Объект.Исполнитель) Тогда 
		
		Если ИспользуетсяСОбъектамиАдресации Тогда 
			
			КонтекстВыбора = "ИсполнительПриИзменении";
			
			ПараметрыФормы = Новый Структура;
			ПараметрыФормы.Вставить("РольИсполнителя", Форма.Объект.Исполнитель);
			ПараметрыФормы.Вставить("ОсновнойОбъектАдресации", ОсновнойОбъектАдресации);
			ПараметрыФормы.Вставить("ДополнительныйОбъектАдресации", ДополнительныйОбъектАдресации);
			
			ОткрытьФорму("ОбщаяФорма.ВыборРолиИсполнителя", ПараметрыФормы, Форма);
			
			Возврат;
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ИсполнительОбработкаВыбора(Форма, Элемент, ВыбранноеЗначение, СтандартнаяОбработка, ОткрытаФормаВыбораИсполнителя) Экспорт
	
	ОткрытаФормаВыбораИсполнителя = ТипЗнч(ВыбранноеЗначение) = Тип("Структура");
	Если ОткрытаФормаВыбораИсполнителя Тогда
		СтандартнаяОбработка = Ложь;
		Форма.Объект.Исполнитель = ВыбранноеЗначение.РольИсполнителя;
		Форма.Объект.ОсновнойОбъектАдресации = ВыбранноеЗначение.ОсновнойОбъектАдресации;
		Форма.Объект.ДополнительныйОбъектАдресации = ВыбранноеЗначение.ДополнительныйОбъектАдресации;
		Форма.Модифицированность = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ИсполнительАвтоПодбор(Текст, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если ЗначениеЗаполнено(Текст) Тогда 
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = БизнесПроцессыИЗадачиВызовСервера.СформироватьДанныеВыбораИсполнителя(Текст);
	КонецЕсли;
	
КонецПроцедуры

Процедура ИсполнительОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, СтандартнаяОбработка) Экспорт
	
	Если ЗначениеЗаполнено(Текст) Тогда 
		СтандартнаяОбработка = Ложь;
		ДанныеВыбора = БизнесПроцессыИЗадачиВызовСервера.СформироватьДанныеВыбораИсполнителя(Текст);
	КонецЕсли;
	
КонецПроцедуры

Процедура СрокИсполненияПриИзменении(Форма, Элемент) Экспорт
	Если Форма.Объект.СрокИсполнения = НачалоДня(Форма.Объект.СрокИсполнения) Тогда
		Форма.Объект.СрокИсполнения = КонецДня(Форма.Объект.СрокИсполнения);
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

Процедура ЗаписатьИЗакрыть(Форма) Экспорт
	
	ОчиститьСообщения();
	Если Не Форма.ПроверитьЗаполнение() Тогда
		Возврат;	
	КонецЕсли;
	
	Форма.Записать();
	Форма.Закрыть();
	
КонецПроцедуры

Процедура Остановить(Форма) Экспорт
	
	БизнесПроцессыИЗадачиКлиент.ОстановитьБизнесПроцессИзФормыОбъекта(ЭтотОбъект);
	ОбновитьДоступностьКомандОстановки(Форма);
	
КонецПроцедуры

Процедура ПродолжитьБизнесПроцесс(Форма) Экспорт
	
	БизнесПроцессыИЗадачиКлиент.ПродолжитьБизнесПроцессИзФормыОбъекта(ЭтотОбъект);
	ОбновитьДоступностьКомандОстановки(Форма);
	
КонецПроцедуры

Процедура НастроитьОтложенныйСтарт(Форма) Экспорт
	ОткрытьНастройкуОтложенногоСтарта(Форма);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ФормаЗадачиБизнесПроцесса

#Область ОбработчикиКомандФормы

Процедура ПринятьЗадачуКИсполнению(Форма, ТекущийПользователь) Экспорт
	БизнесПроцессыИЗадачиКлиент.ПринятьЗадачуКИсполнению(Форма, ТекущийПользователь);
	Форма.Прочитать();
КонецПроцедуры

#КонецОбласти

#Область  СлужебныеПроцедурыИФункции

Процедура ОткрытьПрисоединенныйФайл(ПрисоединенныйФайл) Экспорт
	ДанныеФайла = РаботаСФайламиКлиент.ДанныеФайла(ПрисоединенныйФайл);
	РаботаСФайламиКлиент.ОткрытьФайл(ДанныеФайла, Ложь);
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбновитьФорму(Форма)
	БизнесПроцессыЗаявокСотрудниковКлиентСервер.УстановитьСвойстваЭлементовФормы(Форма);
	ОбновитьДоступностьКомандОстановки(Форма);
КонецПроцедуры

Процедура ОбновитьДоступностьКомандОстановки(Форма)
	
	Если Форма.Объект.Завершен Тогда
		
		Форма.Элементы.ФормаОстановить.Видимость = Ложь;
		Форма.Элементы.ФормаПродолжить.Видимость = Ложь;
		Возврат;
		
	КонецЕсли;
	
	Если Форма.Объект.Состояние = ПредопределенноеЗначение("Перечисление.СостоянияБизнесПроцессов.Остановлен") Тогда
		Форма.Элементы.ФормаОстановить.Видимость = Ложь;
		Форма.Элементы.ФормаПродолжить.Видимость = Истина;
	Иначе
		Форма.Элементы.ФормаОстановить.Видимость = Форма.Объект.Стартован;
		Форма.Элементы.ФормаПродолжить.Видимость = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОткрытьНастройкуОтложенногоСтарта(Форма)

	Если КлючевыеРеквизитыФормыЗаполнены(Форма) Тогда
		БизнесПроцессыИЗадачиКлиент.НастроитьОтложенныйСтарт(Форма.Объект.Ссылка, Форма.Объект.СрокИсполнения);
	КонецЕсли;

КонецПроцедуры

Функция КлючевыеРеквизитыФормыЗаполнены(Форма)

	Если Форма.Объект.Стартован Тогда
		Возврат Истина;
	КонецЕсли;
	
	ОчиститьСообщения();
	
	РеквизитыФормыЗаполнены = Истина;
	Если НЕ ЗначениеЗаполнено(Форма.Объект.Исполнитель) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Поле ""Исполнитель"" не заполнено.'"),,
			"Исполнитель", "Объект.Исполнитель");
		РеквизитыФормыЗаполнены = Ложь;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(Форма.Объект.Наименование) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Поле ""Задание"" не заполнено.'"),,
			"Исполнитель", "Объект.Наименование");
		РеквизитыФормыЗаполнены = Ложь;
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(Форма.Объект.СрокИсполнения) Тогда
		ОбщегоНазначенияКлиент.СообщитьПользователю(НСтр("ru = 'Поле ""Срок"" исполнения не заполнено.'"),,
			"СрокИсполнения", "Объект.СрокИсполнения");
		РеквизитыФормыЗаполнены = Ложь;
	КонецЕсли;
	
	Возврат РеквизитыФормыЗаполнены;
	
КонецФункции

#КонецОбласти
