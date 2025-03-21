///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Шаблон = ШаблонСообщенияПоВладельцу(ПараметрКоманды);
	
	ПараметрыОткрытия          = ШаблоныСообщенийКлиент.ПараметрыФормы(ПараметрыВыполненияКоманды);
	ПараметрыОткрытия.Владелец = ПараметрыВыполненияКоманды.Источник;
	
	ШаблоныСообщенийКлиент.ПоказатьФормуШаблона(Шаблон, ПараметрыОткрытия);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Параметры:
//  ВладелецШаблона - ДокументСсылка.НазначениеОпросов
//
&НаСервере
Функция ШаблонСообщенияПоВладельцу(ВладелецШаблона)

	Шаблон = ШаблоныСообщений.ПараметрыШаблона(ВладелецШаблона);
	Если ЗначениеЗаполнено(Шаблон.Ссылка) Тогда
		Возврат ВладелецШаблона;
	Иначе
		ЗаполнитьШаблоны(Шаблон, ВладелецШаблона);
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьШаблоны(Шаблон, ВладелецШаблона)
	
	Шаблон.Наименование = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Приглашение для анкетирования по теме ""%1""'"), ВладелецШаблона.Наименование);
		
	Шаблон.Тема = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru = 'Опрос по теме [%1]'"), "НазначениеОпросов.Наименование");
	
	ШаблонТекста = НСтр("ru = '<P>Здравствуйте, <P>Приглашаем принять участие в опросе по теме [%1]'")
		+ НСтр("ru='<P><P>Опрос будет открыт для участия [%2]'")
		+ НСтр("ru = 'Чтобы начать опрос, пожалуйста, нажмите ссылку внизу.'")
		+ НСтр("ru = '<BR/> [%3]'")
		+ НСтр("ru = '<P><P>Благодарим за участие в опросе.'")
		+ НСтр("ru = '<P><P>[%4]'")
		+ НСтр("ru = '<P>[%5]'")
		+ НСтр("ru = '<P>[%6]'")
		+ НСтр("ru = '<P>[%7]'");
		
	Шаблон.Текст = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонТекста, 
		"НазначениеОпросов.Наименование", "НазначениеОпросов.ДатаНачала{ДЛФ=''DD''}", 
		"ОбщиеРеквизиты.АдресПубликацииИнформационнойБазыВИнтернете", "ОбщиеРеквизиты.ОсновнаяОрганизация",
		"ОбщиеРеквизиты.ТекущийПользователь.ФизическоеЛицо", "ОбщиеРеквизиты.ТекущийПользователь.Телефон",
		"ОбщиеРеквизиты.ТекущийПользователь.ЭлектроннаяПочта");
	
	Шаблон.ФорматПисьма = Перечисления.СпособыРедактированияЭлектронныхПисем.HTML;
	Шаблон.ПолноеИмяТипаНазначения = "Документ.НазначениеОпросов";
	
КонецПроцедуры

#КонецОбласти