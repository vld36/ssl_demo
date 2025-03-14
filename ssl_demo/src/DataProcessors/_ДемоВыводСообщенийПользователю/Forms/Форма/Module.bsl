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
	
	Объект.РеквизитОбъекта = НСтр("ru = 'Тестовое значение реквизита'");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомОбъектаНаКлиенте(Команда)
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Пример сообщения, связанного с реквизитом объекта (%1).'"), "Объект.РеквизитОбъекта"), ,
		"РеквизитОбъекта", "Объект");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомОбъектаНаСервере(Команда)
	
	ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомОбъектаСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьКодВариантПервый(Команда)
	
	ОткрытьФорму("Обработка._ДемоВыводСообщенийПользователю.Форма.ПримерКода",
		Новый Структура("ПримерКода", "ОбщегоНазначения.СообщитьПользователю(
		|	НСтр(""ru = 'Пример сообщения связанного с реквизитом объекта.'""),
		|	,
		|	""РеквизитОбъекта"",
		|	""Объект"");"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомФормыНаКлиенте(Команда)
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Пример сообщения, связанного с реквизитом формы (%1).'"), "РеквизитФормы"), ,
			"РеквизитФормы");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомФормыНаСервере(Команда)
	
	ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомФормыСервер();
	
КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьКодВариантВторой(Команда)
	
	ОткрытьФорму("Обработка._ДемоВыводСообщенийПользователю.Форма.ПримерКода",
		Новый Структура("ПримерКода", "ОбщегоНазначения.СообщитьПользователю(
		|	НСтр(""ru = 'Пример сообщения, связанного с реквизитом формы (РеквизитФормы).'""),
		|	,
		|	""РеквизитФормы"");"));
		
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазы(Команда)
	
	Если НЕ ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазСервер() Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыЗавершение", ЭтотОбъект);
		ПоказатьПредупреждение(ОписаниеОповещения, НСтр("ru = 'Для выполнения теста предварительно создайте хотя бы один документ ""Демо: Счет на оплату покупателю"".'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьКодВариантТретий(Команда)
	
	ОткрытьФорму("Обработка._ДемоВыводСообщенийПользователю.Форма.ПримерКода",
		Новый Структура("ПримерКода", "ОбщегоНазначения.СообщитьПользователю(
		|	НСтр(""ru = 'Пример сообщения, связанного с реквизитом ""Ответственный"" документа ""Демо: Счет на оплату покупателю"" 
		|		|(объект информационной базы).'""),
		|	Ссылка.ПолучитьОбъект(),
		|	""Ответственный"");"));
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеНаКлиенте(Команда)
	
	Перем РезультатПустой;
	
	Ссылка = ПолучитьСсылку(РезультатПустой);
	
	Если РезультатПустой Тогда
		ПоказатьПредупреждение(, НСтр("ru = 'Не найдено доступных объектов.'"));
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиент.СообщитьПользователю(
		НСтр("ru = 'Пример сообщения, связанного с реквизитом ""Ответственный"" документа ""Демо: Счет на оплату покупателю""
			| (объект информационной базы).'"),
		Ссылка,
		"Ответственный");
	
	Возврат;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеНаСервере(Команда)
	
	Если НЕ ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеСервер() Тогда
		ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеНаСервереЗавершение", ЭтотОбъект);
		ПоказатьПредупреждение(ОписаниеОповещения, НСтр("ru = 'Для выполнения теста предварительно создайте хотя бы один документ ""Демо: Счет на оплату покупателю"".'"));
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПосмотретьКодВариантЧетвертый(Команда)
	
	ОткрытьФорму("Обработка._ДемоВыводСообщенийПользователю.Форма.ПримерКода",
		Новый Структура("ПримерКода", "ОбщегоНазначения.СообщитьПользователю(
		|	НСтр(""ru = 'Тестовое сообщение об ошибке, связанное с реквизитом ""Ответственный"" документа ""Демо: Счет на оплату покупателю""
		|		|(ссылка на объект).'""),
		|	Ссылка,
		|	""Ответственный"")"));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомОбъектаСервер()
	
	ОбщегоНазначения.СообщитьПользователю(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Пример сообщения, связанного с реквизитом объекта (%1).'"), "Объект.РеквизитОбъекта"), ,
		"РеквизитОбъекта",
		"Объект");
	
КонецПроцедуры

&НаСервере
Процедура ПоказатьСообщениеПоляФормыСвязанногоСРеквизитомФормыСервер()
	
	ОбщегоНазначения.СообщитьПользователю(
		СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Пример сообщения, связанного с реквизитом формы (%1).'"), "РеквизитФормы"), ,
		"РеквизитФормы");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыЗавершение(ДополнительныеПараметры) Экспорт
	
	ОткрытьФорму("Документ._ДемоСчетНаОплатуПокупателю.ФормаСписка");
	
КонецПроцедуры

&НаСервере
Функция ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазСервер()
	
	Перем РезультатПустой;
	Ссылка = ПолучитьСсылку(РезультатПустой);
	Если РезультатПустой Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ОбщегоНазначения.СообщитьПользователю(
		НСтр("ru = 'Пример сообщения, связанного с реквизитом ""Ответственный"" документа ""Демо: Счет на оплату покупателю"" 
			| (объект информационной базы).'"),
		Ссылка.ПолучитьОбъект(), "Ответственный");
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеНаСервереЗавершение(ДополнительныеПараметры) Экспорт
	
	ОткрытьФорму("Документ._ДемоСчетНаОплатуПокупателю.ФормаСписка");
	
КонецПроцедуры

&НаСервере
Функция ПоказатьСообщениеСвязанноеСРеквизитомОбъектаИнформационнойБазыПоСсылкеСервер()
	
	Перем РезультатПустой;
	
	Ссылка = ПолучитьСсылку(РезультатПустой);
	
	Если РезультатПустой Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ОбщегоНазначения.СообщитьПользователю(
		НСтр("ru = 'Пример сообщения, связанного с реквизитом ""Ответственный"" документа ""Демо: Счет на оплату покупателю""
			| (ссылка на объект).'"),
		Ссылка,
		"Ответственный");
	
	Возврат Истина;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПолучитьСсылку(РезультатПустой)
	
	ТекстЗапроса = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
		|	_ДемоСчетНаОплатуПокупателю.Ссылка КАК Ссылка
		|ИЗ
		|	Документ._ДемоСчетНаОплатуПокупателю КАК _ДемоСчетНаОплатуПокупателю";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Результат = Запрос.Выполнить();
	
	Если Результат.Пустой() Тогда
		РезультатПустой = Истина;
		Возврат Документы._ДемоСчетНаОплатуПокупателю.ПустаяСсылка();
	КонецЕсли;
	
	РезультатПустой = Ложь;
	Возврат Результат.Выгрузить()[0].Ссылка
	
КонецФункции

#КонецОбласти



