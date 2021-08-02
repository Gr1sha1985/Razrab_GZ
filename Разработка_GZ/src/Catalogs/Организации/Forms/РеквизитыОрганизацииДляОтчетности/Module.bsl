
// Форма предназначена только для записанного элемента справочника.
// Форма не предназначена для обособленных подразделений.

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	// Первоначальная настройка формы
	ОрганизацииФормыДляОтчетности.НастроитьЭлементыКонтактнойИнформации(ЭтотОбъект);
	ОрганизацииФормыДляОтчетности.НастроитьЭлементыСистемыНалогообложения(УсловноеОформление);
	
	НастроитьСвойстваЭлементовФИОРуководителя();
	
	ОрганизацииФормыДляОтчетности.УстановитьПроверяемыеДанные(
		Объект.Ссылка,
		Параметры.ПроверяемыеРеквизиты,
		Параметры.Контекст,
		АдресПроверяемыеДанные,
		УникальныйИдентификатор);
	ОрганизацииФормыДляОтчетности.НастроитьПроверяемыеРеквизиты(ЭтотОбъект, АдресПроверяемыеДанные);
	
	// В форму могли передать данные для заполнения.
	Если Параметры.Свойство("ПоискИННОтвет") Тогда
		
		Объект.ЮридическоеФизическоеЛицо = Перечисления.ЮридическоеФизическоеЛицо.ЮридическоеЛицо;
		
		ЗаполнитьДаннымиЕГР(Параметры.ПоискИННОтвет);
		
		ПроверитьИНН(ПояснениеНекорректныйИНН, Объект.ИНН, Объект.КПП);
		
	КонецЕсли;
		
	ОрганизацииФормыДляОтчетностиКлиентСервер.УстановитьВидимостьПодсказкиОКВЭД2(ЭтотОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	НаименованиеСокращенноеДоИзменения = Объект.НаименованиеСокращенное;
	
	НастроитьКомандыАвтозаполнения();
	
	УправлениеКонтактнойИнформацией.ПриЧтенииНаСервере(ЭтотОбъект, Объект);
	
	ОрганизацииФормыДляОтчетности.ПрочитатьСистемуНалогообложения(СистемаНалогообложенияПредставление, Объект.Ссылка);
	
	ОрганизацииФормыДляОтчетности.ПрочитатьДанныеНалоговогоОргана(
		Объект.РегистрацияВНалоговомОргане,
		ЭтотОбъект,
		ПоляРегистрацииВНалоговомОргане());
	
	ПроверитьИНН(ПояснениеНекорректныйИНН, Объект.ИНН, Объект.КПП);
	ПояснениеНекорректныйКодПоОКТМО = ОрганизацииФормыДляОтчетностиКлиентСервер.ПроверитьКодПоОКТМО(КодПоОКТМО);

	ПрочитатьДанныеРуководителя();
	
	ОрганизацииФормыДляОтчетностиКлиентСервер.УстановитьВидимостьПодсказкиОКВЭД2(ЭтотОбъект);
	
	ОрганизацииФормыДляОтчетностиКлиентСервер.УстановитьЗаголовокФормы(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)

	Если Источник = ЭтотОбъект Тогда
		Возврат;
	КонецЕсли;

	Если ИмяСобытия = "ИзменениеОтветственныхЛиц" Тогда
		
		ПрочитатьДанныеРуководителя();

	КонецЕсли;

КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)

	Если Не ЗначениеЗаполнено(РуководительФизЛицо) Тогда
		
		ХранилищеПроверяемыеДанные = АдресПроверяемыеДанные;
		
	ИначеЕсли ЭтоАдресВременногоХранилища(АдресПроверяемыеДанные) Тогда
		
		// Нужно исключить из проверяемых данных части имени, так как они заведомо заполнены в составе РуководительФизЛицо
		ХранилищеПроверяемыеДанные = ПолучитьИзВременногоХранилища(АдресПроверяемыеДанные);
		Если ТипЗнч(ХранилищеПроверяемыеДанные) = Тип("Соответствие") Тогда
			ХранилищеПроверяемыеДанные.Удалить("РуководительИмя");
			ХранилищеПроверяемыеДанные.Удалить("РуководительФамилия");
			ХранилищеПроверяемыеДанные.Удалить("РуководительОтчество");
		КонецЕсли;
		
	КонецЕсли;
	
	ОрганизацииФормыДляОтчетности.ПроверитьЗаполнение(ЭтотОбъект, ПроверяемыеРеквизиты, ХранилищеПроверяемыеДанные, Отказ);
	
	Если Элементы.КодПоОКТМО.Видимость Тогда
		ОрганизацииФормыДляОтчетности.ПроверитьКодПоОКТМОНаФорме(КодПоОКТМО, "КодПоОКТМО", Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ОрганизацииФормыДляОтчетности.ПередЗаписьюКонтактнойИнформации(ЭтотОбъект, ТекущийОбъект, Отказ);
	
	ЗначенияКлючевыхПолейРегистрацииНаФорме = ОрганизацииФормыДляОтчетности.ЗначенияПолейРегистрацииВНалоговомОргане(
		ЭтотОбъект,
		ПоляРегистрацииВНалоговомОргане(Истина));
	
	ОрганизацииФормыДляОтчетности.НачатьЗаписьРеквизитовГосударственныхОрганов(
		ТекущийОбъект,
		ЗначенияКлючевыхПолейРегистрацииНаФорме);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	ЗначенияПолейРегистрацииНаФорме = ОрганизацииФормыДляОтчетности.ЗначенияПолейРегистрацииВНалоговомОргане(
		ЭтотОбъект,
		ПоляРегистрацииВНалоговомОргане(Ложь));
	
	ОрганизацииФормыДляОтчетности.ЗаписатьРегистрациюВНалоговомОргане(
		ТекущийОбъект,
		ЗначенияПолейРегистрацииНаФорме);

	ЗаписатьДанныеРуководителя(Отказ, ТекущийОбъект);
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	УправлениеКонтактнойИнформацией.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект);
	
	СозданаУчетнаяПолитика = Ложь;
	РезультатВыполнения = КалендарьБухгалтера.ЗапуститьЗаполнениеВФоне(УникальныйИдентификатор, ТекущийОбъект.Ссылка, СозданаУчетнаяПолитика);
	ПараметрыЗаписи.Вставить("РезультатВыполненияЗаданияКалендаряБухгалтера", РезультатВыполнения);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОрганизацииФормыДляОтчетностиКлиентСервер.УстановитьЗаголовокФормы(ЭтотОбъект);
	
	Если ПараметрыЗаписи.Свойство("РезультатВыполненияЗаданияКалендаряБухгалтера") Тогда
		КалендарьБухгалтераКлиент.ОжидатьЗавершениеЗаполненияВФоне(ПараметрыЗаписи.РезультатВыполненияЗаданияКалендаряБухгалтера);
	КонецЕсли;
	
	ОрганизацииФормыДляОтчетностиКлиент.ОповеститьОЗаписи(Объект.Ссылка, ПараметрыЗаписи);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийПолейФормы

&НаКлиенте
Процедура ПолеПоискаИННПриИзменении(Элемент)
	
	ПоискИННОтвет = ОрганизацииФормыДляОтчетностиВызовСервера.ЗапроситьДанныеЕГР(НовыйЗапросДанныхЕГР(ПоискИННЗапрос));
		
	// Пользователь сразу после изменения поля мог нажать команду "Заполнить".
	// Дадим возможность выполниться обработчику команды заполнения.
	// Поэтому фактическую обработку результата выполняем после обработчика изменения поля.
	ПодключитьОбработчикОжидания("Подключаемый_ОбработатьРезультатПоискаИНН", 0.2, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбработатьРезультатПоискаИНН()
	
	ОрганизацииФормыДляОтчетностиКлиент.ОбработатьРезультатПоискаИННПриИзмененииПоляПоиска(
		ПоискИННОтвет,
		ОписаниеОповещенияЗакончитьЗаполнениеДаннымиЕГР());
	
КонецПроцедуры

&НаКлиенте
Процедура НаименованиеСокращенноеПриИзменении(Элемент)
	
	Объект.Наименование = ""; // Будет заполнено перед записью - см. ОрганизацииФормыКлиентСервер.НаименованиеПоСокращенномуНаименованию()
	Объект.КодОКОПФ = "";     // Будет заполнено перед записью
	
	// Заполним полное наименование
	Если ПустаяСтрока(Объект.НаименованиеПолное)
		ИЛИ ОрганизацииФормыКлиентСервер.ПолноеНаименованиеСоответствуетСокращенномуНаименованию(
			НаименованиеСокращенноеДоИзменения, Объект.НаименованиеПолное) Тогда
		Объект.НаименованиеПолное = ОрганизацииФормыКлиентСервер.ПолноеНаименованиеПоСокращенномуНаименованию(
			Объект.НаименованиеСокращенное);
	КонецЕсли;
	
	НаименованиеСокращенноеДоИзменения = Объект.НаименованиеСокращенное;
	
КонецПроцедуры

&НаКлиенте
Процедура ИННПриИзменении(Элемент)
	
	ПроверитьИНН(ПояснениеНекорректныйИНН, Объект.ИНН, Объект.КПП);
	
	Если ПустаяСтрока(ПояснениеНекорректныйИНН) И ПустаяСтрока(Объект.КПП) Тогда
		Объект.КПП = ИдентификационныеНомераНалогоплательщиков.КПППоУмолчанию(Объект.ИНН);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура КПППриИзменении(Элемент)
	
	ПроверитьИНН(ПояснениеНекорректныйИНН, Объект.ИНН, Объект.КПП);
	
КонецПроцедуры

&НаКлиенте
Процедура КодПоОКТМОПриИзменении(Элемент)
	
	ПояснениеНекорректныйКодПоОКТМО = ОрганизацииФормыДляОтчетностиКлиентСервер.ПроверитьКодПоОКТМО(КодПоОКТМО);
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактнаяИнформацияПолеТелефонОрганизацииПриИзменении(Элемент)
	
	УправлениеКонтактнойИнформациейКлиент.НачатьИзменение(ЭтотОбъект, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактнаяИнформацияПолеЮрАдресОрганизацииНажатие(Элемент, СтандартнаяОбработка)
	
	УправлениеКонтактнойИнформациейКлиент.НачатьВыбор(ЭтотОбъект, Элемент, Модифицированность, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура ПослеИзмененияКонтактнойИнформации(ИмяРеквизита)
	
	Если ИмяРеквизита = "КонтактнаяИнформацияПолеЮрАдресОрганизации" Тогда
		
		ЗаполнитьПоАдресу();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьКонтактнуюИнформацию(Результат)
	
	// Обязательный обработчик подсистемы контактной информации
	Если Результат.Свойство("ИмяРеквизита") Тогда
		ПослеИзмененияКонтактнойИнформации(Результат.ИмяРеквизита);
	КонецЕсли;
	УправлениеКонтактнойИнформацией.ОбновитьКонтактнуюИнформацию(ЭтотОбъект, Объект, Результат);
	ПояснениеНекорректныйКодПоОКТМО = ОрганизацииФормыДляОтчетностиКлиентСервер.ПроверитьКодПоОКТМО(КодПоОКТМО);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПродолжитьОбновлениеКонтактнойИнформации(Результат, ДополнительныеПараметры) Экспорт
	
	ОбновитьКонтактнуюИнформацию(Результат);
	УправлениеФормой();
	
КонецПроцедуры

&НаКлиенте
Процедура КодНалоговогоОрганаПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.КодНалоговогоОргана) Тогда
		Возврат;
	КонецЕсли;
	
	Объект.НаименованиеНалоговогоОргана = ОрганизацииФормыДляОтчетностиВызовСервера.РеквизитыГосударственногоОрганаПоКоду(
		ПредопределенноеЗначение("Перечисление.ВидыГосударственныхОрганов.НалоговыйОрган"),
		Объект.КодНалоговогоОргана);
		
КонецПроцедуры

&НаКлиенте
Процедура КодОрганаПФРПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.КодОрганаПФР) Тогда
		Возврат;
	КонецЕсли;
	
	Объект.НаименованиеТерриториальногоОрганаПФР = ОрганизацииФормыДляОтчетностиВызовСервера.РеквизитыГосударственногоОрганаПоКоду(
		ПредопределенноеЗначение("Перечисление.ВидыГосударственныхОрганов.ОрганПФР"),
		Объект.КодОрганаПФР);
		
КонецПроцедуры

&НаКлиенте
Процедура КодПодчиненностиФССПриИзменении(Элемент)
	
	Если ПустаяСтрока(Объект.КодПодчиненностиФСС) Тогда
		Возврат;
	КонецЕсли;
	
	Объект.НаименованиеТерриториальногоОрганаФСС = ОрганизацииФормыДляОтчетностиВызовСервера.РеквизитыГосударственногоОрганаПоКоду(
		ПредопределенноеЗначение("Перечисление.ВидыГосударственныхОрганов.ОрганФСС"),
		Объект.КодПодчиненностиФСС);
		
КонецПроцедуры

&НаКлиенте
Процедура КодОКВЭД2ПриИзменении(Элемент)
	
	ОрганизацииФормыДляОтчетностиКлиентСервер.ИзменениеКодаОКВЭД2(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура КодОКВЭД2НачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОрганизацииФормыДляОтчетностиКлиент.ВыбратьКодИзКлассификатора(
		"ОКВЭД2",
		"КодОКВЭД2",
		"НаименованиеОКВЭД2",
		ЭтотОбъект,
		Объект,
		СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура СистемаНалогообложенияПредставлениеНажатие(Элемент, СтандартнаяОбработка)
	
	ОрганизацииФормыДляОтчетностиКлиент.НачатьИзменениеСистемыНалогообложения(
		Объект.Ссылка,
		ЭтотОбъект,
		"СистемаНалогообложенияПредставление",
		СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура РуководительФизЛицоПриИзменении(Элемент)

	РуководительМодифицирован = Истина;
	
	Если ЗначениеЗаполнено(РуководительФизЛицо) тогда
		
		РуководительДолжность = ДолжностьРуководителя(Объект.Ссылка, РуководительФизЛицо);
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ФамилияРуководителяПриИзменении(Элемент)
	
	РуководительМодифицирован = Истина;

	Если ЗначениеЗаполнено(РуководительФамилия) И НЕ ЗначениеЗаполнено(РуководительДолжность) тогда
		
		РуководительДолжность = ДолжностьРуководителя(Объект.Ссылка, РуководительФизЛицо);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИмяРуководителяПриИзменении(Элемент)
	
	РуководительМодифицирован = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтчествоРуководителяПриИзменении(Элемент)
	
	РуководительМодифицирован = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура РуководительДолжностьПриИзменении(Элемент)
	
	РуководительМодифицирован = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаполнитьРеквизитыПоПолюПоискаИНН(Команда)
	
	ОрганизацииФормыДляОтчетностиКлиент.ЗаполнитьРеквизитыПоПолюПоискаИНН(
		НовыйЗапросДанныхЕГР(ПоискИННЗапрос),
		ПоискИННОтвет,
		ОписаниеОповещенияЗакончитьЗаполнениеДаннымиЕГР(),
		ТекущийЭлемент,
		Элементы.ПолеПоискаИНН);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьРеквизитыПоИНН(Команда)
	
	ОрганизацииФормыДляОтчетностиКлиент.ЗаполнитьРеквизитыПоИНН(
		НовыйЗапросДанныхЕГР(Объект.ИНН),
		ПоискИННОтвет,
		ОписаниеОповещенияЗакончитьЗаполнениеДаннымиЕГР(),
		ТекущийЭлемент,
		Элементы.ИНН);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УправлениеФормой()
	
	Элементы.ПояснениеНекорректныйКодПоОКТМО.Видимость = ЗначениеЗаполнено(ПояснениеНекорректныйКодПоОКТМО);
	
КонецПроцедуры

#Область ИдентификационныеНомераНалогоплательщиков

&НаКлиентеНаСервереБезКонтекста
Процедура ПроверитьИНН(РезультатПроверки, ИНН, КПП)
	
	РезультатПроверки = ОрганизацииФормыДляОтчетностиКлиентСервер.ПроверитьИНН(ИНН, КПП, Истина);
		
КонецПроцедуры

#КонецОбласти	

#Область ЗаполнениеДаннымиЕГР

&НаКлиенте
Функция НовыйЗапросДанныхЕГР(ИНН)
	
	Запрос = ОрганизацииФормыДляОтчетностиКлиентСервер.НовыйЗапросДанныхЕГР();
	Запрос.ИНН                       = ИНН;
	Запрос.ЮридическоеФизическоеЛицо = Объект.ЮридическоеФизическоеЛицо;
	Запрос.Ссылка                    = Объект.Ссылка;
	Запрос.ОбъектЗаполнен            = ЗначениеЗаполнено(Объект.ИНН) И ЗначениеЗаполнено(Объект.НаименованиеСокращенное);
	
	Возврат Запрос;
	
КонецФункции

&НаСервере
Процедура НастроитьКомандыАвтозаполнения()
	
	ОтобразитьЗаполнениеПоДаннымЕГР =
		Не ЗначениеЗаполнено(Объект.ИНН)
		И Не ЗначениеЗаполнено(Объект.НаименованиеПолное)
		И Не ЗначениеЗаполнено(Объект.НаименованиеСокращенное);
	
	Элементы.ЗаполнениеПоДаннымЕГР.Видимость   = ОтобразитьЗаполнениеПоДаннымЕГР;
	Элементы.ЗаполнитьРеквизитыПоИНН.Видимость = НЕ ОтобразитьЗаполнениеПоДаннымЕГР И Элементы.ИНН.Видимость;
	
КонецПроцедуры

&НаКлиенте
Функция ОписаниеОповещенияЗакончитьЗаполнениеДаннымиЕГР()
	
	// Параметр оповещения может быть модифицирован - см. НачатьЗаполнениеДаннымиЕГР()
	Возврат Новый ОписаниеОповещения("ЗакончитьЗаполнениеДаннымиЕГР", ЭтотОбъект, Новый Структура);
	
КонецФункции

&НаКлиенте
Процедура ЗакончитьЗаполнениеДаннымиЕГР(Ответ, ПараметрыЗаполнения) Экспорт
	
	ЗаполнитьНаСервере = ОрганизацииФормыДляОтчетностиКлиент.ЗакончитьЗаполнениеДаннымиЕГР(
		ЭтотОбъект,
		Объект.ЮридическоеФизическоеЛицо,
		Ответ,
		ПараметрыЗаполнения);
		
	Если ЗаполнитьНаСервере Тогда
		ЗаполнитьДаннымиЕГР(ПараметрыЗаполнения.ПоискИННОтвет);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьДаннымиЕГР(Знач ПоискИННОтвет)
	
	ОрганизацииФормыДляОтчетности.ЗаполнитьДаннымиЕГР(ПоискИННОтвет, ЭтотОбъект);
	
	НаименованиеСокращенноеДоИзменения = Объект.НаименованиеСокращенное;
	
	// Данные о руководителе, полученные из ЕГР, имеют "текстовый", а не "ссылочный" тип
	РуководительФизЛицо = Неопределено;
	РуководительМодифицирован = Истина;
	НастроитьВариантВводаДанныхРуководителя();
	
КонецПроцедуры

#КонецОбласти

#Область ЮридическийАдрес

&НаСервере
Процедура ЗаполнитьПоАдресу()
	
	ОрганизацииФормыДляОтчетности.ЗаполнитьПоАдресу(
		Объект,
		КодПоОКТМО,
		ОрганизацииФормыДляОтчетностиКлиентСервер.АдресОрганизацииЗначениеJSON(КонтактнаяИнформацияОписаниеДополнительныхРеквизитов));
		
КонецПроцедуры

#КонецОбласти

#Область РегистрацияВНалоговомОргане

// Методы работы со справочником РегистрацияВНалоговомОргане

&НаСервере
Функция ПоляРегистрацииВНалоговомОргане(ТолькоКлючевые = Ложь)
	
	ПоляРегистрации = Новый Структура;
	ПоляРегистрации.Вставить("Код", "Объект.КодНалоговогоОргана");
	ПоляРегистрации.Вставить("КПП", "Объект.КПП");
	
	Если Не ТолькоКлючевые Тогда
		ПоляРегистрации.Вставить("НаименованиеИФНС", "Объект.НаименованиеНалоговогоОргана");
		ПоляРегистрации.Вставить("КодПоОКТМО",       "КодПоОКТМО");
	КонецЕсли;
	
	Возврат ПоляРегистрации;
	
КонецФункции

#КонецОбласти

#Область Руководитель

&НаСервере
Процедура НастроитьСвойстваЭлементовФИОРуководителя()

	// Максимальное количество символов в поля ввода ФИО разрешаем ввести не больше, чем в справочнике ФизическиеЛица.
	МетаданныеРеквизитыФизЛица = Метаданные.Справочники.ФизическиеЛица.Реквизиты;
	Элементы.РуководительФамилия.ОграничениеТипа  = МетаданныеРеквизитыФизЛица.Фамилия.Тип;
	Элементы.РуководительИмя.ОграничениеТипа      = МетаданныеРеквизитыФизЛица.Имя.Тип;
	Элементы.РуководительОтчество.ОграничениеТипа = МетаданныеРеквизитыФизЛица.Отчество.Тип;

КонецПроцедуры

&НаСервере
Процедура НастроитьВариантВводаДанныхРуководителя()
	
	// Отобразим элементы на форме для ввода ФИО в зависимости от наличия записи об ответственных лицах.
	
	РуководительПредставленСсылкой = ЗначениеЗаполнено(РуководительФизЛицо);
	
	Элементы.РуководительКакФИО.Видимость  = НЕ РуководительПредставленСсылкой;
	Элементы.РуководительФизЛицо.Видимость = РуководительПредставленСсылкой;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ДолжностьРуководителя(Знач Организация, Знач ФизическоеЛицо)
	
	Возврат ОтветственныеЛицаБП.ДолжностьОтветственногоЛица(
				Организация,
				ФизическоеЛицо,
				Перечисления.ОтветственныеЛицаОрганизаций.Руководитель);
	
КонецФункции

&НаСервере
Процедура ПрочитатьДанныеРуководителя()
	
	РуководительМодифицирован = Ложь;
	
	ДанныеРуководителя = ОрганизацииФормыДляОтчетности.ДанныеРуководителя(Объект.Ссылка);
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, ДанныеРуководителя);
	
	НастроитьВариантВводаДанныхРуководителя();
	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьДанныеРуководителя(Отказ, ТекущийОбъект)
	
	Если НЕ РуководительМодифицирован Тогда
		Возврат;
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(РуководительФизЛицо) И НЕ ЗначениеЗаполнено(РуководительФамилия) Тогда
		Возврат;
	КонецЕсли;

	Если НЕ ЗначениеЗаполнено(РуководительФизЛицо) Тогда
		// Создадим сначала физлицо.
		ДанныеФизЛица = Новый Структура;
		ДанныеФизЛица.Вставить("Фамилия",  РуководительФамилия);
		ДанныеФизЛица.Вставить("Имя",      РуководительИмя);
		ДанныеФизЛица.Вставить("Отчество", РуководительОтчество);
		РуководительФизЛицо = ОтветственныеЛицаБП.ПолучитьСоздатьФизЛицо(ДанныеФизЛица);
	КонецЕсли;

	СтруктураРеквизитов = Новый Структура;
	СтруктураРеквизитов.Вставить("ОтветственноеЛицо",	Перечисления.ОтветственныеЛицаОрганизаций.Руководитель);
	СтруктураРеквизитов.Вставить("ФизическоеЛицо",	    РуководительФизЛицо);
	СтруктураРеквизитов.Вставить("Должность",           РуководительДолжность);
	СтруктураРеквизитов.Вставить("Период",	            РуководительПериод);
	
	РегистрыСведений.ОтветственныеЛицаОрганизаций.ЗаписатьНаборЗаписейИсторииОтветственныеЛицаОрганизаций(ТекущийОбъект.Ссылка, СтруктураРеквизитов);
	
	РуководительМодифицирован = Ложь;
	
	НастроитьВариантВводаДанныхРуководителя();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
