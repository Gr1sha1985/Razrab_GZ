#Область ПрограммныйИнтерфейс

#Область УправлениеДоступом

// Разрешает выполнение загрузки данных внешних систем - 
// добавляет соответствующие права в описание поставляемого профиля пользователей.
//
// Параметры:
//  ОписаниеПрофиля - см. УправлениеДоступом.НовоеОписаниеПрофиляГруппДоступа() - заполняемая коллекция
//
Процедура РазрешитьВыполнениеЗагрузкиДанныхВнешнихСистем(ОписаниеПрофиля) Экспорт
	
	ОписаниеПрофиля.Роли.Добавить("ВыполнениеЗагрузкиДанныхВнешнихСистем");
	
КонецПроцедуры

#КонецОбласти

#Область ОчередьЗаданий

// Подключает регламентное задание к подсистеме БСП Регламентные задания.
//
// Параметры:
//  Настройки - ТаблицаЗначений - см. комментарий 
//              к РегламентныеЗаданияПереопределяемый.ПриОпределенииНастроекРегламентныхЗаданий
//
Процедура ЗарегистрироватьРегламентноеЗадание(Настройки) Экспорт
	
	Настройка = Настройки.Добавить();
	Настройка.РегламентноеЗадание        = Метаданные.РегламентныеЗадания.ЗагрузкаДанныхВнешнихСистем;
	Настройка.РаботаетСВнешнимиРесурсами = Истина;
	
КонецПроцедуры

// Подключает регламентное задание к механизм очереди заданий БТС.
// См. комментарий к модулю ОчередьЗаданий:
//    Могут использоваться только методы для которых зарегистрированы псевдонимы через
//    процедуру ПриОпределенииПсевдонимовОбработчиков общего модуля ОчередьЗаданийПереопределяемый.
//
// Параметры:
//  МетодыРегламентныхЗаданий - Соответствие - ключ: имя метода регламентного задания
//
Процедура ЗарегистрироватьРегламентноеЗаданиеОчередиЗаданий(МетодыРегламентныхЗаданий) Экспорт
	
	МетодыРегламентныхЗаданий.Вставить(Метаданные.РегламентныеЗадания.ЗагрузкаДанныхВнешнихСистем.ИмяМетода);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаВБезопасномРежиме

Процедура ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений) Экспорт
	
	ОбменДаннымиСВнешнимиСистемамиБП.ПриЗаполненииРазрешенийНаДоступКВнешнимРесурсам(ЗапросыРазрешений);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти
