
#Область ПрограммныйИнтерфейс

// Функция возвращает значение ставки НДС.
//
// Параметры:
//  СтавкаНДС - ПеречислениеСсылка.СтавкиНДС;
//  ПрименяютсяСтавки4и2 - Булево - Истина если в регионе действуют ставки НДС 4% и 2%.
//
// Возвращаемое значение:
//  Число - значение ставки.
//
Функция ПолучитьСтавкуНДС(СтавкаНДС, ПрименяютсяСтавки4и2 = Ложь) Экспорт
	
	Возврат УчетНДСПереопределяемый.ПолучитьСтавкуНДС(СтавкаНДС, ПрименяютсяСтавки4и2);
	
КонецФункции // ПолучитьСтавкуНДС()

// Функция возвращает курс ставку НДС
//
// Параметры:
//  Валюта - СправочникСсылка.Валюты, валюта, по которой необходимо получить курс
//  ДатаКурса - Дата, календарная дата, на которую необходимо получить курс валюты
//
// Возвращаемое значение:
//	Курс переданной валюты на переданную дату, 1 в случае отсутствия значения.
//
Функция ПолучитьСтавкуНДСдляККТ(СтавкаНДС, ПрименяютсяРасчетныеСтавки = Ложь, ПрименяютсяСтавки4и2 = Ложь) Экспорт

	Если СтавкаНДС = Перечисления.СтавкиНДС.БезНДС Тогда
		Возврат Неопределено;
	ИначеЕсли СтавкаНДС = Перечисления.СтавкиНДС.НДС20_120 И ПрименяютсяРасчетныеСтавки  Тогда 
		Возврат 120;
	ИначеЕсли СтавкаНДС = Перечисления.СтавкиНДС.НДС18_118 И ПрименяютсяРасчетныеСтавки  Тогда 
		Возврат 118;
	ИначеЕсли СтавкаНДС = Перечисления.СтавкиНДС.НДС10_110 И ПрименяютсяРасчетныеСтавки Тогда 
		Возврат 110;
	Иначе
		Возврат УчетНДСПереопределяемый.ПолучитьСтавкуНДС(СтавкаНДС, ПрименяютсяСтавки4и2);
	КонецЕсли;

КонецФункции // ПолучитьСтавкуНДС()

// Функция возвращает расчетную ставку НДС для расчета по авансам
//
// Параметры:
//  СтавкаНДС - ПеречислениеСсылка.СтавкиНДС;
//
// Возвращаемое значение:
//  ПеречислениеСсылка.СтавкиНДС - расчетная ставка.
//
Функция РасчетнаяСтавкаНДС(СтавкаНДС) Экспорт
	СоответствиеСтавок = Новый Соответствие();
	СоответствиеСтавок.Вставить(Перечисления.СтавкиНДС.НДС10,  Перечисления.СтавкиНДС.НДС10_110);
	СоответствиеСтавок.Вставить(Перечисления.СтавкиНДС.НДС18,  Перечисления.СтавкиНДС.НДС18_118);
	СоответствиеСтавок.Вставить(Перечисления.СтавкиНДС.НДС20,  Перечисления.СтавкиНДС.НДС20_120);
	СоответствиеСтавок.Вставить(Перечисления.СтавкиНДС.БезНДС, Перечисления.СтавкиНДС.БезНДС);
	СоответствиеСтавок.Вставить(Перечисления.СтавкиНДС.НДС0,   Перечисления.СтавкиНДС.НДС0);
	
	Возврат СоответствиеСтавок[СтавкаНДС];
КонецФункции


// Массив счетов учета товаров, по которым требуется учет по ГТД
//
Функция СчетаУчетаДляГТД() Экспорт
	
	СчетаГруппы = Новый Массив;
	СчетаГруппы.Добавить(ПланыСчетов.Хозрасчетный.Товары);
	СчетаГруппы.Добавить(ПланыСчетов.Хозрасчетный.ТоварыНаСкладе);
	
	СчетаУчета = БухгалтерскийУчет.СформироватьМассивСубсчетов(СчетаГруппы);
	
	ИсключаемыеСчета = Новый Массив;
	ИсключаемыеСчета.Добавить(ПланыСчетов.Хозрасчетный.ТоварыВРозничнойТорговлеВПродажныхЦенахНТТ);
	ИсключаемыеСчета.Добавить(ПланыСчетов.Хозрасчетный.ТараПодТоваромИПорожняя);
	ИсключаемыеСчета.Добавить(ПланыСчетов.Хозрасчетный.КорректировкаТоваровПрошлогоПериода);
	
	Возврат Новый ФиксированныйМассив(ОбщегоНазначенияКлиентСервер.РазностьМассивов(СчетаУчета, ИсключаемыеСчета));
	
КонецФункции

#КонецОбласти

