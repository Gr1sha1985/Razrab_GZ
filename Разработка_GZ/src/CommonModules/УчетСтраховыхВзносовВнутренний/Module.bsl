
#Область СлужебныйПрограммныйИнтерфейс

// Специфические алгоритмы чтения данных.

// Помещает в переданный МенеджерВременныхТаблиц таблицу 
//	ВТКадровыхДанных, которая содержит следующие поля:
//		Сотрудник - СправочникСсылка.Сотрудники
//		Период - дата
//		Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//		Должность - СправочникСсылка.Должности
//		ЯвляетсяФармацевтом - булево.
//		ЛьготныйТерриториальныйТариф - СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//		ЯвляетсяРаботникомСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//		ЯвляетсяПрокурором - булево.
//		ЯвляетсяВоеннослужащим - булево.
//		РаботаетВСтуденческомОтряде - булево.
//		ЯвляетсяЧленомЛетногоЭкипажа - булево.
//		ЯвляетсяШахтером - булево
//		КоэффициентУчетаСтроки - число от 0 до 1.
//      	 
// Параметры:
//		Организация -
//		ПериодРегистрации - дата -
//		МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - содержит вр. таблицу ВТНачисленияСтраховыеВзносы с полями:
//				Сотрудник -
//				Период - дата -
//				Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления -
//				Подразделение - 
//				СуммаДохода - 
//				СуммаВычетаВзносы -
//				ОблагаетсяЕНВД -
//				ВидДохода - СправочникСсылка.ВидыДоходовПоСтраховымВзносам -
//		УточнятьПериодКадровыхДанных - булево - если выставлен в Истина, период будет скорректирован с учетом дат приема и
//		                                        увольнения, для работающих постоянно - выставлен на конец месяца.
//		МенеджерКадровогоУчета - Общий модуль - держатель метода СоздатьВТКадровыеДанныеСотрудников.
//
Процедура СформироватьВТКадровыхДанных(Организация, ПериодРегистрации, МенеджерВременныхТаблиц, УточнятьПериодКадровыхДанных = Истина, МенеджерКадровогоУчета = Неопределено) Экспорт
	УчетСтраховыхВзносовБазовый.СформироватьВТКадровыхДанных(Организация, ПериодРегистрации, МенеджерВременныхТаблиц, УточнятьПериодКадровыхДанных)	
КонецПроцедуры

// Помещает в переданный МенеджерВременныхТаблиц таблицу 
//	ВТНачисленияСДаннымиУчета, которая содержит следующие поля:
//		Сотрудник - СправочникСсылка.Сотрудники
//		ФизическоеЛицо - СправочникСсылка.ФизическиеЛица
//		ДатаНачала - дата
//		ДатаПолученияДохода - дата.
//		Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//		ВидДохода - СправочникСсылка.ВидыДоходовПоСтраховымВзносам -
//		Подразделение - СправочникСсылка.ПодразделенияОрганизаций
//		ЯвляетсяДоходомФармацевта - булево.
//		ЛьготныйТерриториальныйТариф - СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//		ОблагаетсяВзносамиЗаЗанятыхНаРаботахСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//		КлассУсловийТруда - ПеречислениеСсылка.КлассыУсловийТрудаПоРезультатамСпециальнойОценки
//		ОблагаетсяВзносамиНаДоплатуЛетчикам - булево.
//		ОблагаетсяВзносамиНаДоплатуШахтерам - булево.
//		Сумма - число 
//		Скидка - число.
//      	 
// Параметры:
//		Организация -
//		ПериодРегистрации - дата -
//		МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - содержит 
//			вр. таблицу ВТНачисления с полями
//				Сотрудник -
//				ДатаНачала - дата -
//				Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления -
//				Подразделение - 
//				СуммаДохода - 
//				СуммаВычетаВзносы -
//      	        и, возможно, другими
//			вр. таблицу ВТСДаннымиУчета, с полями
//				Сотрудник - СправочникСсылка.Сотрудники
//				ФизическоеЛицо - СправочникСсылка.ФизическиеЛица
//				ДатаНачала - дата
//				Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//				ВидДохода - СправочникСсылка.ВидыДоходовПоСтраховымВзносам -
//				Подразделение - СправочникСсылка.ПодразделенияОрганизаций
//				ЯвляетсяФармацевтом - булево.
//				ЛьготныйТерриториальныйТариф - СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//				ОблагаетсяВзносамиЗаЗанятыхНаРаботахСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//				КлассУсловийТруда - ПеречислениеСсылка.КлассыУсловийТрудаПоРезультатамСпециальнойОценки
//				ОблагаетсяВзносамиНаДоплатуЛетчикам - булево.
//				ОблагаетсяВзносамиНаДоплатуШахтерам - булево.
//				КоэффициентУчетаСтроки - число от 0 до 1.
//		ИсключаемыйРегистратор - ДокументСсылка -
//
Процедура СформироватьВТНачисленияСДаннымиУчета(Организация, ПериодРегистрации, МенеджерВременныхТаблиц, ИсключаемыйРегистратор) Экспорт
	УчетСтраховыхВзносовБазовый.СформироватьВТНачисленияСДаннымиУчета(Организация, ПериодРегистрации, МенеджерВременныхТаблиц)	
КонецПроцедуры

// Помещает в переданный МенеджерВременныхТаблиц таблицу 
//	ВТСДаннымиУчета, которая содержит следующие поля
//		Сотрудник - СправочникСсылка.Сотрудники
//		ФизическоеЛицо - СправочникСсылка.ФизическиеЛица
//		ДатаНачала - дата
//		Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//		ВидДохода - СправочникСсылка.ВидыДоходовПоСтраховымВзносам -
//		Подразделение - СправочникСсылка.ПодразделенияОрганизаций
//		ЯвляетсяФармацевтом - булево.
//		ЛьготныйТерриториальныйТариф - СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//		ОблагаетсяВзносамиЗаЗанятыхНаРаботахСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//		КлассУсловийТруда - ПеречислениеСсылка.КлассыУсловийТрудаПоРезультатамСпециальнойОценки
//		ОблагаетсяВзносамиНаДоплатуЛетчикам - булево.
//		ОблагаетсяВзносамиНаДоплатуШахтерам - булево.
//		КоэффициентУчетаСтроки - число от 0 до 1.
//      	 
// Параметры:
//		Организация -
//		ПериодРегистрации - дата -
//		МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - содержит
//			вр. таблицу ВТНачисления с полями:
//				Сотрудник - СправочникСсылка.Сотрудники
//				ДатаНачала - дата
//				Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//				ПодразделениеОрганизации - СправочникСсылка.ПодразделенияОрганизаций
//			вр. таблицу ВТКадровыхДанных с полями:
//				Сотрудник - СправочникСсылка.Сотрудники
//				ДатаНачала - дата
//				Начисление - ПеречислениеСсылка.ВидыОсобыхНачисленийИУдержаний, ПланВидовРасчетаСсылка.Начисления
//				Подразделение - СправочникСсылка.ПодразделенияОрганизаций
//				Должность - СправочникСсылка.Должности
//				ЯвляетсяФармацевтом - булево.
//				ЛьготныйТерриториальныйТариф - СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//				ЯвляетсяРаботникомСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//				ЯвляетсяПрокурором - булево.
//				ЯвляетсяВоеннослужащим - булево.
//				РаботаетВСтуденческомОтряде - булево.
//				ЯвляетсяЧленомЛетногоЭкипажа - булево.
//				ЯвляетсяШахтером - булево.
//				КоэффициентУчетаСтроки - число от 0 до 1.
//
Процедура СформироватьВТСДаннымиУчета(Организация, ПериодРегистрации, МенеджерВременныхТаблиц) Экспорт 
	УчетСтраховыхВзносовБазовый.СформироватьВТСДаннымиУчета(Организация, ПериодРегистрации, МенеджерВременныхТаблиц)	
КонецПроцедуры

// Помещает в переданный МенеджерВременныхТаблиц таблицу 
//	ВТКлассыУсловийТруда, которая содержит следующие поля:
//		Организация - СправочникСсылка.Организация
//		Период - дата
//		КлассУсловийТруда - ПеречислениеСсылка.КлассыУсловийТрудаПоРезультатамСпециальнойОценки
//		ВидыРаботСДосрочнойПенсией - ПеречислениеСсылка.ВидыРаботСДосрочнойПенсией
//
// Параметры:
//		МенеджерВременныхТаблиц - МенеджерВременныхТаблиц
//
Процедура СоздатьВТКлассыУсловийТруда(МенеджерВременныхТаблиц) Экспорт
	УчетСтраховыхВзносовБазовый.СоздатьВТКлассыУсловийТруда(МенеджерВременныхТаблиц);
КонецПроцедуры

// Возвращает список доступных тарифов страховых взносов в зависимости
// от настроек учета по организации.
//
// Параметры: 
// 	ВидОрганизации - ПеречислениеСсылка.ЮридическоеФизическоеЛицо - 
//	ПрименяетсяУСН - булево - определяет, применяется ли для организации УСН.
//	ПоказыватьТарифыПрименяемыеПоОтдельнымДоходам - булево - необязательный.
//
// Возвращаемое значение:
//	Массив значений типа СправочникСсылка.ВидыТарифовСтраховыхВзносов.
//
Функция ДоступныеТарифыСтраховыхВзносов(ВидОрганизации, ПрименяетсяУСН, ПоказыватьТарифыПрименяемыеПоОтдельнымДоходам) Экспорт
	Возврат УчетСтраховыхВзносовБазовый.ДоступныеТарифыСтраховыхВзносов(ВидОрганизации, ПрименяетсяУСН, ПоказыватьТарифыПрименяемыеПоОтдельнымДоходам);
КонецФункции

// Получает из параметра Ссылка ссылку на организацию и помещает в массив
//
//	Параметры:
//		ОтборПоОрганизациям - тип Неопределено, в этот параметр помещается массив организаций
//								полученный их параметра Ссылка
//		Ссылка - ссылка на объект из которого можно получить организацию.
//
Процедура ЗаполнитьОтборПоОрганизацииПриУстановкеИспользованияСтраховыхВзносовПоКлассамУсловийТруда(ОтборПоОрганизациям, Ссылка) Экспорт

	// в базовой реализации отбор не заполняется

КонецПроцедуры



#КонецОбласти

