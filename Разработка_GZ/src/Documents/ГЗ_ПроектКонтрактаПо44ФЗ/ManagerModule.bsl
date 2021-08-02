
 Процедура СоздатьДокументПроектКонтактаПо44ФЗ(ДанныеЗаполнения) Экспорт 
	
	Если ДанныеЗаполнения <> Неопределено Тогда
		
		НайденныйДокумент = Документы.ГЗ_ПроектКонтрактаПо44ФЗ.НайтиПоРеквизиту("docRegNumber", ДанныеЗаполнения.docRegNumber) ;
		
		Если НайденныйДокумент.Пустая() Тогда 
			ДокументГЗ = Документы.ГЗ_ПроектКонтрактаПо44ФЗ.СоздатьДокумент();
		Иначе 	
			ДокументГЗ = НайденныйДокумент.ПолучитьОбъект();
		КонецЕсли;
		
		ЗаполнитьЗначенияСвойств(ДокументГЗ,ДанныеЗаполнения);

		Попытка
			ДокументГЗ.Записать(РежимЗаписиДокумента.Проведение);
		Исключение
			ДокументГЗ.Записать(РежимЗаписиДокумента.Запись);
		КонецПопытки;
	Иначе
		ЗаписьЖурналаРегистрации("ГЗ.СозданиеПроектаКонтракта", УровеньЖурналаРегистрации.Ошибка,,,"Пустая структура для заполнения документа проект контракта");
	КонецЕсли;	
	//Возврат ДокументСсылка;

КонецПроцедуры
