
#Область СлужебныеПроцедурыИФункции

Функция ПубликуемаяСтруктураПредприятия(Позиции) Экспорт

	Возврат КабинетСотрудникаБазовый.ПубликуемаяСтруктураПредприятия(Позиции);

КонецФункции

Процедура СоздатьВТШтатноеРасписание(МенеджерВТ) Экспорт
	
	КабинетСотрудникаБазовый.СоздатьВТШтатноеРасписание(МенеджерВТ);
	
КонецПроцедуры

Функция ПодразделениеВСтруктуреПредприятия(Подразделение) Экспорт

	Возврат КабинетСотрудникаБазовый.ПодразделениеВСтруктуреПредприятия(Подразделение);

КонецФункции

Функция ИменаКонтролируемыхПолей(Объект) Экспорт

	Возврат КабинетСотрудникаБазовый.ИменаКонтролируемыхПолей(Объект);

КонецФункции

Процедура ОбъектПриЗаписи(Объект) Экспорт

	КабинетСотрудникаБазовый.ОбъектПриЗаписи(Объект);

КонецПроцедуры

Процедура ОбъектПередЗаписью(Объект) Экспорт

	КабинетСотрудникаБазовый.ОбъектПередЗаписью(Объект);

КонецПроцедуры

Функция ФотографииФизическихЛиц(ФизическиеЛица) Экспорт

	Возврат КабинетСотрудникаБазовый.ФотографииФизическихЛиц(ФизическиеЛица);

КонецФункции

Процедура ОбработатьИзменениеКадровойИстории(ИзменившиесяДанные) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Функция ТипШтатноеРасписание() Экспорт

	Возврат КабинетСотрудникаБазовый.ТипШтатноеРасписание();

КонецФункции

Функция ТипСтруктураПредприятия() Экспорт

	Возврат КабинетСотрудникаБазовый.ТипСтруктураПредприятия();

КонецФункции

Функция ДанныеСтруктурыПредприятия(СписокОтбора) Экспорт

	Возврат КабинетСотрудникаБазовый.ДанныеСтруктурыПредприятия(СписокОтбора);

КонецФункции

Функция ДанныеШтатногоРасписания(СписокОтбора) Экспорт

	Возврат КабинетСотрудникаБазовый.ДанныеШтатногоРасписания(СписокОтбора);

КонецФункции

Процедура ДобавитьСотрудникиДляОбновленияПубликацииПравНаОтпуск(Сотрудник) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ОчиститьДанныеПриОтключенииСервиса() Экспорт

	// в базовой реализации не переопределяется
	
КонецПроцедуры

Процедура ОбновитьСтруктуруПредприятия() Экспорт

	КабинетСотрудникаБазовый.ОбновитьСтруктуруПредприятия();

КонецПроцедуры

Функция НоваяПубликуемаяСтруктураПредприятияПозиций(Позиции) Экспорт

	Возврат КабинетСотрудникаБазовый.НоваяПубликуемаяСтруктураПредприятияПозиций(Позиции);

КонецФункции

Функция ТипыОбрабатываемыхЗаявок() Экспорт

	Возврат КабинетСотрудникаБазовый.ТипыОбрабатываемыхЗаявок();

КонецФункции

Функция КоличествоДнейОтпускаФизическогоЛица(ФизическоеЛицо, ДатаНачала, ДатаОкончания) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	// в базовой реализации не переопределяется
	
КонецПроцедуры

Функция МестаПозицийВСтруктуреПредприятия(Позиции) Экспорт
	
	Возврат КабинетСотрудникаБазовый.МестаПозицийВСтруктуреПредприятия(Позиции);

КонецФункции

Процедура ОчиститьДанныеОбАктуальностиИнформацииОбОтпускеНепубликуемыхСотрудников() Экспорт 
	
	// в базовой реализации не переопределяется
	
КонецПроцедуры

Функция КадровыеДанныеСотрудников(МассивОтбора, ВыбираемыеПоля, ВедетсяШтатноеРасписание) Экспорт

	Возврат КабинетСотрудникаБазовый.КадровыеДанныеСотрудников(МассивОтбора, ВыбираемыеПоля, ВедетсяШтатноеРасписание);

КонецФункции

Процедура ТекущиеКадровыеДанныеСотрудниковПередЗаписью(НаборЗаписей) Экспорт

	КабинетСотрудникаБазовый.ТекущиеКадровыеДанныеСотрудниковПередЗаписью(НаборЗаписей);

КонецПроцедуры

Процедура ТекущиеКадровыеДанныеСотрудниковПриЗаписи(НаборЗаписей) Экспорт

	КабинетСотрудникаБазовый.ТекущиеКадровыеДанныеСотрудниковПриЗаписи(НаборЗаписей);

КонецПроцедуры

Функция ДоступнаяФункциональностьСервиса() Экспорт

	Возврат КабинетСотрудникаБазовый.ДоступнаяФункциональностьСервиса();

КонецФункции

Функция КадровыеДанныеОбновляемыхСотрудников(МенеджерВТ) Экспорт
	
	Возврат КабинетСотрудникаБазовый.КадровыеДанныеОбновляемыхСотрудников(МенеджерВТ);
	
КонецФункции

Функция ДанныеСправокСРаботы(ПараметрыПодключения, МассивОтбора) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

Функция ДанныеСправокОбОстаткеОтпуска(ПараметрыПодключения, МассивОтбора) Экспорт
	
	Возврат Неопределено;
	
КонецФункции

Процедура ОбработатьЗапросСправокСРаботы(СтрокаТаблицы, ОбъектыАдресации, СрокиИсполнения, РольИсполнителя, ПараметрыПодключения, КадровыеДанные) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ОбработатьЗапросСправокОбОстаткеОтпуска(СтрокаТаблицы, ОбъектыАдресации, СрокиИсполнения, РольИсполнителя) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ОбработатьЗапросЗаявкиНаОтсутствие(СтрокаТаблицы, ОбъектыАдресации, СрокиИсполнения, РольИсполнителя, ПараметрыПодключения, ПричинаОтсутствия) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Функция КадровыеДанныеДляЗапросовСправокСРаботы(Заявки) Экспорт
	
	Возврат Новый Массив;

КонецФункции

Процедура ДобавитьЭлементыБлокировкиПриОбновленииПубликации(Блокировка) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ЗарегистрироватьОбновлениеПубликуемыхОбъектов(ПубликуемыеОбъекты) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ОпубликоватьПрочиеИзменения(ПараметрыПодключения, БылиОшибки) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

Процедура ЗаполнитьДанныеДляОбработкиЗаявок(ТаблицаДанных, ТаблицаЗаявок, ЗарегистрированныеЗаявки, СписокФизическихЛиц, ТипЗаявки) Экспорт

	// в базовой реализации не переопределяется

КонецПроцедуры

#КонецОбласти
