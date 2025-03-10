///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем ПрограммноеЗакрытие;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	МассивУчетныхЗаписей = СервисКриптографииDSSКлиентСервер.ПолучитьПолеСтруктуры(Параметры.ПараметрыОперации, "СписокУчетныхЗаписей");
	
	Если МассивУчетныхЗаписей <> Неопределено Тогда
		СписокУчетныхЗаписей.ЗагрузитьЗначения(МассивУчетныхЗаписей);
	Иначе
		ВсеУчетныеЗаписи = СервисКриптографииDSS.ПолучитьВсеУчетныеЗаписи();
		Для Каждого СтрокаТаблицы Из ВсеУчетныеЗаписи Цикл
			СписокУчетныхЗаписей.Добавить(СтрокаТаблицы.Ссылка);
		КонецЦикла;	
	КонецЕсли;
	
	НастроитьУсловноеОформление();
	ЗаполнитьСписокУчетныхЗаписей();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	СервисКриптографииDSSСлужебныйКлиент.ПриОткрытииФормы(ЭтотОбъект, ПрограммноеЗакрытие);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если СервисКриптографииDSSСлужебныйКлиент.ПередЗакрытиемФормы(
			ЭтотОбъект,
			Отказ,
			ПрограммноеЗакрытие,
			ЗавершениеРаботы) Тогда
		ЗакрытьФорму(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

&НаКлиенте
Процедура СписокУчетныхЗаписейВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущаяСтрока = Элементы.Список.ТекущиеДанные;
	Если ТекущаяСтрока <> Неопределено Тогда
		ВыборИзСписка(ТекущаяСтрока.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СписокВыборЗначения(Элемент, Значение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ТекущаяСтрока = Элементы.Список.ТекущиеДанные;
	Если ТекущаяСтрока <> Неопределено Тогда
		ВыборИзСписка(ТекущаяСтрока.Ссылка);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗакрытьФорму(ПараметрыЗакрытия = Неопределено)
	
	ПрограммноеЗакрытие = Истина;
	Если ПараметрыЗакрытия = Неопределено Тогда
		ПараметрыЗакрытия = СервисКриптографииDSSКлиент.ОтветСервисаПоУмолчанию(Ложь, "ОтказПользователя");
	КонецЕсли;
	
	Закрыть(ПараметрыЗакрытия);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыборИзСписка(ТекущаяСсылка)
	
	НашлиСсылку	= ПолучитьТекущегоПользователя(ТекущаяСсылка);
	ПараметрыЗакрытия = Неопределено;
	Если НашлиСсылку <> Неопределено Тогда
		ПараметрыЗакрытия = СервисКриптографииDSSКлиент.ОтветСервисаПоУмолчанию(Истина);
		ПараметрыЗакрытия.Вставить("Результат", НашлиСсылку);
	КонецЕсли;	
	ЗакрытьФорму(ПараметрыЗакрытия);
	
КонецПроцедуры	

&НаСервере
Процедура ЗаполнитьСписокУчетныхЗаписей()
	
	ДанныеСеанса 		= ПолучитьДанныеСеанса();
	ВсеПользователи 	= ДанныеСеанса.Пользователи;
	
	СписокАктивных		= Новый Массив;
	
	Для каждого СтрокаКлюча Из ВсеПользователи Цикл
		Если СтрокаКлюча.Значение.Политика.Заполнено Тогда
			СписокАктивных.Добавить(СтрокаКлюча.Ключ);
		КонецЕсли;
	КонецЦикла;	
	
	Список.Параметры.УстановитьЗначениеПараметра("СписокАктивных", СписокАктивных);
	Список.Параметры.УстановитьЗначениеПараметра("СписокУчетныхЗаписей", СписокУчетныхЗаписей.ВыгрузитьЗначения());
	Список.Параметры.УстановитьЗначениеПараметра("ЕстьОтбор", СписокУчетныхЗаписей.Количество() <> 0);
	
КонецПроцедуры

&НаСервере
Процедура НастроитьУсловноеОформление()
	
	ЭлементУсловногоОформления = Список.УсловноеОформление.Элементы.Добавить();
	
	ЭлементЦветаОформления = ЭлементУсловногоОформления.Оформление.Элементы.Найти("BackColor");
	ЭлементЦветаОформления.Значение = ЦветаСтиля.ДобавленныйРеквизитФон;
	ЭлементЦветаОформления.Использование = Ложь;
	
	ЭлементОтбораДанных = ЭлементУсловногоОформления.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбораДанных.ЛевоеЗначение  = Новый ПолеКомпоновкиДанных("Авторизован");
	ЭлементОтбораДанных.ВидСравнения   = ВидСравненияКомпоновкиДанных.Равно;
	ЭлементОтбораДанных.ПравоеЗначение = Истина;
	ЭлементОтбораДанных.Использование  = Ложь;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПолучитьДанныеСеанса()
	
	Результат = СервисКриптографииDSSСлужебный.ПолучитьКонтейнерНастроек();
	Возврат Результат;
	
КонецФункции	

&НаСервереБезКонтекста
Функция ПолучитьТекущегоПользователя(УчетнаяЗапись)
	
	Результат = СервисКриптографииDSSСлужебныйВызовСервера.ПолучитьНастройкиПользователя(УчетнаяЗапись);
	Возврат Результат;
	
КонецФункции	

#КонецОбласти