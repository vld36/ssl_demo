///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Номер версии, для трансляции с которой предназначен обработчик.
//
// Возвращаемое значение:
//   Строка - исходная версия интерфейса сообщений.
//
Функция ИсходнаяВерсия() Экспорт
	
	Возврат "3.0.1.1";
	
КонецФункции

// Пространство имен версии, для трансляции с которой предназначен обработчик.
//
// Возвращаемое значение:
//   Строка - пространство имен.
//
Функция ПакетИсходнойВерсии() Экспорт
	
	Возврат "http://www.1c.ru/SaaS/Exchange/Manage/3.0.1.1";
	
КонецФункции

// Номер версии, для трансляции в которую предназначен обработчик.
//
// Возвращаемое значение:
//   Строка - результирующая версия интерфейса сообщений.
//
Функция РезультирующаяВерсия() Экспорт
	
	Возврат "2.1.2.1";
	
КонецФункции

// Пространство имен версии, для трансляции в которую предназначен обработчик.
//
// Возвращаемое значение:
//   Строка - пространство имен.
//
Функция ПакетРезультирующейВерсии() Экспорт
	
	Возврат "http://www.1c.ru/SaaS/Exchange/Manage";
	
КонецФункции

// Обработчик проверки выполнения стандартной обработки трансляции.
//
// Параметры:
//   ИсходноеСообщение    - ОбъектXDTO - транслируемое сообщение.
//   СтандартнаяОбработка - Булево - для отмены выполнения стандартной обработки трансляции
//                          этому параметру внутри данной процедуры необходимо установить значение Ложь.
//                          При этом вместо выполнения стандартной обработки трансляции будет вызвана функция.
//                          ТрансляцияСообщения() обработчика трансляции.
//
Процедура ПередТрансляцией(Знач ИсходноеСообщение, СтандартнаяОбработка) Экспорт
	
	ТипТела = ИсходноеСообщение.Тип();
	
	Если ТипТела = Интерфейс().СообщениеНастроитьОбменШаг1(ПакетИсходнойВерсии()) Тогда
		СтандартнаяОбработка = Ложь;
	ИначеЕсли ТипТела = Интерфейс().СообщениеЗагрузитьСообщениеОбмена(ПакетИсходнойВерсии()) Тогда
		СтандартнаяОбработка = Ложь;
	КонецЕсли;
	
КонецПроцедуры

// Обработчик выполнения произвольной трансляции сообщения. Вызывается только в том случае,
// если при выполнении процедуры ПередТрансляцией значению параметра СтандартнаяОбработка
// было установлено значение Ложь.
//
// Параметры:
//   ИсходноеСообщение - ОбъектXDTO - транслируемое сообщение.
//
// Возвращаемое значение:
//   ОбъектXDTO - результат произвольной трансляции сообщения.
//
Функция ТрансляцияСообщения(Знач ИсходноеСообщение) Экспорт
	
	ТипТела = ИсходноеСообщение.Тип();
	
	Если ТипТела = Интерфейс().СообщениеНастроитьОбменШаг1(ПакетИсходнойВерсии()) Тогда
		Возврат ТранслироватьСообщениеНастроитьОбменШаг1(ИсходноеСообщение);
	ИначеЕсли ТипТела = Интерфейс().СообщениеЗагрузитьСообщениеОбмена(ПакетИсходнойВерсии()) Тогда
		Возврат ТранслироватьСообщениеЗагрузитьСообщениеОбмена(ИсходноеСообщение);
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция Интерфейс()
	
	Возврат СообщенияОбменаДаннымиУправлениеИнтерфейс;
	
КонецФункции

Функция ТранслироватьСообщениеНастроитьОбменШаг1(Знач ИсходноеСообщение)
	
	Результат = ФабрикаXDTO.Создать(
		Интерфейс().СообщениеНастроитьОбменШаг1(ПакетРезультирующейВерсии()));
		
	Результат.SessionId = ИсходноеСообщение.SessionId;
	Результат.Zone      = ИсходноеСообщение.Zone;
	
	Результат.CorrespondentZone = ИсходноеСообщение.CorrespondentZone;
	
	Результат.ExchangePlan = ИсходноеСообщение.ExchangePlan;
	Результат.CorrespondentCode = ИсходноеСообщение.CorrespondentCode;
	Результат.CorrespondentName = ИсходноеСообщение.CorrespondentName;
	Результат.Code = ИсходноеСообщение.Code;
	Результат.EndPoint = ИсходноеСообщение.EndPoint;
	
	Если ИсходноеСообщение.Установлено("XDTOSettings") Тогда
		НастройкиXDTO = СериализаторXDTO.ПрочитатьXDTO(ИсходноеСообщение.XDTOSettings);
		
		НастройкиОтборов = Новый Структура;
		НастройкиОтборов.Вставить("НастройкиXDTOКорреспондента", НастройкиXDTO);
		
		Результат.FilterSettings = СериализаторXDTO.ЗаписатьXDTO(НастройкиОтборов);
	Иначе
		Результат.FilterSettings = СериализаторXDTO.ЗаписатьXDTO(Новый Структура);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ТранслироватьСообщениеЗагрузитьСообщениеОбмена(Знач ИсходноеСообщение)
	
	Результат = ФабрикаXDTO.Создать(
		Интерфейс().СообщениеЗагрузитьСообщениеОбмена(ПакетРезультирующейВерсии()));
		
	Результат.SessionId = ИсходноеСообщение.SessionId;
	Результат.Zone      = ИсходноеСообщение.Zone;
	
	Результат.CorrespondentZone = ИсходноеСообщение.CorrespondentZone;
	
	Результат.ExchangePlan = ИсходноеСообщение.ExchangePlan;
	Результат.CorrespondentCode = ИсходноеСообщение.CorrespondentCode;
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти
