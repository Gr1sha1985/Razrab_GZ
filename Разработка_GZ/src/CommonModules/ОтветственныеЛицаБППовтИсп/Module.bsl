////////////////////////////////////////////////////////////////////////////////
// Ответственные лица: процедуры и функции для работы с ответственным лицами.
//  
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Функция возвращает структуру со сведениями об ответственных лицах.
//
// Параметры:
//  Организация   - СправочникСсылка.Организации - Организация, для которой нужно определить ответственных лиц.
//  ДатаСреза     - Дата - Дата со временем, на которые необходимо определить сведения.
//  Подразделение - СправочникСсылка.ПодразделенияОрганизаций - Подразделение, для которого необходимо определить ответственных лиц.
//
// Возвращаемое значение:
//	Структура - Структура с ключами, соответствующими имени значений перечисления ОтветственныеЛица вида:
//		* Руководитель - СправочникСсылка.ФизическиеЛица.
//		* РуководительФИО - структура (Фамилия, Имя, Отчество, Представление).
//		* РуководительПредставление - строка, Фамилия И.О.
//		* РуководительДолжность - СправочникСсылка.Должности.
//		* РуководительДолжностьПредставление - строка, название должности.
//
Функция ОтветственныеЛица(Организация, ДатаСреза, Подразделение = Неопределено) Экспорт

	Возврат Новый ФиксированнаяСтруктура(ОтветственныеЛицаБППереопределяемый.ОтветственныеЛица(Организация, ДатаСреза, Подразделение));

КонецФункции

// Функция возвращает массив дат изменения ответственных лиц.
//
// Параметры:
//  Организация   - СправочникСсылка.Организации - Организация, для которой нужно получить массив дат изменений ответственных лиц.
//
// Возвращаемое значение:
//	Массив - Массив дат изменения ответственных лиц.
//
Функция ДатыИзмененияОтветственныхЛицОрганизаций(Организация) Экспорт

	Возврат Новый ФиксированныйМассив(ОтветственныеЛицаБППереопределяемый.ДатыИзмененияОтветственныхЛицОрганизаций(Организация));

КонецФункции

#КонецОбласти
