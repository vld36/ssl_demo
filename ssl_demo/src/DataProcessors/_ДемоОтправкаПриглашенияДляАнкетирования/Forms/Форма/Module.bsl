///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОтправитьПриглашениеДляАнкетирования(Ссылка, ПараметрыВыполнения) Экспорт
	
	ДлительнаяОперация = СформироватьИОтправитьПисьмо(Ссылка);
	НастройкиОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	НастройкиОжидания.ВыводитьОкноОжидания = Истина;
	Обработчик = Новый ОписаниеОповещения("ПослеОтправкиПриглашения", ЭтотОбъект);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Обработчик, НастройкиОжидания);
	
КонецПроцедуры

// Параметры:
//  Результат - см. ДлительныеОперацииКлиент.НовыйРезультатДлительнойОперации
//  ДополнительныеПараметры - Неопределено
//
&НаКлиенте
Процедура ПослеОтправкиПриглашения(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Результат.Статус = "Выполнено" Тогда
		РезультатОтправки = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
		Если РезультатОтправки.Успешно Тогда
			ПоказатьОповещениеПользователя(НСтр("ru = 'Приглашение успешно отправлено.'"));
			Возврат;
		Иначе
			ИнформацияОбОшибке = РезультатОтправки.ИнформацияОбОшибке;
		КонецЕсли;
	Иначе
		ИнформацияОбОшибке = Результат.ИнформацияОбОшибке;
	КонецЕсли;
	
	СтандартныеПодсистемыКлиент.ВывестиИнформациюОбОшибке(ИнформацияОбОшибке);
	
КонецПроцедуры

&НаСервере
Функция СформироватьИОтправитьПисьмо(Ссылка)
	
	ПараметрыПроцедуры = Новый Структура;
	ПараметрыПроцедуры.Вставить("Ссылка", Ссылка);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания =
		НСтр("ru = 'Создание и отправка приглашения для проведения опроса.'");
	ПараметрыВыполнения.УточнениеОшибки =
		НСтр("ru = 'Не удалось отправить приглашение по причине:'");
	
	Возврат ДлительныеОперации.ВыполнитьВФоне(
		"Обработки._ДемоОтправкаПриглашенияДляАнкетирования.СформироватьИОтправитьПисьмо",
		ПараметрыПроцедуры,
		ПараметрыВыполнения);
	
КонецФункции

#КонецОбласти
