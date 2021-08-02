///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2020, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Вызывается перед началом получения данных в форме Монитора в контексте клиента.
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора.
//
//@skip-warning
Процедура ПередПолучениемДанныхМонитора(Форма) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при обработке команды в форме Монитора Портала 1С:ИТС
// из обработчика "Подключаемый_ОбработатьКоманду".
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора;
//	Команда - КомандаФормы - команда, для которой вызывается обработчик;
//
//@skip-warning
Процедура ОбработатьКомандуВФормеМонитора(Форма, Команда) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при обработке события Нажатие элемента декорации в
// форме Монитора Интернет-поддержки из обработчика "Подключаемый_ДекорацияНажатие".
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора;
//	Элемент - ДекорацияФормы - декорация, для которой вызвано событие;
//
//@skip-warning
Процедура ПриНажатииДекорацииВФормеМонитора(Форма, Элемент) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при обработке события ОбработкаНавигационнойСсылки элемента
// декорации в форме Монитора Портала 1С:ИТС из обработчика
// "Подключаемый_ОбработатьНавигационнуюСсылку";
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора;
//	Элемент - ДекорацияФормы - декорация, для которой вызвано событие;
//	НавигационнаяСсылкаФорматированнойСтроки - Строка - ссылка;
//	СтандартнаяОбработка - Булево - признак стандартной обработки;
//
//@skip-warning
Процедура ОбработатьНавигационнуюСсылкуВФормеМонитора(
	Форма,
	Элемент,
	НавигационнаяСсылкаФорматированнойСтроки,
	СтандартнаяОбработка) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при выполнении обработчика ожидания в форме Монитора Портала 1С:ИТС,
// подключаемого методом МониторПортала1СИТСКлиент.ПодключитьОбработчикОжиданияВФормеМонитора().
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора.
//
//@skip-warning
Процедура ПриВыполненииОбработчикаОжиданияВФормеМонитора(Форма) Экспорт
	
	
	
КонецПроцедуры

// Вызывается при обработке события ПриЗакрытии в форме Монитора Портала 1С:ИТС.
// Описание формы Монитора см. в методе ПриСозданииФормыМонитора общего
// модуля МониторПортала1СИТСПереопределяемый, параметр Форма.
//
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - форма Монитора;
//	ЗавершениеРаботы - Булево - одноименный параметр обработчика формы.
//
//@skip-warning
Процедура ПриЗакрытииФормыМонитора(Форма, ЗавершениеРаботы) Экспорт
	
	
	
КонецПроцедуры

#КонецОбласти
