
////////////////////////////////////////////////////////////////////////////////
// ИнтеграцияСЯндексКассойПереопределяемый: механизм интеграции с Яндекс.Кассой.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область РаботаСПодсистемой

// В процедуре задается описание дополнительных реквизитов настройки Яндекс.Кассы,
// например, Подразделение, Банковский счет и т.д.
// Значения реквизитов будут доступны в качестве свойств структуры, описывающей операцию Яндекс.Кассы.
//
// Параметры:
//  ДополнительныеНастройки - ТаблицаЗначений - таблица дополнительных настроек с колонками:
//   * Настройка - Строка - уникальное имя настройки. Должно соответствовать требованиям именования ключей структуры.
//   * Представление - Строка - пользовательское представление настройки.
//   * ТипЗначения - ОписаниеТипов - описание типов значений настройки. Допустимые типы: ЛюбаяСсылка, Число(20,4), 
//                                   Строка(300), Булево, Дата (Дата + Время).
//
Процедура ПриОпределенииДополнительныхНастроекЯндексКассы(ДополнительныеНастройки) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриОпределенииДополнительныхНастроекЯндексКассы(ДополнительныеНастройки);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСФормами

// Выполняется при создании формы настроек Яндекс.Кассы.
// Позволяет изменить форму и определить дополнительные настройки, 
// которые требуется сохранить в информационной базе.
//
// Для добавленных элементов можно устанавливать следующие действия:
//  * ПриИзменении - Подключаемый_ЭлементПриИзменении.
//  * НачалоВыбора - Подключаемый_ЭлементНачалоВыбора.
//  * ОбработкаВыбора - Подключаемый_ЭлементОбработкаВыбора.
//  * Нажатие - Подключаемый_ЭлементНажатие.
// Для добавленных команд следует устанавливать действие "Подключаемый_ДействиеКоманды".
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - форма настроек Яндекс.Кассы.
//  Группа - ГруппаФормы - группа формы, на которой следует располагать добавляемые элементы.
//  Префикс - Строка - префикс имен для новых реквизитов, команд и элементов формы.
//  ДополнительныеНастройки - Структура - имена реквизитов, содержащих значения дополнительных настроек (для изменения).
//                            Ключ - идентификатор настройки. См. ИнтеграцияСЯндексКассойПереопределяемый.ПриОпределенииДополнительныхНастроекЯндексКассы
//                            Значение - имя реквизита формы со значением настройки.
//
Процедура ПриСозданииФормыНастроекЯндексКассы(Форма, Группа, Префикс, ДополнительныеНастройки) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриСозданииФормыНастроекЯндексКассы(Форма, Группа, Префикс, ДополнительныеНастройки);
	
КонецПроцедуры

// Выполняется перед переходом на страницу редактирования дополнительных настроек в форме настроек Яндекс.Кассы.
// Позволяет проинициализировать реквизиты дополнительных настроек и/или пропустить страницу редактирования.
//
// Параметры:
//  Контекст - Структура - контекст выполнения метода:
//   * Форма - ФормаКлиентскогоПриложения - форма настроек Яндекс.Кассы.
//   * Префикс - Строка - префикс имен добавленных реквизитов, команд и элементов формы.
//   * НоваяНастройка - Булево - признак редактирования новой настройки.
//   * Организация - ОпределяемыТип.Организация - организация, для которой производится настройка.
//   * СДоговором - Булево - признак варианта использования сервиса "С договором". Если Ложь, то "Без договора".
//  Отказ - Булево - если установить Истина, то страница редактирования дополнительных настроек будет пропущена.
//
Процедура ПередНачаломРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ = Ложь) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПередНачаломРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ);
	
КонецПроцедуры

// Выполняется перед закрытием страницы редактирования дополнительных настроек в форме настроек Яндекс.Кассы.
// Позволяет изменить значения реквизитов дополнительных настроек и/или отказаться от перехода со страницы редактирования.
//
// Параметры:
//  Контекст - Структура - контекст выполнения метода:
//   * Форма - ФормаКлиентскогоПриложения - форма настроек Яндекс.Кассы.
//   * Префикс - Строка - префикс имен добавленных реквизитов, команд и элементов формы.
//   * НоваяНастройка - Булево - признак редактирования новой настройки.
//   * Организация - ОпределяемыТип.Организация - организация, для которой производится настройка.
//   * СДоговором - Булево - признак варианта использования сервиса "С договором". Если Ложь, то "Без договора".
//  Отказ - Булево - если установить Истина, то страница редактирования дополнительных настроек не будет закрыта.
//
Процедура ПередОкончаниемРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ = Ложь) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПередОкончаниемРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаСПрикладнымРешением

// Определяет соответствие имен реквизитов оснований платежа через Яндекс.Кассу, в случае их отличия от общепринятых.
// Для каждого основания платежа требуется вставить строку вида:
// СоответствиеРеквизитов.Вставить(<ПолноеИмяМетаданных>.<ОбщепринятоеИмяРеквизита>,<ИмяРеквизитаВПрикладномРешении>);
// Требуется установить соответствие для следующих общепринятых реквизитов: "Организация".
// 
// Параметры:
//  СоответствиеРеквизитов - Соответствие - путь к реквизитам оснований платежа.
//   * Ключ - Строка - полный путь к реквизиту с использованием общепринятого имени.
//   * Значение - Строка - имя реквизита в прикладном решении.
//
Процедура СоответствиеРеквизитовОснованийПлатежа(СоответствиеРеквизитов) Экспорт 
	
КонецПроцедуры

// Определяет объекты, которые могут выступать в качестве оснований платежа через Яндекс.Кассу.
//
// Параметры:
//  ОснованияПлатежа - Массив - имена объектов метаданных (строка) оснований платежа через Яндекс.Кассу.
//
Процедура ПриОпределенииОснованийПлатежа(ОснованияПлатежа) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриОпределенииОснованийПлатежа(ОснованияПлатежа);
	
КонецПроцедуры

// Проверяет основание платежа на возможность формирования ссылки на оплату через Яндекс.Кассу.
//
// Параметры:
//  ОснованиеПлатежа - Произвольный - основание платежа, для которого формируется платежная ссылка.
//  Отказ - Булево - признак отказа от формирования ссылки.
//                   Если установить значение Истина, то ссылка не будет сформирована (обновлена).
//
Процедура ПриПроверкеЗаполненияОснованияПлатежа(Знач ОснованиеПлатежа, Отказ) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриПроверкеЗаполненияОснованияПлатежа(ОснованиеПлатежа, Отказ);
	
КонецПроцедуры

// Заполняет значения реквизитов организации по данным информационной базы.
//
// Параметры:
//  Организация - ОпределяемыйТип.Организация - организация, значения реквизитов которой нужно заполнить.
//  Реквизиты - Структура - значения реквизитов:
//   * ИНН - Строка - ИНН организации.
//   * КПП - Строка - КПП организации.
//   * Резидент - Булево - признак того, что организация является резидентом.
//   * ЭтоЮрЛицо - Булево - признак того, что организация является юридическим лицом.
//
Процедура ЗаполнитьРеквизитыОрганизации(Знач Организация, Реквизиты) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ЗаполнитьРеквизитыОрганизации(Организация, Реквизиты);
	
КонецПроцедуры

// Заполняет данные по основанию платежа, необходимые для формирование ссылки на оплату через Яндекс.Кассу.
//
// Параметры:
//  ОснованиеПлатежа - Произвольный - основание платежа, данные которого нужно заполнить.
//  ДанныеОснованияПлатежа - Структура - данные основания платежа:
//   * Идентификатор - Строка - уникальный идентификатор основание платежа (идентификатора платежа при получении операций оплаты/возврата).
//   * Номер - Строка - номер основание платежа.
//   * Сумма - Число - сумма к оплате.
//   * Валюта - Строка - код валюты по классификатору валют.
//   * НазначениеПлатежа - Строка - назначение платежа.
//   * БанковскийСчет - Структура - банковский счет для зачисления оплаты:
//    ** БанкБИК - Строка - БИК банка.
//    ** БанкНаименование - Строка - наименование банка.
//    ** БанкКоррСчет - Строка - корр. счет банка.
//    ** НомерСчета - Строка - номер расчетного счета.
//   * Продавец - Структура - данные продавца:
//    ** УчетнаяПолитика - Число - код учетной политики продавца: 1 - ОСН, 2 - УСН (доходы), 3 - УСН (доходы минус расходы), 4 - продажа облагается ЕНВД, 
//                                                                5 - единый сельскохозяйственный налог, 6 - патентная СН.
//    ** ИНН - Строка - ИНН продавца.
//    ** КПП - Строка - КПП продавца.
//    ** Наименование - Строка - наименование продавца.
//    ** Телефон - Строка - контактный телефон продавца.
//    ** ЭлектроннаяПочта - Строка - контактный адрес электронной почты продавца.
//    ** ФактическийАдрес - Строка - фактический адрес продавца.
//    ** ЮридическийАдрес - Строка - юридический адрес продавца.
//   * Покупатель - Структура - данные покупателя:
//    ** Идентификатор - Строка - уникальный идентификатор покупателя.
//    ** Наименование - Строка - для юрлица - название организации, для ИП и физического лица - ФИО. 
//                               Если у физлица отсутствует ИНН, в этом же параметре передаются паспортные данные. Не более 256 символов.
//    ** КонтактныеДанныеЧека - Строка - номер телефона или адрес электронной почты для отправки чека. Может быть переопределен в форме формирования платежной ссылки.
//    ** ИНН - Строка - ИНН покупателя (10 или 12 цифр). Если у физического лица отсутствует ИНН, необходимо передать паспортные данные в параметре Покупатель.Наименование.
//   * Номенклатура - ТаблицаЗначений - номенклатура к оплате. Колонки:
//    ** НомерСтроки - Число - номер строки по порядку.
//    ** Наименование - Строка - наименование товара/услуги.
//    ** НаименованиеПолное - Строка - полное наименование товара/услуги.
//    ** Характеристика - Строка - характеристика номенклатуры.
//    ** Количество - Число - количество позиций.
//    ** Цена - Число - цена за единицу.
//    ** СтавкаНДС - Строка - представление ставки НДС.
//    ** СтавкаНДСКод - Число - код ставки НДС. 
//       до 31.12.2018 действуют следующие коды ставок НДС: 1 - без НДС, 2 - 0%, 3 - 10%, 4 - 18%, 5 - 10/110, 6 - 18/118.
//       с  01.01.2019 действуют следующие коды ставок НДС: 1 - без НДС, 2 - 0%, 3 - 10%, 4 - 20%, 5 - 10/110, 6 - 20/120.
//    ** Валюта - Строка - представление валюты строки.
//    ** Артикул - Строка - артикул номенклатуры.
//    ** ЕдиницаИзмерения - Строка - представление единицы измерения.
//    ** ВидНоменклатуры - Строка - вид номенклатуры.
//    ** Родитель - Строка - группа номенклатуры.
//    ** Сумма - Число - сумма строки.
//    ** ПредметРасчета - Число - признак предмета расчета (категория товара для налоговой инспекции).
//                                Возможные значения:
//                                1 - товар;
//                                2 - подакцизный товар;
//                                3 - работа;
//                                4 - услуга;
//                                5 - ставка в азартной игре;
//                                6 - выигрыш в азартной игре;
//                                7 - лотерейный билет;
//                                8 - выигрыш в лотерею;
//                                9 - результаты интеллектуальной деятельности;
//                                10 - платеж;
//                                11 - агентское вознаграждение;
//                                12 - несколько вариантов;
//                                13 - другое.
//    ** КодТовара - Строка -  уникальный номер, который присваивается экземпляру товара при маркировке.
//                             Формат: число в шестнадцатеричном представлении с пробелами. Максимальная длина - 32 байта. 
//                             Пример: 00 00 00 01 00 21 FA 41 00 23 05 41 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 12 00 AB 00.
//    ** КодСтраныПроисхожденияТовара - Строка - Код страны происхождения товара по общероссийскому классификатору 
//                                               стран мира (OК (MК (ИСО 3166) 004-97) 025-2001). Пример: RU.
//    ** НомерТаможеннойДекларации - Строка - номер таможенной декларации.
//    ** СуммаАкциза - Строка - сумма акциза товара с учетом копеек (с точностью до 2 символов после точки).
//   * Штрихкоды - ТаблицаЗначений - штрихкоды номенклатуры. Колонки:
//    ** НомерСтроки - Число - номер строки номенклатуры, к которой относится штрихкод.
//    ** Штрихкод - Строка - штрихкод номенклатуры.
//
Процедура ЗаполнитьДанныеОснованияПлатежа(Знач ОснованиеПлатежа, ДанныеОснованияПлатежа) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ЗаполнитьДанныеОснованияПлатежа(ОснованиеПлатежа, ДанныеОснованияПлатежа);
	
КонецПроцедуры

// Заполняет контактную информацию покупателя для выбора в форме формирования платежной ссылки.
// Используется для отправки чека при оплате.
//
// Параметры:
//  ОснованиеПлатежа - Произвольный - основание платежа, контактную информацию которого нужно заполнить.
//  КонтактнаяИнформация - Структура - контакты покупателя для отправки чека:
//   * Телефоны - Массив строк - телефоны покупателя.
//   * ЭлектроннаяПочта - Массив строк - адреса электронной почты покупателя.
//
Процедура ЗаполнитьКонтактнуюИнформациюОснованияПлатежа(Знач ОснованиеПлатежа, КонтактнаяИнформация) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ЗаполнитьКонтактнуюИнформациюОснованияПлатежа(ОснованиеПлатежа, КонтактнаяИнформация);
	
КонецПроцедуры

// Заполняет список получателей сообщения с платежной ссылкой
//
// Параметры:
//  ОснованиеПлатежа - Произвольный - основание платежа, для которого получена платежная ссылка.
//  ВариантОтправки - Строка - способ отправки ссылки. "ЭлектроннаяПочта" - по электронной почте, "Телефон" - по SMS.
//  Получатели - СписокЗначений - адреса электронной почты или номера телефонов получателей (строка).
//
Процедура ПриФормированииСпискаПолучателейСообщения(Знач ОснованиеПлатежа, Знач ВариантОтправки, Получатели) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриФормированииСпискаПолучателейСообщения(ОснованиеПлатежа, ВариантОтправки, Получатели);
	
КонецПроцедуры

#КонецОбласти

#Область РаботаССервисом

// Выполняется при загрузке операций по Яндекс.Кассе.
// Позволяет отразить полученные операции в учете.
//
// Параметры:
//  Операции - Структура - операции полученные из сервиса по соответствующей настройке.
//                         См. ИнтеграцияСЯндексКассой.ОперацииПоЯндексКассе (элемент возвращаемого массива).
//  Результат - Произвольный - произвольный результат загрузки операций. См. ИнтеграцияСЯндексКассой.ЗагрузитьОперацииПоЯндексКассе (возвращаемое значение)
//  Отказ - Булево - признак отказа от загрузки. Если установить значение Истина, то статус обмена по данной настройке не будет обновлен.
//
Процедура ПриЗагрузкеОперацийПоЯндексКассе(Знач Операции, Результат, Отказ) Экспорт
	
	ИнтеграцияСЯндексКассойБП.ПриЗагрузкеОперацийПоЯндексКассе(Операции, Результат, Отказ);
	
КонецПроцедуры

#КонецОбласти

#Область ШаблоныСообщений

// Включает использование шаблонов сообщений для интеграции Яндекс.Кассой.
//
// Параметры:
//    Используется - Булево - признак использования шаблонов сообщений.
//
Процедура ПроверитьИспользованиеШаблоновСообщений(Используется) Экспорт

КонецПроцедуры

// Описывает предопределенные шаблоны писем,
// с помощью которых можно будет выставлять счета для оплаты через Яндекс.Кассу.
// Эти шаблоны будут доступны для создания из основной формы настроек и использоваться
// в форме формирования платежной ссылки Яндекс.Кассы.
//
// Параметры:
//    Шаблоны - Массив - Массив структур данных, описывающих предопределенные шаблоны сообщения.
//    * ПолноеИмяТипаНазначения - Строка - Полное имя объекта метаданных, на основании которого по данному шаблону 
//                                будут создаваться письма.
//    * Текст - Строка - Текст, который будет использоваться в качестве шаблона письма в формате HTML.
//    * Тема - Строка - Текст, который будет использоваться в качестве шаблона темы письма.
//    * Наименование - Строка - Текст, наименование шаблона письма.
//
Процедура ПредопределенныеШаблоныСообщений(Шаблоны) Экспорт 
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

