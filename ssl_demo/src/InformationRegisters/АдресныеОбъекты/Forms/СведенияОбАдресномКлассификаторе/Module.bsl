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
	СформироватьОтчет();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура СформироватьОтчет()
	
	СистемнаяИнформация = Новый СистемнаяИнформация;
	СведенияОЗагрузкеСубъектовРФ = АдресныйКлассификаторПовтИсп.СведенияОЗагрузкеСубъектовРФ();
	КлассификаторДоступен = СведенияОЗагрузкеСубъектовРФ.Получить("КлассификаторДоступен");
	ИспользоватьЗагруженные = СведенияОЗагрузкеСубъектовРФ.Получить("ИспользоватьЗагруженные");
	
	Сведения = Новый Массив;
	
	Если ЗначениеЗаполнено(Параметры.Адрес) Тогда
		Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Адрес: %1'"), Параметры.Адрес));
		Сведения.Добавить("");
	КонецЕсли;
	
	Если ТипЗнч(Параметры.СведенияОбАдресе) = Тип("Структура") Тогда
		
		Поля = Новый Соответствие;
		Поля.Вставить("ИдентификаторАдресногоОбъекта", Истина);
		Поля.Вставить("ИдентификаторДома", Истина);
		Поля.Вставить("ИдентификаторЗемельногоУчастка", Истина);
		Поля.Вставить("Идентификаторы", Истина);
		Поля.Вставить("ДополнительныеКоды", Истина);
		Поля.Вставить("КодРегиона", Истина);
		
		Сведения.Добавить(НСтр("ru = 'Коды и идентификаторы адреса:'"));
		
		Для Каждого Элемент Из Параметры.СведенияОбАдресе Цикл
			Если Поля[Элемент.Ключ] <> Истина Тогда
				Продолжить;
			КонецЕсли;
			
			Если ТипЗнч(Элемент.Значение)=Тип("Структура") Тогда
				Сведения.Добавить("");
				Сведения.Добавить(Элемент.Ключ + ": ");
				Для Каждого ЭлементВложенный Из Элемент.Значение Цикл
					Если СтрЗаканчиваетсяНа(ЭлементВложенный.Ключ, "Идентификатор")
						Или ПустаяСтрока(ЭлементВложенный.Значение) Тогда
							Продолжить;
					КонецЕсли;
					Сведения.Добавить(ЭлементВложенный.Ключ + ": " + ЭлементВложенный.Значение);
				КонецЦикла;
			Иначе
				Сведения.Добавить(Элемент.Ключ + ": " + Элемент.Значение);
			КонецЕсли;
		КонецЦикла;
		
		Сведения.Добавить("");
		
	КонецЕсли;
	
	Если Не ИспользоватьЗагруженные Тогда
		Сведения.Добавить(НСтр("ru = 'В адресном классификаторе отсутствуют загруженные адресные сведения.'"));
	Иначе
		Сведения.Добавить(НСтр("ru = 'Автоподбор адреса выполняется по загруженным данным для регионов:'"));
	КонецЕсли;
	
	СведенияОРегионах = Новый СписокЗначений;
	
	Для Каждого СведенияОЗагрузкеСубъектаРФ Из СведенияОЗагрузкеСубъектовРФ Цикл
		
		Значение = СведенияОЗагрузкеСубъектаРФ.Значение;
		Если ТипЗнч(Значение) = Тип("Структура") И Значение.ИспользоватьЗагруженные Тогда
			СведенияОРегионах.Добавить(Формат(СведенияОЗагрузкеСубъектаРФ.Ключ,"ЧЦ=2; ЧВН="), НСтр("ru = 'Загружен'") + " - " + Строка(Значение.ДатаЗагрузки));
		КонецЕсли;
		
	КонецЦикла;
	
	СведенияОРегионах.СортироватьПоЗначению();
	
	Для Каждого Регион Из СведенияОРегионах Цикл
		ИмяРегиона = АдресныйКлассификатор.НаименованиеРегионаПоКоду(Регион.Значение);
		СтрокаОтчета = Отчет +Регион.Значение + ", " + ИмяРегиона + ": " + Регион.Представление;
		Сведения.Добавить(СтрокаОтчета);
	КонецЦикла;
	
	Сведения.Добавить("");
	
	ИПППодключена = Ложь;
	Если ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей") Тогда
		МодульИнтернетПоддержкаПользователей = ОбщегоНазначения.ОбщийМодуль("ИнтернетПоддержкаПользователей");
		ИПППодключена = МодульИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
		Если ИПППодключена Тогда
			Сведения.Добавить(НСтр("ru = 'Подключен к Интернет-поддержке пользователей: Да.'"));
		Иначе
			Сведения.Добавить(НСтр("ru = 'Подключен к Интернет-поддержке пользователей: Нет.'"));
		КонецЕсли;
		Сведения.Добавить("");
	КонецЕсли;
	
	Если ИПППодключена Тогда
		
		Если Не АдресныйКлассификаторПовтИсп.ИспользоватьТолькоЗагруженныеДанные() Тогда
		
			ОписаниеСервиса = АдресныйКлассификаторПовтИсп.СервисКлассификатора1С(10); 
			ИнформацияОСервисе = ОписаниеСервиса.СервисКлассификатора;
			СсылкаНаВебСервис = ИнформацияОСервисе.Сервер + ":" + ИнформацияОСервисе.Порт + "/"+ АдресныйКлассификаторСлужебный.ПрефиксВерсииЗапроса();
			Если КлассификаторДоступен Тогда
				
				Шаблон = НСтр("ru = 'Веб-сервис доступен.
				|URL подключения: %1'");
				Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(Шаблон, СсылкаНаВебСервис));
				
			Иначе
				
				Сведения.Добавить(НСтр("ru = 'Веб-сервис недоступен.'"));
				
				Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ПолучениеФайловИзИнтернета") Тогда
					
					МодульПолучениеФайловИзИнтернета = ОбщегоНазначения.ОбщийМодуль("ПолучениеФайловИзИнтернета");
					Результат = МодульПолучениеФайловИзИнтернета.ДиагностикаСоединения(СсылкаНаВебСервис,,Ложь);
					Сведения.Добавить(Результат.ЖурналДиагностики);
					
				КонецЕсли;
				
			КонецЕсли;
		Иначе
			Сведения.Добавить(НСтр("ru = 'Использование веб-сервиса отключено.'"));
		КонецЕсли;
		
	КонецЕсли;
	
	Сведения.Добавить("");
	
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Конфигурация: %1'"), Метаданные.Представление()));
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Версия конфигурации: %1'"), Метаданные.Версия));
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Версия Библиотеки стандартных подсистем: %1'"), СтандартныеПодсистемыСервер.ВерсияБиблиотеки()));
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Платформа 1С:Предприятие: %1 (%2)'"), СистемнаяИнформация.ВерсияПриложения, СистемнаяИнформация.ТипПлатформы));
	
	Сведения.Добавить("");
	
	Сведения.Добавить(НСтр("ru = 'Системная информация'"));
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Версия ОС: %1'"), СистемнаяИнформация.ВерсияОС));
	Сведения.Добавить(СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(НСтр("ru = 'Оперативная память: %1'"), СистемнаяИнформация.ОперативнаяПамять));
	
	Сведения.Добавить("");
	Сведения.Добавить(НСтр("ru = 'Отчет создан'") + ": " + ТекущаяДатаСеанса());
	
	Отчет = СтрСоединить(Сведения, Символы.ПС);
	
КонецПроцедуры

#КонецОбласти