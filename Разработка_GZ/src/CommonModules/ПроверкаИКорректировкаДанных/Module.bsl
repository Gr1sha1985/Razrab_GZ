// @strict-types

#Область ПрограммныйИнтерфейс

// Возвращает таблицу модулей проверки.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//   ВосстанавливатьНастройки - Булево - требуется или нет восстанавливать сохраненные настройки обработок.
//   ПолучатьПрошлыйРезультат - Булево - требуется или нет получать сохраненный результат.
//
// Возвращаемое значение:
//   ТаблицаЗначений - таблица с колонками:
//     * Идентификатор - УникальныйИдентификатор - идентификатор проверки.
//     * Пометка - Булево - для выбора проверки значение этого поля должно быть Истина.
//     * Имя - Строка - имя модуля.
//     * Наименование - Строка - краткое наименование проверки для пользователя.
//     * Описание - Строка - описание проверки для пользователя.
//     * ФормаНастроек - Строка - имя формы настроек, описание:
//          см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок.
//     * Настройки - Структура - структура, содержащая любой сериализуемый тип, описание:
//       ** Поля - Произвольный - произвольный набор полей.
//          см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок.
//     * ВременныеДанные - Структура - структура, содержащая любой сериализуемый тип, описание:
//       ** Поля - Произвольный - произвольный набор полей.
//          см. ПроверкаИКорректировкаДанныхПереопределяемый.ПриЗаполненииПроверок.
//     * ТребуетсяЗаполнитьНастройки - Булево - в строках, где требуется заполнить настройки, 
//          значение этого поля будет Истина.
//     * Дата - Дата - дата последней проверки.
//     * Исправлять - Булево - флаг последней проверки.
//     * ОбнаруженыПроблемы - Булево - результат последней проверки.
//     * ПредставлениеРезультата - Строка - результат последней проверки.
//     * ТабличныйДокумент - Произвольный - файл с результатом последней проверки.
//
Функция Проверки(ВосстанавливатьНастройки = Ложь, Знач ПолучатьПрошлыйРезультат = Ложь) Экспорт
КонецФункции

// Выполняет поиск проблем для выбранных строк и заполняет колонку Результат.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//   Проверки - ТаблицаЗначений - таблица полученная с помощью функции Проверки().
//   Исправлять - Булево - Истина, если требуется исправление.
//   СохранятьРезультат - Булево - если Истина, тогда результат будет сохранен в присоединенный файл.
//
// Возвращаемое значение:
//   Булево - Истина - проверка выполнена, Ложь - требуется заполнить настройки.
//
Функция ПроверитьДанные(Проверки, Исправлять = Ложь, СохранятьРезультат = Ложь) Экспорт
КонецФункции

// Выполняет извлечение табличного документа из zip-архива присоединенного файла.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//   ПрисоединенныйФайл - СправочникСсылка.ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы - файл из которого
//      требуется извлечь табличный документ.
//
// Возвращаемое значение:
//   ТабличныйДокумент - табличный документ извлеченный из архива. Если табличный документ не
//      найден, то будет вызвано исключение.
//
Функция ТабличныйДокументИзПрисоединенногоФайла(ПрисоединенныйФайл) Экспорт
КонецФункции

// Возвращает признак внедрения БСП.
// @skip-warning ПустойМетод - особенность реализации.
//
// Возвращаемое значение:
//   Булево - Истина - внедрена, Ложь - нет.
//
Функция ВнедренаБСП() Экспорт
КонецФункции

// Возвращает модуль по имени.
// @skip-warning ПустойМетод - особенность реализации.
//
// Параметры:
//   Имя - Строка - имя общего модуля.
//
// Возвращаемое значение:
//   ОбщийМодуль - ОбщийМодуль.
//
Функция Модуль(Имя) Экспорт
КонецФункции

// Заполняет массив типов, исключаемых из выгрузки и загрузки данных.
//
// Параметры:
//  Типы - Массив - заполняется метаданными.
//
Процедура ПриЗаполненииТиповИсключаемыхИзВыгрузкиЗагрузки(Типы) Экспорт
	
	Типы.Добавить(Метаданные.Справочники["ИсторияПроверкиИКорректировкиДанных"]);
	Типы.Добавить(Метаданные.Справочники["ИсторияПроверкиИКорректировкиДанныхПрисоединенныеФайлы"]);
	
КонецПроцедуры

#КонецОбласти
