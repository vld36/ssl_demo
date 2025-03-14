///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

#Область ДляВызоваИзДругихПодсистем

// СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// Возвращает сведения о внешнем отчете.
//
// Возвращаемое значение:
//   см. ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке.
//
Функция СведенияОВнешнейОбработке() Экспорт
	ПараметрыРегистрации = ДополнительныеОтчетыИОбработки.СведенияОВнешнейОбработке("2.3.1.1");
	
	ПараметрыРегистрации.Вид = ДополнительныеОтчетыИОбработкиКлиентСервер.ВидОбработкиДополнительныйОтчет();
	ПараметрыРегистрации.Версия = "1.0";
	ПараметрыРегистрации.ОпределитьНастройкиФормы = Истина;
	
	Возврат ПараметрыРегистрации;
КонецФункции

// Конец СтандартныеПодсистемы.ДополнительныеОтчетыИОбработки

// СтандартныеПодсистемы.ВариантыОтчетов

// Задать настройки формы отчета.
//
// Параметры:
//   Форма - ФормаКлиентскогоПриложения
//         - Неопределено
//   КлючВарианта - Строка
//                - Неопределено
//   Настройки - см. ОтчетыКлиентСервер.НастройкиОтчетаПоУмолчанию
//
Процедура ОпределитьНастройкиФормы(Форма, КлючВарианта, Настройки) Экспорт
	Настройки.Печать.ПолеСверху = 5;
	Настройки.Печать.ПолеСлева = 5;
	Настройки.Печать.ПолеСнизу = 5;
	Настройки.Печать.ПолеСправа = 5;
	Настройки.ФормироватьСразу = Ложь;
	Настройки.События.ПередЗагрузкойНастроекВКомпоновщик = Истина;
	Настройки.События.ПриОпределенииПараметровВыбора = Истина;
КонецПроцедуры

// Вызывается перед загрузкой новых настроек. Используется для изменения СКД отчета.
//
// Параметры:
//   Контекст - Произвольный
//   КлючСхемы - Строка
//   КлючВарианта - Строка
//                - Неопределено
//   НовыеНастройкиКД - НастройкиКомпоновкиДанных
//                    - Неопределено
//   НовыеПользовательскиеНастройкиКД - ПользовательскиеНастройкиКомпоновкиДанных
//                                    - Неопределено
//
Процедура ПередЗагрузкойНастроекВКомпоновщик(Контекст, КлючСхемы, КлючВарианта, НовыеНастройкиКД, НовыеПользовательскиеНастройкиКД) Экспорт
	Если КлючСхемы <> "1" Тогда
		КлючСхемы = "1";
		СхемаКД = Отчеты._ДемоФайлы.ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
		ПараметрКД = СхемаКД.Параметры.Добавить();
		ПараметрКД.Имя = "СтатусЗаказаИлиВидОперации";
		ПараметрКД.Заголовок = НСтр("ru = 'Статус заказа или вид операции'");
		ПараметрКД.ТипЗначения = Новый ОписаниеТипов("ПеречислениеСсылка._ДемоСтатусыЗаказовПокупателей, ПеречислениеСсылка._ДемоХозяйственныеОперации");
		ОтчетыСервер.ПодключитьСхему(ЭтотОбъект, Контекст, СхемаКД, КлючСхемы);
	КонецЕсли;
	Если КлючВарианта = "Основной" И НовыеНастройкиКД <> Неопределено И НовыеНастройкиКД.Структура.Количество() = 0 Тогда
		УстановитьПривилегированныйРежим(Истина);
		ВариантСсылка = Справочники.ВариантыОтчетов.НайтиПоНаименованию(НСтр("ru = 'Демо: Версии файлов (подробно)'"));
		Если ЗначениеЗаполнено(ВариантСсылка) Тогда
			НовыеНастройкиКД = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВариантСсылка, "Настройки").Получить();
		Иначе
			СхемаКД = Отчеты._ДемоФайлы.ПолучитьМакет("ОсновнаяСхемаКомпоновкиДанных");
			НовыеНастройкиКД = СхемаКД.ВариантыНастроек.ПоВерсиям.Настройки;
		КонецЕсли;
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
КонецПроцедуры

// См. ОтчетыПереопределяемый.ПриОпределенииПараметровВыбора.
Процедура ПриОпределенииПараметровВыбора(Форма, СвойстваНастройки) Экспорт
	ИмяПоля = Строка(СвойстваНастройки.ПолеКД);
	Если ИмяПоля = "Автор" И СвойстваНастройки.ОписаниеТипов.СодержитТип(Тип("СправочникСсылка.Пользователи")) Тогда
		СвойстваНастройки.ОграничиватьВыборУказаннымиЗначениями = Истина;
		СвойстваНастройки.ЗначенияДляВыбора.Очистить();
		СвойстваНастройки.ЗапросЗначенийВыбора.Текст =
		"ВЫБРАТЬ Ссылка ИЗ Справочник.Пользователи ГДЕ НЕ ПометкаУдаления И НЕ Недействителен И НЕ Служебный";
	ИначеЕсли ИмяПоля = "ТестоваяГруппа.ТестовоеПолеВГруппе" Тогда
		СвойстваНастройки.ПользовательскаяНастройка.ТипЭлементов = "СвязьСКомпоновщиком";
	ИначеЕсли ИмяПоля = "Тест" Тогда
		Элемент = СвойстваНастройки.ЗначенияДляВыбора.НайтиПоЗначению(-1);
		Если Элемент <> Неопределено Тогда
			СвойстваНастройки.ЗначенияДляВыбора.Удалить(Элемент);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

// Конец СтандартныеПодсистемы.ВариантыОтчетов

#КонецОбласти

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли