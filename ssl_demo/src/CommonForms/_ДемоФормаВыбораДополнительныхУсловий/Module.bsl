///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	Заголовок = Параметры.ЗаголовокФормыВыбора;
	СтруктураЗаполняемыхЗначений = Новый Структура("ИмяТаблицыДляЗаполнения, ИмяКолонкиДляЗаполнения", 
													Параметры.ИмяЭлементаФормыДляЗаполнения, 
													Параметры.ИмяРеквизитаЭлементаФормыДляЗаполнения);
	
	Если Параметры.ПараметрыВнешнегоСоединения = Неопределено Тогда
		
		Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
			МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
		Иначе
			МассивПереданныхЗначений = Новый Массив();
		КонецЕсли;
		
		ЗаполнитьСписокДоступныхЗначений( МассивПереданныхЗначений, 
										  Параметры.ИмяТаблицыВыбора,
										  Параметры.КоллекцияФильтров);
	
	Иначе
		
		Если Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВнешнееСоединение" Тогда
			
			СтрокаСообщенияОбОшибке = "";
			
			Результат = ОбменДаннымиСервер.ВнешнееСоединениеСБазой(Параметры.ПараметрыВнешнегоСоединения);
				
			ВнешнееСоединение = Результат.Соединение;
			
			Если ВнешнееСоединение = Неопределено Тогда
				ОбщегоНазначения.СообщитьПользователю(Результат.ПодробноеОписаниеОшибки,,,, Отказ);
				Возврат;
			КонецЕсли;
			
			СвойстваОбъектаМетаданных = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.СвойстваОбъектаМетаданных(Параметры.ИмяТаблицыВыбора);
			
			Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
				МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
			Иначе
				МассивПереданныхЗначений = Новый Массив();
			КонецЕсли;
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
				Или Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				ПолученнаяКоллекцияОбъектов = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы_2_0_1_6(Параметры.ИмяТаблицыВыбора);
				
				ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ПолученнаяКоллекцияОбъектов);
				
			Иначе
				
				ПолученнаяКоллекцияОбъектов = 
				ВнешнееСоединение.ОбменДаннымиВнешнееСоединение.ПолучитьОбъектыТаблицы(Параметры.ИмяТаблицыВыбора);
				
				ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр( ПолученнаяКоллекцияОбъектов);
				
			КонецЕсли;
			
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( СписокВыбираемыхЗначений, 
			МассивПереданныхЗначений, 
			ТаблицаБазыКорреспондента);
			
			Если ЗначениеЗаполнено(Параметры.КоллекцияФильтров) Тогда
				
				ПроверитьПрохождениеФильтраВнешнееСоединение(Параметры.КоллекцияФильтров);
				
			КонецЕсли;
			
		ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ТипСоединения = "ВебСервис" Тогда
			
			СтрокаСообщенияОбОшибке = "";
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7 Тогда
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_1_1_7(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			ИначеЕсли Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси_2_0_1_6(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			Иначе
				
				WSПрокси = ОбменДаннымиСервер.ПолучитьWSПрокси(Параметры.ПараметрыВнешнегоСоединения, СтрокаСообщенияОбОшибке);
				
			КонецЕсли;
			
			Если WSПрокси = Неопределено Тогда
				ОбщегоНазначения.СообщитьПользователю(СтрокаСообщенияОбОшибке,,,, Отказ);
				Возврат;
			КонецЕсли;
			
			Если Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_1_1_7
				ИЛИ Параметры.ПараметрыВнешнегоСоединения.ВерсияКорреспондента_2_0_1_6 Тогда
				
				ДанныеБазыКорреспондента = СериализаторXDTO.ПрочитатьXDTO(WSПрокси.GetIBData(Параметры.ИмяТаблицыВыбора));
				
				СвойстваОбъектаМетаданных = ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных;
				ТаблицаБазыКорреспондента = ОбщегоНазначения.ЗначениеИзСтрокиXML(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
				
			Иначе
				
				ДанныеБазыКорреспондента = ЗначениеИзСтрокиВнутр(WSПрокси.GetIBData(Параметры.ПолноеИмяТаблицыБазыКорреспондента));
				
				СвойстваОбъектаМетаданных = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.СвойстваОбъектаМетаданных);
				ТаблицаБазыКорреспондента = ЗначениеИзСтрокиВнутр(ДанныеБазыКорреспондента.ТаблицаБазыКорреспондента);
				
			КонецЕсли;
			
			Если ЗначениеЗаполнено(Параметры.МассивВыбранныхЗначений) Тогда
				МассивПереданныхЗначений = Параметры.МассивВыбранныхЗначений;
			Иначе
				МассивПереданныхЗначений = Новый Массив();
			КонецЕсли;
			
			ИнициализироватьИдентификаторСсылки(ТаблицаБазыКорреспондента);
			
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение( СписокВыбираемыхЗначений, 
			МассивПереданныхЗначений, 
			ТаблицаБазыКорреспондента);
			
			Если ЗначениеЗаполнено(Параметры.КоллекцияФильтров) Тогда
				
				ПроверитьПрохождениеФильтраВнешнееСоединение(Параметры.КоллекцияФильтров);
				
			КонецЕсли;
			
			
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьЗакрыть(Команда)
	
	ПараметрыЗакрытияФормы = Новый Структура();
	ПараметрыЗакрытияФормы.Вставить("АдресТаблицыВоВременномХранилище", СформироватьТаблицуВыбранныхЗначений());
	ПараметрыЗакрытияФормы.Вставить("ИмяТаблицыДляЗаполнения",          СтруктураЗаполняемыхЗначений.ИмяТаблицыДляЗаполнения);
	ПараметрыЗакрытияФормы.Вставить("ИмяКолонкиДляЗаполнения",          СтруктураЗаполняемыхЗначений.ИмяКолонкиДляЗаполнения);
	
	ОповеститьОВыборе(ПараметрыЗакрытияФормы);
	
КонецПроцедуры

&НаКлиенте
Процедура СнятьОтметку(Команда)
	
	ЗаполнитьОтметки(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОтметитьВсе(Команда)
	
	ЗаполнитьОтметки(Истина);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура ЗаполнитьСписокДоступныхЗначений( МассивПереданныхЗначений, 
											ВидСправочника,
											ДополнительныеУсловия = Неопределено)
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	                      |	СправочникДляВыбораОтборов.Ссылка КАК Представление,
	                      |	ВЫБОР
	                      |		КОГДА СправочникДляВыбораОтборов.Ссылка В (&МассивПереданныхЗначений)
	                      |			ТОГДА ИСТИНА
	                      |		ИНАЧЕ ЛОЖЬ
	                      |	КОНЕЦ КАК Пометка
	                      |ИЗ
	                      |	&ИмяТаблицыМетаданных КАК СправочникДляВыбораОтборов
	                      |ГДЕ
	                      |	СправочникДляВыбораОтборов.ПометкаУдаления = ЛОЖЬ");
	
	Если ЗначениеЗаполнено(ДополнительныеУсловия) Тогда
		
		Для Каждого Фильтр Из ДополнительныеУсловия Цикл
			
			Запрос.Текст = ДобавитьТекстУсловия(Запрос.Текст, " СправочникДляВыбораОтборов.", "И", Фильтр);
			Запрос.УстановитьПараметр(Фильтр.ИмяПараметра, Фильтр.ЗначениеПараметра);
			
		КонецЦикла; 
		
	КонецЕсли;
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "&ИмяТаблицыМетаданных", ВидСправочника);
	Запрос.УстановитьПараметр("МассивПереданныхЗначений", МассивПереданныхЗначений);
	
	СписокВыбираемыхЗначений.Загрузить(Запрос.Выполнить().Выгрузить());
	
	Для Каждого ЭлементСписка Из СписокВыбираемыхЗначений Цикл
		
		Если ТипЗнч(ЭлементСписка.Представление) <> Тип("Строка") Тогда
			ЭлементСписка.Идентификатор = Строка(ЭлементСписка.Представление.УникальныйИдентификатор());
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение(ТаблицаЗначенийБазыКорреспондента, 
		МассивПереданныхЗначений, ДеревоЗначений)
	
	Для Каждого СтрокаДерева Из ДеревоЗначений.Строки Цикл
		Если СтрокаДерева.Строки.Количество() > 0 Тогда
			ЗаполнитьСписокДоступныхЗначенийВнешнееСоединение(ТаблицаЗначенийБазыКорреспондента, 
				МассивПереданныхЗначений, СтрокаДерева);
		Иначе
			НоваяСтрока = ТаблицаЗначенийБазыКорреспондента.Добавить();
			ЗаполнитьЗначенияСвойств(НоваяСтрока, СтрокаДерева);
			Если МассивПереданныхЗначений.Найти(НоваяСтрока.Идентификатор) <> Неопределено Тогда
				НоваяСтрока.Пометка = Истина;
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция СформироватьТаблицуВыбранныхЗначений()
	
	ТаблицаВыбранныхЗначений = 
		СписокВыбираемыхЗначений.Выгрузить(Новый Структура("Пометка", Истина), "Представление, Идентификатор");
	
	Возврат ПоместитьВоВременноеХранилище( ТаблицаВыбранныхЗначений, УникальныйИдентификатор);
		
КонецФункции

&НаСервере
Процедура ЗаполнитьОтметки(ЗначениеОтметки)
	
	ТаблицаЗаполняемыхЗначений = СписокВыбираемыхЗначений.Выгрузить();
	ТаблицаЗаполняемыхЗначений.ЗаполнитьЗначения(ЗначениеОтметки, "Пометка");
	СписокВыбираемыхЗначений.Загрузить(ТаблицаЗаполняемыхЗначений);
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьПрохождениеФильтраВнешнееСоединение(КоллекцияФильтров)
	
	Запрос = Новый Запрос("ВЫБРАТЬ
	                      |	ТаблицаЗначений.Представление,
	                      |	ТаблицаЗначений.Пометка,
	                      |	ТаблицаЗначений.Ключ,
	                      |	ТаблицаЗначений.Идентификатор
	                      |ПОМЕСТИТЬ СписокОтфильтрованныхЭлементов
	                      |ИЗ
	                      |	&СписокОтобранныхЗначений КАК ТаблицаЗначений
	                      |ГДЕ ИСТИНА // Автозамена");
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, " Истина // Автозамена", "");
	Запрос.УстановитьПараметр("СписокОтобранныхЗначений", СписокВыбираемыхЗначений.Выгрузить());
	
	Для Каждого Фильтр Из КоллекцияФильтров Цикл
		
		Если СтрЗаканчиваетсяНа(Запрос.Текст, "ГДЕ") Тогда
			
			СоединительУсловий = "";
			
		Иначе
			
			СоединительУсловий = "И";
			
		КонецЕсли;
		
		Запрос.Текст = ДобавитьТекстУсловия(Запрос.Текст, " ТаблицаЗначений.", СоединительУсловий, Фильтр);
		Запрос.УстановитьПараметр(Фильтр.ИмяПараметра, Фильтр.ЗначениеПараметра);
		
	КонецЦикла; 
	
	Запрос.Текст = Запрос.Текст + "
	                      |;
	                      |ВЫБРАТЬ
	                      |	СписокОтфильтрованныхЭлементов.Представление,
	                      |	СписокОтфильтрованныхЭлементов.Пометка,
	                      |	СписокОтфильтрованныхЭлементов.Ключ,
	                      |	СписокОтфильтрованныхЭлементов.Идентификатор
	                      |ИЗ
	                      |	СписокОтфильтрованныхЭлементов КАК СписокОтфильтрованныхЭлементов";
	
	СписокВыбираемыхЗначений.Загрузить(Запрос.Выполнить().Выгрузить());
	
КонецПроцедуры

// Параметры:
//   ТекстЗапроса - Строка - текст запроса.
//   ИмяТаблицы - Строка - имя таблицы данных.
//   СоединительУсловий - Строка - оператор объединения условий отбора.
//   Фильтр - Структура:
//     * РеквизитОтбора - Строка - имя реквизита объекта.
//     * Условие - Строка - вид условия.
//
&НаСервере
Функция ДобавитьТекстУсловия(ТекстЗапроса, ИмяТаблицы, СоединительУсловий, Фильтр)
	
	ТекстЗапроса = ТекстЗапроса + Символы.ПС + " " + СоединительУсловий 
		+ ИмяТаблицы
		+ Фильтр.РеквизитОтбора
		+ " " + Фильтр.Условие
		+ ?(Фильтр.Условие = "В", " (","")
		+ " &"
		+ Фильтр.ИмяПараметра
		+ ?(Фильтр.Условие = "В", ") ","");

	Возврат ТекстЗапроса;
	
КонецФункции

&НаСервере
Процедура ИнициализироватьИдентификаторСсылки(ТаблицаБазыКорреспондента)
	
	Для Каждого СтрокаДерева Из ТаблицаБазыКорреспондента.Строки Цикл
		Если СтрокаДерева.Строки.Количество() > 0 Тогда
			ИнициализироватьИдентификаторСсылки(СтрокаДерева);
		Иначе
			СтрокаДерева.Идентификатор = ИдентификаторСсылки(СтрокаДерева.Идентификатор);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Функция ИдентификаторСсылки(Знач СтрокаВнутр)
	
	СтрокаУИД = Сред(СтрокаВнутр, 1 + СтрНайти(СтрокаВнутр, ":"), 32);
	
	Идентификатор =
		Сред(СтрокаУИД, 25, 8) 
		+ "-" + Сред(СтрокаУИД, 21, 4) 
		+ "-" + Сред(СтрокаУИД, 17, 4) 
		+ "-" + Сред(СтрокаУИД, 1, 4)
		+ "-" + Сред(СтрокаУИД, 5, 12);
	
	Возврат Идентификатор;
	
КонецФункции

#КонецОбласти

#КонецОбласти