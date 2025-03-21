///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОписаниеПеременных

&НаКлиенте
Перем СчетчикПоискаОткрытойФормы;

&НаКлиенте
Перем НачалоОткрытия;

&НаКлиенте
Перем КоличествоИзмерений;

&НаКлиенте
Перем Счетчик;

&НаКлиенте
Перем ФормаВыбранаИзСписка;

&НаКлиенте
Перем Замеры;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	КоличествоИзмерений = 0;
	ПодключитьОбработчикОжидания("ЗаполнитьСписокВыбораФорм", 1, Истина);
	Если КоличествоЗамеров = 0 Тогда
		КоличествоЗамеров = 5;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыполнитьЗамер(Команда)
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли;
	ТекущийЗамер = ОписаниеЗамера();
	Если ОписаниеЗамера <> ТекущийЗамер Тогда
		ОписаниеЗамера = ТекущийЗамер;
		КоличествоИзмерений = 0;
		Замеры = Новый Массив;
	КонецЕсли;
	Счетчик = КоличествоЗамеров;
	ФормаВыбранаИзСписка = Элементы.ИмяФормы.СписокВыбора.НайтиПоЗначению(ИмяОткрываемойФормы) <> Неопределено;
	НачатьЗамер();
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьРезультаты(Команда)
	КоличествоИзмерений = 0;
	Замеры = Новый Массив;
	РезультатыЗамеров.Очистить();
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ЗаполнитьСписокВыбораФорм()
	Состояние(НСтр("ru = 'Подготовка данных для анализа...'"));
	ЗаполнитьСписокДоступныхФорм();
	Состояние(НСтр("ru = 'Подготовка данных завершена.'"));
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСписокДоступныхФорм()
	Для Каждого Форма Из СписокВсехФормКонфигурации() Цикл
		Элементы.ИмяФормы.СписокВыбора.Добавить(Форма);
	КонецЦикла;
КонецПроцедуры

&НаСервере
Функция СписокВсехФормКонфигурации()
	
	КоллекцииОбъектовМетаданных = Новый Массив;
	КоллекцииОбъектовМетаданных.Добавить("ОбщиеФормы");
	КоллекцииОбъектовМетаданных.Добавить("Справочники");
	КоллекцииОбъектовМетаданных.Добавить("Документы");
	КоллекцииОбъектовМетаданных.Добавить("ЖурналыДокументов");
	КоллекцииОбъектовМетаданных.Добавить("Перечисления");
	КоллекцииОбъектовМетаданных.Добавить("Отчеты");
	КоллекцииОбъектовМетаданных.Добавить("Обработки");
	КоллекцииОбъектовМетаданных.Добавить("ПланыВидовХарактеристик");
	КоллекцииОбъектовМетаданных.Добавить("ПланыСчетов");
	КоллекцииОбъектовМетаданных.Добавить("ПланыВидовРасчета");
	КоллекцииОбъектовМетаданных.Добавить("РегистрыСведений");
	КоллекцииОбъектовМетаданных.Добавить("РегистрыНакопления");
	КоллекцииОбъектовМетаданных.Добавить("РегистрыБухгалтерии");
	КоллекцииОбъектовМетаданных.Добавить("РегистрыРасчета");
	КоллекцииОбъектовМетаданных.Добавить("БизнесПроцессы");
	КоллекцииОбъектовМетаданных.Добавить("Задачи");
	КоллекцииОбъектовМетаданных.Добавить("ПланыОбмена");
	КоллекцииОбъектовМетаданных.Добавить("КритерииОтбора");
	КоллекцииОбъектовМетаданных.Добавить("ХранилищаНастроек");

	Результат = Новый Массив;
	Для Каждого КоллекцияОбъектовМетаданных Из КоллекцииОбъектовМетаданных Цикл
		Для Каждого ОбъектМетаданных Из Метаданные[КоллекцияОбъектовМетаданных] Цикл
			Если Метаданные[КоллекцияОбъектовМетаданных] = Метаданные.ОбщиеФормы Тогда
				Результат.Добавить(ОбъектМетаданных.ПолноеИмя());
			Иначе
				Для Каждого Форма Из ОбъектМетаданных.Формы Цикл
					Результат.Добавить(Форма.ПолноеИмя());
				КонецЦикла;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция ПараметрыОткрытия()
	Результат = Новый Структура;
	Для Каждого ОписаниеПараметра Из ПараметрыОткрытия Цикл
		Результат.Вставить(ОписаниеПараметра.Имя, ОписаниеПараметра.Значение);
	КонецЦикла;
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура НачатьЗамер()
	ПараметрыОткрытияФормы = ПараметрыОткрытия();
	НачалоОткрытия = ТекущаяУниверсальнаяДатаВМиллисекундах();
	Попытка
		ОткрытьФорму(ИмяОткрываемойФормы, ПараметрыОткрытияФормы);
	Исключение
		ОтключитьОбработчикОжидания("ЗафиксироватьОткрытиеФормы");
		ВызватьИсключение;
	КонецПопытки;
	СчетчикПоискаОткрытойФормы = 0;
	ЗафиксироватьОткрытиеФормы();
КонецПроцедуры

&НаКлиенте
Процедура ЗавершитьЗамер()
	
	ВремяОткрытия = ТекущаяУниверсальнаяДатаВМиллисекундах() - НачалоОткрытия;
	Замеры.Добавить(ВремяОткрытия);
	
	Если Замеры.Количество() = 1 Тогда
		Если РезультатыЗамеров.Количество() > 0 Тогда
			РезультатыЗамеров.Добавить("");
		КонецЕсли;
		РезультатыЗамеров.Добавить(ОписаниеЗамера);
	КонецЕсли;
	
	Если Замеры.Количество() = 1 Тогда
		ШаблонРезультата = НСтр("ru = '[%1] %2мс (измерение: %3, исключено из подсчета среднего)'");
		ПредставлениеРезультатаЗамера =  СтрЗаменить(СтрЗаменить(СтрЗаменить(ШаблонРезультата,
			"%1", Формат(ТекущаяДата(), "ДЛФ=T")), // АПК:143 - использование текущей даты сеанса не требуется.
			"%2", ВремяОткрытия),
			"%3", Замеры.Количество());
	Иначе
		ШаблонРезультата = НСтр("ru = '[%1] %2мс (измерение: %3, в среднем: %4 ± %5 мс, минимум: %6, максимум: %7)'");
		ПредставлениеРезультатаЗамера = СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрЗаменить(СтрЗаменить(ШаблонРезультата,
			"%1", Формат(ТекущаяДата(), "ДЛФ=T")), // АПК:143 - использование текущей даты сеанса не требуется.
			"%2", ВремяОткрытия),
			"%3", Замеры.Количество()),
			"%4", СреднеарифметическоеВремяЗамера()),
			"%5", СреднеквадратическоеОтклонение()),
			"%6", МинимальноеЗначениеЗамера()),
			"%7", МаксимальноеЗначениеЗамера());
	КонецЕсли;
		
	РезультатыЗамеров.Добавить(ПредставлениеРезультатаЗамера);
	ТекущийЭлемент = Элементы.РезультатыЗамеров;
	Элементы.РезультатыЗамеров.ТекущаяСтрока = РезультатыЗамеров.Количество() - 1;
	
	Если Счетчик = 1 И КоличествоЗамеров > 1 Тогда
		ШаблонРезультата = НСтр("ru = 'Среднее время открытия формы: %1 ± %2 мс (измерений: %3)'");
		ПредставлениеРезультатаЗамера =  СтрЗаменить(СтрЗаменить(СтрЗаменить(ШаблонРезультата,
			"%1", СреднеарифметическоеВремяЗамера()),
			"%2", СреднеквадратическоеОтклонение()),
			"%3", Замеры.Количество());
		ПоказатьОповещениеПользователя(НСтр("ru = 'Замер выполнен'"), , ПредставлениеРезультатаЗамера);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ОписаниеЗамера()
	Возврат ИмяОткрываемойФормы + ПредставлениеПараметров();
КонецФункции

&НаКлиенте
Функция ПредставлениеПараметров()
	Результат = "";
	Для Каждого ОписаниеПараметра Из ПараметрыОткрытия Цикл
		Если Не ПустаяСтрока(Результат) Тогда
			Результат = Результат + ", ";
		КонецЕсли;
		Результат = Результат + ОписаниеПараметра.Имя + "='" + Строка(ОписаниеПараметра.Значение) + "'";
	КонецЦикла;
	Если Не ПустаяСтрока(Результат) Тогда
		Результат = " (" + Результат + ")";
	КонецЕсли;
	Возврат Результат;
КонецФункции

&НаКлиенте
Процедура ЗафиксироватьОткрытиеФормы()
	СчетчикПоискаОткрытойФормы = СчетчикПоискаОткрытойФормы + 1;
	ОткрытоеОкно = АктивноеОкно();
	Форма = ОткрытоеОкно.Содержимое[0];
	Если Форма.Открыта()
		И ((ФормаВыбранаИзСписка И Форма.ИмяФормы = ИмяОткрываемойФормы)
		Или (Не ФормаВыбранаИзСписка И Форма <> ЭтотОбъект)) Тогда
		ЗавершитьЗамер();
		Форма.Закрыть();
		Счетчик = Счетчик - 1;
		Если Счетчик > 0 Тогда
			ПодключитьОбработчикОжидания("НачатьЗамер", 0.1, Истина);
		КонецЕсли;
	Иначе
		Если СчетчикПоискаОткрытойФормы > 50 Тогда
			Ожидание = (ТекущаяУниверсальнаяДатаВМиллисекундах() - НачалоОткрытия) / 1000;
			Если Ожидание > 2 Тогда
				Состояние(НСтр("ru = 'Ожидается открытие формы...'"));
			КонецЕсли;
			Если Ожидание > 10 Тогда
				Состояние(НСтр("ru = 'Замер прекращен.'"));
				ПоказатьПредупреждение(, НСтр("ru = 'Не удалось зафиксировать открытие формы. Замер прекращен.'"));
				Возврат;
			КонецЕсли;
			ПодключитьОбработчикОжидания("ЗафиксироватьОткрытиеФормы", 0.1, Истина);
		Иначе
			ЗафиксироватьОткрытиеФормы();
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Функция СреднеарифметическоеВремяЗамера()
	Если Замеры = Неопределено Или Замеры.Количество() < 2 Тогда
		Возврат 0;
	КонецЕсли;
	
	СуммаЗамеров = 0;
	Для НомерЗамера = 1 По Замеры.ВГраница() Цикл
		Замер = Замеры[НомерЗамера];
		СуммаЗамеров = СуммаЗамеров + Замер;
	КонецЦикла;
	
	Возврат Окр(СуммаЗамеров / Замеры.ВГраница());
КонецФункции

&НаКлиенте
Функция СреднеквадратическоеОтклонение()
	Если Замеры = Неопределено Или Замеры.Количество() < 2 Тогда
		Возврат 0;
	КонецЕсли;
	
	СреднееВремя = СреднеарифметическоеВремяЗамера();
	СуммаКвадратовОтклонений = 0;
	Для НомерЗамера = 1 По Замеры.ВГраница() Цикл
		Замер = Замеры[НомерЗамера];
		СуммаКвадратовОтклонений = СуммаКвадратовОтклонений + Pow(Замер - СреднееВремя, 2);
	КонецЦикла;
	
	Возврат Окр(Pow(СуммаКвадратовОтклонений / Замеры.ВГраница(), 1/2));
КонецФункции

&НаКлиенте
Функция МинимальноеЗначениеЗамера()
	Если Замеры = Неопределено Или Замеры.Количество() < 2 Тогда
		Возврат 0;
	КонецЕсли;
	
	Минимум = 99999;
	
	Для НомерЗамера = 1 По Замеры.ВГраница() Цикл
		Замер = Замеры[НомерЗамера];
		Минимум = Мин(Минимум, Замер);
	КонецЦикла;
	
	Возврат Минимум;
КонецФункции

&НаКлиенте
Функция МаксимальноеЗначениеЗамера()
	Если Замеры = Неопределено Или Замеры.Количество() < 2 Тогда
		Возврат 0;
	КонецЕсли;
	
	Максимум = 0;
	
	Для НомерЗамера = 1 По Замеры.ВГраница() Цикл
		Замер = Замеры[НомерЗамера];
		Максимум = Макс(Максимум, Замер);
	КонецЦикла;
	
	Возврат Максимум;
КонецФункции

#КонецОбласти

