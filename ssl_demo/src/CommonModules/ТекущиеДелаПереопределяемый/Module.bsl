///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Определяет список обработчиков (модулей менеджеров или общих модулей) для формирования и обновления
// списка всех текущих дел, предусмотренных в конфигурации.
//
// В указанных модулях должна быть размещена процедура обработчика, в которую передается параметр
// ТекущиеДела - см. ТекущиеДелаСервер.ТекущиеДела.
// 
// Далее пример процедуры обработчика для копирования в указанные модули:
//
//// Параметры:
////   ТекущиеДела - см. ТекущиеДелаСервер.ТекущиеДела.
////
//Процедура ПриЗаполненииСпискаТекущихДел(ТекущиеДела) Экспорт
//
//КонецПроцедуры
//
// Параметры:
//  ТекущиеДела - Массив - модули менеджеров или общие модули,
//                         например: Документы.ЗаказПокупателя, ТекущиеДелаПоПродажам.
// Пример:
//  ТекущиеДела.Добавить(Документы.ЗаказПокупателя);
//
Процедура ПриОпределенииОбработчиковТекущихДел(ТекущиеДела) Экспорт
	
	// _Демо начало примера
	ТекущиеДела.Добавить(Документы._ДемоЗаказПокупателя);
	ТекущиеДела.Добавить(Документы._ДемоСчетНаОплатуПокупателю);
	ТекущиеДела.Добавить(_ДемоСтандартныеПодсистемы);
	// _Демо конец примера
	
КонецПроцедуры

// Задает начальный порядок разделов в панели текущих дел.
//
// Параметры:
//  Разделы - Массив - массив разделов командного интерфейса.
//                     Разделы в панели текущих дел выводятся в
//                     том порядке, в котором они были добавлены в массив.
//
Процедура ПриОпределенииПорядкаРазделовКомандногоИнтерфейса(Разделы) Экспорт
	
	// _Демо начало примера
	Разделы.Добавить(Метаданные.Подсистемы._ДемоУправлениеДоступом);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоСинхронизацияДанных);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоНормативноСправочнаяИнформация);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоОрганайзер);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоСервисныеПодсистемы);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоИнтегрируемыеПодсистемы);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоИнтегрируемыеПодсистемыПродолжение);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоБизнесПроцессыИЗадачи);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоАнкетирование);
	Разделы.Добавить(Метаданные.Подсистемы._ДемоИнструментыРазработчика);
	Разделы.Добавить(Метаданные.Подсистемы.Администрирование);
	Разделы.Добавить(Метаданные.Подсистемы.АдминистрированиеСервиса);
	// _Демо конец примера
	
КонецПроцедуры

// Определяет текущие дела, которые не будут выводиться пользователю.
//
// Параметры:
//  ОтключаемыеДела - Массив - массив строк идентификаторов текущих дел, которые нужно отключать.
//
Процедура ПриОтключенииТекущихДел(ОтключаемыеДела) Экспорт
	
КонецПроцедуры

// Позволяет менять некоторые настройки подсистемы.
//
// Параметры:
//  Параметры - Структура:
//     * ЗаголовокПрочихДел - Строка - заголовок раздела, в который выводятся
//                            дела, не отнесенные к разделам командного интерфейса.
//                            Применимо для тех дел, размещение которых в панели
//                            определяется функцией ТекущиеДелаСервер.РазделыДляОбъекта.
//                            Если не указано - дела выводятся в группу с заголовком
//                            "Прочие дела".
//
Процедура ПриОпределенииНастроек(Параметры) Экспорт
	
	
	
КонецПроцедуры

// Позволяет установить параметры запросов, общие для нескольких текущих дел.
//
// Например, если в нескольких обработчиках получения текущих дел устанавливается
// параметр "ТекущаяДата", то установку параметра можно прописать в данной
// процедуре, а в обработчике формирования дела сделать вызов процедуры
// ТекущиеДела.УстановитьОбщиеПараметрыЗапросов(), которая установит данный параметр.
//
// Параметры:
//  Запрос - Запрос - выполняемый запрос.
//  ОбщиеПараметрыЗапросов - Структура - общие значения для расчета текущих дел.
//
Процедура УстановитьОбщиеПараметрыЗапросов(Запрос, ОбщиеПараметрыЗапросов) Экспорт
	
КонецПроцедуры

#КонецОбласти