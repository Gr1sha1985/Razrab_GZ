#Область СлужебныеПроцедурыИФункции

Функция ПолучитьСтавкуНДС(СтавкаНДС, ПрименяютсяСтавки4и2 = Ложь) Экспорт
	
	СтавкаНДСЧислом = 0;
	РаспознаваниеДокументовПереопределяемый.ПриОпределенииСтавкиНДС(СтавкаНДСЧислом, СтавкаНДС, ПрименяютсяСтавки4и2);
	Возврат СтавкаНДСЧислом;
	
КонецФункции

Функция ПеречисленияТипВсеСсылки() Экспорт
	
	Возврат Перечисления.ТипВсеСсылки();
	
КонецФункции

#КонецОбласти

