
#Область СлужебныеПроцедурыИФункции

Процедура СформироватьДвиженияПоДокументу(Движения, Отказ, Организация, ПериодРегистрации, ДанныеДляПроведения, СтрокаСписокТаблиц) Экспорт
	ОтражениеЗарплатыВБухучетеБазовый.СформироватьДвиженияПоДокументу(Движения, Отказ, Организация, ПериодРегистрации, ДанныеДляПроведения, СтрокаСписокТаблиц);
КонецПроцедуры

Процедура СоздатьВТБухучетНачислений(Организация, ПериодРегистрации, ПроцентЕНВД, МенеджерВременныхТаблиц) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.СоздатьВТБухучетНачислений(Организация, ПериодРегистрации, ПроцентЕНВД, МенеджерВременныхТаблиц);

КонецПроцедуры

Процедура СоздатьВТСведенияОБухучетеЗарплатыСотрудников(МенеджерВременныхТаблиц, ИмяВременнойТаблицы, ИменаПолейВременнойТаблицы = "Сотрудник,Период", Организация = Неопределено, Подразделение = Неопределено, ТерриторияВыполненияРаботВОрганизации = Неопределено) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.СоздатьВТСведенияОБухучетеЗарплатыСотрудников(МенеджерВременныхТаблиц, ИмяВременнойТаблицы, ИменаПолейВременнойТаблицы, Организация, Подразделение);

КонецПроцедуры

Процедура СоздатьВТСведенияОБухучетеНачислений(МенеджерВременныхТаблиц) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.СоздатьВТСведенияОБухучетеНачислений(МенеджерВременныхТаблиц);

КонецПроцедуры

Процедура УстановитьСписокВыбораОтношениеКЕНВД(ЭлементФормы, ИмяЭлемента) Экспорт

	// В базовой реализации не устанавливается.
	
КонецПроцедуры

Процедура СоздатьВТНачисленияБазаОтпуска(МенеджерВременныхТаблиц) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.СоздатьВТНачисленияБазаОтпуска(МенеджерВременныхТаблиц);

КонецПроцедуры

Функция ДанныеДляОтраженияЗарплатыВБухучете(Организация, ПериодРегистрации) Экспорт

	Возврат ОтражениеЗарплатыВБухучетеБазовый.ДанныеДляОтраженияЗарплатыВБухучете(Организация, ПериодРегистрации);

КонецФункции

Процедура ДополнитьСведенияОВзносахДаннымиБухучета(Движения, Организация, ПериодРегистрации, Ссылка, МенеджерВременныхТаблиц, ИмяВременнойТаблицы) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.ДополнитьСведенияОВзносахДаннымиБухучета(Движения, Организация, ПериодРегистрации, Ссылка, МенеджерВременныхТаблиц, ИмяВременнойТаблицы);

КонецПроцедуры

Процедура ЗаполнитьПараметрыДляРасчетаОценочныхОбязательствОтпусков(Организация, ПериодРегистрации, ПараметрыДляРасчета, Сотрудники) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.ЗаполнитьПараметрыДляРасчетаОценочныхОбязательствОтпусков(Организация, ПериодРегистрации, ПараметрыДляРасчета, Сотрудники);

КонецПроцедуры

Процедура ЗаполнитьРегистрациюВНалоговомОрганеВКоллекцииСтрок(Организация, Период, КоллекцияНачисленныйНДФЛ) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.ЗаполнитьРегистрациюВНалоговомОрганеВКоллекцииСтрок(Организация, Период, КоллекцияНачисленныйНДФЛ);

КонецПроцедуры

Процедура УдалитьРольОтражениеЗарплатыВБухгалтерскомУчете() Экспорт
	
	ОтражениеЗарплатыВБухучетеБазовый.УдалитьРольОтражениеЗарплатыВБухгалтерскомУчете();
	
КонецПроцедуры

Функция ИспользуетсяЕНВД() Экспорт

	Возврат ОтражениеЗарплатыВБухучетеБазовый.ИспользуетсяЕНВД();
	
КонецФункции

Процедура СоздатьВТИсключаемыеСтроки(МенеджерВременныхТаблиц) Экспорт

	ОтражениеЗарплатыВБухучетеБазовый.СоздатьВТИсключаемыеСтроки(МенеджерВременныхТаблиц);

КонецПроцедуры

#КонецОбласти
