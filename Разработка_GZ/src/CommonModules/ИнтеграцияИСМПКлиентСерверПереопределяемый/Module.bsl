#Область ПрограммныйИнтерфейс

Процедура ЗаполнитьСоответствиеПолейДокументовОснований(Форма, СоответствиеПолей) Экспорт
	
	Если СтрНачинаетсяС(Форма.ИмяФормы, "Документ.МаркировкаТоваровИСМП") Тогда
		
		СоответствиеПолей.Вставить("ОприходованиеТоваров", Новый Соответствие);
		СоответствиеПолей["ОприходованиеТоваров"].Вставить("Организация", "Организация");
		
		СоответствиеПолей.Вставить("ИнвентаризацияТоваровНаСкладе", Новый Соответствие);
		СоответствиеПолей["ИнвентаризацияТоваровНаСкладе"].Вставить("Организация", "Организация");
		
		СоответствиеПолей.Вставить("ОтчетПроизводстваЗаСмену", Новый Соответствие);
		СоответствиеПолей["ОтчетПроизводстваЗаСмену"].Вставить("Организация", "Организация");
		
	ИначеЕсли СтрНачинаетсяС(Форма.ИмяФормы, "Документ.ВыводИзОборотаИСМП") Тогда
		
		СоответствиеПолей.Вставить("СписаниеТоваров", Новый Соответствие);
		СоответствиеПолей["СписаниеТоваров"].Вставить("Организация", "Организация");
		
	ИначеЕсли СтрНачинаетсяС(Форма.ИмяФормы, "Документ.ПеремаркировкаТоваровИСМП") Тогда
		
		СоответствиеПолей.Вставить("ВозвратТоваровОтПокупателя", Новый Соответствие);
		СоответствиеПолей["ВозвратТоваровОтПокупателя"].Вставить("Организация", "Организация");
		
		СоответствиеПолей.Вставить("ОтчетОРозничныхПродажах", Новый Соответствие);
		СоответствиеПолей["ОтчетОРозничныхПродажах"].Вставить("Организация", "Организация");
		
	КонецЕсли;
	
КонецПроцедуры

// Реализовать получение значения Признать определяемого типа ВариантДействийПоРасхождениямКодовМаркировкиИСМП.
// Параметры:
//  ВариантДействия - ОпределяемыйТип.ВариантДействийПоРасхождениямКодовМаркировкиИСМП - значение варината действия.
//
Процедура ПриОпределенииВариантаДействийПоРасхождениямКодовМаркировкиИСМППризнать(ВариантДействия) Экспорт
	
	
КонецПроцедуры

// Реализовать получение значения НеПризнать определяемого типа ВариантДействийПоРасхождениямКодовМаркировкиИСМП.
//
// Параметры:
//  ВариантДействия - ОпределяемыйТип.ВариантДействийПоРасхождениямКодовМаркировкиИСМП - значение варината действия.
//
Процедура ПриОпределенииВариантаДействийПоРасхождениямКодовМаркировкиИСМПНеПризнать(ВариантДействия) Экспорт
	
	
КонецПроцедуры

#КонецОбласти
