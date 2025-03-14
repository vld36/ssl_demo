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
	
	ПараметрыРаботы = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиента();
	ПараметрыРезервногоКопирования = ПараметрыРаботы.РезервноеКопированиеИБ;
	
	ПараметрыФормы = Новый Структура();
	
	Если ПараметрыРезервногоКопирования.Свойство("РезультатКопирования") Тогда
		ПараметрыФормы.Вставить("РежимРаботы", ?(ПараметрыРезервногоКопирования.РезультатКопирования = Истина, "УспешноВыполнено", "НеВыполнено"));
		ПараметрыФормы.Вставить("ИмяФайлаРезервнойКопии", ПараметрыРезервногоКопирования.ИмяФайлаРезервнойКопии);
	КонецЕсли;
	
	ОткрытьФорму("Обработка.РезервноеКопированиеИБ.Форма.РезервноеКопированиеДанных", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти
