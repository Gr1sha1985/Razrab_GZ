
//Структура простых обязательных реквизитов первого уровня
Функция СформироватьСтруктуруОбязательныхРеквизитовПоПроцедуре_epNotificationEZK2020_(xdto_пакет) Экспорт 
	
	Структура_notification111 = Новый Структура;
	Структура_notification111.Вставить("schemeVersion", xdto_пакет.schemeVersion);
	Структура_notification111.Вставить("id", xdto_пакет.id);
	//Структура_notification111.Вставить("externalId");
	//Структура_notification111.Вставить("purchaseNumber");
	//Структура_notification111.Вставить("directDate");
	//Структура_notification111.Вставить("docPublishDate");
	//Структура_notification111.Вставить("docNumber");
	//Структура_notification111.Вставить("href");
	//Структура_notification111.Вставить("printForm");
	Структура_notification111.Вставить("purchaseObjectInfo", xdto_пакет.purchaseObjectInfo);
	//Структура_notification111.Вставить("isBudgetUnionState");
	//Структура_notification111.Вставить("isGOZ");
	Структура_notification111.Вставить("Организация", ГЗ_РегламентныеЗадания44ФЗ.СоздатьОрганизацию(xdto_пакет.purchaseResponsible.responsibleOrg));  //данные заказчика- организации
	
	
	СтруктураЗаполненияЕТР = Новый Структура;
	СтруктураЗаполненияЕТР.Вставить("GZcode",xdto_пакет.placingWay.code);
	СтруктураЗаполненияЕТР.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.placingWay.name, "ETP"));
	СтруктураЗаполненияЕТР.Вставить("Наименование",?(xdto_пакет.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.placingWay.name, "ETP"));
	
	Структура_notification111.Вставить("placingWay", справочники.ГЗ_ETP_ЭлектроннаяТорговаяПлощадка.СоздатьЭТП(СтруктураЗаполненияЕТР));
	
	
	// Структура_notification111.Вставить("isBBST");
	// Структура_notification111.Вставить("article15FeaturesInfo");
	// Структура_notification111.Вставить("contractConclusionOnSt83Ch2");
	//Структура_notification111.Вставить("purchaseObjectInfo");
	//Структура_notification111.Вставить("okpd2okved2");
	// Структура_notification111.Вставить("isBudgetUnionState");
	
	//Структура_notification111.Вставить("procedureInfo");
	Структура_notification111.Вставить("lots", xdto_пакет.lots);
	Структура_notification111.Вставить("attachments", ?(xdto_пакет.Свойства().Получить("attachments")<> Неопределено, xdto_пакет.attachments, ""));
	//Структура_notification111.Вставить("modification");
	//Структура_notification111.Вставить("particularsActProcurement");
	
	
	Возврат Структура_notification111;
	 
КонецФункции
 
Функция  СтрукртураДанных_procedureInfo (procedureInfo)
	
	    collectingEndDate = procedureInfo.collectingEndDate;
		
КонецФункции

Функция  СтрукртураДанных_lots (lots)
	
	
КонецФункции


Функция  СтрукртураДанных_purchaseObjects (purchaseObjects)
	
	
КонецФункции

Функция  СтрукртураДанных_publicDiscussion (publicDiscussion)
	
	
КонецФункции


