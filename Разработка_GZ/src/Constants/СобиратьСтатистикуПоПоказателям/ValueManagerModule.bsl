#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	НайденныеРегламентныеЗадания = РегламентныеЗадания.ПолучитьРегламентныеЗадания(
		Новый Структура("Метаданные", Метаданные.РегламентныеЗадания.ЭкспортНакопленнойСтатистики));
		
	Для Каждого РегламентноеЗадание Из НайденныеРегламентныеЗадания Цикл
		РегламентноеЗадание.Использование = Значение;
		РегламентноеЗадание.Записать();
	КонецЦикла;
	
	Если Значение Тогда
		Константы.НижняяГраницаСчитыванияСтатистики.Установить(ТекущаяДата());	
	КонецЕсли;
		
КонецПроцедуры

#КонецЕсли