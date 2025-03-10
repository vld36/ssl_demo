///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

Функция ЗагрузитьДоверенностьИзРеестра(Знач НомерДоверенности, Знач ИННДоверителя, Знач ИННПредставителя, ТокенДоступа = "") Экспорт
	
	Возврат МашиночитаемыеДоверенностиФНССлужебный.ЗагрузитьДоверенностьИзРеестра(НомерДоверенности, ИННДоверителя, ИННПредставителя, ТокенДоступа);
	
КонецФункции

Функция ЗагрузитьЦепочкуДоверенностейИзРеестра(НомерДоверенности, ИННДоверителя, ТокенДоступа = "") Экспорт
	
	Возврат МашиночитаемыеДоверенностиФНССлужебный.ЗагрузитьЦепочкуДоверенностейИзРеестра(НомерДоверенности, ИННДоверителя, ТокенДоступа);
	
КонецФункции

Функция ДоверенностиДляНалоговыхОрганов(Доверенности) Экспорт
	
	Запрос = Новый Запрос("ВЫБРАТЬ РАЗРЕШЕННЫЕ
	   |	ИСТИНА
	   |ИЗ
	   |	Справочник.МашиночитаемыеДоверенности КАК МашиночитаемыеДоверенности
	   |ГДЕ
	   |	МашиночитаемыеДоверенности.Ссылка В(&Доверенности)
	   |	И МашиночитаемыеДоверенности.ДляНалоговыхОрганов");
	Запрос.УстановитьПараметр("Доверенности", Доверенности);
	Возврат Не Запрос.Выполнить().Пустой();
	
КонецФункции

Функция РезультатПроверкиДоверенности(Знач Доверенность, Знач ПроверятьВРеестреФНС = Неопределено, 
	Знач ИдентификаторФормы = Неопределено) Экспорт
	
	Возврат МашиночитаемыеДоверенностиФНССлужебный.РезультатПроверкиДанныхДоверенности(
		МашиночитаемыеДоверенностиФНССлужебный.ДанныеМЧД(Доверенность),
		ПроверятьВРеестреФНС, ИдентификаторФормы);
	
КонецФункции

Функция РезультатПроверкиПодписиПоМЧД(Знач Доверенность, Знач ПодписанныйОбъект, Знач Сертификат, Знач НаДату, 
	Знач ГотовыеПроверки) Экспорт
	
	Возврат МашиночитаемыеДоверенностиФНССлужебный.РезультатПроверкиПодписиПоМЧД(Доверенность, ПодписанныйОбъект, 
		Сертификат, НаДату, ГотовыеПроверки);
	
КонецФункции

Функция РезультатПроверкиМЧДДляПодписания(Знач Доверенность, Знач Сертификат) Экспорт
	
	ПротоколПроверки = Новый Структура;
	ДатаПроверки = ТекущаяДатаСеанса();
	
	ПроверкаДоверенности = МашиночитаемыеДоверенностиФНССлужебный.РезультатПроверкиДоверенности(Доверенность);
	МашиночитаемыеДоверенностиФНССлужебный.ДобавитьВПротоколПроверкуДоверенности(ПротоколПроверки, ПроверкаДоверенности, ДатаПроверки);
	
	ПроверкаПодписанта = МашиночитаемыеДоверенностиФНССлужебный.ПроверитьСертификатПредставителя(Доверенность, Сертификат, ДатаПроверки);
	МашиночитаемыеДоверенностиФНССлужебный.ДобавитьВПротоколПроверкуПодписанта(ПротоколПроверки, ПроверкаПодписанта, ДатаПроверки);
	
	Возврат ПротоколПроверки;
	
КонецФункции

// Возвращает машиночитаемые доверенности в виде набора файлов.
// Если файлы отдельно взятой доверенности еще не сформированы, то по ней возвращается пустой набор файлов.
// 
// Параметры:
//  Доверенности - Массив из СправочникСсылка.МашиночитаемыеДоверенности
//  
// Возвращаемое значение:
//   Соответствие из КлючИЗначение:
//    * Ключ - СправочникСсылка.МашиночитаемыеДоверенности
//    * Значение - см. МашиночитаемыеДоверенностиФНС.ФайлыДоверенности
//
Функция ФайлыДоверенностей(Знач Доверенности, Знач ДляНалоговыхОрганов) Экспорт
	
	Результат = Новый Массив;
	ФайлыДоверенностей = МашиночитаемыеДоверенностиФНС.ФайлыДоверенностей(Доверенности, ДляНалоговыхОрганов);
	
	Для Каждого Доверенность Из Доверенности Цикл
		ФайлыДоверенности = ФайлыДоверенностей[Доверенность];
		СохраняемыеФайлы = Новый Массив;
		БылиОшибки = Ложь;
		
		Для Каждого ФайлДоверенности Из ФайлыДоверенности Цикл
			Если ЗначениеЗаполнено(ФайлДоверенности.ОписаниеОшибки) Тогда
				ОбщегоНазначения.СообщитьПользователю(ФайлДоверенности.ОписаниеОшибки);
				БылиОшибки = Истина;
				Продолжить;
			КонецЕсли;
			
			СохраняемыеФайлы.Добавить(ФайлДоверенности);
		КонецЦикла;
		
		ДвоичныеДанные = МашиночитаемыеДоверенностиФНССлужебный.УпаковатьВАрхив(СохраняемыеФайлы);
		ИмяАрхива = ОбщегоНазначенияКлиентСервер.ЗаменитьНедопустимыеСимволыВИмениФайла(Строка(Доверенность)) + ".zip";
		
		Если Не БылиОшибки И ЗначениеЗаполнено(СохраняемыеФайлы) Тогда
			ОписаниеПередаваемогоФайла = Новый ОписаниеПередаваемогоФайла(ИмяАрхива, ПоместитьВоВременноеХранилище(ДвоичныеДанные, Новый УникальныйИдентификатор()));
			Результат.Добавить(ОписаниеПередаваемогоФайла);
		КонецЕсли;
	КонецЦикла; 
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
