///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Предназначена для внесения изменений в форму Обслуживание обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура ОбслуживаниеПриСозданииНаСервере(Форма) Экспорт
	
	Форма.Элементы.ОбщаяКомандаПанельОтчетовАдминистрирование.Видимость = Ложь;
	
	Декорация = Форма.Элементы.Добавить(
		"ПростойИнтерфейс_ПанельОтчетовАдминистрирование",
		Тип("ДекорацияФормы"),
		Форма.Элементы.ГруппаОтчетыАдминистратора
	);
	Декорация.Заголовок = Новый ФорматированнаяСтрока(
		Метаданные.ОбщиеКоманды.ПанельОтчетовАдминистрирование.Синоним,,,,
		"e1cib/command/Обработка.ПанелиПростойИнтерфейс.Команда.ПанельОтчетовАдминистрирование"
	);
	Декорация.Подсказка = Метаданные.ОбщиеКоманды.ПанельОтчетовАдминистрирование.Подсказка;
	Декорация.ОтображениеПодсказки = ОтображениеПодсказки.ОтображатьСнизу;
	
	Форма.Элементы.ГруппаОткрытьОписаниеИзмененийСистемы.Видимость = Ложь;
	
КонецПроцедуры

// Предназначена для внесения изменений в форму ОбщиеНастройки обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура ОбщиеНастройкиПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Предназначена для внесения изменений в форму Обслуживание обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура НастройкиПользователейИПравПриСозданииНаСервере(Форма) Экспорт
	
	ЗарплатаКадры.НастройкиПользователейИПравПриСозданииНаСервере(Форма);
	
КонецПроцедуры

// Предназначена для внесения изменений в форму ИнтернетПоддержкаИСервисы обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура ИнтернетПоддержкаИСервисыПриСозданииНаСервере(Форма) Экспорт
	
	Форма.Элементы.ГруппаОткрытьОписаниеИзмененийСистемы.Видимость = Ложь;
	
КонецПроцедуры

// Предназначена для внесения изменений в форму Органайзер обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура ОрганайзерПриСозданииНаСервере(Форма) Экспорт
	
	МоиЗадачи.НастроитьФормуОрганайзер(Форма);
	
КонецПроцедуры

// Предназначена для внесения изменений в форму СинхронизацияДанных обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура СинхронизацияДанныхПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Предназначена для внесения изменений в форму НастройкиРаботыСФайлами обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура НастройкиРаботыСФайламиПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

// Предназначена для внесения изменений в форму ПечатныеФормыОтчетыИОбработки обработки
// ПанельАдминистрированияБСП без снятия формы с поддержки.
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - для внесения изменений.
//
Процедура ПечатныеФормыОтчетыИОбработкиПриСозданииНаСервере(Форма) Экспорт
	
КонецПроцедуры

#КонецОбласти