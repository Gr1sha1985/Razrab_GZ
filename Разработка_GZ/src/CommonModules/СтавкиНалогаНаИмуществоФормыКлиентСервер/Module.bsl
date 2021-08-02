
////////////////////////////////////////////////////////////////////////////////
// Универсальные методы для формы записи регистра и формы настройки налогов
//
// Клиент-серверные методы формы записи регистра сведений СтавкиНалогаНаИмущество
//
////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Процедура УправлениеФормой(Форма) Экспорт
	
	Элементы = Форма.Элементы;
	Запись   = Форма.СтавкиНалогаНаИмущество;
	
	Элементы.КодЛьготыОсвобождениеОтНалогаНаИмущество.Доступность = Запись.ОсвобождениеОтНалогообложения;
	
	Элементы.ОсвобождениеОтНалогообложенияДвижимогоИмущества.Доступность = Не Запись.ОсвобождениеОтНалогообложения;
	Элементы.СнижениеСтавкиНалогаНаИмущество.Доступность = Не Запись.ОсвобождениеОтНалогообложения;
	Элементы.СнижениеНалоговойСтавкиДвижимоеИмущество.Доступность = Не Запись.ОсвобождениеОтНалогообложения;
	
	Элементы.ГруппаУменьшениеСуммыНалогаНаИмущество.Доступность = Не Запись.ОсвобождениеОтНалогообложения;
	Элементы.ПроцентУменьшенияНалогаНаИмущество.Доступность = Запись.УменьшениеСуммыНалогаВПроцентах;
	
	ВидимостьНалогаНаДвижимоеИмущество = Год(Запись.Период) = 2018;
	Элементы.ГруппаСтавкаНалогаНаДвижимоеИмущество.Видимость = ВидимостьНалогаНаДвижимоеИмущество;
	Элементы.ОсвобождениеОтНалогообложенияДвижимогоИмущества.Видимость = ВидимостьНалогаНаДвижимоеИмущество;
	
КонецПроцедуры

#КонецОбласти
