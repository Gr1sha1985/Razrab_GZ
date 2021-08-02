
//Структура простых обязательных реквизитов первого уровня
Функция СформироватьСтруктуруОбязательныхРеквизитовПоПроцедуре_notification111_(xdto_пакет) Экспорт 
	
	СтруктураДанныхДляИзвещения = Новый Структура;
	СтруктураДанныхДляИзвещения.Вставить("schemeVersion", xdto_пакет.schemeVersion);
	
	СтруктураДанныхДляИзвещения.Вставить("Дата",?(xdto_пакет.Свойства().Получить("docPublishDate")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.docPublishDate), ТекущаяДата()));
	
	СтруктураДанныхДляИзвещения.Вставить("id", xdto_пакет.id);
	СтруктураДанныхДляИзвещения.Вставить("externalId",?(xdto_пакет.Свойства().Получить("externalId")<> Неопределено, xdto_пакет.externalId, ""));
	СтруктураДанныхДляИзвещения.Вставить("purchaseNumber",?(xdto_пакет.Свойства().Получить("purchaseNumber")<> Неопределено, xdto_пакет.purchaseNumber, "purchaseNumber"));
	СтруктураДанныхДляИзвещения.Вставить("directDate",?(xdto_пакет.Свойства().Получить("directDate")<> Неопределено, XMLЗначение(Тип("Дата"),xdto_пакет.directDate), Дата("00010101")));
	СтруктураДанныхДляИзвещения.Вставить("docPublishDate",?(xdto_пакет.Свойства().Получить("docPublishDate")<> Неопределено, xdto_пакет.docPublishDate, Дата("00010101")));
	СтруктураДанныхДляИзвещения.Вставить("docNumber",?(xdto_пакет.Свойства().Получить("docNumber")<> Неопределено, СтрЗаменить(xdto_пакет.docNumber, "№",""),""));
	СтруктураДанныхДляИзвещения.Вставить("href",?(xdto_пакет.Свойства().Получить("href")<> Неопределено, xdto_пакет.href, "href"));
	СтруктураДанныхДляИзвещения.Вставить("printForm",?(xdto_пакет.Свойства().Получить("printForm")<> Неопределено, xdto_пакет.printForm.url, ""));
	
	СтруктураДанныхДляИзвещения.Вставить("purchaseObjectInfo",?(xdto_пакет.Свойства().Получить("purchaseObjectInfo")<> Неопределено, xdto_пакет.purchaseObjectInfo, "")); 
	
	СтруктураДанныхДляИзвещения.Вставить("isGOZ",?(xdto_пакет.Свойства().Получить("isGOZ")<> Неопределено, ?(xdto_пакет.isGOZ = "true", Истина, Ложь), Ложь));
	СтруктураДанныхДляИзвещения.Вставить("isBBST",?(xdto_пакет.Свойства().Получить("isBBST")<> Неопределено, ?(xdto_пакет.isBBST = "true", Истина, Ложь), Ложь));
	
	СтруктураДанныхДляИзвещения.Вставить("modification", ?(xdto_пакет.Свойства().Получить("modification")<> Неопределено, xdto_пакет.modification.modificationNumber, 0));
	
	
	СтруктураЗаполненияplacingWay = Новый Структура;
	СтруктураЗаполненияplacingWay.Вставить("GZcode",xdto_пакет.placingWay.code);
	СтруктураЗаполненияplacingWay.Вставить("ГЗ_НаименованиеПолное",?(xdto_пакет.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.placingWay.name, "ETP"));
	СтруктураЗаполненияplacingWay.Вставить("Наименование",?(xdto_пакет.placingWay.Свойства().Получить("name")<> Неопределено, xdto_пакет.placingWay.name, "ETP"));
	СтруктураДанныхДляИзвещения.Вставить("placingWay", справочники.ГЗ_placingWay_ПодспособОпределенияПоставщика.СоздатьПодспособОпределенияПоставщика(СтруктураЗаполненияplacingWay));
	
	СтруктураДанныхДляИзвещения.Вставить("article15FeaturesInfo",?(xdto_пакет.Свойства().Получить("article15FeaturesInfo")<> Неопределено, xdto_пакет.article15FeaturesInfo, ""));
	СтруктураДанныхДляИзвещения.Вставить("contractConclusionOnSt83Ch2",?(xdto_пакет.Свойства().Получить("contractConclusionOnSt83Ch2")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.contractConclusionOnSt83Ch2), "Ложь"));
	
	//Информация об ЭТП
	СтруктураДанныхДляИзвещения.Вставить("ETP", ГЗ_РаботаСXML.ПолучитьЗначениеETP(xdto_пакет.ETP));
	
	//Информация о прецедуре закупки, состоит из блоков collecting (обязательный), scoring(необязательный), bidding(необязательный)
	procedureInfo =?(xdto_пакет.Свойства().Получить("procedureInfo")<> Неопределено, xdto_пакет.procedureInfo, "");
	
	Если ТипЗнч(procedureInfo) = Тип("ОбъектXDTO") Тогда 
		
		Если procedureInfo.Свойства().Получить("collecting")<> Неопределено Тогда 
			СтруктураДанныхДляИзвещения.Вставить("collectiing_startDate",?(procedureInfo.collecting.Свойства().Получить("startDate")<> Неопределено, XMLЗначение(Тип("Дата"),procedureInfo.collecting.startDate), Дата("00010101")));
			СтруктураДанныхДляИзвещения.Вставить("collectiing_place",?(procedureInfo.collecting.Свойства().Получить("place")<> Неопределено, procedureInfo.collecting.place, ""));
			СтруктураДанныхДляИзвещения.Вставить("collectiing_order",?(procedureInfo.collecting.Свойства().Получить("order")<> Неопределено, procedureInfo.collecting.order, ""));
			СтруктураДанныхДляИзвещения.Вставить("collectiing_endDate",?(procedureInfo.collecting.Свойства().Получить("endDate")<> Неопределено, XMLЗначение(Тип("Дата"),procedureInfo.collecting.endDate), Дата("00010101")));
			СтруктураДанныхДляИзвещения.Вставить("collectiing_addInfo",?(procedureInfo.collecting.Свойства().Получить("addInfo")<> Неопределено, procedureInfo.collecting.addInfo, ""));
		КонецЕсли;
		
		
		//Информация о прецедуре рассмотрения закупки
		
		Если procedureInfo.Свойства().Получить("scoring")<> Неопределено Тогда 
			СтруктураДанныхДляИзвещения.Вставить("scoring_date",?(procedureInfo.scoring.Свойства().Получить("date")<> Неопределено, XMLЗначение(Тип("Дата"),procedureInfo.scoring.date), Дата("00010101")));
		КонецЕсли;
		
		//Информация о проведении аукциона в электронной форме	
		Если procedureInfo.Свойства().Получить("bidding")<> Неопределено Тогда 
			СтруктураДанныхДляИзвещения.Вставить("bidding_date",?(procedureInfo.bidding.Свойства().Получить("date")<> Неопределено, XMLЗначение(Тип("Дата"),procedureInfo.bidding.date), Дата("00010101")));
			СтруктураДанныхДляИзвещения.Вставить("bidding_addinfo",?(procedureInfo.bidding.Свойства().Получить("addinfo")<> Неопределено, procedureInfo.bidding.addinfo,""));
		КонецЕсли;
		
	КонецЕсли;
	
	Если xdto_пакет.Свойства().Получить("lot")<> Неопределено Тогда
		//СтруктураДанныхДляИзвещения.Вставить("purchaseObjects", СтруктураДанных_СписокТоваровУслуг(xdto_пакет.lot));
		СтруктураДанныхДляИзвещения.Вставить("maxPrice",?(xdto_пакет.lot.Свойства().Получить("maxPrice")<> Неопределено, xdto_пакет.lot.maxPrice, 0));
		
		Если xdto_пакет.свойства().Получить("purchaseObjects") <> Неопределено Тогда 
			СтруктураДанныхДляИзвещения.Вставить("totalSum",?(xdto_пакет.lot.purchaseObjects.Свойства().Получить("totalSum")<> Неопределено, xdto_пакет.lot.purchaseObjects.totalSum, 0));
			СтруктураДанныхДляИзвещения.Вставить("totalSumCurrency",?(xdto_пакет.lot.purchaseObjects.Свойства().Получить("totalSumCurrency")<> Неопределено, xdto_пакет.lot.purchaseObjects.totalSumCurrency, 0));
		ИначеЕсли  xdto_пакет.свойства().Получить("drugPurchaseObjectsInfo") <> Неопределено Тогда 
			СтруктураДанныхДляИзвещения.Вставить("totalSum",?(xdto_пакет.lot.drugPurchaseObjectsInfo.Свойства().Получить("total")<> Неопределено, xdto_пакет.lot.drugPurchaseObjectsInfo.total, 0));
			СтруктураДанныхДляИзвещения.Вставить("totalSumCurrency",?(xdto_пакет.lot.drugPurchaseObjectsInfo.Свойства().Получить("total")<> Неопределено, xdto_пакет.lot.drugPurchaseObjectsInfo.total, 0));
		КонецЕсли;
		
		СтруктураДанныхДляИзвещения.Вставить("priceFormula",?(xdto_пакет.lot.Свойства().Получить("priceFormula")<> Неопределено, xdto_пакет.lot.priceFormula, ""));
		СтруктураДанныхДляИзвещения.Вставить("standardContractNumber",?(xdto_пакет.lot.Свойства().Получить("standardContractNumber")<> Неопределено, xdto_пакет.lot.standardContractNumber, ""));
		СтруктураДанныхДляИзвещения.Вставить("financeSource",?(xdto_пакет.lot.Свойства().Получить("financeSource")<> Неопределено, xdto_пакет.lot.financeSource, ""));		
		СтруктураДанныхДляИзвещения.Вставить("interbudgetaryTransfer",?(xdto_пакет.lot.Свойства().Получить("interbudgetaryTransfer")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.lot.interbudgetaryTransfer), ""));
		СтруктураДанныхДляИзвещения.Вставить("quantityUndefined",?(xdto_пакет.lot.Свойства().Получить("quantityUndefined")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.lot.quantityUndefined), ""));
		СтруктураДанныхДляИзвещения.Вставить("isContractPriceFormula",?(xdto_пакет.lot.Свойства().Получить("isContractPriceFormula")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.lot.isContractPriceFormula), ""));
		
		СтруктураДанныхДляИзвещения.Вставить("restrictInfo",?(xdto_пакет.lot.Свойства().Получить("restrictInfo")<> Неопределено, xdto_пакет.lot.restrictInfo, ""));
		
		СтруктураДанныхДляИзвещения.Вставить("restrictForeignsInfo",?(xdto_пакет.lot.Свойства().Получить("restrictForeignsInfo")<> Неопределено, xdto_пакет.lot.restrictForeignsInfo, ""));
		СтруктураДанныхДляИзвещения.Вставить("addInfo",?(xdto_пакет.lot.Свойства().Получить("addInfo")<> Неопределено, xdto_пакет.lot.addInfo, ""));
		СтруктураДанныхДляИзвещения.Вставить("noPublicDiscussion",?(xdto_пакет.lot.Свойства().Получить("noPublicDiscussion")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.lot.noPublicDiscussion), ""));
		СтруктураДанныхДляИзвещения.Вставить("mustPublicDiscussion",?(xdto_пакет.lot.Свойства().Получить("mustPublicDiscussion")<> Неопределено, ГЗ_РаботаСXML.ПреобразоватьЗначениеВБулево(xdto_пакет.lot.mustPublicDiscussion), ""));
		
		//Валюта извещения
		Если  xdto_пакет.lot.Свойства().Получить("currency")<> Неопределено Тогда
			СтруктураДанныхДляИзвещения.Вставить("currency",Справочники.Валюты.НайтиПоКоду(xdto_пакет.lot.currency.code));
		Иначе 
			СтруктураДанныхДляИзвещения.Вставить("currency",Справочники.Валюты.НайтиПоНаименованию("RUB")); 
		КонецЕсли;		
		
		//Требования заказчиков
		Если  xdto_пакет.lot.Свойства().Получить("customerRequirements")<> Неопределено Тогда
			Если  xdto_пакет.lot.customerRequirements.Свойства().Получить("customerRequirement")<> Неопределено Тогда
				Если ТипЗнч(xdto_пакет.lot.customerRequirements.customerRequirement) = Тип("ОбъектXDTO") Тогда // Доработать разбор списка!!!! 
					СтруктураДанныхДляИзвещения.Вставить("maxPrice",?(xdto_пакет.lot.customerRequirements.customerRequirement.Свойства().Получить("maxPrice")<> Неопределено,xdto_пакет.lot.customerRequirements.customerRequirement.maxPrice, 0));
					СтруктураДанныхДляИзвещения.Вставить("maxPriceCurrency",?(xdto_пакет.lot.customerRequirements.customerRequirement.Свойства().Получить("maxPriceCurrency")<> Неопределено,xdto_пакет.lot.customerRequirements.customerRequirement.maxPriceCurrency, 0));
					СтруктураДанныхДляИзвещения.Вставить("advancePaymentSum",?(xdto_пакет.lot.customerRequirements.customerRequirement.Свойства().Получить("advancePaymentSum")<> Неопределено,xdto_пакет.lot.customerRequirements.customerRequirement.advancePaymentSum.sumInPercents, 0));
					СтруктураДанныхДляИзвещения.Вставить("provisionWarranty",?(xdto_пакет.lot.customerRequirements.customerRequirement.Свойства().Получить("provisionWarranty")<> Неопределено,xdto_пакет.lot.customerRequirements.customerRequirement.provisionWarranty.amount, 0));
					//СтруктураДанныхДляИзвещения.Вставить("contractGuarantee",?(xdto_пакет.lot.customerRequirements.customerRequirement.Свойства().Получить("contractGuarantee")<> Неопределено,xdto_пакет.lot.customerRequirements.customerRequirement.contractGuarantee.amount, 0));
				КонецЕсли;
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	СтруктураДанныхДляИзвещения.Вставить("Организация", ГЗ_РаботаСXML.СоздатьОрганизацию44ФЗ(xdto_пакет.purchaseResponsible.responsibleOrg));  //данные заказчика- организации
	
	
	Возврат СтруктураДанныхДляИзвещения;	
	
КонецФункции

Функция  СтрукртураДанных_procedureInfo (procedureInfo)
	
	collectingEndDate = procedureInfo.collectingEndDate;
	
КонецФункции

Функция  СтрукртураДанных_lots (lots)
	ТабличнаяЧастьИзвещения = Документы.ГЗ_ИзвещениеОПроведенииЗакупок.ВернутьСтруктуруТабличнойЧастиДокумента();
	
	//Если ТипЗнч(lots.lot) = Тип("ОбъектXDTO") Тогда
	//	
	//	СтрокаТЧ = lots.lot;
	//	
	//	НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//	НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//	НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//	НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//	НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//	НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//	НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, СтрокаТЧ.quantity.value, 0);
	//	НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);	 
	//ИначеЕсли  ТипЗнч(lots.lot) = Тип("СписокXDTO") Тогда
	//	
	//КонецЕсли;
	//
	//
	//
	// Если ТипЗнч(xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.purchaseObject) = Тип("СписокXDTO") Тогда 
	//					Для Каждого СтрокаТЧ Из  xdto_пакет.notificationInfo.purchaseObjectsInfo.notDrugPurchaseObjectsInfo.purchaseObject Цикл
	//						НоваяСтрокаТЧ = ТабличнаяЧастьИзвещения.Добавить();
	//						НоваяСтрокаТЧ.OKEI = ?(СтрокаТЧ.Свойства().Получить("OKEI")<> Неопределено, Справочники.КлассификаторЕдиницИзмерения.ЕдиницаИзмеренияПоКоду(СтрокаТЧ.OKEI.code), Справочники.КлассификаторЕдиницИзмерения.ПолучитьЕдиницуИзмеренияПоУмолчанию()); 
	//						НоваяСтрокаТЧ.isMedicalProduct = ?(СтрокаТЧ.Свойства().Получить("isMedicalProduct")<> Неопределено, СтрокаТЧ.isMedicalProduct, Ложь);
	//						НоваяСтрокаТЧ.name = ?(СтрокаТЧ.Свойства().Получить("name")<> Неопределено, СтрокаТЧ.name, ""); 
	//						НоваяСтрокаТЧ.price= ?(СтрокаТЧ.Свойства().Получить("price")<> Неопределено, СтрокаТЧ.price, 0);
	//						НоваяСтрокаТЧ.purchaseObject= ?(СтрокаТЧ.Свойства().Получить("OKPD2")<> Неопределено, Справочники.КлассификаторОКПД2.НайтиПоКоду(СтрокаТЧ.OKPD2.OKPDCode,Истина), Справочники.КлассификаторОКПД2.ПустаяСсылка());
	//						НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, СтрокаТЧ.quantity.value, 0);
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
	//					НоваяСтрокаТЧ.quantity  = ?(СтрокаТЧ.Свойства().Получить("quantity")<> Неопределено, СтрокаТЧ.quantity.value, 0);
	//					НоваяСтрокаТЧ.sum = ?(СтрокаТЧ.Свойства().Получить("sum")<> Неопределено, СтрокаТЧ.sum, 0);	
	//				КонецЕсли;	
	
	//
	//
	//
	//
	
	
	
	
	
	
	
	
	
КонецФункции

Функция  СтрукртураДанных_purchaseObjects (purchaseObjects)
	
	
КонецФункции

Функция  СтрукртураДанных_publicDiscussion (publicDiscussion)
	
	
КонецФункции


