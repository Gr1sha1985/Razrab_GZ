
#Область СлужебныйПрограммныйИнтерфейс

// Формирует движения по регистрам подсистемы.
//      	 
// Параметры:
//		Движения - коллекция движений регистратора.
//		Отказ - булево - признак отказа от заполнения движений.
//		Организация - СправочникСсылка.Организации -
//		Регистратор - ДокументСсылка - 
//		ТаблицаВыплат - ТаблицаЗначений - 
//		Записывать - булево - признак того, надо ли записывать движения сразу, или они будут записаны позже.
//
Процедура СформироватьДокументыОплаченныеБезУдержанияНДФЛ(Движения, Отказ, Организация, Регистратор, ТаблицаВыплат, Записывать = Ложь) Экспорт
	УчетНДФЛБазовый.СформироватьДокументыОплаченныеБезУдержанияНДФЛ(Движения, Отказ, Организация, Регистратор, ТаблицаВыплат, Записывать)
КонецПроцедуры

// Дополняет перечень оплачиваемых платежным документом начислятелей оплаченными ранее документами, по которым по
// желанию пользователя не был удержан налог.
//      	 
// Параметры:
//      Регистратор - ДокументСсылка - ссылка на документ-регистратор.
//		Организация - СправочникСсылка.Организации -
//		ДатаОперации - дата - дата, которой будет зарегистрировано движение.
//		ПериодРегистрации - дата - 
//      МенеджерВременныхТаблиц - МенеджерВременныхТаблиц, содержит вр. таблицу 
//      	ВТСписокСотрудников с полями 
//				ФизическоеЛицо: должно быть непустым
//          	СуммаВыплаты,
//          	ДокументОснование,
//          	СуммаНачисленная,
//          	СуммаВыплаченная
//		ТаблицаВыплат - таблица значений - выплачиваемые документом-регистратором суммы с колонками
//		ИмяТаблицыСписокСотрудников - Строка - 
//      	 
Процедура ДописатьДокументыОплаченныеБезУдержанияНДФЛ(Регистратор, Организация, ДатаОперации, ПериодРегистрации, МенеджерВременныхТаблиц, ТаблицаВыплат, ИмяТаблицыСписокСотрудников) Экспорт
	УчетНДФЛБазовый.ДописатьДокументыОплаченныеБезУдержанияНДФЛ(Регистратор, Организация, ДатаОперации, ПериодРегистрации, МенеджерВременныхТаблиц, ТаблицаВыплат, ИмяТаблицыСписокСотрудников)
КонецПроцедуры

#КонецОбласти

