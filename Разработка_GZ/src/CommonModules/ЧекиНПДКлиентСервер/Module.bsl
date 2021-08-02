#Область ПрограммныйИнтерфейс

// Конструктор структуры параметров для проверки результатов формирования чека.
// См. РегистрыСведений.ЧекиНПД.ПроверитьРезультатФормированияЧекаВФоне()
// и РегистрыСведений.ЧекиНПД.ПроверитьРезультатФормированияЧека().
// 
// Возвращаемое значение:
//   - Структура.
//
Функция НовыйПараметрыОжиданияФормированияЧека() Экспорт
	
	ПараметрыОжидания = Новый Структура;
	// Ссылка на документ, для которого формируется чек.
	ПараметрыОжидания.Вставить("Ссылка", Неопределено);
	// Структура для запроса результата формирования.
	// Значение см. в РегистрыСведений.ЧекиНПД.НовыйРезультатОперацииСЧеком().ПараметрыОжиданияРезультата
	ПараметрыОжидания.Вставить("ПараметрыОжиданияРезультата", Неопределено);
	Возврат ПараметрыОжидания;
	
КонецФункции

// Конструктор структуры параметров для аннулирования чека.
// См. РегистрыСведений.ЧекиНПД.ПроверитьРезультатАннулированияЧека()
// и РегистрыСведений.ЧекиНПД.АннулироватьЧек().
// 
// Возвращаемое значение:
//   - Структура.
//
Функция НовыйПараметрыАннулированияЧека() Экспорт
	
	ПараметрыАннулирования = Новый Структура;
	ПараметрыАннулирования.Вставить("Ссылка", Неопределено);
	ПараметрыАннулирования.Вставить("Организация", Неопределено);
	ПараметрыАннулирования.Вставить("НомерЧека", "");
	ПараметрыАннулирования.Вставить("ПричинаОтменыЧека",
		ПредопределенноеЗначение("Перечисление.ПричиныОтменыЧекаНПД.ПустаяСсылка"));
	ПараметрыАннулирования.Вставить("ДокументОснование", Неопределено);
	
	Возврат ПараметрыАннулирования;
	
КонецФункции

// Конструктор структуры параметров для проверки результатов аннулирования чека.
// См. РегистрыСведений.ЧекиНПД.ПроверитьРезультатАннулированияЧекаВФоне()
// и РегистрыСведений.ЧекиНПД.ПроверитьРезультатАннулированияЧека().
// 
// Возвращаемое значение:
//   - Структура.
//
Функция НовыйПараметрыОжиданияАннулированияЧека() Экспорт
	
	ПараметрыОжидания = Новый Структура;
	// Ссылка на документ, для которого формируется чек.
	ПараметрыОжидания.Вставить("Ссылка", Неопределено);
	// Структура для запроса результата формирования.
	// Значение см. в РегистрыСведений.ЧекиНПД.НовыйРезультатОперацииСЧеком().ПараметрыОжиданияРезультата
	ПараметрыОжидания.Вставить("ПараметрыОжиданияРезультата", Неопределено);
	Возврат ПараметрыОжидания;
	
КонецФункции

// Конструктор структуры параметров для отправки чека.
// См. РегистрыСведений.ЧекиНПД.ОтправитьЧекВФоне()
// и РегистрыСведений.ЧекиНПД.ОтправитьЧек().
// 
// Возвращаемое значение:
//   - Структура.
//
Функция НовыйПараметрыОтправкиЧека() Экспорт
	
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("Ссылка", Неопределено);
	ПараметрыОтправки.Вставить("ОтправлятьEmail", Ложь);
	ПараметрыОтправки.Вставить("АдресЭлектроннойПочты", "");
	ПараметрыОтправки.Вставить("ОтправлятьSMS", Ложь);
	ПараметрыОтправки.Вставить("НомерТелефона", "");
	ПараметрыОтправки.Вставить("УникальныйИдентификатор", Неопределено);
	Возврат ПараметрыОтправки;
	
КонецФункции

// По состоянию чека возвращает признак, можно ли начинать формирование.
//
// Параметры:
//  СведенияОЧеке	 - Структура - Сведения о чеке. См. РегистрыСведений.ЧекиНПД.СведенияОЧеке().
// 
// Возвращаемое значение:
//   - Структура.
//
Функция НужноНачатьФормированиеЧека(СведенияОЧеке) Экспорт
	
	Возврат Не ЗначениеЗаполнено(СведенияОЧеке)
		Или Не ЗначениеЗаполнено(СведенияОЧеке.Состояние)
		Или СведенияОЧеке.Состояние = ПредопределенноеЗначение("Перечисление.СостоянияЧековНПД.ОшибкаПриРегистрации")
		Или СведенияОЧеке.Состояние = ПредопределенноеЗначение("Перечисление.СостоянияЧековНПД.ВыполняетсяРегистрация");
	
КонецФункции

// Проверяет, что офлайн чек еще не отправлен в ФНС по его состоянию.
//
// Параметры:
//   СведенияОЧеке - Структура - См. РегистрыСведений.ЧекиНПД.НовыйСведенияОЧеке()
//
// Возвращаемое значение:
//   Булево - Истина, если чек еще не отправлен в ФНС. Ложь в противном случае.
//
Функция ЧекОжидаетОтправкиВФНС(СведенияОЧеке) Экспорт
	
	Состояние = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(СведенияОЧеке, "Состояние", Неопределено);
	
	Возврат (Состояние = ПредопределенноеЗначение("Перечисление.СостоянияЧековНПД.ОжидаетОтправкиВФНС"));
	
КонецФункции

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция ИмяСобытияЖурналаРегистрации() Экспорт
	
	Возврат НСтр("ru = 'Чеки НПД'", ОбщегоНазначенияКлиентСервер.КодОсновногоЯзыка());
	
КонецФункции

Функция ИмяСобытияДляОповещенияОбИзмененииЧека() Экспорт
	
	Возврат "ОбновленыДанныеЧекаНПД";
	
КонецФункции

#КонецОбласти
