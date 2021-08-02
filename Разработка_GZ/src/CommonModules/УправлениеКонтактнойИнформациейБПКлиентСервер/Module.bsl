#Область ПрограммныйИнтерфейс

// Возвращает строку дополнительных значений по имени реквизита.
//
// Параметры:
//    Форма   - ФормаКлиентскогоПриложения - передаваемая форма.
//    Элемент - ДанныеФормыСтруктураСКоллекцией - данные формы.
//
// Возвращаемое значение:
//    СтрокаКоллекции - найденные данные.
//    Неопределено    - при отсутствии данных.
//
Функция ЗначениеКонтактнойИнформацииФормы(Форма, ИмяЭлемента) Экспорт
	
	Отбор = Новый Структура("ИмяРеквизита", ИмяЭлемента);
	Строки = Форма.КонтактнаяИнформацияОписаниеДополнительныхРеквизитов.НайтиСтроки(Отбор);
	ДанныеСтроки = ?(Строки.Количество() = 0, Неопределено, Строки[0]);
	
	Возврат ДанныеСтроки;
	
КонецФункции

#КонецОбласти