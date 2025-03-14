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

// СтандартныеПодсистемы.УправлениеДоступом

// Параметры:
//   Ограничение - см. УправлениеДоступомПереопределяемый.ПриЗаполненииОграниченияДоступа.Ограничение.
//
Процедура ПриЗаполненииОграниченияДоступа(Ограничение) Экспорт
	
	Ограничение.Текст =
	"РазрешитьЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Организация)
	|;
	|РазрешитьИзменениеЕслиРазрешеноЧтение
	|ГДЕ
	|	ЗначениеРазрешено(Ответственный, ПустаяСсылка КАК ИСТИНА)";
	
КонецПроцедуры

// Конец СтандартныеПодсистемы.УправлениеДоступом

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Устанавливает проект Проект в качестве основного для текущего пользователя.
// Основной проект подсвечивается жирным шрифтом в списках проектов, а также выводится в заголовке программы.
// 
// Параметры:
//  Проект - СправочникСсылка._ДемоПроекты - проект, который нужно установить в качестве основного.
//
Процедура УстановитьОсновнойПроект(Проект) Экспорт
	
	ОбщегоНазначенияКлиентСервер.ПроверитьПараметр("Справочники._ДемоПроекты.УстановитьОсновнойПроект", "Проект", 
		Проект, Тип("СправочникСсылка._ДемоПроекты"));
	ОбщегоНазначения.ХранилищеОбщихНастроекСохранить("_ДемоПроекты", "ОсновнойПроект", Проект);
	ПараметрыСеанса._ДемоТекущийПроект = Проект;
	
КонецПроцедуры	

// Возвращает основной проект для текущего пользователя.
//
// Возвращаемое значение:
//   СправочникСсылка._ДемоПроекты - основной проект или пустая ссылка, если основной проект не задан.
//
Функция ОсновнойПроект() Экспорт
	
	Возврат ОбщегоНазначения.ХранилищеОбщихНастроекЗагрузить("_ДемоПроекты", "ОсновнойПроект", ПустаяСсылка());
	
КонецФункции	

// Параметры:
//  ИмяПараметра - Строка
//  УстановленныеПараметры - Массив из Строка
//
Процедура УстановкаПараметровСеанса(ИмяПараметра, УстановленныеПараметры) Экспорт
	
	Если ИмяПараметра = "_ДемоТекущийПроект" Тогда
		ПараметрыСеанса._ДемоТекущийПроект = ОсновнойПроект();
		УстановленныеПараметры.Добавить("_ДемоТекущийПроект");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
