

Функция СформироватьСтруктуруОбязательныхРеквизитовПоПроцедуре_purchaseNoticeAEData_(xdto_пакет) Экспорт 
	Структура_purchaseNoticeAEData = Новый Структура;

	Структура_purchaseNoticeAEData.Вставить("guid", xdto_пакет.guid);
	
	Структура_purchaseNoticeAEData.Вставить("additionalInfo",?(xdto_пакет.Свойства().Получить("additionalInfo")<> Неопределено, xdto_пакет.additionalInfo, ""));
	Структура_purchaseNoticeAEData.Вставить("applExaminationOrder",?(xdto_пакет.Свойства().Получить("applExaminationOrder")<> Неопределено, xdto_пакет.applExaminationOrder, ""));
	Структура_purchaseNoticeAEData.Вставить("applSubmisionOrder",?(xdto_пакет.Свойства().Получить("applSubmisionOrder")<> Неопределено, xdto_пакет.applSubmisionOrder, ""));
	Структура_purchaseNoticeAEData.Вставить("applSubmisionPlace",?(xdto_пакет.Свойства().Получить("applSubmisionPlace")<> Неопределено, xdto_пакет.applSubmisionPlace, ""));
	Структура_purchaseNoticeAEData.Вставить("envelopeOpeningOrder",?(xdto_пакет.Свойства().Получить("envelopeOpeningOrder")<> Неопределено, xdto_пакет.envelopeOpeningOrder, ""));
	
	
	Структура_purchaseNoticeAEData.Вставить("applSubmisionStartDate",?(xdto_пакет.Свойства().Получить("applSubmisionStartDate")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.applSubmisionStartDate), Дата(ТекущаяДата()))); 
	Структура_purchaseNoticeAEData.Вставить("Дата",?(xdto_пакет.Свойства().Получить("publicationDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.publicationDateTime), Дата(ТекущаяДата()))); 
	Структура_purchaseNoticeAEData.Вставить("deliveryEndDateTime",?(xdto_пакет.Свойства().Получить("deliveryEndDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.deliveryEndDateTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("modificationDate",?(xdto_пакет.Свойства().Получить("modificationDate")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.modificationDate), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("publicationPlannedDate",?(xdto_пакет.Свойства().Получить("publicationPlannedDate")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.publicationPlannedDate), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("summingupTime",?(xdto_пакет.Свойства().Получить("summingupTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.summingupTime), Дата(ТекущаяДата())));	
	Структура_purchaseNoticeAEData.Вставить("applExamPeriodTime",?(xdto_пакет.Свойства().Получить("applExamPeriodTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.applExamPeriodTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("auctionTime",?(xdto_пакет.Свойства().Получить("auctionTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.auctionTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("deliveryStartDateTime",?(xdto_пакет.Свойства().Получить("deliveryStartDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.deliveryStartDateTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("deliveryStartDateTime",?(xdto_пакет.Свойства().Получить("deliveryStartDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.deliveryStartDateTime), Дата(ТекущаяДата()))); 
	
	Структура_purchaseNoticeAEData.Вставить("examinationDateTime",?(xdto_пакет.Свойства().Получить("examinationDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.examinationDateTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("submissionCloseDateTime",?(xdto_пакет.Свойства().Получить("submissionCloseDateTime")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.submissionCloseDateTime), Дата(ТекущаяДата())));
	Структура_purchaseNoticeAEData.Вставить("examinationPlace",?(xdto_пакет.Свойства().Получить("examinationPlace")<> Неопределено, xdto_пакет.examinationPlace, ""));
	Структура_purchaseNoticeAEData.Вставить("modificationDescription",?(xdto_пакет.Свойства().Получить("modificationDescription")<> Неопределено, xdto_пакет.modificationDescription, ""));
	Структура_purchaseNoticeAEData.Вставить("purchaseObjectInfo",?(xdto_пакет.Свойства().Получить("name")<> Неопределено, xdto_пакет.name, ""));
	Структура_purchaseNoticeAEData.Вставить("place",?(xdto_пакет.Свойства().Получить("place")<> Неопределено, xdto_пакет.place, ""));
	Структура_purchaseNoticeAEData.Вставить("procedure",?(xdto_пакет.Свойства().Получить("procedure")<> Неопределено, xdto_пакет.procedure, ""));
	Структура_purchaseNoticeAEData.Вставить("summingupPlace",?(xdto_пакет.Свойства().Получить("summingupPlace")<> Неопределено, xdto_пакет.summingupPlace, ""));
	
	Если ТипЗнч(xdto_пакет.lots.lot) = Тип("ОбъектXDTO") Тогда 
		Структура_purchaseNoticeAEData.Вставить("initialSum", ?(xdto_пакет.lots.lot.lotData.Свойства().Получить("initialSum")<> Неопределено, xdto_пакет.lots.lot.lotData.initialSum, 0));
   КонецЕсли;
	//Структура_purchaseNoticeAEData.Вставить("directDate");
	
	//Структура_purchaseNoticeAEData.Вставить("printForm");
	//Структура_purchaseNoticeAEData.Вставить("isBudgetUnionState");
	//Структура_purchaseNoticeAEData.Вставить("isGOZ");
	Структура_purchaseNoticeAEData.Вставить("Организация", ГЗ_РаботаСXML.СоздатьОрганизацию223ФЗ(xdto_пакет.customer.mainInfo));  //данные заказчика- организации
	
	
	// Структура_purchaseNoticeAEData.Вставить("isBBST");
	// Структура_purchaseNoticeAEData.Вставить("article15FeaturesInfo");
	
	//Структура_purchaseNoticeAEData.Вставить("okpd2okved2");
	// Структура_purchaseNoticeAEData.Вставить("isBudgetUnionState");
	
	//Структура_purchaseNoticeAEData.Вставить("collectiing_endDate", СтруктураДанных_collectiing_endDate(xdto_пакет.notificationInfo.procedureInfo));
	//Структура_purchaseNoticeAEData.Вставить("collectiing_startDate", СтруктураДанных_collectiing_startDate(xdto_пакет.notificationInfo.procedureInfo));
	
	Структура_purchaseNoticeAEData.Вставить("registrationNumber",?(xdto_пакет.Свойства().Получить("registrationNumber")<> Неопределено, xdto_пакет.registrationNumber, "registrationNumber"));
	Структура_purchaseNoticeAEData.Вставить("href","https://zakupki.gov.ru/223/purchase/public/purchase/info/common-info.html?regNumber="+Структура_purchaseNoticeAEData.registrationNumber); //по 223 фз собираем ссылку на процедуру = "https://zakupki.gov.ru/223/purchase/public/purchase/info/common-info.html?regNumber=" + рег номер закупки
	
	
	//Структура_purchaseNoticeAEData.Вставить("lots", xdto_пакет.lots);
		//Структура_purchaseNoticeAEData.Вставить("modification"); // Наличие элемента говорит о внесении изменений в закупку
	//Структура_purchaseNoticeAEData.Вставить("particularsActProcurement");
	Структура_purchaseNoticeAEData.Вставить("lot", СтруктураДанных_СписокТоваровУслуг(xdto_пакет));
	
	Если xdto_пакет.Свойства().Получить("electronicPlaceId") <> Неопределено Тогда 
		СтруктураЗаполненияЕТР = Новый Структура;
		СтруктураЗаполненияЕТР.Вставить("GZcode",xdto_пакет.electronicPlaceInfo.electronicPlaceId);
		СтруктураЗаполненияЕТР.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.electronicPlaceInfo.Свойства().Получить("name")<> Неопределено, xdto_пакет.electronicPlaceInfo.name, "ETP"));
		СтруктураЗаполненияЕТР.Вставить("Наименование",?(xdto_пакет.electronicPlaceInfo.Свойства().Получить("name")<> Неопределено, xdto_пакет.electronicPlaceInfo.name, "ETP"));
		СтруктураЗаполненияЕТР.Вставить("url", ?(xdto_пакет.electronicPlaceInfo.свойства().Получить("url")<> Неопределено, xdto_пакет.electronicPlaceInfo.url, "url"));
		Структура_purchaseNoticeAEData.Вставить("electronicPlaceInfo", справочники.ГЗ_ETP_ЭлектроннаяТорговаяПлощадка.СоздатьЭТП(СтруктураЗаполненияЕТР));
	КонецЕсли;
	
	Если xdto_пакет.Свойства().Получить("purchaseMethodCode") <> Неопределено Тогда 
		СтруктураЗаполненияplacingWay = Новый Структура;
		СтруктураЗаполненияplacingWay.Вставить("GZcode",xdto_пакет.purchaseMethodCode);
		СтруктураЗаполненияplacingWay.Вставить("ГЗ_НаименованиеПолное",xdto_пакет.purchaseCodeName);
		СтруктураЗаполненияplacingWay.Вставить("Наименование",xdto_пакет.purchaseCodeName);
		Структура_purchaseNoticeAEData.Вставить("purchaseMethodCode", справочники.ГЗ_placingWay_ПодспособОпределенияПоставщика.СоздатьПодспособОпределенияПоставщика(СтруктураЗаполненияplacingWay));
	КонецЕсли;	
	Возврат Структура_purchaseNoticeAEData;
	
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
		
		ТабличнаяЧастьИзвещения = документы.ГЗ_ИзвещениеОПроведенииЗакупок223ФЗ.ВернутьСтруктуруТабличнойЧастиДокумента();
		
		Если xdto_пакет.Свойства().Получить("lots")<> Неопределено Тогда 
			Если xdto_пакет.lots.свойства().Получить("lot") <> Неопределено Тогда 
				Если ТипЗнч(xdto_пакет.lots.lot) = Тип("ОбъектXDTO") Тогда
					Если xdto_пакет.lots.lot.свойства().Получить("lotData") <> Неопределено Тогда 
						Если xdto_пакет.lots.lot.lotData.свойства().Получить("lotItems") <> Неопределено Тогда
							Если xdto_пакет.lots.lot.lotData.lotItems.свойства().Получить("lotItem") <> Неопределено Тогда
								Если ТипЗнч(xdto_пакет.lots.lot.lotData.lotItems.lotItem) =  Тип("СписокXDTO") Тогда
									
									Для Каждого СтрокаТЧ Из  xdto_пакет.lots.lot.lotData.lotItems.lotItem Цикл
										
										НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
										
										НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("okei")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.okei.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
										
										НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("additionalInfo")<> Неопределено, СтрокаТЧ.additionalInfo, "");
										
										//НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
										
										НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("okpd2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.okpd2.code,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
										
										НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
										НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);
										
										НоваяСтрокаТЧ.purchaseObject_Строкой= ?(СтрокаТЧ.Свойства().Получить("okpd2")<> Неопределено, СтрокаТЧ.okpd2.code,"");

									КонецЦикла; 
								ИначеЕсли ТипЗнч(xdto_пакет.lots.lot.lotData.lotItems.lotItem) =  Тип("ОбъектXDTO") Тогда
									
									   СтрокаТЧ= xdto_пакет.lots.lot.lotData.lotItems.lotItem; 
										
										НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
										
										НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("okei")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.okei.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
										
										НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("additionalInfo")<> Неопределено, СтрокаТЧ.additionalInfo, "");
										
										//НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
										
										НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("okpd2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.okpd2.code,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
										
										НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, ?(СтрокаТЧ.quantity.Свойства().Получить("value")<>Неопределено,СтрокаТЧ.quantity.value,0),0);
										НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);
										
										НоваяСтрокаТЧ.purchaseObject_Строкой= ?(СтрокаТЧ.Свойства().Получить("okpd2")<> Неопределено, СтрокаТЧ.okpd2.code,"");

								КонецЕсли;
								
							КонецЕсли;
						КонецЕсли;
					КонецЕсли;
					
				КонецЕсли;
			КонецЕсли;
			КонецЕсли;
			Возврат ТабличнаяЧастьИзвещения;	
КонецФункции

Функция  СтруктураДанных_purchaseObjects (purchaseObjects)
	
	
КонецФункции

Функция  СтруктураДанных_publicDiscussion (publicDiscussion)
	
	
КонецФункции


