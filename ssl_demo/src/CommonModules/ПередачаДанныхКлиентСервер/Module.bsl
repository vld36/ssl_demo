#Область СлужебныйПрограммныйИнтерфейс

// Подробное представление ошибки
// Используется для обработки предупреждений об устаревшем методе в конфигурациях с режимом совместимости до 8.3.17.
// 
// Параметры:
// 	ИнформацияОбОшибке - ИнформацияОбОшибке
// Возвращаемое значение:
// 	Строка
Функция ПодробныйТекстОшибки(ИнформацияОбОшибке) Экспорт
	
	//@skip-warning
	Возврат ОбработкаОшибок.ПодробноеПредставлениеОшибки(ИнформацияОбОшибке);
	
КонецФункции

// Краткое представление ошибки
// Используется для обработки предупреждений об устаревшем методе в конфигурациях с режимом совместимости до 8.3.17.
// 
// Параметры:
// 	ИнформацияОбОшибке - ИнформацияОбОшибке
// Возвращаемое значение:
// 	Строка
Функция КраткийТекстОшибки(ИнформацияОбОшибке) Экспорт
	
	//@skip-warning
	Возврат ОбработкаОшибок.КраткоеПредставлениеОшибки(ИнформацияОбОшибке);
	
КонецФункции
	
#КонецОбласти