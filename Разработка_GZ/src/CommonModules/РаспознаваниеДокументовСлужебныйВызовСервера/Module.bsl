#Область СлужебныеПроцедурыИФункции

#Область ПроверкаАвторизации

Функция ПодключеноКСервисуРаспознавания(ПринудительноИТС = Ложь) Экспорт
	
	Если ПринудительноИТС Тогда
		УстановитьПривилегированныйРежим(Истина);
		НачатьТранзакцию();
		РаспознаваниеДокументов.УдалитьДанныеАвторизации();
		РаспознаваниеДокументов.ВыполнитьАвторизациюПоТикетуИТС();
		ЗафиксироватьТранзакцию();
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	ПытатьсяПодключитьсяПриПроверке = Истина;
	ВыбрасыватьИсключение = Истина;
	
	Возврат РаспознаваниеДокументов.ПодключеноКСервисуРаспознавания(ПытатьсяПодключитьсяПриПроверке, ВыбрасыватьИсключение);
	
КонецФункции

Функция ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки() Экспорт
	
	Возврат ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
	
КонецФункции

#КонецОбласти

#Область ОбменСКонтрагентамиСлужебныйВызовСервера

// Функция проверяет доступность каталога, указанного в настройках соглашения об обмене (через каталог),
// на доступность как с клиента (т.к. выбор каталога происходит с клиента), так и с сервера (т.к. работа с файлами
// выполняется на сервере).
//
// Параметры:
//  ПутьККаталогу - строка - полный путь к каталогу, доступность которого надо проверить (с клиента и с сервера).
//
Функция ПроверитьДоступностьКаталогаДляПрямогоОбмена(ПутьККаталогу) Экспорт
	
	КаталогиДоступны = Ложь;
	Если ЗначениеЗаполнено(ПутьККаталогу) Тогда
		ПутьККаталогу = СокрЛП(ПутьККаталогу);
		УдалитьКаталогПослеТеста = Ложь;
		Каталог = Новый Файл(ПутьККаталогу);
		Если НЕ Каталог.Существует() Тогда
			УдалитьКаталогПослеТеста = Истина;
			СоздатьКаталог(ПутьККаталогу);
		КонецЕсли;
		Разделитель = ?(Прав(ПутьККаталогу, 1) = "\", "", "\");
		ТестовыйФайл = Новый ТекстовыйДокумент;
		ПолноеИмяТестовогоФайла = ПутьККаталогу + Разделитель + "EDI_" + Строка(Новый УникальныйИдентификатор) + ".tst";
		ТестовыйФайл.Записать(ПолноеИмяТестовогоФайла);
		КаталогиДоступны = ПрочитатьТестовыйФайлНаСервере(ПолноеИмяТестовогоФайла);
		Если НЕ КаталогиДоступны Тогда
			ТекстСообщения = НСтр("ru = 'Указанный каталог %1 не может использоваться для обмена, так как он не доступен с сервера.
				|Необходимо указать сетевой каталог для обмена.'");
			ТекстСообщения = СтрЗаменить(ТекстСообщения, "%1", """" + ПутьККаталогу + """");
			ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);
		КонецЕсли;
		Если УдалитьКаталогПослеТеста Тогда
			РаспознаваниеДокументов.УдалитьВременныеФайлы(Каталог.ПолноеИмя);
		Иначе
			РаспознаваниеДокументов.УдалитьВременныеФайлы(ПолноеИмяТестовогоФайла);
		КонецЕсли;
	КонецЕсли;
	
	Возврат КаталогиДоступны;
	
КонецФункции

// Функция используется для проверки доступности каталога, указанного в настройках соглашения об обмене (через каталог):
// на клиенте в каталог записывается файл, на сервере выполняется попытка прочитать его по тому же пути. Связано это с тем,
// что данный каталог должен быть доступен как с клиента, так и с сервера.
//
// Параметры:
//  ПолноеИмяТестовогоФайла - строка - полный путь к тестовому файлу записанному из клиентского сеанса.
//
// Возвращаемое значение:
//  Булево - Истина - файл по указанному пути существует, иначе - Ложь.
//
Функция ПрочитатьТестовыйФайлНаСервере(ПолноеИмяТестовогоФайла)
	
	ТестовыйФайл = Новый Файл(ПолноеИмяТестовогоФайла);
	
	Возврат ТестовыйФайл.Существует();
	
КонецФункции

#КонецОбласти

#Область Прочее

Процедура ОтправкаВложенийИзПочты(УчетнаяЗапись) Экспорт
	
	Если Не ЗначениеЗаполнено(УчетнаяЗапись) Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.РазделениеВключено() И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		КлючЗадания = "ОтправкаВложенийИзПочты" + XMLСтрока(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса());
	Иначе
		КлючЗадания = "ОтправкаВложенийИзПочты";
	КонецЕсли;
	
	ДанныеУчетнойЗаписи = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(УчетнаяЗапись, "Ссылка,ПротоколВходящейПочты");
	ПараметрыЗадания = Новый Массив();
	ПараметрыЗадания.Добавить(ДанныеУчетнойЗаписи);
	
	Задания = ФоновыеЗадания.ПолучитьФоновыеЗадания(Новый Структура("Ключ, Состояние", КлючЗадания, СостояниеФоновогоЗадания.Активно)); 
	Если Задания.Количество() <> 0 Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ФоновоеЗадание = ФоновыеЗадания.Выполнить("РаспознаваниеДокументов.ОтправитьВложенияИзПочтыНаРаспознавание", ПараметрыЗадания,
			КлючЗадания, НСтр("ru = 'Отправка вложений из почты на распознавание'"));
	Исключение
		ТекстОшибки = СтрШаблон(
			НСтр("ru = 'Невозможно выполнить фоновое задание с ключом: %1
			           |Описание ошибки:
			           |%2'"),
			КлючЗадания,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ЗаписьЖурналаРегистрации(
			РаспознаваниеДокументов.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Ошибка,,,
			ТекстОшибки);
	КонецПопытки;
	
КонецПроцедуры

Процедура ОтправкаФайловИзКаталога(ПараметрыПоиска) Экспорт
	
	Если ОбщегоНазначения.РазделениеВключено() И ОбщегоНазначения.ДоступноИспользованиеРазделенныхДанных() Тогда
		КлючЗадания = "ОтправкаФайловИзКаталога" + XMLСтрока(РаботаВМоделиСервиса.ЗначениеРазделителяСеанса());
	Иначе
		КлючЗадания = "ОтправкаФайловИзКаталога";
	КонецЕсли;
	
	ПараметрыЗадания = Новый Массив();
	ПараметрыЗадания.Добавить(ПараметрыПоиска);
	
	Задания = ФоновыеЗадания.ПолучитьФоновыеЗадания(Новый Структура("Ключ, Состояние", КлючЗадания, СостояниеФоновогоЗадания.Активно)); 
	Если Задания.Количество() <> 0 Тогда
		Возврат;
	КонецЕсли;
	
	Попытка
		ФоновоеЗадание = ФоновыеЗадания.Выполнить("РаспознаваниеДокументов.ОтправитьФайлыИзКаталогаНаРаспознавание", ПараметрыЗадания,
			КлючЗадания, НСтр("ru = 'Отправка файлов из каталога на распознавание'"));
	Исключение
		ТекстОшибки = СтрШаблон(
			НСтр("ru = 'Невозможно выполнить фоновое задание с ключом: %1
			           |Описание ошибки:
			           |%2'"),
			КлючЗадания,
			ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
		ЗаписьЖурналаРегистрации(
			РаспознаваниеДокументов.СобытиеЖурналаРегистрации(),
			УровеньЖурналаРегистрации.Ошибка,,,
			ТекстОшибки);
	КонецПопытки;
	
КонецПроцедуры

Функция ТипРаспознанногоДокумента(Ссылка) Экспорт 
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Ссылка, "ТипДокумента");
	
КонецФункции

Функция ПорогНоменклатурыДляГрупповогоСоздания() Экспорт
	
	ТекущиеНастройки = РегистрыСведений.ОбщиеНастройкиРаспознаваниеДокументов.ТекущиеНастройки();
	Возврат ТекущиеНастройки.ПорогНоменклатурыДляГрупповогоСоздания;
	
КонецФункции

Функция ФайлыРаспознанногоДокумента(РаспознанныйДокумент, ИдентификаторФормы) Экспорт
	
	УправлениеДоступом.ПроверитьЧтениеРазрешено(РаспознанныйДокумент);
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ИсходныеДанныеЗаданийРаспознаваниеДокументов.ИмяФайла КАК ИмяФайла,
		|	ИсходныеДанныеЗаданийРаспознаваниеДокументов.ИсходныйФайл КАК ИсходныйФайл,
		|	ИсходныеДанныеЗаданийРаспознаваниеДокументов.ДатаЗагрузки КАК ДатаЗагрузки,
		|	РезультатыОбработкиЗаданийРаспознаваниеДокументов.ИменаФайлов КАК ИменаФайлов
		|ИЗ
		|	РегистрСведений.РезультатыОбработкиЗаданийРаспознаваниеДокументов КАК РезультатыОбработкиЗаданийРаспознаваниеДокументов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ИсходныеДанныеЗаданийРаспознаваниеДокументов КАК ИсходныеДанныеЗаданийРаспознаваниеДокументов
		|		ПО РезультатыОбработкиЗаданийРаспознаваниеДокументов.ИдентификаторФайла = ИсходныеДанныеЗаданийРаспознаваниеДокументов.ИдентификаторФайла
		|ГДЕ
		|	РезультатыОбработкиЗаданийРаспознаваниеДокументов.ИдентификаторРезультата = &ИдентификаторРезультата";
	
	Запрос.УстановитьПараметр("ИдентификаторРезультата", РаспознанныйДокумент.ИдентификаторРезультата);
	
	РезультатЗапроса = Запрос.Выполнить();
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Результат = Новый Массив;
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ИмяФайла = ВыборкаДетальныеЗаписи.ИмяФайла;
		ДвоичныеДанные = ВыборкаДетальныеЗаписи.ИсходныйФайл.Получить();
		АдресХранилища = ПоместитьВоВременноеХранилище(ДвоичныеДанные, ИдентификаторФормы);
		
		ОписаниеФайла = Новый ОписаниеПередаваемогоФайла(ИмяФайла, АдресХранилища);
		
		Результат.Добавить(ОписаниеФайла);
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Результат;
	
КонецФункции

Функция КоличествоФайловРаспознанногоДокумента(РаспознанныйДокумент) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	КОЛИЧЕСТВО(ИсходныеДанныеЗаданийРаспознаваниеДокументов.ИдентификаторФайла) КАК КоличествоФайлов
		|ИЗ
		|	РегистрСведений.РезультатыОбработкиЗаданийРаспознаваниеДокументов КАК РезультатыОбработкиЗаданийРаспознаваниеДокументов
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ РегистрСведений.ИсходныеДанныеЗаданийРаспознаваниеДокументов КАК ИсходныеДанныеЗаданийРаспознаваниеДокументов
		|		ПО РезультатыОбработкиЗаданийРаспознаваниеДокументов.ИдентификаторФайла = ИсходныеДанныеЗаданийРаспознаваниеДокументов.ИдентификаторФайла
		|			И (РезультатыОбработкиЗаданийРаспознаваниеДокументов.ИдентификаторРезультата = &ИдентификаторРезультата)";
	
	Запрос.УстановитьПараметр("ИдентификаторРезультата", РаспознанныйДокумент.ИдентификаторРезультата);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Возврат Выборка.КоличествоФайлов;
	
КонецФункции

Функция ЭтоНоменклатураУслуга(Объект) Экспорт
	
	Возврат ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект, "Услуга")
	
КонецФункции

#КонецОбласти

#Область УправлениеДоступом

Функция ДоступенНеоплаченныйРаспознанныйДокумент(РаспознанныйДокумент) Экспорт
	
	Если Не Пользователи.ЭтоПолноправныйПользователь() Тогда
		ДанныеДокумента = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(РаспознанныйДокумент, "Статус, ТребуетсяОплата, Ответственный", Истина);
		Если ЗначениеЗаполнено(ДанныеДокумента) И (ДанныеДокумента.ТребуетсяОплата
			ИЛИ ДанныеДокумента.Статус = Перечисления.СтатусыСозданныхДокументовРаспознаваниеДокументов.Ошибка)
			И Пользователи.ТекущийПользователь() <> ДанныеДокумента.Ответственный Тогда
			
			Возврат Ложь;
		КонецЕсли;
	КонецЕсли;
	
	// Другие случаи должно проверить RLS
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область Комплекты

Функция ПолучитьПараметрыОткрытияФормы(ДокументСсылка, Знач ВидОперации, Знач ТипДокументаСтрокой) Экспорт
	
	ДокументОбъект = ДокументСсылка.ПолучитьОбъект();
	
	ПараметрыЗаполнения = Новый Структура();
	ПараметрыЗаполнения.Вставить("Основание", ДокументОбъект.Ссылка);
	ПараметрыЗаполнения.Вставить("ВидОперации", ВидОперации);
	ПараметрыЗаполнения.Вставить("НомерВходящегоДокумента", ДокументОбъект.РеквизитыДокумента[0].Значение);
	ПараметрыЗаполнения.Вставить("ДатаВходящегоДокумента", ДокументОбъект.РеквизитыДокумента[1].Значение);
	
	Если ДокументОбъект.ТипДокумента = Перечисления.ТипыДокументовРаспознаваниеДокументов.СчетФактура
		ИЛИ ДокументОбъект.ТипДокумента = Перечисления.ТипыДокументовРаспознаваниеДокументов.УПД Тогда
		
		ПараметрыЗаполнения.Вставить("НомерВходящегоДокументаСчетаФактуры", ДокументОбъект.РеквизитыДокумента[0].Значение);
		ПараметрыЗаполнения.Вставить("ДатаВходящегоДокументаСчетаФактуры", ДокументОбъект.РеквизитыДокумента[1].Значение);
		
	КонецЕсли;
	
	ПараметрыЗаполнения.Вставить("Дата", ДокументОбъект.РеквизитыДокумента[1].Значение);
	ПараметрыЗаполнения.Вставить("ДоговорКонтрагента", ДокументОбъект.РеквизитыДокумента[6].Значение);
	
	Для Каждого ДанныеРеквизита Из ДокументОбъект.РеквизитыДокумента Цикл
		ПараметрыЗаполнения.Вставить(ДанныеРеквизита.ИмяРеквизита, ДанныеРеквизита.Значение);
	КонецЦикла;
	
	Если ТипДокументаСтрокой = "ПоступлениеТоваровУслуг" Тогда
		ПараметрыЗаполнения.Вставить("Организация", ПараметрыЗаполнения.ПокупательОрганизация);
		ПараметрыЗаполнения.Вставить("Контрагент", ПараметрыЗаполнения.Продавец);
		
		ОтражениеВУСН = ПоступлениеТоваровУслугФормыКлиентСервер.ОтражениеВУСН(ВидОперации, Ложь);
	Иначе
		ПараметрыЗаполнения.Вставить("Организация", ПараметрыЗаполнения.ПродавецОрганизация);
		ПараметрыЗаполнения.Вставить("Контрагент", ПараметрыЗаполнения.Покупатель);
		
		ПараметрыЗаполнения.Вставить("Номер", ДокументОбъект.РеквизитыДокумента[0].Значение);
	КонецЕсли;
	
	СтрокиТаблицыТовары = Новый Массив;
	СтрокиТаблицыУслуги = Новый Массив;
	
	ТаблицаДокумента = РаспознаваниеДокументовСлужебный.ЗаполненнаяТаблицаДокумента(ДокументОбъект);
	КолонкиТаблицы = ТаблицаДокумента.Колонки;
	Для Каждого СтрокаТаблицыДокумента Из ТаблицаДокумента Цикл
		ДанныеСтрокиТаблицы = Новый Структура();
		Для Каждого Колонка Из КолонкиТаблицы Цикл
			Если Колонка.Имя = "ЕдиницаИзмерения" Тогда
				ДанныеСтрокиТаблицы.Вставить(Колонка.Имя,
					ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СтрокаТаблицыДокумента.Номенклатура, "ЕдиницаИзмерения"));
			Иначе
				ДанныеСтрокиТаблицы.Вставить(Колонка.Имя, СтрокаТаблицыДокумента[Колонка.Имя]);
			КонецЕсли;
		КонецЦикла;
		
		Если ТипДокументаСтрокой = "ПоступлениеТоваровУслуг" Тогда
			ДанныеСтрокиТаблицы.Вставить("ОтражениеВУСН", ОтражениеВУСН);
		КонецЕсли;
		
		Если СтрокаТаблицыДокумента.Номенклатура.Услуга Тогда
			СтрокиТаблицыУслуги.Добавить(ДанныеСтрокиТаблицы);
		Иначе
			ДанныеСтрокиТаблицы.Вставить("Коэффициент", 1);
			СтрокиТаблицыТовары.Добавить(ДанныеСтрокиТаблицы);
		КонецЕсли;
	КонецЦикла;
	
	ПараметрыЗаполнения.Вставить("Товары", СтрокиТаблицыТовары);
	ПараметрыЗаполнения.Вставить("Услуги", СтрокиТаблицыУслуги);
	
	Если ПараметрыЗаполнения.Основание.ТипДокумента = Перечисления.ТипыДокументовРаспознаваниеДокументов.СчетФактура
		ИЛИ ПараметрыЗаполнения.Основание.ТипДокумента = Перечисления.ТипыДокументовРаспознаваниеДокументов.УПД Тогда
		
		ПараметрыЗаполнения.Вставить("СуммаВключаетНДС", Ложь);
		
	ИначеЕсли ПараметрыЗаполнения.Свойство("ИтогоВсего")
		И ПараметрыЗаполнения.Свойство("ИтогоСумма") Тогда
		
		Если ПараметрыЗаполнения.ИтогоВсего <> 0
			И ПараметрыЗаполнения.ИтогоСумма <> 0 Тогда
			
			ПараметрыЗаполнения.Вставить("СуммаВключаетНДС", (ПараметрыЗаполнения.ИтогоВсего = ПараметрыЗаполнения.ИтогоСумма));
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат ПараметрыЗаполнения;
	
КонецФункции

Функция ЗапрещеноСозданиеДокументаВЗакрытомПериоде(Знач ТипДокументаСтрокой, Знач ДатаДокумента) Экспорт
	
	ПроверяемыйДокумент = Документы[ТипДокументаСтрокой].СоздатьДокумент();
	ПроверяемыйДокумент.Дата = ДатаДокумента;
	РедактированиеЗапрещено = ДатыЗапретаИзменения.ИзменениеЗапрещено(ПроверяемыйДокумент);
	
	Возврат РедактированиеЗапрещено;
	
КонецФункции

Функция СоздатьДокументыИзКомплекта(ПараметрыСоздания) Экспорт
	
	ТипДокументаСтрокой = ПараметрыСоздания.ТипДокументаСтрокой;
	ПараметрыЗаполнения = ПараметрыСоздания.ПараметрыЗаполнения;
	
	ДокументТорг12АктОбъект = ПараметрыСоздания.Ссылка.ПолучитьОбъект();
	ДокументТорг12АктОбъект.Статус = Перечисления.СтатусыСозданныхДокументовРаспознаваниеДокументов.Обработан;
	
	ДокументСФОбъект = ПараметрыСоздания.РаспознанныйДокументСФ.ПолучитьОбъект();
	ДокументСФОбъект.Статус = Перечисления.СтатусыСозданныхДокументовРаспознаваниеДокументов.Обработан;
	
	СчетФактураСсылка = Неопределено;
	
	Результат = Новый Структура;
	Результат.Вставить("СоздаваемыйДокумент", Неопределено);
	Результат.Вставить("УдалосьПровести", Ложь);
	Результат.Вставить("ОшибкиПроведения", Новый Соответствие);
	
	Если ДокументТорг12АктОбъект.Направление = Перечисления.НаправленияРаспознанногоДокумента.Входящий Тогда
		СтрокаТипДокумента = НСтр("ru = 'Комплект поступления'");
		ВОтКонтрагента = СтрШаблон(НСтр("ru = 'от ""%1""'"), СокрЛП(ДокументТорг12АктОбъект.Контрагент));
	Иначе
		СтрокаТипДокумента = НСтр("ru = 'Комплект реализации'");
		ВОтКонтрагента = СтрШаблон(НСтр("ru = 'в ""%1""'"), СокрЛП(ДокументТорг12АктОбъект.Контрагент));
	КонецЕсли;
	
	//ТекстКомплектНеСоздан = СтрШаблон(НСтр("ru = '%1 от %2 %3 не создан.'"),
	//	СтрокаТипДокумента,
	//	ДокументТорг12АктОбъект.ДатаДокумента,
	//	ВОтКонтрагента);
	
	УдалосьПровести = Ложь;
	ОбщийТекстОшибки = НСтр("ru = 'Исправьте ошибки заполнения документов комплекта или обработайте их по отдельности.'");
	НачатьТранзакцию();
	Попытка
		ОбрабатываемыйДокумент = ДокументТорг12АктОбъект.Ссылка;
		Если ЗначениеЗаполнено(ПараметрыСоздания.СозданныйДокументТорг12Акт) Тогда
			СоздаваемыйДокумент = ПараметрыСоздания.СозданныйДокументТорг12Акт;
		ИначеЕсли ПараметрыСоздания.СоздатьДокументПоступлениеРеализация Тогда
			СоздаваемыйДокумент = РаспознаваниеДокументовСлужебный.СоздатьДокументНаОснованииРаспознанного(ПараметрыСоздания.Ссылка, ТипДокументаСтрокой, ПараметрыЗаполнения);
			СоздаваемыйДокументОбъект = СоздаваемыйДокумент.ПолучитьОбъект();
			
			Если Не СоздаваемыйДокументОбъект.ПроверитьЗаполнение() Тогда
				ВызватьИсключение ОбщийТекстОшибки;
			КонецЕсли;
			
			РаспознаваниеДокументовПереопределяемый.ПриПроведенииДокументаНаОснованииРаспознанного(СоздаваемыйДокументОбъект);
			СоздаваемыйДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
		Иначе
			Возврат Результат;
		КонецЕсли;
		
		// Изменения в документах "Распознанный документ"
		ДокументТорг12АктОбъект.Записать();
		
		// Уже сделано в РаспознаваниеДокументовСлужебный.СоздатьДокументНаОснованииРаспознанного
		//РегистрыСведений.СвязанныеОбъектыРаспознаниеДокументов.ЗаписатьЗначения(СоздаваемыйДокумент, ПараметрыСоздания.Ссылка, Ложь);
		
		ОбрабатываемыйДокумент = СоздаваемыйДокумент;
		Если Не ПараметрыСоздания.СканПрикрепленТорг12Акт И ПараметрыСоздания.ПрикрепитьСканКПоступлениюРеализации Тогда
			АдресКартинки = ПоместитьВоВременноеХранилище(ДокументТорг12АктОбъект.ИсходноеИзображение.Получить());
			РаспознаваниеДокументовСлужебный.ДобавитьПрисоединенныйФайл(ДокументТорг12АктОбъект, СоздаваемыйДокумент, АдресКартинки);
		КонецЕсли;
		
		ОбрабатываемыйДокумент = ДокументСФОбъект.Ссылка;
		Если ЗначениеЗаполнено(ПараметрыСоздания.СозданныйДокументСФ) Тогда
			СчетФактураСсылка = ПараметрыСоздания.СозданныйДокументСФ;
		ИначеЕсли ПараметрыСоздания.СоздатьДокументСчетФактура Тогда
			
			ПараметрыЗаполнения.Вставить("НомерВходящегоДокумента", ДокументСФОбъект.НомерДокумента);
			ПараметрыЗаполнения.Вставить("ДатаВходящегоДокумента", ДокументСФОбъект.ДатаДокумента);
			
			ПараметрыСозданияСФ = Новый Структура;
			ПараметрыСозданияСФ.Вставить("ТипДокументаСтрокой", ТипДокументаСтрокой);
			ПараметрыСозданияСФ.Вставить("Основание", СоздаваемыйДокумент);
			ПараметрыСозданияСФ.Вставить("ПараметрыЗаполнения", ПараметрыЗаполнения);
			
			РаспознаваниеДокументовПереопределяемый.ПриСозданииСчетФактуры(ПараметрыСозданияСФ, СчетФактураСсылка);
			
			Если СчетФактураСсылка = Неопределено Тогда
				ВызватьИсключение ОбщийТекстОшибки;
			КонецЕсли;
		КонецЕсли;
		
		Если СчетФактураСсылка <> Неопределено Тогда
			// Изменения в документах "Распознанный документ"
			ДокументСФОбъект.Записать();
			
			ОбрабатываемыйДокумент = СчетФактураСсылка;
			РегистрыСведений.СвязанныеОбъектыРаспознаниеДокументов.ЗаписатьЗначения(СчетФактураСсылка, ПараметрыСоздания.Ссылка, Ложь);
			РегистрыСведений.СвязанныеОбъектыРаспознаниеДокументов.ЗаписатьЗначения(СчетФактураСсылка, ПараметрыСоздания.РаспознанныйДокументСФ, Ложь);
			
			Если Не ПараметрыСоздания.СканПрикрепленСФ И ПараметрыСоздания.ПрикрепитьСканКСчетуФактуре Тогда
				АдресКартинки = ПоместитьВоВременноеХранилище(ДокументСФОбъект.ИсходноеИзображение.Получить());
				РаспознаваниеДокументовСлужебный.ДобавитьПрисоединенныйФайл(ДокументСФОбъект, СчетФактураСсылка, АдресКартинки);
			КонецЕсли;
		КонецЕсли;
		
		УдалосьПровести = Истина;
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		
		СообщенияОбОшибках = Новый Массив(ПолучитьСообщенияПользователю(Истина));
		ПредставлениеОшибки = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
		
		Если ПредставлениеОшибки <> ОбщийТекстОшибки Тогда
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
			СообщенияОбОшибках.Вставить(0, Сообщение);
		КонецЕсли;
		Результат.ОшибкиПроведения.Вставить(ОбрабатываемыйДокумент, СообщенияОбОшибках);
		
		Возврат Результат;
	КонецПопытки;
	
	Если ЗначениеЗаполнено(СоздаваемыйДокумент) Тогда
		ДанныеСозданногоТорг12Акт = ПолучитьОбратнуюСвязьДляСозданногоДокумента(ДокументТорг12АктОбъект, СоздаваемыйДокумент);
		Если Не ЗначениеЗаполнено(ПараметрыСоздания.СозданныйДокументТорг12Акт)
			И ПараметрыСоздания.СоздатьДокументПоступлениеРеализация Тогда
			
			Пакет = Новый Структура;
			Пакет.Вставить("created", ДанныеСозданногоТорг12Акт);
			РаспознаваниеДокументовКоннекторСлужебный.ПередатьОбратнуюСвязь(ДокументТорг12АктОбъект.ИдентификаторРезультата, Пакет);
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СчетФактураСсылка) Тогда
		ДанныеСозданнойСФ = ПолучитьОбратнуюСвязьДляСозданногоДокумента(ДокументСФОбъект, СчетФактураСсылка);
		Если Не ЗначениеЗаполнено(ПараметрыСоздания.СозданныйДокументСФ)
			И ПараметрыСоздания.СоздатьДокументСчетФактура Тогда
			
			Пакет = Новый Структура;
			Пакет.Вставить("created", ДанныеСозданнойСФ);
			РаспознаваниеДокументовКоннекторСлужебный.ПередатьОбратнуюСвязь(ДокументСФОбъект.ИдентификаторРезультата, Пакет);
		КонецЕсли;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(СоздаваемыйДокумент) И ЗначениеЗаполнено(СчетФактураСсылка) Тогда
		ТипыДокументовВСервисе = РаспознаваниеДокументовСлужебныйКлиентСервер.ПолучитьОбратноеСоответствие(Документы.РаспознанныйДокумент.СоответствиеТиповДокументовВСервисеИБРД());
		set_id = Строка(Новый УникальныйИдентификатор);
		
		ДанныеСозданногоТорг12Акт.Удалить("Статус");
		ДанныеСозданногоТорг12Акт.Вставить("set_id", set_id);
		ДанныеСозданногоТорг12Акт.Вставить("doc_uuid", ДокументТорг12АктОбъект.ИдентификаторРезультата);
		ДанныеСозданногоТорг12Акт.Вставить("ТипДокумента", ТипыДокументовВСервисе.Получить(ДокументТорг12АктОбъект.ТипДокумента));
		ДанныеСозданногоТорг12Акт.Вставить("ОсновнойДокумент", Истина);
		ДанныеСозданнойСФ.Удалить("Статус");
		ДанныеСозданнойСФ.Вставить("set_id", set_id);
		ДанныеСозданнойСФ.Вставить("doc_uuid", ДокументСФОбъект.ИдентификаторРезультата);
		ДанныеСозданнойСФ.Вставить("ТипДокумента", ТипыДокументовВСервисе.Получить(ДокументСФОбъект.ТипДокумента));
		ДанныеСозданнойСФ.Вставить("ОсновнойДокумент", Ложь);
		
		ДанныеПакета = Новый Массив;
		
		Если ПараметрыСоздания.ДанныеОбработки <> Неопределено
			И ПараметрыСоздания.Свойство("НомерКомплекта") Тогда
			
			ДанныеКомплекта = ПараметрыСоздания.ДанныеОбработки.РезультатОбратнойСвязи.Комплекты.Получить(ПараметрыСоздания.НомерКомплекта);
			Для Каждого КлючЗначение Из ДанныеКомплекта Цикл
				Если ДокументТорг12АктОбъект.Ссылка = КлючЗначение.Ключ Тогда
					ДанныеСозданногоТорг12Акт.Вставить("Действие", КлючЗначение.Значение);
					
					ДанныеПакета.Добавить(ДанныеСозданногоТорг12Акт);
				ИначеЕсли ДокументСФОбъект.Ссылка = КлючЗначение.Ключ Тогда
					ДанныеСозданнойСФ.Вставить("Действие", КлючЗначение.Значение);
					
					ДанныеПакета.Добавить(ДанныеСозданнойСФ);
				Иначе
					ДопРаспознанныеДанные = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(КлючЗначение.Ключ,
						"Номер, Направление, ТипДокумента, НомерДокумента, ДатаДокумента, СуммаДокумента, Контрагент, Организация, ИдентификаторРезультата");
					ДопДанныеПакета = ПолучитьОбратнуюСвязьДляСозданногоДокумента(ДокументТорг12АктОбъект);
					ДопДанныеПакета.Удалить("Статус");
					ДопДанныеПакета.Вставить("set_id", set_id);
					ДопДанныеПакета.Вставить("doc_uuid", ДопРаспознанныеДанные.ИдентификаторРезультата);
					ДопДанныеПакета.Вставить("ТипДокумента", ТипыДокументовВСервисе.Получить(ДопРаспознанныеДанные.ТипДокумента));
					ДопДанныеПакета.Вставить("ОсновнойДокумент", Ложь);
					ДопДанныеПакета.Вставить("Действие", КлючЗначение.Значение);
					
					ДанныеПакета.Добавить(ДопДанныеПакета);
				КонецЕсли;
			КонецЦикла;
			
			Если ПараметрыСоздания.ДанныеОбработки.ГрупповаяОбработка Тогда
				ОбратнаяСвязь = ПараметрыСоздания.ДанныеОбработки.РезультатОбратнойСвязи.Отправить;
				Если Не ЗначениеЗаполнено(ОбратнаяСвязь) Тогда
					ОбратнаяСвязь.Вставить("ИдентификаторРезультата", ДокументТорг12АктОбъект.ИдентификаторРезультата);
					ОбратнаяСвязь.Вставить("ДанныеПакета", ДанныеПакета);
				Иначе
					Для Каждого ЧастьПакета Из ДанныеПакета Цикл
						ОбратнаяСвязь.ДанныеПакета.Добавить(ЧастьПакета);
					КонецЦикла;
				КонецЕсли;
			Иначе
				Пакет = Новый Структура;
				Пакет.Вставить("set_creation", ДанныеПакета);
				РаспознаваниеДокументовКоннекторСлужебный.ПередатьОбратнуюСвязь(ДокументТорг12АктОбъект.ИдентификаторРезультата, Пакет);
			КонецЕсли;
		Иначе
			ДанныеСозданногоТорг12Акт.Вставить("Действие", "ДобавленАвтоматически");
			ДанныеСозданнойСФ.Вставить("Действие", "ДобавленАвтоматически");
			
			ДанныеПакета.Добавить(ДанныеСозданногоТорг12Акт);
			ДанныеПакета.Добавить(ДанныеСозданнойСФ);
			
			Пакет = Новый Структура;
			Пакет.Вставить("set_creation", ДанныеПакета);
			РаспознаваниеДокументовКоннекторСлужебный.ПередатьОбратнуюСвязь(ДокументТорг12АктОбъект.ИдентификаторРезультата, Пакет);
		КонецЕсли;
	КонецЕсли;
	
	Результат = Новый Структура;
	Результат.Вставить("СоздаваемыйДокумент", СоздаваемыйДокумент);
	Результат.Вставить("УдалосьПровести", УдалосьПровести);
	Если СчетФактураСсылка <> Неопределено Тогда
		Результат.Вставить("СоздаваемаяСчетФактура", СчетФактураСсылка);
	КонецЕсли;
	
	Если Результат.УдалосьПровести
		И ПараметрыСоздания.ДанныеОбработки <> Неопределено
		И ПараметрыСоздания.Свойство("НомерКомплекта") Тогда
		
		ПараметрыСоздания.ДанныеОбработки.НомераСозданныхКомплектов.Добавить(ПараметрыСоздания.НомерКомплекта);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ПолучитьОбратнуюСвязьДляСозданногоДокумента(ДокументОбъект, СоздаваемыйДокумент = Неопределено) Экспорт
	
	Результат = РаспознаваниеДокументов.ОписаниеОбратнойСвязи("Проведен");
	Если СоздаваемыйДокумент = Неопределено Тогда
		Результат.IdСозданногоДокумента = "";
	Иначе
		Результат.IdСозданногоДокумента = Строка(СоздаваемыйДокумент.УникальныйИдентификатор());
	КонецЕсли;
	Результат.НомерРаспознанногоДокумента = ДокументОбъект.Номер;
	Результат.ЭтоВходящийДокумент = (ДокументОбъект.Направление = Перечисления.НаправленияРаспознанногоДокумента.Входящий);
	Результат.НомерДокумента = ДокументОбъект.НомерДокумента;
	Результат.ДатаДокумента = ДокументОбъект.ДатаДокумента;
	Результат.СуммаДокумента = ДокументОбъект.СуммаДокумента;
	Результат.Контрагент = РаспознаваниеДокументов.УбратьОрганизационнуюФорму(ДокументОбъект.Контрагент);
	Результат.Организация = РаспознаваниеДокументов.УбратьОрганизационнуюФорму(ДокументОбъект.Организация);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти

#КонецОбласти