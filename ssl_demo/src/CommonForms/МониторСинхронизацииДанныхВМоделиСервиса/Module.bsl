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
	
	Если Не Пользователи.ЭтоПолноправныйПользователь(Неопределено, Истина, Ложь) Тогда
		ВызватьИсключение НСтр("ru = 'Нет прав на администрирование обменов данными.'");
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Истина);
	
	ОбновитьСписокСостоянияУзлов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПерейтиВЖурналРегистрацииСобытийВыгрузкиДанных(Команда)
	
	ТекущиеДанные = Элементы.СписокСостоянияУзлов.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.УзелИнформационнойБазы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиКлиент.ПерейтиВЖурналРегистрацииСобытийДанныхМодально(ТекущиеДанные.УзелИнформационнойБазы, ЭтотОбъект, "ВыгрузкаДанных");
	
КонецПроцедуры

&НаКлиенте
Процедура ПерейтиВЖурналРегистрацииСобытийЗагрузкиДанных(Команда)
	
	ТекущиеДанные = Элементы.СписокСостоянияУзлов.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если ТекущиеДанные.УзелИнформационнойБазы = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ОбменДаннымиКлиент.ПерейтиВЖурналРегистрацииСобытийДанныхМодально(ТекущиеДанные.УзелИнформационнойБазы, ЭтотОбъект, "ЗагрузкаДанных");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьМонитор(Команда)
	
	ОбновитьДанныеМонитора();
	
КонецПроцедуры

&НаКлиенте
Процедура Подробно(Команда)
	
	ПодробноНаСервере();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьСписокСостоянияУзлов()
	
	СписокСостоянияУзлов.Очистить();
	
	СписокСостоянияУзлов.Загрузить(
		ОбменДаннымиВМоделиСервиса.ТаблицаМонитораОбменаДанными(ОбменДаннымиПовтИсп.РазделенныеПланыОбменаБСП()));
		
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеМонитора()
	
	ИндексСтрокиСписокСостоянияУзлов = ПолучитьТекущийИндексСтроки();
	
	// выполняем обновление таблиц монитора на сервере
	ОбновитьСписокСостоянияУзлов();
	
	// выполняем позиционирование курсора
	ВыполнитьПозиционированиеКурсора(ИндексСтрокиСписокСостоянияУзлов);
	
КонецПроцедуры

&НаКлиенте
Функция ПолучитьТекущийИндексСтроки()
	
	// возвращаемое значение функции
	ИндексСтроки = Неопределено;
	
	// при обновлении монитора выполняем позиционирование курсора
	ТекущиеДанные = Элементы.СписокСостоянияУзлов.ТекущиеДанные;
	
	Если ТекущиеДанные <> Неопределено Тогда
		
		ИндексСтроки = СписокСостоянияУзлов.Индекс(ТекущиеДанные);
		
	КонецЕсли;
	
	Возврат ИндексСтроки;
КонецФункции

&НаКлиенте
Процедура ВыполнитьПозиционированиеКурсора(ИндексСтроки)
	
	Если ИндексСтроки <> Неопределено Тогда
		
		// выполняем проверки позиционирования курсора после получения новых данных
		Если СписокСостоянияУзлов.Количество() <> 0 Тогда
			
			Если ИндексСтроки > СписокСостоянияУзлов.Количество() - 1 Тогда
				
				ИндексСтроки = СписокСостоянияУзлов.Количество() - 1;
				
			КонецЕсли;
			
			// позиционируем курсор
			Элементы.СписокСостоянияУзлов.ТекущаяСтрока = СписокСостоянияУзлов[ИндексСтроки].ПолучитьИдентификатор();
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПодробноНаСервере()
	
	Элементы.СписокСостоянияУзловПодробно.Пометка = Не Элементы.СписокСостоянияУзловПодробно.Пометка;
	
	Элементы.СписокСостоянияУзловДатаПоследнейУспешнойВыгрузки.Видимость = Элементы.СписокСостоянияУзловПодробно.Пометка;
	Элементы.СписокСостоянияУзловДатаПоследнейУспешнойЗагрузки.Видимость = Элементы.СписокСостоянияУзловПодробно.Пометка;
	Элементы.СписокСостоянияУзловИмяПланаОбмена.Видимость = Элементы.СписокСостоянияУзловПодробно.Пометка;
	
КонецПроцедуры

#КонецОбласти