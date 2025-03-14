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
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Тогда
		ПриЧтенииСозданииНаСервере();
		Объект.ДатаВыполнения = НачалоДня(ТекущаяДатаСеанса());
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)

	// СтандартныеПодсистемы.УправлениеДоступом
	Если ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.УправлениеДоступом") Тогда
		МодульУправлениеДоступом = ОбщегоНазначения.ОбщийМодуль("УправлениеДоступом");
		МодульУправлениеДоступом.ПриЧтенииНаСервере(ЭтотОбъект, ТекущийОбъект);
	КонецЕсли;
	// Конец СтандартныеПодсистемы.УправлениеДоступом
	
	ПриЧтенииСозданииНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("Запись_ПоручениеЭкспедитору", ПараметрыЗаписи, Объект.Ссылка);

КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)

	// СтандартныеПодсистемы.УправлениеДоступом
	УправлениеДоступом.ПослеЗаписиНаСервере(ЭтотОбъект, ТекущийОбъект, ПараметрыЗаписи);
	// Конец СтандартныеПодсистемы.УправлениеДоступом

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ПунктПриИзменении(Элемент)
	ПунктПриИзмененииНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ПунктНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ПоказатьВыборИзСписка(Новый ОписаниеОповещения("ПунктНачалоВыбораНачалоВыбораЗавершение", ЭтотОбъект), СписокВыбораПунктов, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура ДатаПриИзменении(Элемент)
	
	Если Объект.ДатаВыполнения < Объект.Дата Тогда
		Объект.ДатаВыполнения = Объект.Дата;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПриЧтенииСозданииНаСервере()
	
	Если Не ЗначениеЗаполнено(Объект.Ответственный) Тогда
		Объект.Ответственный = Пользователи.ТекущийПользователь();
	КонецЕсли;
	
	СписокВыбораПунктов.Очистить();
	Если ПравоДоступа("Просмотр", Метаданные.Справочники._ДемоПартнеры) Тогда
		СписокВыбораПунктов.Добавить("ВыбратьПартнера", НСтр("ru = '<Выбрать партнера>'"));
	КонецЕсли;
	Если ПравоДоступа("Просмотр", Метаданные.Справочники._ДемоМестаХранения) Тогда
		СписокВыбораПунктов.Добавить("ВыбратьМестоХранения", НСтр("ru = '<Выбрать место хранения>'"));
	КонецЕсли;
	СписокВыбораПунктов.Добавить("ВвестиПроизвольныйТекст", НСтр("ru = '<Ввести произвольный текст>'"));
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура ПунктПриИзмененииНаСервере()
	
	Элементы.АдресПункта.СписокВыбора.Очистить();
	
	ПроверитьЗаполнитьКонтактноеЛицо();
	
	УстановитьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступностьЭлементов()
	
	Элементы.КонтактноеЛицо.Доступность = (ТипЗнч(Объект.Пункт) = Тип("СправочникСсылка._ДемоПартнеры"));
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьЗаполнитьКонтактноеЛицо()
	
	Если ТипЗнч(Объект.Пункт) <> Тип("СправочникСсылка._ДемоПартнеры") Тогда
		Объект.КонтактноеЛицо = Справочники._ДемоКонтактныеЛицаПартнеров.ПустаяСсылка();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПунктНачалоВыбораНачалоВыбораЗавершение(ВыбранныйЭлемент, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйЭлемент = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ВыбранноеЗначение = ВыбранныйЭлемент.Значение;
	ОписаниеОповещения = Новый ОписаниеОповещения("ПослеВыбораПункта",ЭтотОбъект);
	
	Если ВыбранноеЗначение = Неопределено Тогда
		Возврат;
		
	ИначеЕсли ВыбранноеЗначение = "ВыбратьПартнера" Тогда
		ОткрытьФорму("Справочник._ДемоПартнеры.ФормаВыбора",,ЭтотОбъект,,,,
			ОписаниеОповещения,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	ИначеЕсли ВыбранноеЗначение = "ВыбратьМестоХранения" Тогда
		ОткрытьФорму("Справочник._ДемоМестаХранения.ФормаВыбора",,ЭтотОбъект,,,,
			ОписаниеОповещения,РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
		
	ИначеЕсли ВыбранноеЗначение = "ВвестиПроизвольныйТекст" Тогда
		Объект.Пункт = "";
	Иначе
		Объект.Пункт = ВыбранноеЗначение;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыбораПункта(ВыбранноеЗначение, ДополнительныеПараметры) Экспорт
	
	Если ВыбранноеЗначение = Неопределено Тогда
		Возврат;
	КонецЕсли;
	Объект.Пункт = ВыбранноеЗначение;
	ПунктПриИзмененииНаСервере();
	
КонецПроцедуры

#КонецОбласти
