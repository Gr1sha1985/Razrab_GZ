
//Структура простых обязательных реквизитов первого уровня
Функция СформироватьСтруктуруОбязательныхРеквизитовПоПроцедуре_epNotificationEZK2020_(xdto_пакет) Экспорт 
	
	Структура_epNotificationEZK2020 = Новый Структура;
	Структура_epNotificationEZK2020.Вставить("schemeVersion", xdto_пакет.schemeVersion);
	Структура_epNotificationEZK2020.Вставить("id", xdto_пакет.id);
	Структура_epNotificationEZK2020.Вставить("externalId",?(xdto_пакет.Свойства().Получить("externalId")<> Неопределено, xdto_пакет.externalId, ""));

	//Структура_epNotificationEZK2020.Вставить("directDate");
	
	//Структура_epNotificationEZK2020.Вставить("printForm");
	//Структура_epNotificationEZK2020.Вставить("isBudgetUnionState");
	//Структура_epNotificationEZK2020.Вставить("isGOZ");
	Структура_epNotificationEZK2020.Вставить("Организация", ГЗ_РаботаСXML.СоздатьОрганизацию44ФЗ(xdto_пакет.purchaseResponsibleInfo.responsibleOrgInfo));  //данные заказчика- организации
		
	
	// Структура_epNotificationEZK2020.Вставить("isBBST");
	// Структура_epNotificationEZK2020.Вставить("article15FeaturesInfo");

	//Структура_epNotificationEZK2020.Вставить("okpd2okved2");
	// Структура_epNotificationEZK2020.Вставить("isBudgetUnionState");
	Если xdto_пакет.notificationInfo.Свойства().Получить("procedureInfo") <> Неопределено Тогда 
	Структура_epNotificationEZK2020.Вставить("collectiing_endDate", СтруктураДанных_collectiing_endDate(xdto_пакет.notificationInfo.procedureInfo));
	Структура_epNotificationEZK2020.Вставить("collectiing_startDate", СтруктураДанных_collectiing_startDate(xdto_пакет.notificationInfo.procedureInfo));
	КонецЕсли;
	//Структура_epNotificationEZK2020.Вставить("lots", xdto_пакет.lots);
	Структура_epNotificationEZK2020.Вставить("attachments", ?(xdto_пакет.Свойства().Получить("attachments")<> Неопределено, xdto_пакет.attachmentsInfo, ""));
	//Структура_epNotificationEZK2020.Вставить("modification"); // Наличие элемента говорит о внесении изменений в закупку
	//Структура_epNotificationEZK2020.Вставить("particularsActProcurement");
	Структура_epNotificationEZK2020.Вставить("purchaseObjects", СтруктураДанных_СписокТоваровУслуг(xdto_пакет));
	
	commonInfo = ?(xdto_пакет.Свойства().Получить("commonInfo")<> Неопределено, xdto_пакет.commonInfo, "");	
	Если ТипЗнч(commonInfo) <> "" Тогда // Значит объект XDTO
		Если ТипЗнч(commonInfo) = Тип("ОбъектXDTO") Тогда
			//Структура_epNotificationEZK2020.Вставить("Организация", ГЗ_РегламентныеЗадания44ФЗ.СоздатьОрганизацию(xdto_пакет.purchaseResponsibleInfo.responsibleOrgInfo));  //данные заказчика- организации
			Структура_epNotificationEZK2020.Вставить("href",?(xdto_пакет.commonInfo.Свойства().Получить("href")<> Неопределено, xdto_пакет.commonInfo.href, "href"));
		    Структура_epNotificationEZK2020.Вставить("purchaseNumber",?(xdto_пакет.commonInfo.Свойства().Получить("purchaseNumber")<> Неопределено, xdto_пакет.commonInfo.purchaseNumber, "purchaseNumber"));
			Структура_epNotificationEZK2020.Вставить("docNumber",?(xdto_пакет.commonInfo.Свойства().Получить("docNumber")<> Неопределено, СтрЗаменить(xdto_пакет.commonInfo.docNumber, "№",""),""));
			Структура_epNotificationEZK2020.Вставить("contractConclusionOnSt83Ch2",?(xdto_пакет.commonInfo.Свойства().Получить("contractConclusionOnSt83Ch2")<> Неопределено, xdto_пакет.commonInfo.contractConclusionOnSt83Ch2, "Ложь"));
			Структура_epNotificationEZK2020.Вставить("purchaseObjectInfo",?(xdto_пакет.commonInfo.Свойства().Получить("purchaseObjectInfo")<> Неопределено, xdto_пакет.commonInfo.purchaseObjectInfo, ""));
			Структура_epNotificationEZK2020.Вставить("Дата",?(xdto_пакет.commonInfo.Свойства().Получить("plannedPublishDate")<> Неопределено,XMLЗначение(Тип("Дата"),xdto_пакет.commonInfo.plannedPublishDate), ТекущаяДата()));

			
			Если xdto_пакет.commonInfo.Свойства().Получить("ETP")<> Неопределено Тогда  
				
				СтруктураЗаполненияЕТР = Новый Структура;
				СтруктураЗаполненияЕТР.Вставить("GZcode",xdto_пакет.commonInfo.ETP.code);
				СтруктураЗаполненияЕТР.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.commonInfo.ETP.Свойства().Получить("name")<> Неопределено, xdto_пакет.commonInfo.ETP.name, "ETP"));
				СтруктураЗаполненияЕТР.Вставить("Наименование",?(xdto_пакет.commonInfo.ETP.Свойства().Получить("name")<> Неопределено, xdto_пакет.commonInfo.ETP.name, "ETP"));
				СтруктураЗаполненияЕТР.Вставить("url", ?(xdto_пакет.commonInfo.ETP.свойства().Получить("url")<> Неопределено, xdto_пакет.commonInfo.ETP.url, "url"));
				Структура_epNotificationEZK2020.Вставить("ETP", справочники.ГЗ_ETP_ЭлектроннаяТорговаяПлощадка.СоздатьЭТП(СтруктураЗаполненияЕТР));
				
			ИначеЕсли xdto_пакет.Свойства().Получить("notificationInfo") <> Неопределено Тогда 
				Если xdto_пакет.notificationInfo.Свойства().Получить("ETPInfo") <> Неопределено Тогда
					
					СтруктураЗаполненияЕТР = Новый Структура;
					СтруктураЗаполненияЕТР.Вставить("GZcode",xdto_пакет.notificationInfo.ETPInfo.code);
					СтруктураЗаполненияЕТР.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.notificationInfo.ETPInfo.Свойства().Получить("name")<> Неопределено, xdto_пакет.notificationInfo.ETPInfo.name, "ETP"));
					СтруктураЗаполненияЕТР.Вставить("Наименование",?(xdto_пакет.notificationInfo.ETPInfo.Свойства().Получить("name")<> Неопределено, xdto_пакет.notificationInfo.ETPInfo.name, "ETP"));
					СтруктураЗаполненияЕТР.Вставить("url", ?(xdto_пакет.notificationInfo.ETPInfo.свойства().Получить("url")<> Неопределено, xdto_пакет.notificationInfo.ETPInfo.url, "url"));
					Структура_epNotificationEZK2020.Вставить("ETP", справочники.ГЗ_ETP_ЭлектроннаяТорговаяПлощадка.СоздатьЭТП(СтруктураЗаполненияЕТР));
				КонецЕсли;			
			КонецЕсли;
			//СтруктураЗаполненияplacingWay = Новый Структура;
			//СтруктураЗаполненияplacingWay.Вставить("GZcode",xdto_пакет.commonInfo.placingWay.code);
			//СтруктураЗаполненияplacingWay.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.commonInfo.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.commonInfo.placingWay.name, "ETP"));
			//СтруктураЗаполненияplacingWay.Вставить("Наименование",?(xdto_пакет.commonInfo.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.commonInfo.placingWay.name, "ETP"));
			//Структура_epNotificationEZK2020.Вставить("placingWay", справочники.ГЗ_placingWay_ПодспособОпределенияПоставщика.СоздатьПодспособОпределенияПоставщика(СтруктураЗаполненияplacingWay));
			
		КонецЕсли;
	КонецЕсли;
	
	Возврат Структура_epNotificationEZK2020;
	 
	 
КонецФункции
 
Функция  СтруктураДанных_collectiing_endDate (procedureInfo)
	
	collectingEndDate = НачалоГода(ТекущаяДата());
	
	Если procedureInfo.Свойства().Получить("collectingEndDate")<> Неопределено Тогда 
		collectingEndDate = XMLЗначение(Тип("Дата"),procedureInfo.collectingEndDate);
	ИначеЕсли procedureInfo.Свойства().Получить("collectingInfo")<> Неопределено Тогда 	
		collectingEndDate = XMLЗначение(Тип("Дата"),procedureInfo.collectingInfo.endDT);
	КонецЕсли;
	
	Возврат collectingEndDate;
КонецФункции

Функция  СтруктураДанных_collectiing_startDate (procedureInfo)
	
	collectingEndDate = НачалоГода(ТекущаяДата());
	
	Если procedureInfo.Свойства().Получить("collectingStartDate")<> Неопределено Тогда 
		collectingEndDate = XMLЗначение(Тип("Дата"),procedureInfo.collectingStartDate);
	ИначеЕсли procedureInfo.Свойства().Получить("collectingInfo")<> Неопределено Тогда 	
		collectingEndDate = XMLЗначение(Тип("Дата"),procedureInfo.collectingInfo.startDT);
	КонецЕсли;
	
	Возврат collectingEndDate;
КонецФункции

Функция  СтруктураДанных_СписокТоваровУслуг (xdto_пакет)
	
	//1 варинат drugPurchaseObjectsInfo.drugPurchaseObjectInfo  - лекарства
	//2 вариант purchaseObjects.purchaseObject - остальное
	ТабличнаяЧастьИзвещения = Новый ТаблицаЗначений;
	
	Если xdto_пакет.свойства().Получить("purchaseObjects") <> Неопределено Тогда 
		ТабличнаяЧастьИзвещения = ГЗ_РаботаСXML.ЗаполнитьТЧИзвещения_purchaseObjects(xdto_пакет); //передавать объект XDTO с которым будет работа 
	ИначеЕсли   xdto_пакет.свойства().Получить("drugPurchaseObjectsInfo") <> Неопределено Тогда 
		ТабличнаяЧастьИзвещения = ГЗ_РаботаСXML.ЗаполнитьТЧИзвещения_drugPurchaseObjectsInfo(xdto_пакет);
	//ИначеЕсли xdto_пакет.свойства().Получить("notificationInfo")<> Неопределено Тогда 
	//	Если xdto_пакет.notificationInfo.Своства().Получить("purchaseObjectsInfo") <> Неопределено Тогда 
	//		Если xdto_пакет.notificationInfo.purchaseObjectsInfo.свойства().Получить("notDrugPurchaseObjectsInfo") <> Неопределено Тогда
	//			ТабличнаяЧастьИзвещения = ГЗ_РаботаСXML.ЗаполнитьТЧИзвещения_drugPurchaseObjectsInfo(xdto_пакет);
	//		КонецЕсли;
	//	КонецЕсли;
		
	Иначе	
		ЗаписьЖурналаРегистрации("ИнформационнаяБаза.ФЗ_44_ЗагрузкаДанныхИзXML", 
		УровеньЖурналаРегистрации.Ошибка, , ,
		"При загрузке данных для табличной части не обнаружен источник. Номер документа: " + Строка(?(xdto_пакет.Свойства().Получить("docNumber")<> Неопределено, xdto_пакет.docNumber, "№")));
	КонецЕсли;
	
	Возврат ТабличнаяЧастьИзвещения;
	
	//ТабличнаяЧастьИзвещения = документы.ГЗ_ИзвещениеОПроведенииЗакупок.ВернутьСтруктуруТабличнойЧастиДокумента();
	//
	//Если xdto_пакет.Свойства().Получить("notificationInfo")<> Неопределено Тогда 
	//	Если xdto_пакет.notificationInfo.свойства().Получить("purchaseObjectsInfo") <> Неопределено Тогда 
	//		Если xdto_пакет.notificationInfo.purchaseObjectsInfo.свойства().Получить("notDrugPurchaseObjectsInfo") <> Неопределено Тогда   //xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.drugPurchaseObjectInfo
	//			Если xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.Свойства().Получить("purchaseObject") <> Неопределено Тогда 
	//				Если ТипЗнч(xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.purchaseObject) = Тип("СписокXDTO") Тогда 
	//					Для Каждого СтрокаТЧ Из  xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.purchaseObject Цикл
	//						НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//						НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//						НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//						НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//						НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//						НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//						
	//						Если Не ЗначениеЗаполнено(НоваяСтрокаТЧ.purchaseObject.Ссылка) Тогда //ОКПД2 получим из КТРУ
	//							КодКТРУ = ?(СтрокаТЧ.Свойства().Получить("KTRU")<> Неопределено, СтрокаТЧ.KTRU.code, "");
	//							МассивЗначенийКТРУ = СтрРазделить(КодКТРУ, "-");
	//							НоваяСтрокаТЧ.purchaseObject= Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрЗаменить(МассивЗначенийКТРУ[0],".000",""));	//Убрать нули на конце						 
	//						КонецЕсли;
	//						
	//						НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
	//						НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);
	//					КонецЦикла;
	//				Иначе
	//					СтрокаТЧ = xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.purchaseObject;
	//					НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//					НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//					НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//					НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//					НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//					НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//					
	//					Если Не ЗначениеЗаполнено(НоваяСтрокаТЧ.purchaseObject.Ссылка) Тогда //ОКПД2 получим из КТРУ
	//						КодКТРУ = ?(СтрокаТЧ.Свойства().Получить("KTRU")<> Неопределено, СтрокаТЧ.KTRU.code, "");
	//						МассивЗначенийКТРУ = СтрРазделить(КодКТРУ, "-");
	//						НоваяСтрокаТЧ.purchaseObject= Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрЗаменить(МассивЗначенийКТРУ[0],".000",""));	//Убрать нули на конце						 							 
	//					КонецЕсли;
	//					
	//					НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
	//					НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);	
	//				КонецЕсли;	
	//			КонецЕсли;
	//			
	//		ИначеЕсли xdto_пакет.notificationInfo.purchaseObjectsInfo.свойства().Получить("drugPurchaseObjectsInfo") <> Неопределено Тогда   //xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.drugPurchaseObjectInfo
	//              Если xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.Свойства().Получить("drugPurchaseObjectInfo") <> Неопределено Тогда 
	//				Если ТипЗнч(xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.drugPurchaseObjectInfo) = Тип("СписокXDTO") Тогда 
	//					Для Каждого СтрокаТЧ Из  xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.drugPurchaseObjectInfo Цикл
	//						НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//						НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//						НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//						НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//						НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//						НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//						
	//						Если Не ЗначениеЗаполнено(НоваяСтрокаТЧ.purchaseObject.Ссылка) Тогда //ОКПД2 получим из КТРУ
	//							КодКТРУ = ?(СтрокаТЧ.Свойства().Получить("KTRU")<> Неопределено, СтрокаТЧ.KTRU.code, "");
	//							МассивЗначенийКТРУ = СтрРазделить(КодКТРУ, "-");
	//							НоваяСтрокаТЧ.purchaseObject= Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрЗаменить(МассивЗначенийКТРУ[0],".000",""));	//Убрать нули на конце						 
	//						КонецЕсли;
	//						
	//						НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
	//						НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);
	//					КонецЦикла;
	//				Иначе
	//					СтрокаТЧ = xdto_пакет.notificationInfo.purchaseObjectsInfo.drugPurchaseObjectsInfo.drugPurchaseObjectInfo;
	//					НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//					НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//					НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//					НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//					НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//					НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//					
	//					Если Не ЗначениеЗаполнено(НоваяСтрокаТЧ.purchaseObject.Ссылка) Тогда //ОКПД2 получим из КТРУ
	//						КодКТРУ = ?(СтрокаТЧ.Свойства().Получить("KTRU")<> Неопределено, СтрокаТЧ.KTRU.code, "");
	//						МассивЗначенийКТРУ = СтрРазделить(КодКТРУ, "-");
	//						НоваяСтрокаТЧ.purchaseObject= Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрЗаменить(МассивЗначенийКТРУ[0],".000",""));	//Убрать нули на конце						 							 
	//					КонецЕсли;
	//					
	//					НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
	//					НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);	
	//				КонецЕсли;	
	//			КонецЕсли;

	//			
	//		КонецЕсли;
	//	КонецЕсли;
	//КонецЕсли;
	//
	//Возврат ТабличнаяЧастьИзвещения;	
КонецФункции



























































