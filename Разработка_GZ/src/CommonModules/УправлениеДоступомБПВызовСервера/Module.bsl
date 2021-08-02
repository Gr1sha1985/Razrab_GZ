#Область ПрограммныйИнтерфейс

// Возвращает признак, имеет ли пользователь доступ ко _всем_ данным бухгалтерского учета, включая проводки.
// См. также ВыполнитьПроверкуПраваДоступаКДаннымБухгалтерии()
//
Функция ПравоДоступаКДаннымБухгалтерии() Экспорт
	
	// Может быть вызвана в привилегированном режиме.
	// В этом случае в ПравоДоступа() следует указывать параметр Пользователь.
	// Но может быть вызвана и вне привилегированного режима.
	// В этом случае параметр Пользователь указывать не следует.
	// Чтобы не делать две ветки, устанавливаем привилегированный режим.
	УстановитьПривилегированныйРежим(Истина);
	
	Возврат ПравоДоступа(
		"Просмотр",
		Метаданные.ПланыСчетов.Хозрасчетный,
		ПользователиИнформационнойБазы.ТекущийПользователь());
	
КонецФункции

// Выполняет проверку прав доступа пользователя ко _всем_ данным бухгалтерского учета, включая проводки.
// Если право отсутствует, то вызывается исключение и в журнал регистрации пишется соответствующее событие
// См. также ПравоДоступаКДаннымБухгалтерии()
//
Процедура ВыполнитьПроверкуПраваДоступаКДаннымБухгалтерии() Экспорт
	
	ВыполнитьПроверкуПравДоступа("Просмотр", Метаданные.ПланыСчетов.Хозрасчетный);
	
КонецПроцедуры

// Возвращает признак, имеет ли пользователь право просмотра всех кадровых данных.
//
Функция ПравоПросмотраВсехКадровыхДанных() Экспорт
	
	// Считаем, что если пользователю доступен реквизит "ПостоянноПроживалВКрыму18Марта2014Года",
	// то ему доступны кадровые данные.
	Возврат ПравоДоступа(
		"Просмотр",
		Метаданные.Справочники.ФизическиеЛица.Реквизиты.ПостоянноПроживалВКрыму18Марта2014Года)
	
КонецФункции

#КонецОбласти