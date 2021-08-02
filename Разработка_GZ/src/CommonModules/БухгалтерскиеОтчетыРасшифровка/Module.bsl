#Область ПрограммныйИнтерфейс

// Создает настройки расшифровки отчета, которые могут быть открыты любым стандартным отчетом.
//
// Параметры:
//  АдресРасшифровки		 - Строка - Адрес данных расшифровки во временном хранилище.
//  ИдентификаторРасшифровки - ИдентификаторРасшифровкиКомпоновкиДанных - Указатель на элемент данных расшифровки для которого строится расшифровка.
//  ИмяИсходногоОтчета		 - Строка - Имя менеджера отчета из которого вызвана расшифровка.
//  РеквизитыРасшифровки	 - Структура - значения реквизитов из контекста расшифровываемой ячейки.
// 
// Возвращаемое значение:
//   - Структура см. БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки - настройки расшифровки пригодные для чтения стандартным отчетом.
//
Функция НастройкиРасшифровки(АдресРасшифровки, ИдентификаторРасшифровки, ИмяИсходногоОтчета, РеквизитыРасшифровки) Экспорт
	
	Расшифровка = ПолучитьИзВременногоХранилища(АдресРасшифровки);
	
	ДанныеРасшифровки	= Неопределено;
	Объект 				= Неопределено;
	Настройки			= БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки();
	
	Если НЕ ТипЗнч(Расшифровка) = Тип("Структура") Тогда
		Возврат Настройки;
	КонецЕсли;
	
	Расшифровка.Свойство("ДанныеРасшифровки",	ДанныеРасшифровки);
	Расшифровка.Свойство("Объект", 				Объект);
	
	Если ДанныеРасшифровки = Неопределено
		ИЛИ Объект = Неопределено 
		ИЛИ ИдентификаторРасшифровки = Неопределено
		ИЛИ РеквизитыРасшифровки = Неопределено
		ИЛИ ИмяИсходногоОтчета = Неопределено
		Тогда
		Возврат Настройки;
	КонецЕсли;
	
	МенеджерОтчета = Отчеты[ИмяИсходногоОтчета];
	МенеджерОтчета.ЗаполнитьНастройкиРасшифровки(Настройки, Объект, ДанныеРасшифровки, ИдентификаторРасшифровки, РеквизитыРасшифровки);
	
	Возврат Настройки;
	
КонецФункции

// Заполняет настройки расшифровки отчета.
//
// Параметры:
//  Настройки				 - Структура								 - Настройки расшифровки отчета, которые нужно заполнить (см. БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки).
//  ДанныеРасшифровки		 - ДанныеРасшифровкиКомпоновкиДанных		 - Данные расшифровки отчета.
//  ИдентификаторРасшифровки - ИдентификаторРасшифровкиКомпоновкиДанных  - Идентификатор расшифровки из ячейки для которой вызвана расшифровка.
//  Объект					 - ОтчетОбъект								 - Отчет из данных которого нужно собрать универсальные настройки.
//  РеквизитыРасшифровки	 - Структура								 - Реквизиты отчета полученные из контекста расшифровываемой ячейки.
//
Процедура ЗаполнитьНастройкиРасшифровкиПоДаннымСтандартногоОтчета(Настройки, ДанныеРасшифровки, ИдентификаторРасшифровки, Объект, РеквизитыРасшифровки) Экспорт
	
	ДобавитьВНастройкиДанныеОтчета(Настройки, Объект);
	
	ДобавитьВНастройкиДанныеРасшифровки(ДанныеРасшифровки, ИдентификаторРасшифровки, Настройки, РеквизитыРасшифровки);

КонецПроцедуры

// Определяет, какими отчетами можно расшифровать ячейку отчета.
//
// Параметры:
//  ИмяОтчета					 - Строка									 - Имя отчета, для которого определяются возможные расшифровки.
//  ДанныеРасшифровки			 - ДанныеРасшифровкиКомпоновкиДанных		 - Данные расшифровки исходного отчета, содержит данный для всех ячеек отчета.
//  ИдентификаторРасшифровки	 - ИдентификаторРасшифровкиКомпоновкиДанных	 - Идентификатор связывающий ячейку отчета с элементом данных расшифровки.
//  ОтборИмяОтчетаРасшифровки	 - Строка									 - Отбор по имени расшифровочного отчета, позволяет сократить вычисления и проверить возможность расшифровки только указанным отчетом.
// 
// Возвращаемое значение:
//  ТаблицаЗначений см. НовыйПравилаРасшифровки() - Содержит имена отчетов и реквизиты, требуемые для этих отчетов, правилами расшифровки (см. БухгалтерскиеОтчетыРасшифровка.НовыйПравилаРасшифровки()).
//
Функция РасшифровочныеОтчеты(ДанныеРасшифровки, ИдентификаторРасшифровки, ИмяОтчета) Экспорт
	
	ПравилаРасшифровки = БухгалтерскиеОтчетыРасшифровка.НовыйПравилаРасшифровки();
	
	Отчеты[ИмяОтчета].ЗаполнитьПравилаРасшифровки(ПравилаРасшифровки);
	
	ЭлементРасшифровки = ДанныеРасшифровки.Элементы[ИдентификаторРасшифровки];
	
	Для Каждого Правило Из ПравилаРасшифровки Цикл
		
		Правило.ОтчетГотов = Истина;
		
		Для Каждого Реквизит Из Правило.ТребуемыеРеквизиты Цикл
			
			РеквизитЗаполнен = Ложь;
			Источники = СтрРазделить(Реквизит.Источники, ",", Ложь);
			
			ЗначениеПоля = НайтиПолеВЭлементеРасшифровки(ЭлементРасшифровки, Источники);
			
			Если ЗначениеПоля <> Неопределено Тогда
				Правило.ЗначенияРеквизитов.Вставить(Реквизит.Реквизит, ЗначениеПоля);
				РеквизитЗаполнен = Истина;
				Продолжить;
			КонецЕсли;
			
			Если Не РеквизитЗаполнен И Реквизит.Значение <> Неопределено Тогда
				Правило.ЗначенияРеквизитов.Вставить(Реквизит.Реквизит, Реквизит.Значение);
				РеквизитЗаполнен = Истина;
				Продолжить;
			КонецЕсли;
			
			Если Не РеквизитЗаполнен Тогда
				Правило.ОтчетГотов = Ложь;
				Прервать;
			КонецЕсли;
			
		КонецЦикла;
		
		Если Правило.ОтчетГотов Тогда
			
			Для Каждого Условие Из Правило.Условия Цикл
				
				ЗначениеРеквизита = Неопределено;
				Если Правило.ЗначенияРеквизитов.Свойство(Условие.Ключ, ЗначениеРеквизита) И ЗначениеРеквизита <> Условие.Значение Тогда
					
					Правило.ОтчетГотов = Ложь;
					
				КонецЕсли;
				
			КонецЦикла;
			
		КонецЕсли;
		
	КонецЦикла;

	Возврат ПравилаРасшифровки;
	
КонецФункции

// Добавляет реквизит, требующийся для корректного открытия расшифровочного отчета, в коллекцию требуемых реквизитов правил расшифровки.
//
// Параметры:
//  ТребуемыеРеквизиты	 - ТаблицаЗначений	 - См. НовыйТребуемыеРеквизитыРасшифровки().
//  ИмяРеквизита		 - Строка			 - Имя реквизита.
//  Источники			 - Строка			 - Имена источников для заполнения значения реквизита, разделенные запятыми.
//  Значение			 - Неопределено		 - Значение реквизита, которое будет подставлено, если не будет найдено ни одного источника.
//
Процедура ДобавитьТребуемыйРеквизитРасшифровки(ТребуемыеРеквизиты, ИмяРеквизита, Источники, Значение = Неопределено) Экспорт
	
	Если ТребуемыеРеквизиты.Колонки.Количество() = 0 Тогда
		ТипСтрока = Новый ОписаниеТипов("Строка");
		ТребуемыеРеквизиты.Колонки.Добавить("Реквизит",		ТипСтрока);
		ТребуемыеРеквизиты.Колонки.Добавить("Источники",	ТипСтрока);
		ТребуемыеРеквизиты.Колонки.Добавить("Значение");
	КонецЕсли;

	НовыйРеквизит = ТребуемыеРеквизиты.Добавить();
	НовыйРеквизит.Реквизит 	= ИмяРеквизита;
	НовыйРеквизит.Источники = Источники;
	НовыйРеквизит.Значение = Значение;

КонецПроцедуры

// Создает и инициализирует новую таблицу правил расшифровки отчета.
// При помощи правил расшифровки определяется список расшифровочных отчетов для конкретного отчета источника.
// Одна строка правил описывает один отчет, который может быть использован как расшифровка.
//
// Возвращаемое значение:
//   ТаблицаЗначений - Правила расшифровки.
//
Функция НовыйПравилаРасшифровки() Экспорт
	
	Правила = Новый ТаблицаЗначений;
	
	ТипСтрока = ОбщегоНазначения.ОписаниеТипаСтрока(255);
	ТипСтруктура = Новый ОписаниеТипов("Структура");
	
	Правила.Колонки.Добавить("Отчет",				ТипСтрока);									// Имя потенциального расшифровочного отчета.
	
	Правила.Колонки.Добавить("ТребуемыеРеквизиты",	Новый ОписаниеТипов("ТаблицаЗначений"));	// Коллекция реквизитов, необходимых для того, чтобы этот отчет можно было считать пригодным для расшифровки.
																								// Если требуемые реквизиты не могут быть определены из контекста расшифровываемого отчета, то отчет не 
																								// будет показываться пользователю в списке действий расшифровки См. НовыйТребуемыеРеквизитыРасшифровки().

	Правила.Колонки.Добавить("ШаблонПредставления",	Новый ОписаниеТипов("Строка")); 			// Текст который будет показан пользователю в списке выбора действий расшифровки. Может быть задан шаблоном вида:
																								// "Имя отчета [Реквизит] [Реквизит1] ...", где "Реквизит" имя реквизита из коллекции "ТребуемыеРеквизиты", 
																								// вместо "[Реквизит]" в шаблон будет подставлено значение реквизита.
																								
	Правила.Колонки.Добавить("Условия",				ТипСтруктура);								// Коллекция условий применяемых к значениям реквизитов, 
																								// если значение реквизита не соответствует значению условия отчет исключается из списка действий.
																								
																								
	// Служебные поля: заполняются при обработке правил.
	Правила.Колонки.Добавить("ЗначенияРеквизитов",	ТипСтруктура);								// Найденные значения требуемых реквизитов.
	
	Правила.Колонки.Добавить("ОтчетГотов",			Новый ОписаниеТипов("Булево"));				// Флаг означающий что все требуемые реквизиты отчета найдены и соответствуют условиям,
																								// отчет может быть показан пользователю.
	
	Возврат Правила;

КонецФункции

// Читает данные расшифровки и добавляет их в настройки.
//
// Параметры:
//  ДанныеРасшифровки		 - ДанныеРасшифровкиКомпоновкиДанных		 - Данные расшифровки, из которых будут получены значения настроек.
//  ИдентификаторРасшифровки - ИдентификаторРасшифровкиКомпоновкиДанных	 - Идентификатор расшифровки из ячейки для которой вызвана расшифровка.
//  Настройки				 - Структура								 - Универсальные настройки, которое нужно дополнить из данных расшифровки.
//  РеквизитыРасшифровки	 - Структура								 - Реквизиты отчета, полученные из данных расшифровки, которыми нужно дополнить настройки.
//
Процедура ДобавитьВНастройкиДанныеРасшифровки(ДанныеРасшифровки, ИдентификаторРасшифровки, Настройки, РеквизитыРасшифровки) Экспорт
	
	ПоляРасшифровки = Новый Соответствие;
	
	ПоляРасшифровкиИзЭлемента(ДанныеРасшифровки.Элементы[ИдентификаторРасшифровки], ПоляРасшифровки);
	
	Для Каждого ПолеРасшифровки Из ПоляРасшифровки Цикл
		
		ЗначениеПоляРасшифровки = ПолеРасшифровки.Значение.Значение;
		
		Если ПолеРасшифровки.Ключ = "Период" Тогда
			
			БухгалтерскиеОтчетыКлиентСервер.ПреобразоватьПериодичностьОтчетаВПериод(Настройки, ЗначениеПоляРасшифровки);
			Продолжить;
			
		КонецЕсли;
		
		ПрименяемыйВидСравнения = ВидСравненияДляПоляРасшифровки(ПолеРасшифровки.Значение);
		
		Если ОтборПоПолюИмеетСмысл(ПолеРасшифровки.Ключ, ПрименяемыйВидСравнения, Настройки.Отбор) Тогда
			БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(Настройки.Отбор, ПолеРасшифровки.Ключ, ЗначениеПоляРасшифровки, ПрименяемыйВидСравнения);
		КонецЕсли;

	КонецЦикла;
	
	Для Каждого РеквизитРасшифровки Из РеквизитыРасшифровки Цикл
		Настройка = Неопределено;
		Если Настройки.Свойство(РеквизитРасшифровки.Ключ, Настройка) Тогда
			
			ОбработатьИзменениеНастройки(Настройки, РеквизитРасшифровки.Ключ, Настройка, РеквизитРасшифровки.Значение);
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

// Проверяет, есть ли в коллекции отборов, элемент устанавливающий такой же или более точный отбор по переданному полю.
//
// Параметры:
//  Поле					 - Строка						 - Имя поля левого значения, по которому предполагается наложить отбор.
//  ПрименяемыйВидСравнения	 - ВидСравненияКомпоновкиДанных	 - Вид сравнения предполагаемого отбора.
//  Отбор					 - ОтборКомпоновкиДанных 		 - Проверяемый отбор.
// 
// Возвращаемое значение:
//  Булево - Истина - если более точного отбора в коллекции нет, и отбор имеет смысл, в противном случае - ложь.
//
Функция ОтборПоПолюИмеетСмысл(Поле, ПрименяемыйВидСравнения, Отбор)
	
	ПолеОтбора = Новый ПолеКомпоновкиДанных(Поле);
	
	Для Каждого ЭлементОтбора Из Отбор.Элементы Цикл
		
		Если Не ЭлементОтбора.Использование Тогда
			Продолжить;
		КонецЕсли;
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда
			Возврат ОтборПоПолюИмеетСмысл(Поле, ПрименяемыйВидСравнения, ЭлементОтбора);
		КонецЕсли;
		
		Если ЭлементОтбора.ЛевоеЗначение <> ПолеОтбора Тогда
			Продолжить;
		КонецЕсли;
		
		Если ЭлементОтбора.ВидСравнения = ВидСравненияКомпоновкиДанных.Равно
			ИЛИ ЭлементОтбора.ВидСравнения = ПрименяемыйВидСравнения Тогда
			Возврат Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Истина;

КонецФункции

// Читает данные отчета и добавляет их в настройки.
//
// Параметры:
//  Настройки	 - Структура	 - Универсальные настройки, которые нужно дополнить данными отчета.
//  Отчет		 - ОтчетОбъект	 - Отчет, из которого нужно взять данные.
//
Процедура ДобавитьВНастройкиДанныеОтчета(Настройки, Отчет) Экспорт
	
	ЗаполнитьЗначенияСвойств(Настройки, Отчет);
	
	Группировка = Неопределено;
	
	Если Отчет.Свойство("Группировка", Группировка) Тогда
		
		Для Каждого СтрокаГруппировки Из Группировка Цикл
			
			НоваяСтрока = БухгалтерскиеОтчетыКлиентСервер.НовыйСтрокаГруппировки();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаГруппировки);
			Настройки.ТаблицаГруппировка.Добавить(НоваяСтрока);
			
		КонецЦикла;
		
	КонецЕсли;

	ДополнительныеПоля = Неопределено;
	
	Если Отчет.Свойство("ДополнительныеПоля", ДополнительныеПоля) Тогда
		
		Для Каждого СтрокаДополнительныеПоля Из ДополнительныеПоля Цикл
			
			НоваяСтрока = БухгалтерскиеОтчетыКлиентСервер.НовыйСтрокаДополнительныеПоля();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаДополнительныеПоля);
			Настройки.ТаблицаДополнительныеПоля.Добавить(НоваяСтрока);
			
		КонецЦикла;
		
	КонецЕсли;
	
	КомпоновкаДанныхКлиентСервер.СкопироватьЭлементы(Настройки.Отбор,				Отчет.НастройкиКомпоновкиДанных.Отбор);
	КомпоновкаДанныхКлиентСервер.СкопироватьЭлементы(Настройки.УсловноеОформление,	Отчет.НастройкиКомпоновкиДанных.УсловноеОформление);
	КомпоновкаДанныхКлиентСервер.СкопироватьЭлементы(Настройки.Порядок,				Отчет.НастройкиКомпоновкиДанных.Порядок);
	
КонецПроцедуры

// Выполняет замену левых значений отбора (для отборов по субконто), когда у нового счета другой состав и/или порядок субконто.
//
// Параметры:
//  Настройки			 - Структура				 - Настройки в отборе которых нужно осуществить замену, см. НовыйПравилаРасшифровки().
//  НовыйСчет			 - ПланыСчетов.Хозрасчетный	 - Новый счет.
//	КартаВидовСубконто	 - Соответствие				 - Содержит соответствие старых и новых номеров субконто см. КартаПереходаСубконтоМеждуСчетами.
//
Процедура ПоменятьНумерациюСубконтоВОтборе(Настройки, НовыйСчет, КартаВидовСубконто) Экспорт
	
	ЭлементыОтбораКУдалению = Новый Массив();
	ЭлементыОтбораПодЗамену = Новый Массив();

	ЗаполнитьЭлементыОтбораПодЗамену(
		КартаВидовСубконто,
		Настройки.Отбор.Элементы,
		ЭлементыОтбораПодЗамену,
		ЭлементыОтбораКУдалению);
	
	Если ЭлементыОтбораПодЗамену.Количество() > 0 Тогда
		
		ВидыСубконто = Новый Соответствие;
		СвойстваСчета = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(НовыйСчет);
		
		Для НомерСубконто = 1 По БухгалтерскийУчет.МаксимальноеКоличествоСубконто() Цикл
			ВидСубконто = СвойстваСчета["ВидСубконто" + НомерСубконто];
			Если ВидСубконто <> Неопределено Тогда
				ВидыСубконто.Вставить(ВидСубконто, НомерСубконто);
			КонецЕсли;
		КонецЦикла;
		
		Для Каждого ЭлементЗамены Из ЭлементыОтбораПодЗамену Цикл
			
			ПоляПодходящегоТипа = Новый Массив;
			
			ЛевоеЗначениеПуть = СтрРазделить(ЭлементЗамены.ЛевоеЗначение, ".");
			
			Для Каждого ВидСубконто Из ВидыСубконто Цикл
				
				Если ВидСубконто.Ключ.ТипЗначения.СодержитТип(ТипЗнч(ЭлементЗамены.ПравоеЗначение)) Тогда
					ПоляПодходящегоТипа.Добавить(ПутьПоляСНовымНомеромСубконто(ЛевоеЗначениеПуть, ВидСубконто.Значение));
				КонецЕсли;
				
			КонецЦикла;
			
			КоличествоПодходящихПолей = ПоляПодходящегоТипа.Количество();
			Если КоличествоПодходящихПолей = 0 Тогда // остается только удалить отбор по невостребованному субконто
				
				ЭлементыОтбораКУдалению.Добавить(ЭлементЗамены);
				
			ИначеЕсли КоличествоПодходящихПолей = 1 Тогда // заменяем одно субконто на другое того же типа

				ЭлементЗамены.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ПоляПодходящегоТипа[0]);

			Иначе // значение может служить отбором по более чем одному субконто
				
				ЭлементыОтбораКУдалению.Добавить(ЭлементЗамены);
				
				НоваяГруппа = Настройки.Отбор.Элементы.Добавить(Тип("ГруппаЭлементовОтбораКомпоновкиДанных"));
				НоваяГруппа.ТипГруппы = ТипГруппыЭлементовОтбораКомпоновкиДанных.ГруппаИли;
				НоваяГруппа.Использование = Истина;
				
				Для Каждого Поле Из ПоляПодходящегоТипа Цикл
					
					БухгалтерскиеОтчетыКлиентСервер.ДобавитьОтбор(
						НоваяГруппа, Поле, ЭлементЗамены.ПравоеЗначение,  ЭлементЗамены.ВидСравнения);
					
				КонецЦикла;
				
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Для Каждого ЭлементДляУдаления Из ЭлементыОтбораКУдалению Цикл
		Настройки.Отбор.Элементы.Удалить(ЭлементДляУдаления);
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Проверяет является ли объект группой элементов, для определения используется функция БСП см. ОбщегоНазначения.ОбъектЯвляетсяГруппой.
// Для неопределенного объекта возвращает Ложь.
//
// Параметры:
//  Объект - Объект, Ссылка, Неопределено, ДанныеФормыСтруктура по типу Объект - Объект который нужно проверить.
//
// Возвращаемое значение:
//  Булево - Признак является ли объект группой.
//
Функция ОбъектЯвляетсяГруппой(Объект) Экспорт
	
	Если Объект = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат ОбщегоНазначения.ОбъектЯвляетсяГруппой(Объект);
		
КонецФункции

// Выполняет рекурсивный поиск полей в элементе расшифровки компоновки данных.
//
// Параметры:
//  ЭлементРасшифровки	 - ЭлементРасшифровкиКомпоновкиДанныхПоля, ЭлементРасшифровкиКомпоновкиДанныхГруппировка 	 - Элемент в данных которого нужно выполнить поиск.
//  ПоляДляПоиска		 - Соответствие	 - Поля, значения которых нужно найти, ключ - искомое поле, значение - другие поля являющиеся источниками для одно и того же реквизита.
// 
// Возвращаемое значение:
//  Произвольный - Значение искомого поля, Неопределено.
//
Функция НайтиПолеВЭлементеРасшифровки(ЭлементРасшифровки, ПоляДляПоиска)
	
	Если ТипЗнч(ЭлементРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		
		ПоляРасшифровки = ЭлементРасшифровки.ПолучитьПоля();
		
		Для Каждого ПолеРасшифровки Из ПоляРасшифровки Цикл
			
			Источник = ПоляДляПоиска.Найти(ПолеРасшифровки.Поле);
			
			Если Источник = Неопределено Тогда 
				Продолжить;
			КонецЕсли;
			
			Возврат ПолеРасшифровки.Значение;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Родители = ЭлементРасшифровки.ПолучитьРодителей();
	Если Родители.Количество() > 0 Тогда
		
		Для Каждого Родитель Из Родители Цикл
			
			Возврат НайтиПолеВЭлементеРасшифровки(Родитель, ПоляДляПоиска);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

// Анализирует состав видов субконто
// и составляет карту соответствия между видами субконто исходного счета и нового счета.
//
// Параметры:
//  ВидыСубконтоИсходногоСчета	 - Соответствие	 - Виды субконто исходного счета по порядку см. ВидыСубконтоСчета().
//  ВидыСубконтоНовогоСчета		 - Соответствие	 - Виды субконто нового счета по порядку см. ВидыСубконтоСчета().
//
// Возвращаемое значение:
//   Соответствие - Ключ соответствия - номер субконто исходного счета,
//		значение соответствия - массив номеров субконто нового счета, соответствующих виду субконто исходного счета.
//		Если виду субконто не соответствует напрямую ни один вид субконто нового счета, то в массиве будет одно значение - 0.
//
Функция КартаПереходаСубконтоМеждуСчетами(ВидыСубконтоИсходногоСчета, ВидыСубконтоНовогоСчета)
	
	КартаПереходаНомеровСубконто = Новый Соответствие;
	
	Если НЕ ОбщегоНазначения.КоллекцииИдентичны(ВидыСубконтоИсходногоСчета, ВидыСубконтоНовогоСчета) Тогда
		
		МаксимальноеКоличествоСубконто = БухгалтерскийУчет.МаксимальноеКоличествоСубконто();
		
		НомераСубконтоНовогоСчета = Новый Соответствие;
		Для НомерСубконто = 1 По МаксимальноеКоличествоСубконто Цикл
			НомераСубконтоНовогоСчета.Вставить(ВидыСубконтоНовогоСчета[НомерСубконто], НомерСубконто);
		КонецЦикла;
		
		Для НомерСубконтоИсходногоСчета = 1 По МаксимальноеКоличествоСубконто Цикл
			ВидСубконто = ВидыСубконтоИсходногоСчета[НомерСубконтоИсходногоСчета];
			НомерСубконтоНовогоСчета = НомераСубконтоНовогоСчета[ВидСубконто];
			КартаПереходаНомеровСубконто.Вставить(НомерСубконтоИсходногоСчета,
				?(ЗначениеЗаполнено(НомерСубконтоНовогоСчета), НомерСубконтоНовогоСчета, 0));
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат КартаПереходаНомеровСубконто;
	
КонецФункции

// Получает коллекцию видов субконто счета.
//
// Параметры:
//  Счет			 - ПланыСчетов.Хозрасчетный	 - счет, коллекцию видов субконто которого нужно получить.
//
// Возвращаемое значение:
//  Соответствие - коллекция  видов субконто счета, ключ - номер субконто, значение - вид субконто.
//
Функция ВидыСубконтоСчета(Счет)
	
	ВидыСубконто = Новый Соответствие;
	СвойстваСчета = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Счет);
	
	Для НомерСубконто = 1 По БухгалтерскийУчет.МаксимальноеКоличествоСубконто() Цикл
		ВидСубконто = СвойстваСчета["ВидСубконто" + НомерСубконто];
		Если ВидСубконто <> Неопределено Тогда
			ВидыСубконто.Вставить(НомерСубконто, ВидСубконто);
		КонецЕсли;
	КонецЦикла;
	Возврат ВидыСубконто;

КонецФункции

// Выполняет замену полей (для субконто) в таблице группировок и дополнительных полей, если при изменении счета поменялись номера и порядок субконто.
//
// Параметры:
//  ИмяТабличнойЧасти	 - Строка					 - Имя табличной части в настройках ("ТаблицаГруппировка" или "ТаблицаДополнительныеПоля") 
//													 см. БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки().
//  Настройки			 - Структура				 - Универсальные настройки содержащие таблицу.
//  ИсходныйСчет		 - ПланыСчетов.Хозрасчетный	 - Исходный счет.
//  НовыйСчет			 - ПланыСчетов.Хозрасчетный	 - Новый счет.
//  КартаВидовСубконто	 - Соответствие				 - Содержит соответствие старых и новых номеров субконто см. КартаПереходаСубконтоМеждуСчетами().
//
Процедура ПоменятьНумерациюСубконтоВТабличнойЧасти(ИмяТабличнойЧасти, Настройки, ИсходныйСчет, НовыйСчет, КартаВидовСубконто = Неопределено) Экспорт
	
	ТабличнаяЧасть = Неопределено;
	
	Настройки.Свойство(ИмяТабличнойЧасти, ТабличнаяЧасть);
	Если ТипЗнч(ТабличнаяЧасть) <> Тип("Массив") Тогда
		Возврат;
	КонецЕсли;
	
	Если КартаВидовСубконто = Неопределено Тогда
		
		КартаВидовСубконто = КартаПереходаСубконтоМеждуСчетами(ВидыСубконтоСчета(ИсходныйСчет), ВидыСубконтоСчета(НовыйСчет));
		
	КонецЕсли;
	
	СтрокиКоторыеНужноУдалить = Новый Массив;
	
	Для ИндексСтроки = 0 По ТабличнаяЧасть.ВГраница() Цикл
		
		Строка = ТабличнаяЧасть.Получить(ИндексСтроки);
		
		Поле = 	Строка.Поле;
		Путь = СтрРазделить(Строка.Поле, ".");
		
		Если СтрНачинаетсяС(Путь[0],"Субконто") Тогда
			
			НомерЗамены = КартаВидовСубконто.Получить(БухгалтерскиеОтчетыКлиентСервер.НомерСубконто(Путь[0]));
			
			Если НомерЗамены = Неопределено Тогда
				Продолжить;
			ИначеЕсли НомерЗамены = 0 Тогда
				СтрокиКоторыеНужноУдалить.Добавить(ИндексСтроки);
			Иначе
				Строка.Поле = ПутьПоляСНовымНомеромСубконто(Путь, НомерЗамены);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	КоличествоСтрок = СтрокиКоторыеНужноУдалить.Количество();
	Для ИндексСтроки = 1 По КоличествоСтрок Цикл
		ТабличнаяЧасть.Удалить(СтрокиКоторыеНужноУдалить[КоличествоСтрок - ИндексСтроки]);
	КонецЦикла;

КонецПроцедуры

// Составляет новый путь поля компоновки данных, подменяя номер субконто.
// При смене счета в настройках отчета, на счет с другим составом и порядком субконто,
// пути полей отбора, группировки и дополнительных полей должны быть заменены.
//
// Параметры:
//  Путь				 - Массив			 - Путь поля компоновки данных в виде массива. 
//												Одно значение массива соответствует одному элементу пути отделяемому точкой ".".
//												Точек в элементах массива быть не должно.
//  НовыйНомерСубконто	 - Число, Строка	 - Номер субконто, который нужно подставить.
// 
// Возвращаемое значение:
//   Строка - Новый путь.
//
Функция ПутьПоляСНовымНомеромСубконто(Путь, НовыйНомерСубконто)
	
	НовыйПуть = ОбщегоНазначенияКлиентСервер.СкопироватьМассив(Путь);
	НовыйПуть.Установить(0, "Субконто" + НовыйНомерСубконто);
	Возврат СтрСоединить(НовыйПуть, ".");

КонецФункции

// Получает все поля расшифровки из элемента расшифровки и его родителей. 
// По сути, получает контекст расшифровываемой ячейки отчета, для того чтобы в последующим наложить по нему отбор.
//
// Параметры:
//  ЭлементРасшифровки	 - ЭлементРасшифровкиКомпоновкиДанныхПоля, ЭлементРасшифровкиКомпоновкиДанныхГруппировка - Элемент расшифровки, из которого нужно получить поля.
//  ПоляРасшифровки		 - Соответствие - Соответствие в которое нужно поместить найденные поля расшифровки.
//
Процедура ПоляРасшифровкиИзЭлемента(ЭлементРасшифровки, ПоляРасшифровки)
	
	Если ТипЗнч(ЭлементРасшифровки) = Тип("ЭлементРасшифровкиКомпоновкиДанныхПоля") Тогда
		Для каждого Поле Из ЭлементРасшифровки.ПолучитьПоля() Цикл
			Если ПоляРасшифровки.Получить(Поле.Поле) = Неопределено Тогда
				ПоляРасшифровки.Вставить(Поле.Поле, Поле);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	// Для поиска полей на уровень выше, получим все родительские элементы данного элемента расшифровки,
	// и выполним поиск в каждом из них.
	Для каждого Родитель Из ЭлементРасшифровки.ПолучитьРодителей() Цикл
		ПоляРасшифровкиИзЭлемента(Родитель, ПоляРасшифровки);
	КонецЦикла;
	
КонецПроцедуры

// Записывает новое значение настройки в коллекцию настроек и выполняет необходимые при смене значения преобразования.
//
// Параметры:
//  Настройки		 - Структура	 - Настройки в которых нужно установить новое значение см. БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки().
//  ИмяНастройки	 - Строка		 - Имя настройки, новое значение которой нужно установить.
//  СтароеЗначение	 - Неопределено	 - Предыдущее значение настройки.
//  НовоеЗначение	 - Неопределено	 - Новое значение настройки.
//
Процедура ОбработатьИзменениеНастройки(Настройки, ИмяНастройки, СтароеЗначение, НовоеЗначение)
	
	Если ИмяНастройки = "Счет" тогда
		
		Если ТипЗнч(НовоеЗначение) = Тип("ПланСчетовСсылка.Хозрасчетный") И СтароеЗначение <> НовоеЗначение Тогда
			
			Если Настройки.СписокВидовСубконто.Количество() > 0 Тогда
				ВидыСубконтоИсходногоСчета = Новый Соответствие;
				НомерСубконто = 1;
				Для Каждого ВидСубконто Из Настройки.СписокВидовСубконто Цикл
					ВидыСубконтоИсходногоСчета.Вставить(НомерСубконто, ВидСубконто.Значение);
					НомерСубконто = НомерСубконто + 1;
				КонецЦикла;
			Иначе
				ВидыСубконтоИсходногоСчета = ВидыСубконтоСчета(СтароеЗначение);
			КонецЕсли;
			
			КартаВидовСубконто = КартаПереходаСубконтоМеждуСчетами(ВидыСубконтоИсходногоСчета, ВидыСубконтоСчета(НовоеЗначение));

			ПоменятьНумерациюСубконтоВОтборе(Настройки, НовоеЗначение, КартаВидовСубконто);
			ПоменятьНумерациюСубконтоВТабличнойЧасти("ТаблицаГруппировка", Настройки, СтароеЗначение, НовоеЗначение, КартаВидовСубконто);
			ПоменятьНумерациюСубконтоВТабличнойЧасти("ТаблицаДополнительныеПоля", Настройки, СтароеЗначение, НовоеЗначение, КартаВидовСубконто);
			СброситьНедопустимыеДляСчетаПоказатели(НовоеЗначение, Настройки);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Настройки.Вставить(ИмяНастройки, НовоеЗначение);

КонецПроцедуры

// Устанавливает показатели НУ,ПР,ВР, Количество в значение Ложь, если на счете нет соответствующего учета.
//
// Параметры:
//  Счет	 - ПланСчетовСсылка.Хозрасчетный	 - Счет, по свойствам которого нужно сбросить показатели.
//  Настройки - Структура						 - Настройки, в которых нужно установить свойства см. БухгалтерскиеОтчетыКлиентСервер.НовыйУниверсальныеНастройки().
//
Процедура СброситьНедопустимыеДляСчетаПоказатели(Счет, Настройки)
	
	СвойстваСчета = БухгалтерскийУчетВызовСервераПовтИсп.ПолучитьСвойстваСчета(Счет);
	
	Если НЕ СвойстваСчета.Количественный Тогда
		Настройки.ПоказательКоличество = Ложь;
	КонецЕсли;
	
	// Для счетов групп валютная сумма допустима.
	Если НЕ СвойстваСчета.Валютный И НЕ СвойстваСчета.ЗапретитьИспользоватьВПроводках Тогда
		Настройки.ПоказательВалютнаяСумма = Ложь;
	КонецЕсли;
	
	Если НЕ СвойстваСчета.НалоговыйУчет Тогда
		Настройки.ПоказательНУ       = Ложь;
		Настройки.ПоказательСверкаНУ = Ложь;
		Настройки.ПоказательПР       = Ложь;
		Настройки.ПоказательВР       = Ложь;
		Настройки.ПоказательКонтроль = Ложь;
	КонецЕсли;
	
	Если СвойстваСчета.Вид <> ВидСчета.АктивноПассивный Тогда
		Настройки.РазвернутоеСальдо = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Определяет вид сравнения подходящий для отбора по переданному полю расшифровки.
// В качестве значения отбора, рассматривается значение поля расшифровки.
//
// Параметры:
//  ПолеРасшифровки	 - ЗначениеПоляРасшифровкиКомпоновкиДанных	 - Значение расшифровки, для которого нужно определить вид сравнения.
// 
// Возвращаемое значение:
//  ВидСравненияКомпоновкиДанных - Вид сравнения подходящий для значения поля расшифровки.
//
Функция ВидСравненияДляПоляРасшифровки(ПолеРасшифровки)
	
	ЗначениеПоляРасшифровки = ПолеРасшифровки.Значение;
	ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.Равно;
	
	Если ПолеРасшифровки.Иерархия Тогда
		ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.ВИерархии;
	ИначеЕсли НЕ ЗначениеЗаполнено(ЗначениеПоляРасшифровки) Тогда
		ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.НеЗаполнено;
	ИначеЕсли ТипЗнч(ЗначениеПоляРасшифровки) = Тип("Строка") Тогда
		ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.Содержит;
	ИначеЕсли ОбщегоНазначения.ЗначениеСсылочногоТипа(ЗначениеПоляРасшифровки) Тогда
		
		Если ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ЗначениеПоляРасшифровки, "ЭтоГруппа") Тогда
			Если ЗначениеПоляРасшифровки.ЭтоГруппа Тогда
				ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.ВИерархии;
			КонецЕсли;
		ИначеЕсли ОбщегоНазначенияКлиентСервер.ЕстьРеквизитИлиСвойствоОбъекта(ЗначениеПоляРасшифровки, "Родитель")
			И НЕ ЗначениеЗаполнено(ЗначениеПоляРасшифровки.Родитель) Тогда
			ПрименяемыйВидСравнения = ВидСравненияКомпоновкиДанных.ВИерархии;
		КонецЕсли;
		
	КонецЕсли;
	Возврат ПрименяемыйВидСравнения;

КонецФункции

// Заполняет колекцию элементов отбора в которых нужно выполнить замену левого поля.
//
// Параметры:
//  КартаВидовСубконто		- Соответствие - Содержит соответствие старых и новых номеров субконто см. КартаПереходаСубконтоМеждуСчетами.
//  ЭлементыОтбора			- КоллекцияЭлементовОтбораКомпоновкиДанных - Элементы отбора, из которых нужно выбрать заменяемые.
//  ЭлементыОтбораПодЗамену	- Массив - Коллекция элементов отбора, в которых нужно выполнить замену левого поля.
//  ЭлементыОтбораКУдалению	- Массив - Коллекция элементов отбора, которые нужно удалить.
//
Процедура ЗаполнитьЭлементыОтбораПодЗамену(КартаВидовСубконто, ЭлементыОтбора, ЭлементыОтбораПодЗамену, ЭлементыОтбораКУдалению)
	
	Для Каждого ЭлементОтбора Из ЭлементыОтбора Цикл
		
		Если НЕ ЭлементОтбора.Использование Тогда
			ЭлементыОтбораКУдалению.Добавить(ЭлементОтбора);
			Продолжить;
		КонецЕсли;
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ГруппаЭлементовОтбораКомпоновкиДанных") Тогда
			
			ЗаполнитьЭлементыОтбораПодЗамену(КартаВидовСубконто, ЭлементОтбора.Элементы, ЭлементыОтбораПодЗамену, ЭлементыОтбораКУдалению);
			
		Иначе
			
			ЛевоеЗначениеПуть = СтрРазделить(ЭлементОтбора.ЛевоеЗначение, ".");
			
			Если СтрНачинаетсяС(ЛевоеЗначениеПуть[0],"Субконто") Тогда
				
				НомерЗамены = КартаВидовСубконто.Получить(БухгалтерскиеОтчетыКлиентСервер.НомерСубконто(ЛевоеЗначениеПуть[0]));
				
				Если НомерЗамены = Неопределено Тогда
					Продолжить;
				ИначеЕсли НомерЗамены = 0 Тогда
					// Если прямого совпадения по виду субконто нет, 
					// то ниже попытаемся найти нужный вид субконто по типу значения отбора.
					ЭлементыОтбораПодЗамену.Добавить(ЭлементОтбора);
					
				Иначе
					
					ЭлементОтбора.ЛевоеЗначение = Новый ПолеКомпоновкиДанных(ПутьПоляСНовымНомеромСубконто(ЛевоеЗначениеПуть, НомерЗамены));
					
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
