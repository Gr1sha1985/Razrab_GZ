// Механизм расчета статусов оформления документов ИС МП.
//

#Область СлужебныйПрограммныйИнтерфейс

// Позволяет переопределить имена реквизитов документа-основания для документа ИСМП.
//
// Параметры:
//  МетаданныеДокументаОснования - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.Основание<Имя документа ИСМП>
//  МетаданныеДокументаИСМП - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.ДокументыИСМППоддерживающиеСтатусыОформления
//  Реквизиты  - Структура - имена реквизитов:
//  * Ключ  - служебное имя реквизита в ИСМП
//  * Значение - имя реквизита документа-основания, которое при необходимости надо переопределить
//  (см. РасчетСтатусовОформленияИСМП.СтруктураРеквизитовДляРасчетаСтатусаОформленияДокументов).
Процедура ПриОпределенииИменРеквизитовДляРасчетаСтатусаОформления(
			Знач МетаданныеДокументаОснования, Знач МетаданныеДокументаИСМП, Реквизиты) Экспорт
	
	// Зададим имена реквизитов по умолчанию.
	Реквизиты.Контрагент = "Организация";
	
	Если МетаданныеДокументаОснования = Метаданные.Документы.ПроизводственнаяОперацияВЕТИС Тогда
		Реквизиты.Контрагент = "ХозяйствующийСубъект";
	ИначеЕсли МетаданныеДокументаОснования = Метаданные.Документы.ВходящаяТранспортнаяОперацияВЕТИС Тогда
		Реквизиты.Контрагент = "ГрузополучательХозяйствующийСубъект";
	КонецЕсли;
		
	// Определим имя реквизита "Ответственный".
	Если МетаданныеДокументаОснования.Реквизиты.Найти("Кассир") <> Неопределено Тогда
		Реквизиты.Ответственный = "Кассир";
	Иначе
		Реквизиты.Ответственный = "Ответственный";
	КонецЕсли;
	
КонецПроцедуры

// Позволяет переопределить текст запроса выборки данных из документов-основания для расчета статуса оформления.
//   Требования к тексту запроса:
//     Если данные из документа выбирать не требуется, то данному параметру надо присвоить значение "" (пустая строка).
//     Результат запроса обязательно должен содержать следующие поля:
//      * Ссылка - ОпределяемыйТип.Основание<Имя документа ИСМП> - ссылка на документ-основание
//      * ЭтоДвижениеПриход - Булево - вид движения ТМЦ (Истина - приход, Ложь - расход)
//      * Номенклатура - ОпределяемыйТип.Номенклатура - номенклатура
//      * Характеристика - ОпределяемыйТип.ХарактеристикаНоменклатуры - характеристика номенклатуры
//      * Серия - ОпределяемыйТип.СерияНоменклатуры - серия номенклатуры
//      * Количество - Число - количество номенклатуры в ее основной единице измерения
//     В результат запроса нужно включать только подконтрольную номенклатуру ИСМП (табак, обувь)
//     Для отбора документов-основания в запросе нужно использовать отбор "В (&МассивДокументов)"
//     Выбранные данные необходимо поместить во временную таблицу (См. РасчетСтатусовОформленияИСМП.ИмяВременнойТаблицыДляВыборкиДанныхДокумента).
//
//Параметры:
//   МетаданныеДокументаОснования - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.Основание<Имя документа ИСМП>
//   МетаданныеДокументаИСМП - ОбъектМетаданных - метаданные документа из ОпределяемыйТип.ДокументыИСМППоддерживающиеСтатусыОформления
//   ТекстЗапроса - Строка - текст запроса выборки данных, который надо переопределить
//   ДополнительныеПараметрыЗапроса - Структура - дополнительные параметры запроса, требуемые для выполнения запроса 
//       конкретного документа; при необходимости можно дополнить данную структуру
//     Ключ     - имя параметры
//     Значение - значение параметра.
//
Процедура ПриОпределенииТекстаЗапросаДляРасчетаСтатусаОформления(
			Знач МетаданныеДокументаОснования, Знач МетаданныеДокументаИСМП, ТекстЗапроса, ДополнительныеПараметрыЗапроса) Экспорт
	
	Если МетаданныеДокументаОснования = Метаданные.Документы.ОтчетПроизводстваЗаСмену
		И МетаданныеДокументаИСМП = Метаданные.Документы.МаркировкаТоваровИСМП Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ОтчетПроизводстваЗаСмену.Продукция КАК ТаблицаТовары
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура
		|
		|ГДЕ
		|	ТаблицаТовары.Ссылка В (&МассивДокументов)
		|	И (СправочникНоменклатура.ТабачнаяПродукция 
		|	ИЛИ СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.АльтернативныйТабак
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.СписаниеТоваров
		И МетаданныеДокументаИСМП = Метаданные.Документы.ВыводИзОборотаИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ЛОЖЬ КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.СписаниеТоваров.Товары КАК ТаблицаТовары
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура
		|
		|ГДЕ
		|	ТаблицаТовары.Ссылка В (&МассивДокументов)
		|	И (СправочникНоменклатура.ТабачнаяПродукция 
		|	ИЛИ СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.АльтернативныйТабак
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ОприходованиеТоваров
		И МетаданныеДокументаИСМП = Метаданные.Документы.МаркировкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ОприходованиеТоваров.Товары КАК ТаблицаТовары
		|	ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура
		|
		|ГДЕ
		|	ТаблицаТовары.Ссылка В (&МассивДокументов)
		|	И (СправочникНоменклатура.ТабачнаяПродукция 
		|	ИЛИ СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.АльтернативныйТабак
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ВозвратТоваровОтПокупателя
		И МетаданныеДокументаИСМП = Метаданные.Документы.ПеремаркировкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ВозвратТоваровОтПокупателя.Товары КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (СправочникНоменклатура.ТабачнаяПродукция 
		|	ИЛИ СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.АльтернативныйТабак
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|	И ТаблицаТовары.Ссылка.Сделка ССЫЛКА Документ.ОтчетОРозничныхПродажах";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ОтчетОРозничныхПродажах
		И МетаданныеДокументаИСМП = Метаданные.Документы.ПеремаркировкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ОтчетОРозничныхПродажах.Возвраты КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (СправочникНоменклатура.ТабачнаяПродукция 
		|	ИЛИ СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.АльтернативныйТабак
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.РеализацияТоваровУслуг
		И МетаданныеДокументаИСМП = Метаданные.Документы.ОтгрузкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ЛОЖЬ КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.РеализацияТоваровУслуг.Товары КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|	И НЕ(1 В (ВЫБРАТЬ 1 Из РегистрСведений.СостоянияЭД КАК СостоянияЭД 
		|			ГДЕ СостоянияЭД.СсылкаНаОбъект = ТаблицаТовары.Ссылка 
		|			И СостоянияЭД.ЭлектронныйДокумент.СодержитДанныеОМаркируемыхТоварах))";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ВозвратТоваровПоставщику
		И МетаданныеДокументаИСМП = Метаданные.Документы.ОтгрузкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ЛОЖЬ КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ВозвратТоваровПоставщику.Товары КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (СправочникНоменклатура.ОбувнаяПродукция
		|	ИЛИ СправочникНоменклатура.Велосипеды
		|	ИЛИ СправочникНоменклатура.Духи
		|	ИЛИ СправочникНоменклатура.КреслаКоляски
		|	ИЛИ СправочникНоменклатура.ЛегкаяПромышленность
		|	ИЛИ СправочникНоменклатура.УпакованнаяВода
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияПодконтрольнаяВЕТИС
		|	ИЛИ СправочникНоменклатура.МолочнаяПродукцияБезВЕТИС
		|	ИЛИ СправочникНоменклатура.Фотоаппараты
		|	ИЛИ СправочникНоменклатура.Шины)
		|	И НЕ(1 В (ВЫБРАТЬ 1 Из РегистрСведений.СостоянияЭД КАК СостоянияЭД 
		|			ГДЕ СостоянияЭД.СсылкаНаОбъект = ТаблицаТовары.Ссылка 
		|			И СостоянияЭД.ЭлектронныйДокумент.СодержитДанныеОМаркируемыхТоварах))";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ПоступлениеТоваровУслуг
		И МетаданныеДокументаИСМП = Метаданные.Документы.ПриемкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ПоступлениеТоваровУслуг.Товары КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (1 В (ВЫБРАТЬ 1 ИЗ Документ.ПриемкаТоваровИСМП КАК ПриемкаТоваровИСМП 
		|		ГДЕ ПриемкаТоваровИСМП.ДокументОснование = ТаблицаТовары.Ссылка))";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.ВозвратТоваровОтПокупателя
		И МетаданныеДокументаИСМП = Метаданные.Документы.ПриемкаТоваровИСМП) Тогда
		
		ТекстЗапроса =
		"ВЫБРАТЬ
		|	ИСТИНА КАК ЭтоДвижениеПриход,
		|	ТаблицаТовары.Ссылка КАК Ссылка,
		|	ТаблицаТовары.Номенклатура КАК Номенклатура,
		|	"""" КАК Характеристика,
		|	"""" КАК Серия,
		|	ТаблицаТовары.Количество КАК Количество
		|ПОМЕСТИТЬ %1
		|ИЗ
		|	Документ.ВозвратТоваровОтПокупателя.Товары КАК ТаблицаТовары
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Номенклатура КАК СправочникНоменклатура
		|		ПО (СправочникНоменклатура.Ссылка = ТаблицаТовары.Номенклатура)
		|ГДЕ
		|	ТаблицаТовары.Ссылка В(&МассивДокументов)
		|	И (1 В (ВЫБРАТЬ 1 ИЗ Документ.ПриемкаТоваровИСМП КАК ПриемкаТоваровИСМП 
		|		ГДЕ ПриемкаТоваровИСМП.ДокументОснование = ТаблицаТовары.Ссылка))";
		
	ИначеЕсли (МетаданныеДокументаОснования = Метаданные.Документы.МаркировкаТоваровИСМП
		И МетаданныеДокументаИСМП = Метаданные.Документы.ЗаказНаЭмиссиюКодовМаркировкиСУЗ) Тогда
		//Опеределяется в библиотеке
		
	Иначе
		
		ТекстЗапроса = "ВЫБРАТЬ ПЕРВЫЕ 0
		|	ЛОЖЬ		 КАК ЭтоДвижениеПриход,
		|	НЕОПРЕДЕЛЕНО КАК Ссылка,
		|	НЕОПРЕДЕЛЕНО КАК Номенклатура,
		|	НЕОПРЕДЕЛЕНО КАК Характеристика,
		|	НЕОПРЕДЕЛЕНО КАК Серия,
		|	0 			 КАК Количество
		|ПОМЕСТИТЬ %1";
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
