
&НаКлиенте
Процедура hrefНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	ЗапуститьПриложение(Объект.href);
КонецПроцедуры

&НаКлиенте
Процедура printFormНажатие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	ЗапуститьПриложение(Объект.printForm);
КонецПроцедуры

&НаКлиенте
Процедура ИмяФайлаОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка=Ложь;
	
	КаталогПоиска  = ГЗ_РаботаСXML.ВернутьПутьХраненияФайлов("Извещения44ФЗ");	
	
    ЗапуститьПриложение(КаталогПоиска+объект.ИмяФайла);

КонецПроцедуры
