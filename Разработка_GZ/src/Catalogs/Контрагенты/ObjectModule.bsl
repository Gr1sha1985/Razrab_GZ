#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	Если ТипЗнч(ДанныеЗаполнения) = Тип("СправочникСсылка.Организации") Тогда
		
		ОбработкаЗаполненияПоОрганизации(ДанныеЗаполнения);
		
	ИначеЕсли ТипЗнч(ДанныеЗаполнения) = Тип("Структура") Тогда
		
		Если ДанныеЗаполнения.Свойство("ЮридическоеФизическоеЛицо") Тогда
			Если ТипЗнч(ДанныеЗаполнения.ЮридическоеФизическоеЛицо) = Тип("ФиксированныйМассив")
				И ДанныеЗаполнения.ЮридическоеФизическоеЛицо.Количество() = 1 Тогда
				// Это ограничение вида
				ДанныеЗаполнения.Вставить("ЮридическоеФизическоеЛицо", ДанныеЗаполнения.ЮридическоеФизическоеЛицо[0]);
			КонецЕсли;
		КонецЕсли;
		
		Если ДанныеЗаполнения.Свойство("ЭтоЭлектронныйДокумент") Тогда
			ОбработкаЗаполненияПоЭлектронномуДокументу(ДанныеЗаполнения);
		КонецЕсли;
		
		ОбработкаЗаполненияПоСтруктуре(ДанныеЗаполнения);
		
	КонецЕсли;

КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)

	МассивНепроверяемыхРеквизитов	= Новый Массив;
	
	Если НЕ ЭтоГруппа Тогда
		
		Если НЕ ОбособленноеПодразделение Тогда
			МассивНепроверяемыхРеквизитов.Добавить("ГоловнойКонтрагент");
		КонецЕсли;
		
		Если НЕ ГосударственныйОрган Тогда
			МассивНепроверяемыхРеквизитов.Добавить("ВидГосударственногоОргана");
			МассивНепроверяемыхРеквизитов.Добавить("КодГосударственногоОргана");
		ИначеЕсли ВидГосударственногоОргана = Перечисления.ВидыГосударственныхОрганов.Прочий Тогда
			МассивНепроверяемыхРеквизитов.Добавить("КодГосударственногоОргана");
		КонецЕсли;
		
		ЭтоЮрЛицо = (ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо);
		
		Если ЗначениеЗаполнено(ИНН) И НЕ ИННВведенКорректно Тогда
			СтруктураРезультатаПроверкиКорректностиИНН = ИдентификационныеНомераНалогоплательщиков.ПроверитьСоответствиеТребованиямИНН(ИНН, ЭтоЮрЛицо);
			
			Если НЕ ПустаяСтрока(СтруктураРезультатаПроверкиКорректностиИНН.ОписаниеОшибки) Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					СтруктураРезультатаПроверкиКорректностиИНН.ОписаниеОшибки,
					ЭтотОбъект,
					"ИНН",
					,
					Отказ);
				// Запишем информацию о проблеме с ИНН в журнал регистрации.
				ЗаписьЖурналаРегистрации(
					НСтр("ru='Не удалось записать контрагента. Неправильный ИНН.'"), 
					УровеньЖурналаРегистрации.Информация, 
					Метаданные.Справочники.Контрагенты,
					,
					СтруктураРезультатаПроверкиКорректностиИНН.ОписаниеОшибки);
			КонецЕсли;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(КПП) И НЕ КППВведенКорректно Тогда
			СтруктураРезультатаПроверкиКорректностиКПП = ИдентификационныеНомераНалогоплательщиков.ПроверитьСоответствиеТребованиямКПП(КПП, ЭтоЮрЛицо, ОбособленноеПодразделение);
			
			Если НЕ СтруктураРезультатаПроверкиКорректностиКПП.СоответствуетТребованиям И НЕ ПустаяСтрока(СтруктураРезультатаПроверкиКорректностиКПП.ОписаниеОшибки) Тогда
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
					СтруктураРезультатаПроверкиКорректностиКПП.ОписаниеОшибки,
					ЭтотОбъект,
					"КПП",
					,
					Отказ);
				// Запишем информацию о проблеме с КПП в журнал регистрации.
				ЗаписьЖурналаРегистрации(
					НСтр("ru='Не удалось записать контрагента. Неправильный КПП.'"), 
					УровеньЖурналаРегистрации.Информация, 
					Метаданные.Справочники.Контрагенты,
					,
					СтруктураРезультатаПроверкиКорректностиКПП.ОписаниеОшибки);
			КонецЕсли;
		КонецЕсли;
		
		// Проверяем заполнение КПП только для российских организаций
		Если ЗначениеЗаполнено(ИНН) И ЭтоЮрЛицо 
			И СтранаРегистрации = ПредопределенноеЗначение("Справочник.СтраныМира.Россия") Тогда
			ПроверяемыеРеквизиты.Добавить("КПП");
		КонецЕсли;
		
		Если ЗначениеЗаполнено(КПП) И ЭтоЮрЛицо 
			И СтранаРегистрации = ПредопределенноеЗначение("Справочник.СтраныМира.Россия") Тогда
			ПроверяемыеРеквизиты.Добавить("ИНН");
		КонецЕсли;
		
		Если ОбособленноеПодразделение И ЗначениеЗаполнено(ГоловнойКонтрагент) И ГоловнойКонтрагент = Ссылка Тогда
			
			ТекстОшибки	= НСтр("ru = 'Контрагент не может являться своим обособленным подразделением'");
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, ЭтотОбъект, "ГоловнойКонтрагент", , Отказ);
			
		КонецЕсли;

		
		Если ЗначениеЗаполнено(ГоловнойКонтрагент) И ГоловнойКонтрагент <> Ссылка Тогда
			
			МассивПодчиненныхКонтрагентов	= Справочники.Контрагенты.ПолучитьМассивПодчиненныхКонтрагентов(Ссылка);
			Если МассивПодчиненныхКонтрагентов.Количество() > 0 Тогда
				
				ТекстОшибки	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Контрагент %1 не может иметь головного контрагента, т.к. сам является головным для других контрагентов'"),
					Наименование);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, ЭтотОбъект, "ГоловнойКонтрагент", , Отказ);
				
			Иначе
				
				СвойстваГоловногоКонтрагента	= ОбщегоНазначения.ЗначенияРеквизитовОбъекта(
					ГоловнойКонтрагент, "Наименование, ГоловнойКонтрагент, СтранаРегистрации");
					
				Если ЗначениеЗаполнено(СвойстваГоловногоКонтрагента.ГоловнойКонтрагент)
					И СвойстваГоловногоКонтрагента.ГоловнойКонтрагент <> ГоловнойКонтрагент Тогда
					
					ТекстОшибки	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						НСтр("ru = 'Контрагент %1 не может быть выбран головным, т.к. для него самого назначен головной контрагент'"),
						СвойстваГоловногоКонтрагента.Наименование);
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, ЭтотОбъект, "ГоловнойКонтрагент", , Отказ);
					
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
		Если НЕ ЭтоЮрЛицо Тогда
			
			МассивОбособленныхПодразделений	= Справочники.Контрагенты.ПолучитьМассивОбособленныхПодразделений(Ссылка);
			Если МассивОбособленныхПодразделений.Количество() > 0 Тогда
				
				ТекстОшибки	= СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
					НСтр("ru = 'Контрагент %1 не может быть физическим лицом, т.к. является головным подразделением для других контрагентов'"),
					Наименование);
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, ЭтотОбъект, , , Отказ);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЕсли;
	
	ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);

КонецПроцедуры

Процедура ПередЗаписью(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ЭтоГруппа Тогда
		Возврат;
	КонецЕсли;
	
	//ДополнительныеСвойства.Вставить("НужноЗаписыватьВРегистрПриЗаписи", Ложь);
	//ЗарегистрироватьДублиКонтрагентов();
	//	
	//Если НЕ ЗначениеЗаполнено(ГоловнойКонтрагент) И НЕ ОбособленноеПодразделение Тогда
	//	
	//	ГоловнойКонтрагент = СсылкаКонтрагента();
	//	
	//КонецЕсли;
	//
	//Если НЕ ЗначениеЗаполнено(СтранаРегистрации) Тогда
	//	СтранаРегистрации = Справочники.СтраныМира.Россия;
	//КонецЕсли;
	//
	//ИНН = СокрП(ИНН);
	//
	//ОбработатьИсториюРеквизитовПередЗаписью();
	//
	//Если НЕ ЭтоНовый()
	//	И НЕ ОбособленноеПодразделение
	//	И ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо Тогда
	//	
	//	Запрос = Новый Запрос;
	//	Запрос.УстановитьПараметр("ГоловнойКонтрагент", Ссылка);
	//	Запрос.УстановитьПараметр("ИНН", ИНН);
	//	
	//	Запрос.Текст = 
	//	"ВЫБРАТЬ
	//	|	Контрагенты.Ссылка КАК Ссылка
	//	|ИЗ
	//	|	Справочник.Контрагенты КАК Контрагенты
	//	|ГДЕ
	//	|	Контрагенты.ОбособленноеПодразделение
	//	|	И Контрагенты.ГоловнойКонтрагент = &ГоловнойКонтрагент
	//	|	И Контрагенты.ИНН <> &ИНН
	//	|	И НЕ Контрагенты.ПометкаУдаления
	//	|	И НЕ Контрагенты.ЭтоГруппа";
	//	
	//	Выборка = Запрос.Выполнить().Выбрать();
	//	Пока Выборка.Следующий() Цикл
	//		ОбособленноеПодразделениеОбъект	= Выборка.Ссылка.ПолучитьОбъект();
	//		ОбособленноеПодразделениеОбъект.ИНН	= ИНН;
	//		ОбособленноеПодразделениеОбъект.Записать();
	//	КонецЦикла;
	//	
	//КонецЕсли;
	//
	//Если ДополнительныеСвойства.Свойство("ДанныеКонтактногоЛица")
	//	И ТипЗнч(ДополнительныеСвойства.ДанныеКонтактногоЛица) = Тип("Структура") Тогда
	//	
	//	КонтактноеЛицо = Справочники.КонтактныеЛица.СоздатьЭлемент();
	//	
	//	КонтактноеЛицо.ОбъектВладелец = СсылкаКонтрагента();
	//	КонтактноеЛицо.Заполнить(ДополнительныеСвойства.ДанныеКонтактногоЛица);
	//	
	//	КонтактноеЛицо.Наименование = КонтактноеЛицо.Фамилия 
	//		+ ?(ЗначениеЗаполнено(КонтактноеЛицо.Имя), " " + КонтактноеЛицо.Имя, "")
	//		+ ?(ЗначениеЗаполнено(КонтактноеЛицо.Отчество), " " + КонтактноеЛицо.Отчество, "")
	//		+ ?(ЗначениеЗаполнено(КонтактноеЛицо.Должность), ", " + КонтактноеЛицо.Должность, "");
	//	
	//	КонтактноеЛицо.Записать();
	//	
	//	ОсновноеКонтактноеЛицо = КонтактноеЛицо.Ссылка;
	//	
	//КонецЕсли;
	//
	//Если НЕ ЭтоНовый() Тогда
	//	
	//	// Изменяем пометку удаления у контактных лиц, в случае если изменилась пометка у справочника "Контрагенты"
	//	ПредыдущаяПометкаНаУдаление = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ПометкаУдаления");
	//	Если ПредыдущаяПометкаНаУдаление <> ПометкаУдаления Тогда
	//		
	//		Запрос = Новый Запрос();
	//		Запрос.УстановитьПараметр("Ссылка", Ссылка);
	//		Запрос.УстановитьПараметр("ПометкаУдаления", ПометкаУдаления);
	//		Запрос.Текст = "ВЫБРАТЬ
	//		|	КонтактныеЛица.Ссылка КАК КонтЛицо
	//		|ИЗ
	//		|	Справочник.КонтактныеЛица КАК КонтактныеЛица
	//		|
	//		|ГДЕ
	//		|	КонтактныеЛица.ОбъектВладелец = &Ссылка
	//		|		И КонтактныеЛица.ПометкаУдаления <> &ПометкаУдаления";
	//		ВыборкаКонтЛиц = Запрос.Выполнить().Выбрать();
	//		
	//		Пока ВыборкаКонтЛиц.Следующий() Цикл
	//			
	//			КонтЛицо = ВыборкаКонтЛиц.КонтЛицо.ПолучитьОбъект();
	//			КонтЛицо.УстановитьПометкуУдаления(ПометкаУдаления);
	//			
	//		КонецЦикла;
	//	КонецЕсли;
	//КонецЕсли;
	
	Если ЭтоНовый() Тогда
		// Храним дату создания контрагента.
		ДатаСоздания = ТекущаяДатаСеанса();
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередУдалением(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	УдалитьРегистрациюДублейПередУдалением();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
	//Если ДополнительныеСвойства.Свойство("НужноЗаписыватьВРегистрПриЗаписи")
	//	И ДополнительныеСвойства.НужноЗаписыватьВРегистрПриЗаписи = Истина Тогда
	//	Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(Ссылка, ИНН, КПП, Ложь);
	//КонецЕсли;	

КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	Если НЕ ЭтоГруппа Тогда
		ОсновнойБанковскийСчет = Неопределено;
		ОсновноеКонтактноеЛицо = Неопределено;
		Если ОбъектКопирования.ГоловнойКонтрагент = ОбъектКопирования.Ссылка Тогда
			ГоловнойКонтрагент = Справочники.Контрагенты.ПустаяСсылка();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ОбработкаЗаполненияПоОрганизации(Организация)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, Организация,
		"Наименование, ЮридическоеФизическоеЛицо, ОбособленноеПодразделение, ИНН, КПП, КодПоОКПО");
	
	Если Организация.ВариантНаименованияДляПечатныхФорм = Перечисления.ВариантыНаименованияДляПечатныхФорм.ПолноеНаименование Тогда
		НаименованиеПолное = Организация.НаименованиеПолное;
	Иначе
		НаименованиеПолное = Организация.НаименованиеСокращенное;
	КонецЕсли;
	
	Для каждого ЭлементКонтактнойИнформации Из Организация.КонтактнаяИнформация Цикл
		
		Если ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФактАдресОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФаксОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.EmailОрганизации
			ИЛИ ЭлементКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияОрганизации Тогда
		
			НоваяСтрокаКонтактнойИнформации = ЭтотОбъект.КонтактнаяИнформация.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрокаКонтактнойИнформации, ЭлементКонтактнойИнформации);
			
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФактАдресОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФаксОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ФаксКонтрагенты;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.EmailОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты;
			КонецЕсли;
			Если НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияОрганизации Тогда
				НоваяСтрокаКонтактнойИнформации.Вид = Справочники.ВидыКонтактнойИнформации.ДругаяИнформацияКонтрагенты;
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполненияПоЭлектронномуДокументу(ДанныеЗаполнения)
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеЗаполнения);
	
	ЭтоЮрЛицо         = СтрДлина(ДанныеЗаполнения.ИНН) = 10;
	СтранаРегистрации = Справочники.СтраныМира.Россия;
	
	Если ЭтоЮрЛицо Тогда
		ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
	Иначе
		ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ФизическоеЛицо;
	КонецЕсли;
	
	ДанныеЗаполненияКИ = Новый ТаблицаЗначений;
	ДанныеЗаполненияКИ.Колонки.Добавить("ВидКИ");
	ДанныеЗаполненияКИ.Колонки.Добавить("СтруктураКИ");
	
	Если ДанныеЗаполнения.Свойство("ФактическийАдрес") Тогда
		СтрокаЗаполненияКИ             = ДанныеЗаполненияКИ.Добавить();
		СтрокаЗаполненияКИ.ВидКИ       = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента;
		СтрокаЗаполненияКИ.СтруктураКИ = ДанныеЗаполнения.ФактическийАдрес;
		
		СтрокаЗаполненияКИ             = ДанныеЗаполненияКИ.Добавить();
		СтрокаЗаполненияКИ.ВидКИ       = Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента;
		СтрокаЗаполненияКИ.СтруктураКИ = ДанныеЗаполнения.ФактическийАдрес;
		
		СтрокаЗаполненияКИ             = ДанныеЗаполненияКИ.Добавить();
		СтрокаЗаполненияКИ.ВидКИ       = Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента;
		СтрокаЗаполненияКИ.СтруктураКИ = ДанныеЗаполнения.ФактическийАдрес;
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("Телефон") Тогда
		СтрокаЗаполненияКИ             = ДанныеЗаполненияКИ.Добавить();
		СтрокаЗаполненияКИ.ВидКИ       = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента;
		СтрокаЗаполненияКИ.СтруктураКИ = ДанныеЗаполнения.Телефон;
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("АдресЭлектроннойПочты") Тогда
		СтрокаЗаполненияКИ             = ДанныеЗаполненияКИ.Добавить();
		СтрокаЗаполненияКИ.ВидКИ       = Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты;
		СтрокаЗаполненияКИ.СтруктураКИ = ДанныеЗаполнения.АдресЭлектроннойПочты;
	КонецЕсли;
	
	Для Каждого СтрокаЗаполненияКИ Из ДанныеЗаполненияКИ Цикл
		Если НЕ ЗначениеЗаполнено(СтрокаЗаполненияКИ.СтруктураКИ) Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаКИ               = КонтактнаяИнформация.Добавить();
		СтрокаКИ.Тип           = СтрокаЗаполненияКИ.ВидКИ.Тип;
		СтрокаКИ.Вид           = СтрокаЗаполненияКИ.ВидКИ;
		СтрокаКИ.Представление = СтрокаЗаполненияКИ.СтруктураКИ.Представление;
		СтрокаКИ.ЗначенияПолей = СтрокаЗаполненияКИ.СтруктураКИ.КонтактнаяИнформация;
	КонецЦикла;
	
КонецПроцедуры

Процедура ОбработкаЗаполненияПоСтруктуре(ДанныеЗаполнения)
	
	Если Не ДанныеЗаполнения.Свойство("Наименование") 
		И ДанныеЗаполнения.Свойство("НаименованиеПолное") 
		И Не ПустаяСтрока(ДанныеЗаполнения.НаименованиеПолное) Тогда
		ДанныеЗаполнения.Вставить("Наименование", ДанныеЗаполнения.НаименованиеПолное);
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("ГосударственныйОрган") 
		И ДанныеЗаполнения.ГосударственныйОрган
		И Не ДанныеЗаполнения.Свойство("ВидГосударственногоОргана") Тогда
		ДанныеЗаполнения.Вставить("ВидГосударственногоОргана", Перечисления.ВидыГосударственныхОрганов.НалоговыйОрган);
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("СтранаРегистрации") И ТипЗнч(ДанныеЗаполнения.СтранаРегистрации) = Тип("Строка") Тогда
		ДанныеЗаполнения.Вставить("СтранаРегистрации",
			Справочники.Контрагенты.СтранаРегистрацииПоКоду(ДанныеЗаполнения.СтранаРегистрации));
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("ЮридическийАдресЗначениеJSON")
		И ЗначениеЗаполнено(ДанныеЗаполнения.ЮридическийАдресЗначениеJSON) Тогда
		
		УправлениеКонтактнойИнформацией.ДобавитьКонтактнуюИнформацию(
			ЭтотОбъект, ДанныеЗаполнения.ЮридическийАдресЗначениеJSON, Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента);
		
		ФактическийАдресЗначениеJSON = ?(ДанныеЗаполнения.Свойство("ФактическийАдресЗначениеJSON"),
			ДанныеЗаполнения.ФактическийАдресЗначениеJSON,
			ДанныеЗаполнения.ЮридическийАдресЗначениеJSON);
		
		УправлениеКонтактнойИнформацией.ДобавитьКонтактнуюИнформацию(
			ЭтотОбъект, ФактическийАдресЗначениеJSON, Справочники.ВидыКонтактнойИнформации.ФактАдресКонтрагента);
		
		ПочтовыйАдресЗначениеJSON = ?(ДанныеЗаполнения.Свойство("ПочтовыйАдресЗначениеJSON"),
			ДанныеЗаполнения.ПочтовыйАдресЗначениеJSON,
			ДанныеЗаполнения.ЮридическийАдресЗначениеJSON);
		
		УправлениеКонтактнойИнформацией.ДобавитьКонтактнуюИнформацию(
			ЭтотОбъект, ПочтовыйАдресЗначениеJSON, Справочники.ВидыКонтактнойИнформации.ПочтовыйАдресКонтрагента);
		
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("ТелефонЗначениеJSON")
		И ЗначениеЗаполнено(ДанныеЗаполнения.ТелефонЗначениеJSON) Тогда
		УправлениеКонтактнойИнформацией.ДобавитьКонтактнуюИнформацию(
			ЭтотОбъект, ДанныеЗаполнения.ТелефонЗначениеJSON, Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента);
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("АдресЭлектроннойПочтыЗначениеJSON")
		И ЗначениеЗаполнено(ДанныеЗаполнения.АдресЭлектроннойПочтыЗначениеJSON) Тогда
		УправлениеКонтактнойИнформацией.ДобавитьКонтактнуюИнформацию(
			ЭтотОбъект, ДанныеЗаполнения.АдресЭлектроннойПочтыЗначениеJSON, Справочники.ВидыКонтактнойИнформации.EmailКонтрагенты);
	КонецЕсли;
	
	//Если ДанныеЗаполнения.Свойство("КПП") Тогда
	//	Если Не ДанныеЗаполнения.Свойство("СтранаРегистрации")
	//		Или ДанныеЗаполнения.СтранаРегистрации = ПредопределенноеЗначение("Справочник.СтраныМира.Россия") Тогда
	//		Справочники.Контрагенты.УстановитьАктуальноеЗначениеИсторииКПП(ДанныеЗаполнения.КПП, ЭтотОбъект.ИсторияКПП);
	//	КонецЕсли;
	//КонецЕсли;
	
	//Если ДанныеЗаполнения.Свойство("НаименованиеПолное") Тогда
	//	Справочники.Контрагенты.УстановитьАктуальноеЗначениеИсторииНаименований(
	//		ДанныеЗаполнения.НаименованиеПолное, ЭтотОбъект.ИсторияНаименований);
	//КонецЕсли;
	
КонецПроцедуры

Функция СсылкаКонтрагента()
	
	Если ЭтоНовый() Тогда
		СсылкаКонтрагента = ПолучитьСсылкуНового();
		Если НЕ ЗначениеЗаполнено(СсылкаКонтрагента) Тогда
			СсылкаКонтрагента = Справочники.Контрагенты.ПолучитьСсылку();
		КонецЕсли;
		УстановитьСсылкуНового(СсылкаКонтрагента);
	Иначе
		СсылкаКонтрагента = Ссылка;
	КонецЕсли;
	
	Возврат СсылкаКонтрагента;
	
КонецФункции 

Процедура ЗаблокироватьРегистрДублиКонтрагентов(ПараметрыБлокировки)
	//Блокировка = Новый БлокировкаДанных;
	//
	//Для каждого Параметр Из ПараметрыБлокировки Цикл
	//	ЭлементБлокировки = Блокировка.Добавить("РегистрСведений.НаличиеДублейУКонтрагентов");
	//	ЭлементБлокировки.УстановитьЗначение(Параметр.Ключ, Параметр.Значение);
	//	ЭлементБлокировки.Режим = РежимБлокировкиДанных.Исключительный;
	//КонецЦикла;

	//Блокировка.Заблокировать();
КонецПроцедуры

Процедура ЗарегистрироватьДублиКонтрагентов() Экспорт
	
	ПрежнийМассивДублей = Новый Массив;
	НужноВыполнятьПроверку = ЭтоНовый();
	
	ИзменилсяИНН = НужноВыполнятьПроверку;
	ИзменилсяКПП = НужноВыполнятьПроверку;
	
	Если НЕ НужноВыполнятьПроверку Тогда
		
		СтруктураПрежнихЗначений = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Ссылка, 
																			  "ИНН,
																			  |КПП,
																			  |СтранаРегистрации,
																			  |ИННВведенКорректно,
																			  |КППВведенКорректно, 
																			  |ЮридическоеФизическоеЛицо, 
																			  |ОбособленноеПодразделение");
																			  
		Если НЕ СтруктураПрежнихЗначений.ИНН = ИНН 
			ИЛИ НЕ СтруктураПрежнихЗначений.КПП = КПП 
			ИЛИ НЕ СтруктураПрежнихЗначений.СтранаРегистрации = СтранаРегистрации
			ИЛИ НЕ СтруктураПрежнихЗначений.ЮридическоеФизическоеЛицо = ЮридическоеФизическоеЛицо
			ИЛИ НЕ СтруктураПрежнихЗначений.ОбособленноеПодразделение = ОбособленноеПодразделение Тогда
			
			НужноВыполнятьПроверку = Истина; 
			
		КонецЕсли;
		
		ИзменилсяИНН = НЕ СтруктураПрежнихЗначений.ИНН = ИНН;
		ИзменилсяКПП = НЕ СтруктураПрежнихЗначений.КПП = КПП;
		
		БылДоступенКПП   = СтруктураПрежнихЗначений.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо
								И СтруктураПрежнихЗначений.СтранаРегистрации = Справочники.СтраныМира.Россия;
		
		Если НужноВыполнятьПроверку 
			и СтруктураПрежнихЗначений.ИННВведенКорректно 
			и СтруктураПрежнихЗначений.КППВведенКорректно Тогда
			
			Если НЕ СтруктураПрежнихЗначений.ИНН = ИНН
				ИЛИ НЕ СтруктураПрежнихЗначений.КПП = КПП Тогда
				
				ПараметрыБлокировки = Новый Структура;
				
				Если НЕ СтруктураПрежнихЗначений.ИНН = ИНН Тогда
					ПараметрыБлокировки.Вставить("ИНН", СтруктураПрежнихЗначений.ИНН);
				КонецЕсли;
				
				Если НЕ СтруктураПрежнихЗначений.КПП = КПП и БылДоступенКПП Тогда
					ПараметрыБлокировки.Вставить("КПП", СтруктураПрежнихЗначений.КПП);
				КонецЕсли;
				
				ЗаблокироватьРегистрДублиКонтрагентов(ПараметрыБлокировки);
			Конецесли;
			
			ПрежнийМассивДублей = Справочники.Контрагенты.ЕстьЗаписиВРегистреДублей(СокрЛП(СтруктураПрежнихЗначений.ИНН), 
																								  СокрЛП(СтруктураПрежнихЗначений.КПП), 
																								  Ссылка);
		КонецЕсли;
	КонецЕсли;
	
	ЭтоЮрЛицо = (ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо);
	
	РезультатПроверкиИНН = ИдентификационныеНомераНалогоплательщиков.ПроверитьСоответствиеТребованиямИНН(ИНН, ЭтоЮрЛицо);
	РезультатПроверкиКПП = ИдентификационныеНомераНалогоплательщиков.ПроверитьСоответствиеТребованиямКПП(КПП, ЭтоЮрЛицо, ОбособленноеПодразделение);
	
	ЭтотОбъект.ИННВведенКорректно = ПустаяСтрока(РезультатПроверкиИНН.ОписаниеОшибки) И РезультатПроверкиИНН.СоответствуетТребованиям;
	ЭтотОбъект.КППВведенКорректно = ПустаяСтрока(РезультатПроверкиКПП.ОписаниеОшибки) И РезультатПроверкиКПП.СоответствуетТребованиям;
	
	//Если НужноВыполнятьПроверку Тогда
	//	
	//	Если (ИзменилсяИНН ИЛИ ИзменилсяКПП)
	//		И (РезультатПроверкиИНН.СоответствуетТребованиям И РезультатПроверкиИНН.ЭтоЮрЛицо = ЭтоЮрЛицо) 
	//		И (РезультатПроверкиКПП.СоответствуетТребованиям ИЛИ НЕ ЭтоЮрЛицо ИЛИ СтранаРегистрации <> Справочники.СтраныМира.Россия) Тогда
	//		
	//		ПараметрыБлокировки = Новый Структура;
	//		
	//		ПараметрыБлокировки.Вставить("ИНН", ИНН);
	//		Если ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо Тогда
	//			ПараметрыБлокировки.Вставить("КПП", КПП);
	//		КонецЕсли;
	//		
	//		ЗаблокироватьРегистрДублиКонтрагентов(ПараметрыБлокировки);
	//		
	//		МассивДублей = Справочники.Контрагенты.ПроверитьДублиСправочникаКонтрагентыПоИННКПП(СокрЛП(ИНН), 
	//																							СокрЛП(КПП), 
	//																							Ссылка, Истина);
	//																							
	//		Если МассивДублей.Количество() > 0 Тогда
	//		
	//			РасширенноеПредставлениеИНН = ИНН;
	//			РасширенноеПредставлениеКПП = КПП;
	//			
	//			// Для нового элемента Ссылка будет доступна только ПриЗаписи, там и запишем.
	//			ДополнительныеСвойства.НужноЗаписыватьВРегистрПриЗаписи = Истина;	
	//			
	//			Для Каждого ЭлементМассива Из МассивДублей Цикл
	//				Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(ЭлементМассива, ИНН, КПП, Ложь);
	//			КонецЦикла;
	//			
	//		КонецЕсли;
	//		
	//		Если ПрежнийМассивДублей.Количество() > 0 Тогда
	//			
	//			РасширенноеПредставлениеИНН = ИНН;
	//			РасширенноеПредставлениеКПП = КПП;
	//			
	//			Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(Ссылка, СтруктураПрежнихЗначений.ИНН, СтруктураПрежнихЗначений.КПП, Истина);
	//			
	//			Если ПрежнийМассивДублей.Количество() = 1 Тогда
	//				Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(ПрежнийМассивДублей[0], СтруктураПрежнихЗначений.ИНН, СтруктураПрежнихЗначений.КПП, Истина);
	//			КонецЕсли;
	//			
	//		КонецЕсли;
	//		
	//	Иначе
	//		
	//		Если ПрежнийМассивДублей.Количество() > 0 Тогда
	//			
	//			Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(Ссылка, СтруктураПрежнихЗначений.ИНН, СтруктураПрежнихЗначений.КПП, Истина);
	//		
	//			Если ПрежнийМассивДублей.Количество() = 1 Тогда
	//				Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(ПрежнийМассивДублей[0], СтруктураПрежнихЗначений.ИНН, СтруктураПрежнихЗначений.КПП, Истина);
	//			КонецЕсли;
	//			
	//		КонецЕсли;
	//		
	//	КонецЕсли;
	//	
	//КонецЕсли;
	//
КонецПроцедуры

Процедура УдалитьРегистрациюДублейПередУдалением()
	
	МассивДублей = 
	Справочники.Контрагенты.ЕстьЗаписиВРегистреДублей(
		СокрЛП(ИНН),
		СокрЛП(КПП),
		Ссылка);
		
	Если МассивДублей.Количество() = 1 Тогда
		
		ЭтоЮрЛицо = ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
		
		ПараметрыБлокировки = Новый Структура;
		
		ПараметрыБлокировки.Вставить("ИНН", ИНН);
		
		Если ЭтоЮрЛицо Тогда
			ПараметрыБлокировки.Вставить("КПП", КПП);
		КонецЕсли;
		
		ЗаблокироватьРегистрДублиКонтрагентов(ПараметрыБлокировки);
		
		Справочники.Контрагенты.ВыполнитьДвиженияПоРегиструДублей(МассивДублей[0], ИНН, КПП, Истина);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработатьИсториюРеквизитовПередЗаписью()

	// Если запись в истории одна, то считается, что изменений нет,
	// нужно определять значение из данных объекта, а таблицу истории очистить.
	// Если записей в истории более 1, последняя запись всегда должна соответствовать данным объекта,
	// а первая запись должна иметь пустую дату.
	
	Если ИсторияКПП.Количество() = 1 Тогда
		ИсторияКПП.Очистить();
	ИначеЕсли ИсторияКПП.Количество() > 1 Тогда
		Справочники.Контрагенты.УстановитьАктуальноеЗначениеИсторииКПП(КПП, ИсторияКПП);
		ИсторияКПП[0].Период = '00010101';
		ВсеПериоды = ОбщегоНазначения.ВыгрузитьКолонку(ИсторияКПП, "Период", Истина);
		Если ВсеПериоды.Количество() <> ИсторияКПП.Количество() Тогда
			ТекстСообщения = НСтр("ru='В истории КПП есть записи с одинаковым периодом.'");
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;
	КонецЕсли;
	
	Если ИсторияНаименований.Количество() = 1 Тогда
		ИсторияНаименований.Очистить();
	ИначеЕсли ИсторияНаименований.Количество() > 1 Тогда
		Справочники.Контрагенты.УстановитьАктуальноеЗначениеИсторииНаименований(НаименованиеПолное, ИсторияНаименований);
		ИсторияНаименований[0].Период = '00010101';
		ВсеПериоды = ОбщегоНазначения.ВыгрузитьКолонку(ИсторияНаименований, "Период", Истина);
		Если ВсеПериоды.Количество() <> ИсторияНаименований.Количество() Тогда
			ТекстСообщения = НСтр("ru='В истории полного наименования есть записи с одинаковым периодом.'");
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;
	КонецЕсли;
	
	УправлениеКонтактнойИнформациейБП.ПередЗаписьюИсторииКонтактнойИнформацииОбъекта(ЭтотОбъект);
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли