
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!
	
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ

	// регистр ГЗ_ЗакупкиПоОрганизациям	
	Движения.ГЗ_ЗакупкиПоОрганизациям.Записывать = Истина;
	
	// регистр ГЗ_ЗакупкиПоРегионам
	Движения.ГЗ_ЗакупкиПоРегионам.Записывать = Истина;

	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ГЗ_ИзвещениеОПроведенииЗакупок223ФЗlot.purchaseObject КАК purchaseObject,
		|	СУММА(ГЗ_ИзвещениеОПроведенииЗакупок223ФЗlot.sum) КАК sum
		|ИЗ
		|	Документ.ГЗ_ИзвещениеОПроведенииЗакупок223ФЗ.lot КАК ГЗ_ИзвещениеОПроведенииЗакупок223ФЗlot
		|ГДЕ
		|	ГЗ_ИзвещениеОПроведенииЗакупок223ФЗlot.Ссылка = &Ссылка
		|
		|СГРУППИРОВАТЬ ПО
		|	ГЗ_ИзвещениеОПроведенииЗакупок223ФЗlot.purchaseObject";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);

	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл

		Движение = Движения.ГЗ_ЗакупкиПоОрганизациям.Добавить();
		Движение.Организация = Ссылка.Организация;
		Движение.Период = Ссылка.Дата;
		Движение.ОКПД2_Полный = ВыборкаДетальныеЗаписи.purchaseObject;
		
		МассивОКПД2 = СтрРазделить(Движение.ОКПД2_Полный, ".",Истина);
		
		Если МассивОКПД2.Количество() = 4 Тогда 
			Движение.ОКПД2_3Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]+"."+МассивОКПД2[1]+"."+МассивОКПД2[2]);
			Движение.ОКПД2_2Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]+"."+МассивОКПД2[1]);
			Движение.ОКПД2_1Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]);
		КонецЕсли;

		Движение.ДатаОкончанияПодачиЗаявок = Ссылка.submissionCloseDateTime;
		Движение.Сумма = ВыборкаДетальныеЗаписи.sum;
		
		
		ДвижениеПоРегионам = Движения.ГЗ_ЗакупкиПоРегионам.Добавить();
		ДвижениеПоРегионам.КодСубъектаРФ = Лев(Ссылка.Организация.ИНН, 2);
		ДвижениеПоРегионам.Период=Ссылка.Дата;
		ДвижениеПоРегионам.ОКПД2_Полный = ВыборкаДетальныеЗаписи.purchaseObject;
		
		МассивОКПД2 = СтрРазделить(Движение.ОКПД2_Полный, ".",Истина);
		
		Если МассивОКПД2.Количество() = 4 Тогда 
			ДвижениеПоРегионам.ОКПД2_3Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]+"."+МассивОКПД2[1]+"."+МассивОКПД2[2]);
			ДвижениеПоРегионам.ОКПД2_2Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]+"."+МассивОКПД2[1]);
			ДвижениеПоРегионам.ОКПД2_1Уровень = Справочники.КлассификаторОКПД2.НайтиПоКоду(МассивОКПД2[0]);
		КонецЕсли;
		
		ДвижениеПоРегионам.ДатаОкончанияПодачиЗаявок = Ссылка.submissionCloseDateTime;
		ДвижениеПоРегионам.Сумма = ВыборкаДетальныеЗаписи.sum;

		
	КонецЦикла;

	

КонецПроцедуры
