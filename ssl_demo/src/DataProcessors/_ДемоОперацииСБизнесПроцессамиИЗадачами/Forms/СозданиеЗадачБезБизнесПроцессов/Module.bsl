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
	
	ТемаЗадачи = НСтр("ru = 'Новая задача'");
	СрокИсполнения = ТекущаяДатаСеанса();
	Задача = Задачи.ЗадачаИсполнителя.ПустаяСсылка();
	УстановитьТипыОбъектовАдресации();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	УстановитьСостояниеЭлементов();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РольПриИзменении(Элемент)
	
	ОсновнойОбъектАдресации = Неопределено;
	ДополнительныйОбъектАдресации = Неопределено;
	УстановитьТипыОбъектовАдресации();
	УстановитьСостояниеЭлементов();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СоздатьЗадачуВыполнить(Команда)
	
	СоздатьЗадачу();
	ОтобразитьИзменениеДанных(ЗадачаСсылка, ВидИзмененияДанных.Добавление);
		
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УстановитьТипыОбъектовАдресации()
	
	ТипыОсновногоОбъектаАдресации = Неопределено;
	ТипыДополнительногоОбъектаАдресации = Неопределено;
	ИспользуетсяСОбъектамиАдресации = Ложь;
	Если Не Роль.Пустая() Тогда
		СведенияОРоли = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Роль, 
			"ТипыОсновногоОбъектаАдресации,ТипыДополнительногоОбъектаАдресации,ИспользуетсяСОбъектамиАдресации");
		ИспользуетсяСОбъектамиАдресации = СведенияОРоли.ИспользуетсяСОбъектамиАдресации;
		Если ИспользуетсяСОбъектамиАдресации Тогда
			ТипыОсновногоОбъектаАдресации = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СведенияОРоли.ТипыОсновногоОбъектаАдресации, "ТипЗначения");
			ТипыДополнительногоОбъектаАдресации = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СведенияОРоли.ТипыДополнительногоОбъектаАдресации, "ТипЗначения");
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСостояниеЭлементов()

	ЗаданаРоль = НЕ Роль.Пустая();
	ЗаданыТипыОсновногоОбъектаАдресации = ЗаданаРоль И ИспользуетсяСОбъектамиАдресации
		И ЗначениеЗаполнено(ТипыОсновногоОбъектаАдресации);
	ЗаданыТипыДопОбъектаАдресации = ЗаданаРоль И ИспользуетсяСОбъектамиАдресации 
		И ЗначениеЗаполнено(ТипыДополнительногоОбъектаАдресации);
	Элементы.ОсновнойОбъектАдресации.Доступность = ЗаданыТипыОсновногоОбъектаАдресации;
	Элементы.ДополнительныйОбъектАдресации.Доступность = ЗаданыТипыДопОбъектаАдресации;
	
	Элементы.ОсновнойОбъектАдресации.АвтоОтметкаНезаполненного = ЗаданыТипыОсновногоОбъектаАдресации;
	Элементы.ДополнительныйОбъектАдресации.АвтоОтметкаНезаполненного = ЗаданыТипыДопОбъектаАдресации;
	Элементы.ОсновнойОбъектАдресации.ОграничениеТипа = ТипыОсновногоОбъектаАдресации;
	Элементы.ДополнительныйОбъектАдресации.ОграничениеТипа = ТипыДополнительногоОбъектаАдресации;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьЗадачу()
	
	УстановитьПривилегированныйРежим(Истина);
	
	ЗадачаОбъект = Задачи.ЗадачаИсполнителя.СоздатьЗадачу();
	ЗадачаОбъект.Дата = ТекущаяДатаСеанса();
	ЗадачаОбъект.Автор = Пользователи.ТекущийПользователь();
	ЗадачаОбъект.РольИсполнителя = Роль;
	ЗадачаОбъект.ОсновнойОбъектАдресации = ОсновнойОбъектАдресации;
	ЗадачаОбъект.ДополнительныйОбъектАдресации = ДополнительныйОбъектАдресации;
	ЗадачаОбъект.Описание = НСтр("ru = 'Задача сгенерирована автоматически.'");
	ЗадачаОбъект.Наименование = ТемаЗадачи;
	ЗадачаОбъект.СрокИсполнения = СрокИсполнения;
	ЗадачаОбъект.Записать();
	
	Задача = Строка(ЗадачаОбъект);
	ЗадачаСсылка = ЗадачаОбъект.Ссылка;
	
КонецПроцедуры

#КонецОбласти
