///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2024, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Область СлужебныеПроцедурыИФункции

// Возвращает результат проверки печати непроведенного документа.
Функция ПечатьРазрешена(СсылкаНаДокумент) Экспорт
	
	Если ОбщегоНазначения.ЗначениеРеквизитаОбъекта(СсылкаНаДокумент, "Проведен") Тогда
		Возврат
			НСтр("ru = 'Печать всех проведенных документов разрешена.
			           |Для проверки выберите непроведенный документ.'")
	КонецЕсли;
	
	Если УправлениеДоступом.ЕстьРоль("_ДемоПечатьНепроведенныхДокументов", СсылкаНаДокумент) Тогда
		Возврат
			НСтр("ru = 'Печать этого непроведенного документа разрешена, поскольку документ
			           |доступен на чтение (с учетом ограничения на уровне записей) и
			           |в профиль включена роль ""Демо: Печать непроведенных документов"".'");
	Иначе
		Возврат
			НСтр("ru = 'Печать этого непроведенного документа запрещена, поскольку либо документ
				       |недоступен на чтение (с учетом ограничения на уровне записей), либо
				       |в профиль не включена роль ""Демо: Печать непроведенных документов"".'");
	КонецЕсли;
	
КонецФункции

#КонецОбласти

