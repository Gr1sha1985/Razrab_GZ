#Область ПрограммныйИнтерфейс

// Возвращает информацию о последней по времени установке пометки на удаление текущим пользователем.
//
// Возвращаемое значение:
//	Струкутура - со следующими элементами:
//	* Ссылка - СправочникСсылка или ДокументСсылка - Ссылка на объект, на который была установлена пометка.
//	* Время - Число - Универсальная дата установки пометки в миллисекундах.
//	* НеПоказыватьВопросПриПометкеНаУдаление - Булево или Неопределено - Признак показа диалогового окна при пометке.
//	См. также: ПомеченныеНаУдалениеСервер.ПриЗаписиОбъектаДляПометкиУдаления()
//
Функция ПолучитьДанныеПометкиНаУдаление() Экспорт
	
	ДанныеПоследнейПометки = ХранилищеОбщихНастроек.Загрузить("ПомеченныеНаУдаление", "ДанныеПоследнейПометки");
	Если ТипЗнч(ДанныеПоследнейПометки) <> Тип("Структура") Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если ДанныеПоследнейПометки.Время < ТекущаяУниверсальнаяДатаВМиллисекундах() - 500 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	ХранилищеОбщихНастроек.Удалить("ПомеченныеНаУдаление", "ДанныеПоследнейПометки", ИмяПользователя());
	
	ДанныеПоследнейПометки.Вставить(
		"НеПоказыватьВопросПриПометкеНаУдаление",
		ХранилищеОбщихНастроек.Загрузить("ПомеченныеНаУдаление", "НеПоказыватьВопросПриПометкеНаУдаление")
	);
	
	Возврат ДанныеПоследнейПометки;
	
КонецФункции

#КонецОбласти