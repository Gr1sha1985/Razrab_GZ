#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
    	Возврат;
    КонецЕсли;
	
	Если НЕ Константы.ИнтерфейсЭлектронныхТрудовыхКнижек.Получить() Тогда
		Константы.ИспользоватьКадровыйУчетОсновнойИнтерфейс.Установить(Значение);
	Иначе
		Константы.ИспользоватьКадровыйУчетОсновнойИнтерфейс.Установить(Ложь);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
