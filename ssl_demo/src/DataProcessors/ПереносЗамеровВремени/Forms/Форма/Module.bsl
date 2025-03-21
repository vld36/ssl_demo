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
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ISNULL(МИНИМУМ(ДатаЗаписи), ДАТАВРЕМЯ(3000,1,1)) КАК ДатаЗаписи
	|ИЗ
	|	РегистрСведений.УдалитьЗамерыВремени3
	|";
	Результат = Запрос.Выполнить();
	Если НЕ Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		ДатаНачала3 = Выборка.ДатаЗаписи;
	КонецЕсли;
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	ISNULL(МАКСИМУМ(ДатаЗаписи), ДАТАВРЕМЯ(1,1,1)) КАК ДатаЗаписи
	|ИЗ
	|	РегистрСведений.УдалитьЗамерыВремени3
	|";
	Результат = Запрос.Выполнить();
	Если НЕ Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		ДатаОкончания3 = Выборка.ДатаЗаписи;
	КонецЕсли;
	
	Запрос.Текст = "
	|ВЫБРАТЬ
	|	КОЛИЧЕСТВО(*) КАК КоличествоЗамеров
	|ИЗ
	|	РегистрСведений.УдалитьЗамерыВремени3
	|";
	Результат = Запрос.Выполнить();
	Если НЕ Результат.Пустой() Тогда
		Выборка = Результат.Выбрать();
		Выборка.Следующий();
		Объект.КоличествоОбнаружено = Объект.КоличествоОбнаружено + Выборка.КоличествоЗамеров;
	КонецЕсли;
	
	Объект.ДатаНачалаОбнаружено = ДатаНачала3;
	Объект.ДатаНачалаПеренос = ДатаНачала3;
	
	Объект.ДатаОкончанияОбнаружено = ДатаОкончания3;
	Объект.ДатаОкончанияПеренос = ДатаОкончания3;
	
	Объект.КоличествоОсталосьПеренести = Объект.КоличествоОбнаружено;
	
	Если Объект.КоличествоОбнаружено = 0 Тогда
		Объект.ДатаНачалаОбнаружено = Дата(1,1,1);
		Объект.ДатаНачалаПеренос = Дата(1,1,1);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура Перенести(Команда)
	
	Если Объект.КоличествоОбнаружено <> 0 Тогда
		ПодключитьОбработчикОжидания("ПеренестиПодключаемый", 0.1, Истина);
	Иначе
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru = 'Нет данных для переноса.'");
	
		Сообщение.Сообщить();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПеренестиПодключаемый()
	
	Записано = ПеренестиНаСервере(Объект.ДатаНачалаПеренос, Объект.ДатаОкончанияПеренос);
	
	Если Записано > 0 Тогда
		Объект.КоличествоОсталосьПеренести = Объект.КоличествоОсталосьПеренести - Записано;
		ПодключитьОбработчикОжидания("ПеренестиПодключаемый", 0.1, Истина);
	Иначе
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = НСтр("ru = 'Перенос данных завершен.'");
	
		Сообщение.Сообщить();
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПеренестиНаСервере(ДатаНачала, ДатаОкончания)
	
	Записано = 0;
	
	НачатьТранзакцию();
	
	Попытка
		Блокировка = Новый БлокировкаДанных;
		Блокировка.Добавить("РегистрСведений.УдалитьЗамерыВремени3");
		Блокировка.Заблокировать();
		
		Результат = ВыбратьЗаписиДляПереноса(ДатаНачала, ДатаОкончания);
		Записано = Записано + ПеренестиЗаписи(Результат);
		
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	Возврат Записано;
	
КонецФункции

&НаСервереБезКонтекста
Функция ВыбратьЗаписиДляПереноса(ДатаНачала, ДатаОкончания)
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = "
	|ВЫБРАТЬ ПЕРВЫЕ 1000
	|	КлючеваяОперация,
	|	ДатаНачалаЗамера,
	|	НомерСеанса,
	|	ДатаЗаписиНачалоЧаса,
	|	ВремяВыполнения,
	|	ВесЗамера,
	|	Комментарий,
	|	ДатаЗаписи,
	|	ДатаОкончания,
	|	Пользователь,
	|	ДатаЗаписиЛокальная
	|ИЗ
	|	РегистрСведений.УдалитьЗамерыВремени3
	|ГДЕ
	|	ДатаЗаписи <= &ДатаОкончания
	|УПОРЯДОЧИТЬ ПО
	|	ДатаЗаписи УБЫВ
	|";
	
	Запрос.УстановитьПараметр("ДатаНачала", ДатаНачала);
	Запрос.УстановитьПараметр("ДатаОкончания", ДатаОкончания);
	Результат = Запрос.Выполнить();
	
	Возврат Результат;
	
КонецФункции

&НаСервереБезКонтекста
Функция ПеренестиЗаписи(Результат)
	
	Записано = 0;
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		
		МенеджерЗаписи = РегистрыСведений.ЗамерыВремени.СоздатьМенеджерЗаписи();
		МенеджерЗаписи.КлючеваяОперация = Выборка.КлючеваяОперация;
		МенеджерЗаписи.НомерСеанса = Выборка.НомерСеанса;
		МенеджерЗаписи.ВремяВыполнения = Выборка.ВремяВыполнения;
		МенеджерЗаписи.ДатаЗаписи = Выборка.ДатаЗаписи;
		МенеджерЗаписи.Пользователь = Выборка.Пользователь;
		МенеджерЗаписи.ДатаЗаписиЛокальная = Выборка.ДатаЗаписиЛокальная;
		МенеджерЗаписи.ДатаНачалаЗамера = Выборка.ДатаНачалаЗамера;
		МенеджерЗаписи.ДатаОкончания = Выборка.ДатаОкончания;
		МенеджерЗаписи.ДатаЗаписиНачалоЧаса = Выборка.ДатаЗаписиНачалоЧаса;
		МенеджерЗаписи.ВесЗамера = Выборка.ВесЗамера;
		МенеджерЗаписи.Комментарий = Выборка.Комментарий;
		МенеджерЗаписи.Записать(Истина);
		
		НаборЗаписейУдалить = РегистрыСведений.УдалитьЗамерыВремени3.СоздатьНаборЗаписей();
		НаборЗаписейУдалить.Отбор.КлючеваяОперация.Установить(Выборка.КлючеваяОперация);
		НаборЗаписейУдалить.Отбор.ДатаНачалаЗамера.Установить(Выборка.ДатаНачалаЗамера);
		НаборЗаписейУдалить.Отбор.НомерСеанса.Установить(Выборка.НомерСеанса);
		НаборЗаписейУдалить.Отбор.ДатаЗаписиНачалоЧаса.Установить(Выборка.ДатаЗаписиНачалоЧаса);
		НаборЗаписейУдалить.Записать(Истина);

		Записано = Записано + 1;
		
	КонецЦикла;
	
	Возврат Записано;
	
КонецФункции

#КонецОбласти