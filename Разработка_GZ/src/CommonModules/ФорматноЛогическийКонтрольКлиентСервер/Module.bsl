
#Область ПрограммныйИнтерфейс    

// Функция выполняет проверку сумм фискальных строк,
// осуществляя форматно-логический контроль чека.
// Параметры:
//   ОбщиеПараметры - Структура - Полученная ранее методом МенеджерОборудованияКлиентСервер.ПараметрыОперацииФискализацииЧека,
//                    и заполненная данными чека.
//                    Содержит параметры для контроля:
//                      СпособФорматноЛогическогоКонтроля - ПеречислениеСсылка.СпособыФорматноЛогическогоКонтроля - если не заполнена,
//                                                         то контроль не выполняется,
//                      ДопустимоеРасхождениеФорматноЛогическогоКонтроля - Число - по умолчанию установленное 54-ФЗ отклонение - 0.01,
//
//   ПодключаемоеОборудование - СправочникСсылка.ПодключаемоеОборудования - Не обязательный
//                              Если заполнено оборудование и не заполнен способ контроля в общих параметрах,
//                              то способ контроля и допустимое расхождение получаются из подключаемого оборудования.
// Функция переопределяется методом ФорматноЛогическийКонтрольКлиентСерверПереопределяемый.ПровестиФорматноЛогическийКонтроль
Процедура ПровестиФорматноЛогическийКонтроль(ОбщиеПараметры, ПодключаемоеОборудование = Неопределено) Экспорт
	
	СтандартнаяОбработка = Истина;
	ФорматноЛогическийКонтрольКлиентСерверПереопределяемый.ПровестиФорматноЛогическийКонтроль(ОбщиеПараметры, СтандартнаяОбработка, ПодключаемоеОборудование);
	
	Если СтандартнаяОбработка Тогда
		СпособФорматноЛогическогоКонтроля = ОбщиеПараметры.СпособФорматноЛогическогоКонтроля;
		ДопустимоеРасхождение = ОбщиеПараметры.ДопустимоеРасхождениеФорматноЛогическогоКонтроля;
		Если СпособФорматноЛогическогоКонтроля = Неопределено Тогда
			Если ПодключаемоеОборудование <> Неопределено Тогда
				РеквизитыОборудования  = ФорматноЛогическийКонтрольВызовСервера.СтруктураДанныхФорматноЛогическогоКонтроля(ПодключаемоеОборудование);
				СпособФорматноЛогическогоКонтроля = РеквизитыОборудования.СпособФорматноЛогическогоКонтроля;
				ДопустимоеРасхождение = РеквизитыОборудования.ДопустимоеРасхождениеФорматноЛогическогоКонтроля;
			КонецЕсли;
		КонецЕсли;
		Если (НЕ ЗначениеЗаполнено(СпособФорматноЛогическогоКонтроля))
			ИЛИ СпособФорматноЛогическогоКонтроля = ПредопределенноеЗначение("Перечисление.СпособыФорматноЛогическогоКонтроля.НеКонтролировать") Тогда
			Возврат;
		КонецЕсли;
		Если ДопустимоеРасхождение = Неопределено Тогда
			ДопустимоеРасхождение = 0.01;
		КонецЕсли;
		
		Если ОбщиеПараметры.ПозицииЧека <> Неопределено Тогда
			ГраницаНачальногоМассива = ОбщиеПараметры.ПозицииЧека.Количество() - 1;
			НовыеПозицииЧека = Новый Массив;
			Если СпособФорматноЛогическогоКонтроля = ПредопределенноеЗначение("Перечисление.СпособыФорматноЛогическогоКонтроля.ЗачитыватьСуммы") Тогда
				
				СтрокиПоложительные = Новый Массив;
				СтрокиОтрицательные = Новый Массив;
				СтрокаПоследнегоТовара = 0;
				
				Для ИндексМассива = 0 По ГраницаНачальногоМассива Цикл
					ТекущаяПозиция = ОбщиеПараметры.ПозицииЧека[ИндексМассива]; //Структура - где: *Наименование - Строка - .
					Если ТекущаяПозиция.Свойство("ФискальнаяСтрока") Тогда
						СтрокаПоследнегоТовара = ТекущаяПозиция.НомерСтрокиТовара;
						Наименование = ТекущаяПозиция.Наименование;
						Количество = ?(ТекущаяПозиция.Количество = 0, 1, ТекущаяПозиция.Количество);
						Если Количество = 1 Тогда
							НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
							НоваяПозиция.ЦенаСоСкидками = НоваяПозиция.Сумма;
							НоваяПозиция.Вставить("СтрокаПоследнегоТовара", СтрокаПоследнегоТовара);
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						КонецЕсли;
						НоваяСуммаБезОкругления = Количество * ТекущаяПозиция.ЦенаСоСкидками;
						Сумма = ТекущаяПозиция.Сумма;
						РазницаСуммДляПроверки = НоваяСуммаБезОкругления - Сумма;
						НомерСекции = ТекущаяПозиция.НомерСекции;
						СтавкаНДС = ТекущаяПозиция.СтавкаНДС;
						// Получаем расчетную цену с учетом скидок делением входящей суммы на входящее количество.
						РасчетнаяЦена = Окр(Сумма / Количество, 2, 1);
						// Здесь и далее все цены и суммы округляем до 2 знаков после запятой, количества - до 3 знаков.
						// Умножаем входящее количество  на расчетную цену и получаем новую промежуточную сумму.
						НоваяСумма = Окр(Количество * РасчетнаяЦена, 2, 1);
						// Вычисляем разницу между промежуточной и входящей суммой.
						РазницаСумм = НоваяСумма - Сумма;
						
						НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
						НоваяПозиция.Вставить("РасчетнаяЦена", РасчетнаяЦена);
						НоваяПозиция.Вставить("РазницаСумм", РазницаСумм);
						НоваяПозиция.Вставить("РазницаСуммДляПроверки", РазницаСуммДляПроверки);
						НоваяПозиция.Вставить("СтрокаПоследнегоТовара", СтрокаПоследнегоТовара);
						Если Окр(ТекущаяПозиция.ЦенаСоСкидками * Количество, 2, 1) = ТекущаяПозиция.Сумма Тогда
							// Строку оставляем в первоначальном виде.
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						ИначеЕсли РазницаСуммДляПроверки >= -ДопустимоеРасхождение И РазницаСуммДляПроверки <= ДопустимоеРасхождение Тогда
							// Если разница допустима - оставляем одну строку.
							// Но подменяем расчетную цену.
							НоваяПозиция.ЦенаСоСкидками = РасчетнаяЦена;
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						ИначеЕсли РазницаСумм = 0 Тогда
							// Если разница неокругленная есть, а округленной нет.
							// То передаем в ККТ как есть - оставляем одну строку.
							// Но подменяем расчетную цену.
							НоваяПозиция.ЦенаСоСкидками = РасчетнаяЦена;
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						ИначеЕсли РазницаСумм > 0 Тогда
							//Если разница есть, то строку с  положительной разницей добавляем в массив положительных строк.
							СтрокиПоложительные.Добавить(НоваяПозиция);
						Иначе
							//Если разница есть, то строку с  отрицательной разницей добавляем в массив отрицательных строк.
							НоваяПозиция.РазницаСумм = -РазницаСумм;
							СтрокиОтрицательные.Добавить(НоваяПозиция);
						КонецЕсли;
					Иначе
						НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
						Если СтрокаПоследнегоТовара = 0 Тогда
							НоваяПозиция.Вставить("СтрокаПоследнегоТовара", 0);
						Иначе
							НоваяПозиция.Вставить("СтрокаПоследнегоТовара", 99999);
						КонецЕсли;
						НовыеПозицииЧека.Добавить(НоваяПозиция);
					КонецЕсли;
				КонецЦикла;
				
				ИндексПоложительных = СтрокиПоложительные.ВГраница();
				ИндексОтрицательных = СтрокиОтрицательные.ВГраница();
				Если ИндексПоложительных >= 0 И ИндексОтрицательных >= 0 Тогда
					// В массиве положительных и отрицательных.
					// Находим строки с совпадающей по модулю сумой расхождения.
					// Строки идут одна к одному.
					СдвигПоложительного = 0;
					Для СчетчикПоложительный = 0 По ИндексПоложительных Цикл
						ПоложительнаяСтрока = СтрокиПоложительные[СчетчикПоложительный - СдвигПоложительного];
						СдвигОтрицательного = 0;
						ИндексОтрицательных = СтрокиОтрицательные.ВГраница();
						Для СчетчикОтрицательный = 0 По ИндексОтрицательных Цикл
							ОтрицательнаяСтрока = СтрокиОтрицательные[СчетчикОтрицательный - СдвигОтрицательного];
							Если ПоложительнаяСтрока.РазницаСумм = ОтрицательнаяСтрока.РазницаСумм Тогда
								// Перекрываем разницу по совпадающим строкам из одного массива суммами другого.
								// Увеличивая сумму в положительной строке и уменьшая в отрицательной.
								ПоложительнаяСтрока.Сумма =  ПоложительнаяСтрока.Сумма + ПоложительнаяСтрока.РазницаСумм;
								ОтрицательнаяСтрока.Сумма =  ОтрицательнаяСтрока.Сумма - ПоложительнаяСтрока.РазницаСумм;
								
								// Перекрытые строки переносим в массив для печати и удаляем из массивов.
								НоваяПозиция = СкопироватьСтруктуру(ПоложительнаяСтрока);
								НовыеПозицииЧека.Добавить(НоваяПозиция);
								
								НоваяПозиция = СкопироватьСтруктуру(ОтрицательнаяСтрока);
								НовыеПозицииЧека.Добавить(НоваяПозиция);
								
								СтрокиПоложительные.Удалить(СчетчикПоложительный - СдвигПоложительного);
								СтрокиОтрицательные.Удалить(СчетчикОтрицательный - СдвигОтрицательного);
								
								СдвигПоложительного = СдвигПоложительного + 1;
								СдвигОтрицательного = СдвигОтрицательного + 1;
								Прервать;
							КонецЕсли;
						КонецЦикла;
						
						Если ИндексПоложительных < 0 Тогда
							Прервать;
						КонецЕсли;
					КонецЦикла;
					
				КонецЕсли;
				
				ИндексПоложительных = СтрокиПоложительные.ВГраница();
				ИндексОтрицательных = СтрокиОтрицательные.ВГраница();
				Если ИндексПоложительных >= 0 И ИндексОтрицательных >= 0 Тогда
					// Обходим строки положительного массива.
					// Увеличивая сумму в каждой из них на сумму расхождения.
					// Которую распределяем по строкам с отрицательным расхождением, уменьшая сумму там.
					СдвигПоложительного = 0;
					Для СчетчикПоложительный = 0 По ИндексПоложительных Цикл
						ПоложительнаяСтрока = СтрокиПоложительные[СчетчикПоложительный - СдвигПоложительного];
						Если ПоложительнаяСтрока.РазницаСумм <= ДопустимоеРасхождение Тогда
							// Разница сумм в строке всегда по модулю.
							Продолжить;
						КонецЕсли;
						СдвигОтрицательного = 0;
						ИндексОтрицательных = СтрокиОтрицательные.ВГраница();
						Для СчетчикОтрицательный = 0 По ИндексОтрицательных Цикл
							ОтрицательнаяСтрока = СтрокиОтрицательные[СчетчикОтрицательный - СдвигОтрицательного];
							Если ОтрицательнаяСтрока.РазницаСумм <= ДопустимоеРасхождение
								И ОтрицательнаяСтрока.РазницаСумм <> ПоложительнаяСтрока.РазницаСумм Тогда
								// Разница сумм в строке всегда по модулю.
								Продолжить;
							КонецЕсли;
							// Перекрываем разницу по совпадающим строкам из одного массива суммами другого.
							// Увеличивая сумму в положительной строке и уменьшая в отрицательной.
							
							Если ПоложительнаяСтрока.РазницаСумм > ОтрицательнаяСтрока.РазницаСумм Тогда
								ПоложительнаяСтрока.Сумма =  ПоложительнаяСтрока.Сумма + ОтрицательнаяСтрока.РазницаСумм;
								ОтрицательнаяСтрока.Сумма =  ОтрицательнаяСтрока.Сумма - ОтрицательнаяСтрока.РазницаСумм;
								// Уменьшаем остаток разницы положительной строки
								ПоложительнаяСтрока.РазницаСумм = ПоложительнаяСтрока.РазницаСумм - ОтрицательнаяСтрока.РазницаСумм;
								// Перекрытую строку переносим в массив для печати.
								
								НоваяПозиция = СкопироватьСтруктуру(ОтрицательнаяСтрока);
								НовыеПозицииЧека.Добавить(НоваяПозиция);
								
								// И удаляем из массивов.
								СтрокиОтрицательные.Удалить(СчетчикОтрицательный - СдвигОтрицательного);
								// Сдвигаем отрицательные счетчики
								СдвигОтрицательного = СдвигОтрицательного + 1;
								
							Иначе
								
								НадоУдалятьОтрицательные = ПоложительнаяСтрока.РазницаСумм = ОтрицательнаяСтрока.РазницаСумм;
								
								ПоложительнаяСтрока.Сумма =  ПоложительнаяСтрока.Сумма + ПоложительнаяСтрока.РазницаСумм;
								ОтрицательнаяСтрока.Сумма =  ОтрицательнаяСтрока.Сумма - ПоложительнаяСтрока.РазницаСумм;
								// Уменьшаем остаток разницы положительной строки
								ОтрицательнаяСтрока.РазницаСумм = ОтрицательнаяСтрока.РазницаСумм - ПоложительнаяСтрока.РазницаСумм;
								// Перекрытую строку переносим в массив для печати.
								
								НоваяПозиция = СкопироватьСтруктуру(ПоложительнаяСтрока);
								НовыеПозицииЧека.Добавить(НоваяПозиция);
								Если НадоУдалятьОтрицательные Тогда
									НоваяПозиция = СкопироватьСтруктуру(ОтрицательнаяСтрока);
									НовыеПозицииЧека.Добавить(НоваяПозиция);
								КонецЕсли;
								
								// И удаляем из массивов.
								СтрокиПоложительные.Удалить(СчетчикПоложительный - СдвигПоложительного);
								// Сдвигаем положительные счетчики
								СдвигПоложительного = СдвигПоложительного + 1;
								
								Если НадоУдалятьОтрицательные Тогда
									// И удаляем из массивов.
									СтрокиОтрицательные.Удалить(СчетчикОтрицательный - СдвигОтрицательного);
									// Сдвигаем отрицательные счетчики
									СдвигОтрицательного = СдвигОтрицательного + 1;
								КонецЕсли;
								
								// Отрицательный цикл прерываем.
								// Ибо закрывать текущую строку придется следующей положительной.
								// Если она есть.
								Прервать;
							КонецЕсли;
						КонецЦикла;
						
						Если ИндексПоложительных < 0 Тогда
							Прервать;
						КонецЕсли;
					КонецЦикла;
					
				КонецЕсли;
				
				ИндексПоложительных = СтрокиПоложительные.ВГраница();
				// Оставшиеся строки обоих массивов разделяются.
				// Каждая на две по первому алгоритму и добавляются в массив для печати.
				Если ИндексПоложительных >= 0 Тогда
					Для Каждого ТекущаяПозиция Из СтрокиПоложительные Цикл
						// Еще раз пересчитываем разницу
						// Получаем расчетную цену с учетом скидок делением входящей суммы на входящее количество.
						РасчетнаяЦена = Окр(ТекущаяПозиция.Сумма / ТекущаяПозиция.Количество, 2, 1);
						// Здесь и далее все цены и суммы округляем до 2 знаков после запятой, количества - до 3 знаков.
						// Умножаем входящее количество  на расчетную цену и получаем новую промежуточную сумму.
						НоваяСумма = Окр(ТекущаяПозиция.Количество * РасчетнаяЦена, 2, 1);
						// Вычисляем разницу между промежуточной и входящей суммой.
						РазницаСумм = НоваяСумма - ТекущаяПозиция.Сумма;
						Если ТекущаяПозиция.РазницаСуммДляПроверки >= -ДопустимоеРасхождение И ТекущаяПозиция.РазницаСуммДляПроверки <= ДопустимоеРасхождение Тогда
							// Если разница допустима - оставляем одну строку.
							НовыеПозицииЧека.Добавить(ТекущаяПозиция);
						ИначеЕсли РазницаСумм = 0 Тогда
							// Если разница неокругленная есть, а округленной нет.
							// То передаем в ККТ как есть - оставляем одну строку.
							НовыеПозицииЧека.Добавить(ТекущаяПозиция);
						Иначе
							// Разделяем строку.
							РазделитьФискальнуюСтроку(ТекущаяПозиция, НовыеПозицииЧека, РасчетнаяЦена, РазницаСумм);
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
				
				ИндексОтрицательных = СтрокиОтрицательные.ВГраница();
				Если ИндексОтрицательных >= 0 Тогда
					Для Каждого ТекущаяПозиция Из СтрокиОтрицательные Цикл
						// Еще раз пересчитываем разницу
						// Получаем расчетную цену с учетом скидок делением входящей суммы на входящее количество.
						РасчетнаяЦена = Окр(ТекущаяПозиция.Сумма / ТекущаяПозиция.Количество, 2, 1);
						// Здесь и далее все цены и суммы округляем до 2 знаков после запятой, количества - до 3 знаков.
						// Умножаем входящее количество  на расчетную цену и получаем новую промежуточную сумму.
						НоваяСумма = Окр(ТекущаяПозиция.Количество * РасчетнаяЦена, 2, 1);
						// Вычисляем разницу между промежуточной и входящей суммой.
						РазницаСумм = НоваяСумма - ТекущаяПозиция.Сумма;
						Если ТекущаяПозиция.РазницаСуммДляПроверки >= -ДопустимоеРасхождение И ТекущаяПозиция.РазницаСуммДляПроверки <= ДопустимоеРасхождение Тогда
							// Если разница допустима - оставляем одну строку.
							НовыеПозицииЧека.Добавить(ТекущаяПозиция);
						ИначеЕсли РазницаСумм = 0 Тогда
							// Если разница неокругленная есть, а округленной нет.
							// То передаем в ККТ как есть - оставляем одну строку.
							НовыеПозицииЧека.Добавить(ТекущаяПозиция);
						Иначе
							// Разделяем строку.
							РазделитьФискальнуюСтроку(ТекущаяПозиция, НовыеПозицииЧека, РасчетнаяЦена, РазницаСумм);
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
				// Массив для печати сортируется по первоначальному номеру строки.
				СортироватьМассивФискальныхСтрок(НовыеПозицииЧека);
				
			Иначе
				Для ИндексМассива = 0 По ГраницаНачальногоМассива Цикл
					ТекущаяПозиция = ОбщиеПараметры.ПозицииЧека[ИндексМассива]; //Структура - где: *Наименование - Строка - .
					Если ТекущаяПозиция.Свойство("ФискальнаяСтрока") Тогда
						Наименование = ТекущаяПозиция.Наименование;
						Количество = ?(ТекущаяПозиция.Количество = 0, 1, ТекущаяПозиция.Количество);
						Если Количество = 1 Тогда
							НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
							НоваяПозиция.ЦенаСоСкидками = НоваяПозиция.Сумма;
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						КонецЕсли;
						НоваяСуммаБезОкругления = Количество * ТекущаяПозиция.ЦенаСоСкидками;
						Сумма = ТекущаяПозиция.Сумма;
						РазницаСуммДляПроверки = НоваяСуммаБезОкругления - Сумма;
						НомерСекции = ТекущаяПозиция.НомерСекции;
						СтавкаНДС = ТекущаяПозиция.СтавкаНДС;
						// Получаем расчетную цену с учетом скидок делением входящей суммы на входящее количество.
						РасчетнаяЦена = Окр(Сумма / Количество, 2, 1);
						// Здесь и далее все цены и суммы округляем до 2 знаков после запятой, количества - до 3 знаков.
						// Умножаем входящее количество  на расчетную цену и получаем новую промежуточную сумму.
						НоваяСумма = Окр(Количество * РасчетнаяЦена, 2, 1);
						// Вычисляем разницу между промежуточной и входящей суммой.
						РазницаСумм = НоваяСумма - Сумма;
						Если Окр(ТекущаяПозиция.ЦенаСоСкидками * Количество, 2, 1) = ТекущаяПозиция.Сумма Тогда
							// Цену не пересчитываем.
							НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						ИначеЕсли РазницаСуммДляПроверки >= -ДопустимоеРасхождение И РазницаСуммДляПроверки <= ДопустимоеРасхождение Тогда
							// Если разница допустима - оставляем одну строку.
							// Если разницы нет - оставляем одну строку.
							НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
							// Но подменяем расчетную цену.
							НоваяПозиция.ЦенаСоСкидками = РасчетнаяЦена;
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						ИначеЕсли РазницаСумм = 0 Тогда
							// Если разница неокругленная есть, а округленной нет.
							// То передаем в ККТ как есть - оставляем одну строку.
							НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
							// Но подменяем расчетную цену.
							НоваяПозиция.ЦенаСоСкидками = РасчетнаяЦена;
							НовыеПозицииЧека.Добавить(НоваяПозиция);
							Продолжить;
						Иначе
							// Разделяем строку.
							РазделитьФискальнуюСтроку(ТекущаяПозиция, НовыеПозицииЧека, РасчетнаяЦена, РазницаСумм);
						КонецЕсли;
						
					Иначе
						НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
						НовыеПозицииЧека.Добавить(НоваяПозиция);
					КонецЕсли;
				КонецЦикла;
			КонецЕсли;
			ОбщиеПараметры.ПозицииЧека = НовыеПозицииЧека;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

// Функция выполняет проверку сумм фискальных строк,
// осуществляя форматно-логический контроль чека.
//
Функция НуженФорматноЛогическийКонтроль(ОбщиеПараметры) Экспорт
	
	СтандартнаяОбработка = Истина;
	
	ПереопределяемыйРезультат = ФорматноЛогическийКонтрольКлиентСерверПереопределяемый.НуженФорматноЛогическийКонтроль(ОбщиеПараметры, СтандартнаяОбработка);
	Если СтандартнаяОбработка Тогда
		СпособФорматноЛогическогоКонтроля = Неопределено;
		ОбщиеПараметры.Свойство("СпособФорматноЛогическогоКонтроля", СпособФорматноЛогическогоКонтроля);
		Если (НЕ ЗначениеЗаполнено(СпособФорматноЛогическогоКонтроля))
			ИЛИ СпособФорматноЛогическогоКонтроля = ПредопределенноеЗначение("Перечисление.СпособыФорматноЛогическогоКонтроля.НеКонтролировать") Тогда
			Возврат Ложь;
		КонецЕсли;
		ДопустимоеРасхождение = 0.01; // В соответствии с текущей версией 54-ФЗ
		Если ОбщиеПараметры.Свойство("ДопустимоеРасхождениеФорматноЛогическогоКонтроля") Тогда
			ДопустимоеРасхождение = ОбщиеПараметры.ДопустимоеРасхождениеФорматноЛогическогоКонтроля;
		КонецЕсли;
		
		Если ОбщиеПараметры.ПозицииЧека <> Неопределено Тогда
			ГраницаНачальногоМассива = ОбщиеПараметры.ПозицииЧека.Количество() - 1;
			Для ИндексМассива = 0 По ГраницаНачальногоМассива Цикл
				ТекущаяПозиция = ОбщиеПараметры.ПозицииЧека[ИндексМассива];
				Если ТекущаяПозиция.Свойство("ФискальнаяСтрока") Тогда
					Количество = ?(ТекущаяПозиция.Количество = 0, 1, ТекущаяПозиция.Количество);
					Если Количество = 1 Тогда
						Если ТекущаяПозиция.ЦенаСоСкидками <> ТекущаяПозиция.Сумма Тогда
							Возврат Истина;
						КонецЕсли;
					Иначе
						Если Окр(ТекущаяПозиция.ЦенаСоСкидками * Количество, 2, 1) <> ТекущаяПозиция.Сумма Тогда
							Сумма = ТекущаяПозиция.Сумма;
							// Умножаем входящее количество на заданную цену и получаем новую промежуточную сумму.
							// Сумму НЕ округляем - Требования АСК ККТ ФНС РФ.
							НоваяСуммаБезОкругления = Количество * ТекущаяПозиция.ЦенаСоСкидками;
							// Вычисляем разницу между промежуточной и входящей суммой.
							РазницаСумм = НоваяСуммаБезОкругления - Сумма;
							// Если разница допустима - оставляем одну строку.
							// Если разницы нет - оставляем одну строку.
							Если РазницаСумм >= -ДопустимоеРасхождение И РазницаСумм <= ДопустимоеРасхождение Тогда
								// Дополнительно получаем расчетную цену с учетом скидок делением входящей суммы на входящее количество.
								// Цену округляем.
								РасчетнаяЦена = Окр(Сумма / Количество, 2, 1);
								Если ТекущаяПозиция.ЦенаСоСкидками <> РасчетнаяЦена Тогда
									// Но. Если цена не совпадает с расчетной - все равно надо ее пересчитывать.
									Возврат Истина;
								КонецЕсли;
							Иначе
								// Надо разделять строку.
								Возврат Истина;
							КонецЕсли;
						КонецЕсли;
					КонецЕсли;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	Иначе
		Возврат ПереопределяемыйРезультат;
	КонецЕсли;
	
	Возврат Ложь;
	
КонецФункции

// Процедура приводит к формату согласованному с ФНС.
// Для старта преобразования данных нужно
//
//  Параметры:
//    ОсновныеПараметры - см. МенеджерОборудованияКлиентСервер.ПараметрыОперацииФискализацииЧека
//    Отказ - Булево
//    ОписаниеОшибки - Строка
//
Процедура ПривестиДанныеКТребуемомуФормату(ОсновныеПараметры, Отказ, ОписаниеОшибки, ИсправленыОсновныеПараметры) Экспорт
	
	ИндивидуальныйРежимПодготовкиДанныхКПередачеВОФД = Ложь;
	Если ОсновныеПараметры.Свойство("ИндивидуальныйРежимПодготовкиДанныхКПередачеВОФД", ИндивидуальныйРежимПодготовкиДанныхКПередачеВОФД) 
		И ИндивидуальныйРежимПодготовкиДанныхКПередачеВОФД = Истина Тогда
		Возврат;
	КонецЕсли;
	
	СпособФорматноЛогическогоКонтроля = Неопределено;
	
	Если ОсновныеПараметры.Свойство("СпособФорматноЛогическогоКонтроля", СпособФорматноЛогическогоКонтроля) Тогда
		Если НЕ (СпособФорматноЛогическогоКонтроля = ПредопределенноеЗначение("Перечисление.СпособыФорматноЛогическогоКонтроля.РазделятьСтроки")
			ИЛИ СпособФорматноЛогическогоКонтроля = ПредопределенноеЗначение("Перечисление.СпособыФорматноЛогическогоКонтроля.ЗачитыватьСуммы")) Тогда
			Возврат;
		КонецЕсли;
	Иначе
		Возврат;
	КонецЕсли;
	
	СуммаЧастныхОплат = 0;
	ПересчитатьНДС = Ложь;
	НужноПриводитьСуммы = Ложь;
	СуммаПередачиБезОплаты = 0;
	ОбщаяСуммаЧека = 0;
	СуммаПолнойОплаты = 0;
	Для Каждого ПозицияЧека Из ОсновныеПараметры.ПозицииЧека Цикл
		Если ПозицияЧека.Свойство("ФискальнаяСтрока") Тогда
			БезПередачиТовара = Ложь;
			НужнаПроверкаСтавокНДС = Ложь;
			Если ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ПредоплатаЧастичная") Тогда
				СуммаЧастныхОплат = СуммаЧастныхОплат + ПозицияЧека.Сумма;
				БезПередачиТовара          = Истина;
				НужнаПроверкаСтавокНДС     = Истина;
				НужноПриводитьСуммы        = Истина;
			ИначеЕсли ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ОплатаКредита") Тогда
				СуммаЧастныхОплат = СуммаЧастныхОплат + ПозицияЧека.Сумма;
				БезПередачиТовара          = Истина;
				НужноПриводитьСуммы        = Истина;
				Если ПозицияЧека.Свойство("СтавкаНДС") Тогда
					ПозицияЧека.СтавкаНДС = Неопределено;
					ПересчитатьНДС = Истина;
				КонецЕсли;
				Если ПозицияЧека.Свойство("СуммаНДС") Тогда
					ПозицияЧека.СуммаНДС = 0;
					ПересчитатьНДС = Истина;
				КонецЕсли;
			ИначеЕсли ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.Аванс")
				ИЛИ ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ПредоплатаПолная") Тогда
				БезПередачиТовара = Истина;
				НужнаПроверкаСтавокНДС = Истина;
				СуммаПолнойОплаты = СуммаПолнойОплаты + ПозицияЧека.Сумма;
			ИначеЕсли ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ПередачаБезОплаты") Тогда
				СуммаПередачиБезОплаты = СуммаПередачиБезОплаты + ПозицияЧека.Сумма;
			ИначеЕсли ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ПередачаСПолнойОплатой") Тогда
				СуммаПолнойОплаты = СуммаПолнойОплаты + ПозицияЧека.Сумма;
			КонецЕсли;
			
			Если БезПередачиТовара Тогда
				Если ПозицияЧека.Свойство("ЕдиницаИзмерения") Тогда
					ПозицияЧека.ЕдиницаИзмерения = "Платеж";
				КонецЕсли;
				Если ПозицияЧека.Свойство("Количество") Тогда
					ПозицияЧека.Количество = 1;
				КонецЕсли;
				Если ПозицияЧека.Свойство("Цена") Тогда
					ПозицияЧека.Цена = ПозицияЧека.Сумма;
				КонецЕсли;
				Если ПозицияЧека.Свойство("ЦенаСоСкидками") Тогда
					ПозицияЧека.ЦенаСоСкидками = ПозицияЧека.Сумма;
				КонецЕсли;
				Если ПозицияЧека.Свойство("СуммаСкидок") Тогда
					ПозицияЧека.СуммаСкидок = 0;
				КонецЕсли;
				ПозицияЧека.Вставить("ПризнакПредметаРасчета", ПредопределенноеЗначение("Перечисление.ПризнакиПредметаРасчета.ПлатежВыплата"));
				ИсправленыОсновныеПараметры = Истина;
			КонецЕсли;
			
			Если НужнаПроверкаСтавокНДС Тогда
				Если ПозицияЧека.Свойство("СтавкаНДС") Тогда
					Если ПозицияЧека.СтавкаНДС = 18 ИЛИ ПозицияЧека.СтавкаНДС = 10 ИЛИ ПозицияЧека.СтавкаНДС = 20 Тогда
						ПозицияЧека.СтавкаНДС = 100 + ПозицияЧека.СтавкаНДС;
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
			
			ОбщаяСуммаЧека = ОбщаяСуммаЧека + ПозицияЧека.Сумма;
		КонецЕсли;
	КонецЦикла;
	
	Если НужноПриводитьСуммы Тогда
		ПривестиСуммыПозицийЧекаКСуммеТаблицыОплат(ОсновныеПараметры, ОбщаяСуммаЧека, СуммаПолнойОплаты, СуммаПередачиБезОплаты, Отказ, ОписаниеОшибки);
	КонецЕсли;
	
КонецПроцедуры

// Процедура приводит суммы позиций чека к сумме полной оплаты
// 
// Параметры:
//    ОсновныеПараметры - Структура - см. МенеджерОборудованияКлиентСервер.ПараметрыОперацииФискализацииЧека
//    ОбщаяСуммаЧека - Число - Общая сумма позиций чека
//    СуммаПолнойОплаты - Число - Сумма оплаченная
//    СуммаПередачиБезОплаты - Число - Сумма без оплаты
//    Отказ - Булево - Флаг отказа
//    ОписаниеОшибки - Строка - Описание ошибки
//
Процедура ПривестиСуммыПозицийЧекаКСуммеТаблицыОплат(ОсновныеПараметры, ОбщаяСуммаЧека, СуммаПолнойОплаты, СуммаПередачиБезОплаты, Отказ, ОписаниеОшибки) Экспорт
	
	СуммаНаличные = 0;
	СуммаЭлектронно = 0;
	СуммаВстречноеПредоставление = 0;
	СуммаПредоплата = 0;
	СуммаПостоплата = 0;
	
	Для Каждого СтрокаОплат Из ОсновныеПараметры.ТаблицаОплат Цикл  
		Если СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Наличные") Тогда
			СуммаНаличные = СуммаНаличные + СтрокаОплат.Сумма;
		ИначеЕсли СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Электронно") Тогда
			СуммаЭлектронно = СуммаЭлектронно + СтрокаОплат.Сумма;
		ИначеЕсли СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.ВстречноеПредоставление") Тогда
			 СуммаВстречноеПредоставление = СуммаВстречноеПредоставление + СтрокаОплат.Сумма;
		 ИначеЕсли СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Предоплата") Тогда
			 СуммаПредоплата = СуммаПредоплата + СтрокаОплат.Сумма;
		 ИначеЕсли СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Постоплата") Тогда
			 СуммаПостоплата = СуммаПостоплата + СтрокаОплат.Сумма;
		КонецЕсли;
	КонецЦикла;
	
	СуммаОплатБезн = СуммаЭлектронно + СуммаВстречноеПредоставление + СуммаПредоплата + СуммаПостоплата;
	// Проверяем что сумма наличные указана со сдачей.
	Если (СуммаОплатБезн + СуммаНаличные > ОбщаяСуммаЧека) И (СуммаНаличные > 0) Тогда
		НаличныеСдача = СуммаОплатБезн + СуммаНаличные - ОбщаяСуммаЧека;
		Если СуммаНаличные > НаличныеСдача Тогда
			СуммаНаличные = СуммаНаличные - НаличныеСдача;
		КонецЕсли;
	КонецЕсли;
	
	СуммаФактическихОплат = СуммаНаличные + СуммаЭлектронно + СуммаВстречноеПредоставление; 
	
	СуммаФактическихОплат = СуммаФактическихОплат - СуммаПолнойОплаты;
	Если СуммаФактическихОплат < 0 Тогда
		Отказ = Истина;
		ОписаниеОшибки = НСтр("ru = 'Сумма по строкам с указанием признака полной оплаты меньше чем сумма самих оплат'") ;
		Возврат;
	ИначеЕсли СуммаФактическихОплат = 0 Тогда
		Отказ = Истина;
		ОписаниеОшибки = НСтр("ru = 'Необходимо указать оплату'") ;
		Возврат;
	КонецЕсли;
	
	СуммаНеобходимойПолнойОплаты = ОбщаяСуммаЧека - СуммаПередачиБезОплаты - СуммаПолнойОплаты; 
	// Сумма всегда больше нулю, т.к. в чеке есть строки в частичной оплатой
	Если СуммаФактическихОплат < СуммаНеобходимойПолнойОплаты Тогда
		Коэффициент = СуммаФактическихОплат / СуммаНеобходимойПолнойОплаты;
		РассчитаннаяСуммаЧека = 0;
		МаксимальнаяПозиция = Неопределено;
		МаксимальнаяСумма = 0;
		СуммаЧастичныхОплат = 0;
		Для Каждого ПозицияЧека Из ОсновныеПараметры.ПозицииЧека Цикл
			Если ПозицияЧека.Свойство("ФискальнаяСтрока") Тогда
				Если ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ПредоплатаЧастичная")
					ИЛИ ПозицияЧека.ПризнакСпособаРасчета = ПредопределенноеЗначение("Перечисление.ПризнакиСпособаРасчета.ОплатаКредита") Тогда
					Если ПозицияЧека.Сумма > МаксимальнаяСумма Тогда
						МаксимальнаяСумма = ПозицияЧека.Сумма;
						МаксимальнаяПозиция = ПозицияЧека;
					КонецЕсли;
					СуммаЧастичныхОплат = СуммаЧастичныхОплат + ПозицияЧека.Сумма;
					ПозицияЧека.Сумма = Окр(ПозицияЧека.Сумма * Коэффициент,2,1);
					РассчитаннаяСуммаЧека = РассчитаннаяСуммаЧека + ПозицияЧека.Сумма;
					Если ПозицияЧека.Свойство("Цена") Тогда
						ПозицияЧека.Цена = ПозицияЧека.Сумма;
					КонецЕсли;
					
					Если ПозицияЧека.Свойство("ЦенаСоСкидками") Тогда
						ПозицияЧека.ЦенаСоСкидками = ПозицияЧека.Сумма;
					КонецЕсли;
					
					Если ПозицияЧека.Свойство("СуммаНДС") И ПозицияЧека.СуммаНДС <> Неопределено Тогда
						ПозицияЧека.СуммаНДС = Окр(ПозицияЧека.СуммаНДС * Коэффициент,2,1);
					КонецЕсли;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	Иначе
		Возврат;
	КонецЕсли;
	
	Отклонение = СуммаФактическихОплат - РассчитаннаяСуммаЧека;
	
	Если Макс(Отклонение, -Отклонение) >= 0.01 Тогда
		СуммаМаксимальноПозиции = МаксимальнаяПозиция.Сумма;
		МаксимальнаяПозиция.Сумма = МаксимальнаяПозиция.Сумма + Отклонение;
		Если МаксимальнаяПозиция.Свойство("Цена") Тогда
			МаксимальнаяПозиция.Цена = МаксимальнаяПозиция.Сумма;
		КонецЕсли;
		
		Если ПозицияЧека.Свойство("ЦенаСоСкидками") Тогда
			ПозицияЧека.ЦенаСоСкидками = ПозицияЧека.Сумма;
		КонецЕсли;
					
		Если МаксимальнаяПозиция.Свойство("СуммаНДС") И МаксимальнаяПозиция.СуммаНДС <> Неопределено И СуммаМаксимальноПозиции <> Неопределено Тогда
			// Максимальная сумма не может быть равна или меньше нуля
			// Определяем отклонение НДС
			МаксимальнаяПозиция.СуммаНДС = Окр(МаксимальнаяПозиция.Сумма * МаксимальнаяПозиция.СуммаНДС / СуммаМаксимальноПозиции, 2,1);
		КонецЕсли;
	КонецЕсли; 
	
	// Общие суммы НДС по ставкам пересчитывается далее по алгоритму.
	
	// ИсправитьТаблицуОплат
	
	СуммаИсправленияОплат = СуммаНеобходимойПолнойОплаты - СуммаФактическихОплат;
	
	Если СуммаИсправленияОплат > 0 Тогда
		Для Каждого СтрокаОплат Из ОсновныеПараметры.ТаблицаОплат Цикл
			Если СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Постоплата") 
				ИЛИ СтрокаОплат.ТипОплаты = ПредопределенноеЗначение("Перечисление.ТипыОплатыККТ.Предоплата") Тогда
				
				Если СуммаИсправленияОплат >= СтрокаОплат.Сумма Тогда
					СуммаИсправленияОплат = СуммаИсправленияОплат - СтрокаОплат.Сумма;
					СтрокаОплат.Сумма = 0;
				Иначе
					СуммаИсправленияОплат = 0;
					СтрокаОплат.Сумма = СтрокаОплат.Сумма - СуммаИсправленияОплат;
				КонецЕсли;
				Если СуммаИсправленияОплат <= 0 Тогда
					Прервать;
				КонецЕсли;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	КоличествоЭлементов = ОсновныеПараметры.ТаблицаОплат.Количество();
	Для Индекс = 1 По КоличествоЭлементов Цикл
		Если ОсновныеПараметры.ТаблицаОплат[КоличествоЭлементов - Индекс].Сумма = 0 Тогда
			ОсновныеПараметры.ТаблицаОплат.Удалить(КоличествоЭлементов - Индекс);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Скопировать структуру.
//
Функция СкопироватьСтруктуру(ТекущаяПозиция) Экспорт
	
	НоваяПозиция = Новый Структура;
	Для Каждого ЭлементСтруктуры Из ТекущаяПозиция Цикл
		НоваяПозиция.Вставить(ЭлементСтруктуры.Ключ, ЭлементСтруктуры.Значение);
	КонецЦикла;
	
	Возврат НоваяПозиция;
	
КонецФункции

// Функция выполняет разделение фискальной строки.
// 
Процедура РазделитьФискальнуюСтроку(ТекущаяПозиция, НовыеПозицииЧека, РасчетнаяЦена, РазницаСумм) Экспорт
	
	СтандартнаяОбработка = Истина;
	ФорматноЛогическийКонтрольКлиентСерверПереопределяемый.РазделитьФискальнуюСтроку(ТекущаяПозиция, НовыеПозицииЧека, РасчетнаяЦена, РазницаСумм, СтандартнаяОбработка);
	Если СтандартнаяОбработка Тогда
		// Запоминаем начальные значения.
		КоличествоНачальное = ТекущаяПозиция.Количество;
		СуммаСкидокНачальная = ТекущаяПозиция.СуммаСкидок;
		СуммаНДСНачальная = ТекущаяПозиция.СуммаНДС; // Рассчитывается формально, т.к. сумма НДС текущими драйверами игнорируется.
		СуммаНачальная = ТекущаяПозиция.Сумма;
			
		// Если разница есть, то ее делим на копейку.
		// Получаем количество, которое нужно переоценить.
		КоличествоПереоценки = Окр(РазницаСумм / 0.01, 3, 1);
		Если КоличествоПереоценки < 0 Тогда
			КоличествоПереоценки = -КоличествоПереоценки;
		КонецЕсли;
		
		// Из начального количества отнимаем количество переоценки.
		// Получаем количество, которое остается по расчетной цене.
		КоличествоРасчетное = ТекущаяПозиция.Количество - КоличествоПереоценки;
		
		// Цена переоценки во всех примерах отличается от расчетной на 1 копейку.
		// В  большую или меньшую сторону в зависимости от знака разницы - зависимость обратная.
		ЦенаПереоценки = РасчетнаяЦена - Окр(РазницаСумм / КоличествоПереоценки, 2, 1);
		
		// Теперь считаются суммы, т.к. по ним выполняется анализ коэффициента для пересчета
		СуммаПереоценки = Окр(КоличествоПереоценки * ЦенаПереоценки, 2, 1);
		СуммаРасчетная = Окр(КоличествоРасчетное * РасчетнаяЦена, 2, 1);
	
		// Распределяем суммы скидок пропорционально количеству.
		// Если суммы есть. А если их нет, то должно остаться Неопределено.
		Если СуммаСкидокНачальная <> Неопределено Тогда
			Если КоличествоПереоценки > КоличествоРасчетное Тогда
				СуммаСкидокПереоценки = Окр(СуммаСкидокНачальная * КоличествоПереоценки / КоличествоНачальное, 2, 1);
				СуммаСкидокРасчетная = СуммаСкидокНачальная - СуммаСкидокПереоценки;
			Иначе
				СуммаСкидокРасчетная = Окр(СуммаСкидокНачальная * КоличествоРасчетное / КоличествоНачальное, 2, 1);
				СуммаСкидокПереоценки = СуммаСкидокНачальная - СуммаСкидокРасчетная;
			КонецЕсли;
		КонецЕсли;
		// А суммы распределяем НДС пропорционально суммам.
		// Потому что распределение пропорционально количеству.
		// Вызывает расхождения в некоторых критичных ситуациях.
		// Если суммы есть. А если их нет, то должно остаться Неопределено.
		Если СуммаНДСНачальная <> Неопределено Тогда
			Если СуммаПереоценки > СуммаРасчетная Тогда
				СуммаНДСПереоценки = Окр(СуммаНДСНачальная * СуммаПереоценки / СуммаНачальная, 2, 1);
				СуммаНДСРасчетная = СуммаНДСНачальная - СуммаНДСПереоценки;
			Иначе
				СуммаНДСРасчетная = Окр(СуммаНДСНачальная * СуммаРасчетная / СуммаНачальная, 2, 1);
				СуммаНДСПереоценки = СуммаНДСНачальная - СуммаНДСРасчетная;
			КонецЕсли;
		КонецЕсли;
			
		// Выводим вместо первоначальной строки две новых.
		// Сначала с расчетной ценой и остатком количества.
		// И суммой - произведение цены и количества.
		НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
		НоваяПозиция.Количество = КоличествоРасчетное;
		НоваяПозиция.ЦенаСоСкидками = РасчетнаяЦена;
		НоваяПозиция.Сумма = СуммаРасчетная;
		Если СуммаСкидокНачальная <> Неопределено Тогда
			НоваяПозиция.СуммаСкидок = СуммаСкидокНачальная - СуммаСкидокПереоценки;
		КонецЕсли;
		Если СуммаНДСНачальная <> Неопределено Тогда
			НоваяПозиция.СуммаНДС = СуммаНДСРасчетная;
		КонецЕсли;
		НовыеПозицииЧека.Добавить(НоваяПозиция);
		
		// Потом с переоцененной ценой и переоцененным количеством.
		// И суммой - произведение цены и количества.
		НоваяПозиция = СкопироватьСтруктуру(ТекущаяПозиция);
		НоваяПозиция.Количество = КоличествоПереоценки;
		НоваяПозиция.ЦенаСоСкидками = ЦенаПереоценки;
		НоваяПозиция.Сумма = СуммаПереоценки;
		Если СуммаСкидокНачальная <> Неопределено Тогда
			НоваяПозиция.СуммаСкидок = СуммаСкидокПереоценки;
		КонецЕсли;
		Если СуммаНДСНачальная <> Неопределено Тогда
			НоваяПозиция.СуммаНДС = СуммаНДСПереоценки;
		КонецЕсли;
		НовыеПозицииЧека.Добавить(НоваяПозиция);
	КонецЕсли;
	
КонецПроцедуры

// Функция сортирует массив фискальных строк
//
Процедура СортироватьМассивФискальныхСтрок(МассивФискальныхСтрок, ИмяРеквизита = "СтрокаПоследнегоТовара") Экспорт
	
	МаксимальныйИндекс = МассивФискальныхСтрок.ВГраница();
	Если МаксимальныйИндекс >= 0 Тогда
		// Начинаем со второго элемента.
		Для ТекущийИндекс = 1 По МаксимальныйИндекс Цикл
			ТекущаяСтрока = МассивФискальныхСтрок[ТекущийИндекс];
			НоваяТекущаяСтрока = СкопироватьСтруктуру(ТекущаяСтрока);
			НовыйИндексТекущейСтроки = -1;
			Для ОбратныйСчетчик = 1 По ТекущийИндекс Цикл
				ПредыдущаяСтрока = МассивФискальныхСтрок[ТекущийИндекс - ОбратныйСчетчик];
				Если ПредыдущаяСтрока[ИмяРеквизита] > ТекущаяСтрока[ИмяРеквизита] Тогда
					НоваяПредыдущаяСтрока = СкопироватьСтруктуру(ПредыдущаяСтрока);
					
					НовыйИндексТекущейСтроки = ТекущийИндекс - ОбратныйСчетчик;
					МассивФискальныхСтрок.Удалить(НовыйИндексТекущейСтроки + 1);
					МассивФискальныхСтрок.Вставить(НовыйИндексТекущейСтроки + 1, НоваяПредыдущаяСтрока);
				Иначе
					Прервать;
				КонецЕсли;
			КонецЦикла;
			Если НовыйИндексТекущейСтроки >=0 Тогда
				МассивФискальныхСтрок.Удалить(НовыйИндексТекущейСтроки);
				МассивФискальныхСтрок.Вставить(НовыйИндексТекущейСтроки, НоваяТекущаяСтрока);
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти