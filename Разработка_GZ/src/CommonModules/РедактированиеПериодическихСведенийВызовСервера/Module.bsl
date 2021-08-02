
#Область СлужебныеПроцедурыИФункции

Функция СтруктураМенеджераЗаписи(ИмяРегистра, ВедущийОбъект) Экспорт
	
	ИмяИзмерения = Метаданные.РегистрыСведений[ИмяРегистра].Измерения[0].Имя;
	
	СтруктураВедущихОбъектов = Новый Структура();
	СтруктураВедущихОбъектов.Вставить(ИмяИзмерения, ВедущийОбъект);
	
	Возврат СтруктураМенеджераЗаписиПоСтруктуре(ИмяРегистра, СтруктураВедущихОбъектов);
	
КонецФункции

Функция СтруктураМенеджераЗаписиПоСтруктуре(ИмяРегистра, СтруктураВедущихОбъектов) Экспорт
	
	МетаданныеРегистра = Метаданные.РегистрыСведений[ИмяРегистра];
	СтруктураПоМенеджеруЗаписи = ОбщегоНазначения.СтруктураПоМенеджеруЗаписи(РегистрыСведений[ИмяРегистра].СоздатьМенеджерЗаписи(), МетаданныеРегистра);
	Для Каждого ВедущийОбъект Из СтруктураВедущихОбъектов Цикл
		СтруктураПоМенеджеруЗаписи[ВедущийОбъект.Ключ] = ВедущийОбъект.Значение;
	КонецЦикла;
	
	Возврат СтруктураПоМенеджеруЗаписи;
	
КонецФункции

#КонецОбласти
