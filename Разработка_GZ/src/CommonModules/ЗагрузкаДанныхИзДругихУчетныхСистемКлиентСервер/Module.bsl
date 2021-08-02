
#Область СлужебныйПрограммныйИнтерфейс

Функция НовыеСвойстваФайла() Экспорт
	
	СвойстваФайла = Новый Структура;
	СвойстваФайла.Вставить("Имя", "");
	СвойстваФайла.Вставить("Расширение", "");
	СвойстваФайла.Вставить("Хранение", "");
	СвойстваФайла.Вставить("ДвоичныеДанные");
	Возврат СвойстваФайла;
	
КонецФункции

Функция ПоддерживаемыеРасширения() Экспорт
	
	Расширения = Новый Массив;
	Расширения.Добавить("zip");
	Расширения.Добавить("csv");
	Расширения.Добавить("xls");
	Расширения.Добавить("xlsx");
	Возврат Расширения;
	
КонецФункции

Функция ЭтоZipАрхив(Расширение) Экспорт
	
	Возврат Расширение = "zip";
	
КонецФункции

Функция РасширениеТекстовогоФайла() Экспорт
	
	Возврат "csv";
	
КонецФункции

#КонецОбласти