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

// СтандартныеПодсистемы.ВерсионированиеОбъектов

// Определяет настройки объекта для подсистемы ВерсионированиеОбъектов.
//
// Параметры:
//  Настройки - Структура - настройки подсистемы.
//
Процедура ПриОпределенииНастроекВерсионированияОбъектов(Настройки) Экспорт

КонецПроцедуры

// Конец СтандартныеПодсистемы.ВерсионированиеОбъектов

// СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

// Возвращаемое значение:
//   см. ЗапретРедактированияРеквизитовОбъектовПереопределяемый.ПриОпределенииЗаблокированныхРеквизитов.ЗаблокированныеРеквизиты.
//
Функция ПолучитьБлокируемыеРеквизитыОбъекта() Экспорт
	
	БлокируемыеРеквизиты = Новый Массив;
	
	Реквизит = ЗапретРедактированияРеквизитовОбъектов.НовыйБлокируемыйРеквизит();
	Реквизит.Группа = "ОбщаяНадпись";
	Реквизит.ПредставлениеГруппы = НСтр("ru = 'Пример измененной общей надписи формы'"); // Если пустая строка, надпись удаляется.
	БлокируемыеРеквизиты.Добавить(Реквизит);
	
	Реквизит = ЗапретРедактированияРеквизитовОбъектов.НовыйБлокируемыйРеквизит();
	Реквизит.Имя = "Код";
	Реквизит.Предупреждение =
		НСтр("ru = 'Пример предупреждения для поля Код'");
	БлокируемыеРеквизиты.Добавить(Реквизит);
	
	БлокируемыеРеквизиты.Добавить("Родитель");
	
	Реквизит = ЗапретРедактированияРеквизитовОбъектов.НовыйБлокируемыйРеквизит();
	Реквизит.Группа = "НастройкиСчета";
	Реквизит.ПредставлениеГруппы = НСтр("ru = 'Настройки счета (пример заголовка группы)'");
	Реквизит.Предупреждение =
		НСтр("ru = 'Настройки счета не рекомендуется изменять, если счет уже используются
		           |(пример предупреждения отображаемого для группы и реквизитов группы)'");
	БлокируемыеРеквизиты.Добавить(Реквизит);
	
	БлокируемыеРеквизиты.Добавить("Вид;;НастройкиСчета");
	БлокируемыеРеквизиты.Добавить("Забалансовый;;НастройкиСчета");
	БлокируемыеРеквизиты.Добавить("Валютный;;НастройкиСчета");
	БлокируемыеРеквизиты.Добавить("Количественный;;НастройкиСчета");
	
	БлокируемыеРеквизиты.Добавить("ВидыСубконто");
	
	Возврат БлокируемыеРеквизиты;
	
КонецФункции

// Конец СтандартныеПодсистемы.ЗапретРедактированияРеквизитовОбъектов

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов
// 
// Параметры:
//  Настройки - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов.Настройки
//
Процедура ПриНастройкеНачальногоЗаполненияЭлементов(Настройки) Экспорт
	
КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов
// 
// Параметры:
//   КодыЯзыков - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.КодыЯзыков
//   Элементы - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.Элементы
//   ТабличныеЧасти - см. ОбновлениеИнформационнойБазыПереопределяемый.ПриНачальномЗаполненииЭлементов.ТабличныеЧасти
//
Процедура ПриНачальномЗаполненииЭлементов(КодыЯзыков, Элементы, ТабличныеЧасти) Экспорт
	
	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "Вспомогательный";
	Элемент.Порядок = "00";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Вспомогательный'");
	Элемент.Код = "00";
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "НДСПоПриобретеннымЦенностям";
	Элемент.Порядок = "19";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'НДС по приобретенным ценностям'");
	Элемент.Код = "19";
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "НДСПоПриобретеннымМПЗ";
	Элемент.Порядок = "19.03";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'НДС по приобретенным материально-производственным запасам'");
	Элемент.Код = "19.03";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.НДСПоПриобретеннымЦенностям;
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "Товары";
	Элемент.Порядок = "41";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Товары'");
	Элемент.Код = "41";
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "ТоварыНаСкладах";
	Элемент.Порядок = "41.01";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Товары на складах'");
	Элемент.Код = "41.01";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.Товары;
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПоставщикамиИПодрядчиками";
	Элемент.Порядок = "60";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с поставщиками и подрядчиками'");
	Элемент.Код = "60";
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПоставщиками";
	Элемент.Порядок = "60.01";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с поставщиками и подрядчиками'");
	Элемент.Код = "60.01";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.РасчетыСПоставщикамиИПодрядчиками;
	Элемент.Вид = ВидСчета.Пассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПоставщикамиВал";
	Элемент.Порядок = "60.21";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с поставщиками и подрядчиками (в валюте)'");
	Элемент.Код = "60.21";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.РасчетыСПоставщикамиИПодрядчиками;
	Элемент.Вид = ВидСчета.Пассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПокупателямиИЗаказчиками";
	Элемент.Порядок = "62";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с покупателями и заказчиками'");
	Элемент.Код = "62";
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПокупателями";
	Элемент.Порядок = "62.01";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с покупателями'");
	Элемент.Код = "62.01";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.РасчетыСПокупателямиИЗаказчиками;
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыСПокупателямиВал";
	Элемент.Порядок = "62.21";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты с покупателями и заказчиками (в валюте)'");
	Элемент.Код = "62.21";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.РасчетыСПокупателямиИЗаказчиками;
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "РасчетыПоНалогам";
	Элемент.Порядок = "68";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Расчеты по налогам и сборам'");
	Элемент.Код = "68";
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "НДС";
	Элемент.Порядок = "68.02";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Налог на добавленную стоимость'");
	Элемент.Код = "68.02";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.РасчетыПоНалогам;
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "Продажи";
	Элемент.Порядок = "90";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Продажи'");
	Элемент.Код = "90";
	Элемент.Вид = ВидСчета.АктивноПассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "Выручка";
	Элемент.Порядок = "90.01";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Выручка'");
	Элемент.Код = "90.01";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.Продажи;
	Элемент.Вид = ВидСчета.Пассивный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "СебестоимостьПродаж";
	Элемент.Порядок = "90.02";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Себестоимость продаж'");
	Элемент.Код = "90.02";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.Продажи;
	Элемент.Вид = ВидСчета.Активный;

	Элемент = Элементы.Добавить(); // ПланСчетовОбъект._ДемоОсновной
	Элемент.ИмяПредопределенныхДанных = "Продажи_НДС";
	Элемент.Порядок = "90.03";
	Элемент.Забалансовый = Ложь;
	Элемент.Наименование = НСтр("ru = 'Продажи НДС'");
	Элемент.Код = "90.03";
	Элемент.Родитель = ПланыСчетов._ДемоОсновной.Продажи;
	Элемент.Вид = ВидСчета.Активный;
	
КонецПроцедуры

// Смотри также ОбновлениеИнформационнойБазыПереопределяемый.ПриНастройкеНачальногоЗаполненияЭлементов
//
// Параметры:
//  Объект                  - ПланСчетовОбъект._ДемоОсновной - заполняемый объект.
//  Данные                  - СтрокаТаблицыЗначений - данные заполнения объекта.
//  ДополнительныеПараметры - Структура:
//   * ПредопределенныеДанные - ТаблицаЗначений - данные заполненные в процедуре ПриНачальномЗаполненииЭлементов.
//
Процедура ПриНачальномЗаполненииЭлемента(Объект, Данные, ДополнительныеПараметры) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли
