
#Область СлужебныйПрограммныйИнтерфейс

Процедура ЗаполнитьСписокВыбораКодПричиныНетрудоспособности(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("01", НСтр("ru = '01 - заболевание'"));
	Элемент.СписокВыбора.Добавить("02", НСтр("ru = '02 - травма'"));
	Элемент.СписокВыбора.Добавить("03", НСтр("ru = '03 - карантин'"));
	Элемент.СписокВыбора.Добавить("04", НСтр("ru = '04 - несчастный случай на производстве или его последствия'"));
	Элемент.СписокВыбора.Добавить("05", НСтр("ru = '05 - отпуск по беременности и родам'"));
	Элемент.СписокВыбора.Добавить("06", НСтр("ru = '06 - протезирование в стационаре'"));
	Элемент.СписокВыбора.Добавить("07", НСтр("ru = '07 - профессиональное заболевание или его обострение'"));
	Элемент.СписокВыбора.Добавить("08", НСтр("ru = '08 - долечивание в санатории'"));
	Элемент.СписокВыбора.Добавить("09", НСтр("ru = '09 - уход за больным членом семьи'"));
	Элемент.СписокВыбора.Добавить("10", НСтр("ru = '10 - иное состояние (отравление, проведение манипуляций и др.)'"));
	Элемент.СписокВыбора.Добавить("11", НСтр("ru = '11 - заболевание туберкулезом'"));
	Элемент.СписокВыбора.Добавить("12", НСтр("ru = '12 - в случае заболевания ребенка, включенного в перечень заболеваний определяемых Минздравсоцразвития России'"));
	Элемент.СписокВыбора.Добавить("13", НСтр("ru = '13 - ребенок-инвалид'"));
	Элемент.СписокВыбора.Добавить("14", НСтр("ru = '14 - поствакцинальное осложнение или злокачественное новообразование у ребенка'"));
	Элемент.СписокВыбора.Добавить("15", НСтр("ru = '15 - ВИЧ-инфицированный ребенок'"));
КонецПроцедуры 

Процедура ЗаполнитьСписокВыбораДополнительныйКодПричиныНетрудоспособности(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("017", НСтр("ru = '017 - лечение в специализированном санатории'"));
	Элемент.СписокВыбора.Добавить("018", НСтр("ru = '018 - санаторно-курортное лечение в связи с несчастным случаем на производстве в период временной нетрудоспособности (до направления на МСЭ)'"));
	Элемент.СписокВыбора.Добавить("019", НСтр("ru = '019 - лечение в клинике научно-исследовательского учреждения (института) курортологии, физиотерапии и реабилитации'"));
	Элемент.СписокВыбора.Добавить("020", НСтр("ru = '020 - дополнительный отпуск по беременности и родам'"));
	Элемент.СписокВыбора.Добавить("021", НСтр("ru = '021 - заболевание или травма, наступившей вследствие алкогольного, наркотического, токсического опьянения или действий, связанных с таким опьянением'"));
КонецПроцедуры 

Процедура ЗаполнитьСписокВыбораТипРодственнойСвязи(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("38", НСтр("ru = '38 - мать'"));
	Элемент.СписокВыбора.Добавить("39", НСтр("ru = '39 - отец'"));
	Элемент.СписокВыбора.Добавить("40", НСтр("ru = '40 - опекун'"));
	Элемент.СписокВыбора.Добавить("41", НСтр("ru = '41 - попечитель'"));
	Элемент.СписокВыбора.Добавить("42", НСтр("ru = '42 - иной родственник, фактически осуществляющий уход'"));
КонецПроцедуры 

Процедура ЗаполнитьСписокВыбораКодНарушенияРежима(Элемент) Экспорт
  	Элемент.СписокВыбора.Добавить("23", НСтр("ru = '23 - несоблюдение предписанного режима, самовольный уход из стационара, выезд на лечение в другой административный район без разрешения лечащего врача'"));
	Элемент.СписокВыбора.Добавить("24", НСтр("ru = '24 - несвоевременная явка на прием к врачу'"));
	Элемент.СписокВыбора.Добавить("25", НСтр("ru = '25 - выход на работу без выписки'"));
	Элемент.СписокВыбора.Добавить("26", НСтр("ru = '26 - отказ от направления в учреждение медико-социальной экспертизы'"));
	Элемент.СписокВыбора.Добавить("27", НСтр("ru = '27 - несвоевременная явка в учреждение медико-социальной экспертизы'"));
	Элемент.СписокВыбора.Добавить("28", НСтр("ru = '28 - другие нарушения'"));
КонецПроцедуры

Процедура ЗаполнитьСписокВыбораГруппаИнвалидности(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("1", НСтр("ru = '1 группа'"));
	Элемент.СписокВыбора.Добавить("2", НСтр("ru = '2 группа'"));
	Элемент.СписокВыбора.Добавить("3", НСтр("ru = '3 группа'"));
	Элемент.СписокВыбора.Добавить("9", НСтр("ru = '9, установлена утрата трудоспособности'"));
КонецПроцедуры

Процедура ЗаполнитьСписокВыбораИное(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("31", НСтр("ru = '31 - продолжает болеть'"));
	Элемент.СписокВыбора.Добавить("32", НСтр("ru = '32 - установлена инвалидность'"));
	Элемент.СписокВыбора.Добавить("33", НСтр("ru = '33 - изменена группа инвалидности'"));
	Элемент.СписокВыбора.Добавить("34", НСтр("ru = '34 - умер'"));
	Элемент.СписокВыбора.Добавить("35", НСтр("ru = '35 - отказ от проведения медико-социальной экспертизы'"));
	Элемент.СписокВыбора.Добавить("36", НСтр("ru = '36 - явился трудоспособным'"));
	Элемент.СписокВыбора.Добавить("37", НСтр("ru = '37 - долечивание'"));
КонецПроцедуры

Процедура ЗаполнитьСписокВыбораКодУсловийИсчисления(Элемент) Экспорт
	Элемент.СписокВыбора.Добавить("43", НСтр("ru = '43 - лицо, относящееся к категории лиц, подвергшихся воздействию радиации'"));
	Элемент.СписокВыбора.Добавить("44", НСтр("ru = '44 - лицо, приступившее к работе в районах РКС и МКС до 2007 года и продолжающее работать в этих местностях'"));
	Элемент.СписокВыбора.Добавить("45", НСтр("ru = '45 - лицо, имеющее инвалидность'"));
	Элемент.СписокВыбора.Добавить("46", НСтр("ru = '46 - трудовой договор менее 6 месяцев (не проставляется в случае указания кода 11 в строке ""Причина нетрудоспособности"")'"));
	Элемент.СписокВыбора.Добавить("47", НСтр("ru = '47 - заболевание (травма) наступили в течение 30 календарных дней со дня прекращения работы'"));
	Элемент.СписокВыбора.Добавить("48", НСтр("ru = '48 - уважительная причина нарушения режима'"));
	Элемент.СписокВыбора.Добавить("49", НСтр("ru = '49 - продолжительность заболевания превышает 4 месяца подряд (для лиц, имеющих инвалидность)'"));
	Элемент.СписокВыбора.Добавить("50", НСтр("ru = '50 - продолжительность заболевания превышает 5 месяцев в календарном году (для лиц, имеющих инвалидность)'"));
	Элемент.СписокВыбора.Добавить("51", НСтр("ru = '51 - неполное рабочее время'"));
КонецПроцедуры

#КонецОбласти
