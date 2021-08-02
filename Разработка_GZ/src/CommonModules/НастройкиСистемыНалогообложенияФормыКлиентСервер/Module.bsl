
////////////////////////////////////////////////////////////////////////////////
// Универсальные методы для формы записи регистра и формы настройки налогов
//
// Клиент-серверные методы формы записи регистра сведений НастройкиСистемыНалогообложения
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура УправлениеФормой(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Запись   = Форма.НастройкиСистемыНалогообложения;
	
	Период = ПолучитьПериодФормы(Форма);
	
	СистемаНалогообложения = СистемаНалогообложенияПоИндексу(Форма.СистемаНалогообложенияПредставление);
	
	Элементы.ГруппаЕНВД.Видимость = ДопускаетсяСовмещениеСЕНВД(СистемаНалогообложения)
		И Период < УчетЕНВДКлиентСервер.ДатаОтменыЕНВД();
	Элементы.ГруппаПатент.Видимость = Не Форма.ЭтоЮрЛицо И ДопускаетсяСовмещениеСПатентом(СистемаНалогообложения);
	Элементы.ГруппаТорговыйСбор.Видимость = ОблагаетсяТорговымСбором(СистемаНалогообложения);
	Элементы.ГруппаСпецрежим.Видимость = Элементы.ГруппаЕНВД.Видимость
		Или Элементы.ГруппаПатент.Видимость
		Или Элементы.ГруппаТорговыйСбор.Видимость;
	
	Элементы.ГруппаПереходНаУСН.Видимость = (СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"));
	Элементы.ДатаПереходаНаУСН.Доступность = Форма.ПоложенияПереходногоПериодаУСН;
	Элементы.ДатаПереходаНаУСН.АвтоОтметкаНезаполненного = Форма.ПоложенияПереходногоПериодаУСН;
	
	Элементы.СистемаНалогообложенияТолькоЕНВДПредставление.Видимость = Форма.ПрименяетсяТолькоЕНВДПослеОтменыНаМоментОткрытия
		И Период >= УчетЕНВДКЛиентСервер.ДатаОтменыЕНВД();
	Элементы.ГруппаПредупреждениеЕНВД.Видимость = ПрименяетсяТолькоЕНВДПослеОтмены(Форма);
	
	Элементы.ПредупреждениеЕНВДУказатьДействующуюСистему.Видимость = Форма.ПравоРедактированияНастроек;
	Элементы.ПредупреждениеЕНВДОбратитесьКСотруднику.Видимость = НЕ Форма.ПравоРедактированияНастроек;
	
КонецПроцедуры

Процедура ЗаполнитьСписокВыбораСистемНалогообложения(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Запись   = Форма.НастройкиСистемыНалогообложения;
	
	Период = ПолучитьПериодФормы(Форма);
	
	СписокВыбора = Элементы.СистемаНалогообложенияПредставление.СписокВыбора;
	
	СписокВыбора.Очистить();
	
	СписокВыбора.Добавить(
				ИндексСистемыНалогообложения(
					ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"),
					,
					,
					ПредопределенноеЗначение("Перечисление.ОбъектыНалогообложенияПоУСН.Доходы")),
				НСтр("ru = 'Упрощенная (доходы)'"));
				
	СписокВыбора.Добавить(
				ИндексСистемыНалогообложения(
					ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"),
					,
					,
					ПредопределенноеЗначение("Перечисление.ОбъектыНалогообложенияПоУСН.ДоходыМинусРасходы")),
				НСтр("ru = 'Упрощенная (доходы минус расходы)'"));
				
	Если Не Форма.ЭтоЮрЛицо Тогда
		
		Если ТарификацияБПВызовСервераПовтИсп.РазрешенУчетРегулярнойДеятельности() Тогда
			
			СписокВыбора.Добавить(
				ИндексСистемыНалогообложения(
					ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.ОсобыйПорядок"),
					Истина,
					Ложь),
				НСтр("ru = 'Только патент'"));
				
			Если Период < УчетЕНВДКлиентСервер.ДатаОтменыЕНВД() Тогда
				СписокВыбора.Добавить(
						ИндексСистемыНалогообложения(
							ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.ОсобыйПорядок"),
							Ложь,
							Истина),
						НСтр("ru = 'Только ЕНВД (до конца 2020 года)'"));
			КонецЕсли;
			
			СписокВыбора.Вставить(
				0, ИндексСистемыНалогообложения(ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.НалогНаПрофессиональныйДоход")),
				НСтр("ru = 'Налог на профессиональный доход (""самозанятые"")'"));
			
		КонецЕсли;
		
	КонецЕсли;
	
	СписокВыбора.Добавить(
				ИндексСистемыНалогообложения(
					ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Общая")),
				НСтр("ru = 'Общая'"));
	
КонецПроцедуры

Процедура УстановитьСистемуНалогообложения(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	СписокВыбора = Элементы.СистемаНалогообложенияПредставление.СписокВыбора;
	
	Если СписокВыбора.НайтиПоЗначению(Форма.СистемаНалогообложенияПредставление) = Неопределено Тогда
		Форма.СистемаНалогообложенияПредставление = СписокВыбора[0].Значение;
	КонецЕсли;
	
КонецПроцедуры

Функция ИндексСистемыНалогообложения(СистемаНалогообложения, ПрименяетсяУСНПатент = Ложь, ПлательщикЕНВД = Ложь, ОбъектНалогообложенияУСН = Неопределено) Экспорт
	
	Индекс = 5; // Общая
	
	Если СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная") Тогда
		Если ОбъектНалогообложенияУСН = ПредопределенноеЗначение("Перечисление.ОбъектыНалогообложенияПоУСН.Доходы") Тогда
			Индекс = 1;
		Иначе
			Индекс = 2;
		КонецЕсли;
	ИначеЕсли СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.ОсобыйПорядок") Тогда
		Если ПлательщикЕНВД Тогда
			Индекс = 4;
		ИначеЕсли ПрименяетсяУСНПатент Тогда
			Индекс = 3;
		КонецЕсли;
	ИначеЕсли СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.НалогНаПрофессиональныйДоход") Тогда
		Индекс = 0;
	КонецЕсли;
	
	Возврат Индекс;
	
КонецФункции

Функция СистемаНалогообложенияПоИндексу(Индекс) Экспорт
	
	Если Индекс = 0 Тогда
		СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.НалогНаПрофессиональныйДоход");
	ИначеЕсли Индекс = 1 Или Индекс = 2 Тогда
		СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная");
	ИначеЕсли Индекс = 3 Или Индекс = 4 Тогда
		СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.ОсобыйПорядок");
	ИначеЕсли Индекс = 5 Тогда
		СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Общая");
	Иначе
		СистемаНалогообложения = Неопределено;
	КонецЕсли;
	
	Возврат СистемаНалогообложения;
	
КонецФункции

Процедура СброситьПризнакПлательщикЕНВД(Форма) Экспорт
	
	Период = ПолучитьПериодФормы(Форма);
	
	Если Период >= УчетЕНВДКлиентСервер.ДатаОтменыЕНВД() Тогда
		Форма.НастройкиСистемыНалогообложения.ПлательщикЕНВД = Ложь;
	КонецЕсли;
	
КонецПроцедуры

Функция ПрименяетсяТолькоЕНВДПослеОтмены(Форма) Экспорт
	
	Запись = Форма.НастройкиСистемыНалогообложения;
	Период = ПолучитьПериодФормы(Форма);
	
	Возврат Запись.ПрименяетсяОсобыйПорядокНалогообложения
		И Запись.ПлательщикЕНВД
		И Период >= УчетЕНВДКЛиентСервер.ДатаОтменыЕНВД();
	
КонецФункции

Функция ДопускаетсяСовмещениеСЕНВД(СистемаНалогообложения)
	
	Возврат (СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Общая")
		Или СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"));
	
КонецФункции

Функция ДопускаетсяСовмещениеСПатентом(СистемаНалогообложения)
	
	Возврат (СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Общая")
		Или СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"));
	
КонецФункции

Функция ОблагаетсяТорговымСбором(СистемаНалогообложения)
	
	Возврат (СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Общая")
		Или СистемаНалогообложения = ПредопределенноеЗначение("Перечисление.СистемыНалогообложения.Упрощенная"));
	
КонецФункции

Функция ПолучитьПериодФормы(Форма) Экспорт
	
	Если Форма.ИмяФормы = "ОбщаяФорма.НалогиИОтчеты" Тогда
		Возврат Форма.ДатаИзменения;
	Иначе
		Возврат Форма.НастройкиСистемыНалогообложения.Период;
	КонецЕсли;
	
КонецФункции

#КонецОбласти