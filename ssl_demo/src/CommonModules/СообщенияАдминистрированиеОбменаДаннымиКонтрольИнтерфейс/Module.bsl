///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Пространство имен текущей (используемой вызывающим кодом) версии интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - пространство имен.
//
Функция Пакет() Экспорт
	
	Возврат "http://www.1c.ru/SaaS/ExchangeAdministration/Control";
	
КонецФункции

// Текущая (используемая вызывающим кодом) версия интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - версия интерфейса сообщений.
//
Функция Версия() Экспорт
	
	Возврат "2.1.2.1";
	
КонецФункции

// Название программного интерфейса сообщений.
//
// Возвращаемое значение:
//   Строка - название программного интерфейса сообщений.
//
Функция ПрограммныйИнтерфейс() Экспорт
	
	Возврат "ExchangeAdministrationControl";
	
КонецФункции

// Выполняет регистрацию обработчиков сообщений в качестве обработчиков каналов обмена сообщениями.
//
// Параметры:
//   МассивОбработчиков - Массив из ОбщийМодуль - коллекция модулей, содержащих обработчики.
//
Процедура ОбработчикиКаналовСообщений(Знач МассивОбработчиков) Экспорт
	
	МассивОбработчиков.Добавить(СообщенияАдминистрированиеОбменаДаннымиКонтрольОбработчикСообщения_2_1_2_1);
	
КонецПроцедуры

// Выполняет регистрацию обработчиков трансляции сообщений.
//
// Параметры:
//   МассивОбработчиков - Массив из ОбщийМодуль - коллекция модулей, содержащих обработчики.
//
Процедура ОбработчикиТрансляцииСообщений(Знач МассивОбработчиков) Экспорт
	
КонецПроцедуры

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}CorrespondentConnectionCompleted
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеКорреспондентУспешноПодключен(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "CorrespondentConnectionCompleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}CorrespondentConnectionFailed
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеОшибкаПодключенияКорреспондента(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "CorrespondentConnectionFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}GettingSyncSettingsCompleted
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеНастройкиСинхронизацииДанныхПолучены(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "GettingSyncSettingsCompleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}GettingSyncSettingsFailed
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеОшибкаПолученияНастроекСинхронизацииДанных(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "GettingSyncSettingsFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}EnableSyncCompleted
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеВключениеСинхронизацииУспешноЗавершено(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "EnableSyncCompleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}DisableSyncCompleted
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеСинхронизацияУспешноОтключена(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "DisableSyncCompleted");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}EnableSyncFailed
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеОшибкаВключенияСинхронизации(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "EnableSyncFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}DisableSyncFailed
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеОшибкаОтключенияСинхронизации(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "DisableSyncFailed");
	
КонецФункции

// Возвращает тип сообщения {http://www.1c.ru/SaaS/ExchangeAdministration/Control/a.b.c.d}SyncCompleted
//
// Параметры:
//   ИспользуемыйПакет - Строка - пространство имен версии интерфейса сообщений, для которой
//                                получается тип сообщения.
//
// Возвращаемое значение:
//   ТипОбъектаXDTO - тип объекта сообщения.
//
Функция СообщениеСинхронизацияЗавершена(Знач ИспользуемыйПакет = Неопределено) Экспорт
	
	Возврат СоздатьТипСообщения(ИспользуемыйПакет, "SyncCompleted");
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Для внутреннего использования
//
Функция СоздатьТипСообщения(Знач ИспользуемыйПакет, Знач Тип)
	
	Если ИспользуемыйПакет = Неопределено Тогда
		ИспользуемыйПакет = Пакет();
	КонецЕсли;
	
	Возврат ФабрикаXDTO.Тип(ИспользуемыйПакет, Тип);
	
КонецФункции

#КонецОбласти
