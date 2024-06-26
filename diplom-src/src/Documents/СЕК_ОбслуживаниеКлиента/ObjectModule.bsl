
#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда  

#Область ОбработчикиСобытий

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	РекДоговора = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Договор,
		"ВидДоговора, СЕК_ДатаНачалаДействияДоговора, СЕК_ДатаОкончанияДействияДоговора");
	
	Если Не РекДоговора.ВидДоговора = Перечисления.ВидыДоговоровКонтрагентов.СЕК_АбонентскоеОбслуживание Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Вид договора должен быть только с видом ""Абонентсткое обслуживание"".";
		Сообщение.Поле = "Договор";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
	
	Если Дата <= РекДоговора.СЕК_ДатаНачалаДействияДоговора
		Или Дата >= РекДоговора.СЕК_ДатаОкончанияДействияДоговора Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = "Дата документа должна быть между началом и концом действия Договора";
		Сообщение.Поле = "Дата";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроведения(Отказ, Режим)
	
	ДвиженияВыполненныеКлиентуРаботы();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	СЕК_УсловияОплатыСотрудниковСрезПоследних.ПроцентОтРабот КАК ПроцентОтРабот
	|ИЗ
	|	РегистрСведений.СЕК_УсловияОплатыСотрудников.СрезПоследних(&Дата, ) КАК СЕК_УсловияОплатыСотрудниковСрезПоследних
	|ГДЕ
	|	СЕК_УсловияОплатыСотрудниковСрезПоследних.Сотрудник.Ссылка = &Сотрудник";
	
	Запрос.УстановитьПараметр("Дата", Дата);
	Запрос.УстановитьПараметр("Сотрудник", Специалист);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Если РезультатЗапроса.Пустой() Тогда
		Отказ = Истина;
		Сообщить("Отсутствует значение процента от работы для указанного специалиста!");
		Возврат;
	КонецЕсли;
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	
	//регистр СЕК_ВыполненныеСотрудникомРаботы
	Движения.СЕК_ВыполненныеСотрудникомРаботы.Записывать = Истина;
	Движение = Движения.СЕК_ВыполненныеСотрудникомРаботы.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
	Движение.Период = Дата;
	Движение.Специалист = Специалист;
	Движение.ЧасовКОплате = ВыполненныеРаботы.Итог("ЧасыКОплатеКлиенту");
	
	ЧасовКОплатеКлиенту = ВыполненныеРаботы.Итог("ЧасыКОплатеКлиенту");
	СтавкаЧасаКлиента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Договор, "СЕК_СтоимостьЧасаРаботыСпециалиста");
	ПроцентОтРабот = ВыборкаДетальныеЗаписи.ПроцентОтРабот;
	
	Движение.СуммаКОплате = ЧасовКОплатеКлиенту * СтавкаЧасаКлиента * ПроцентОтРабот / 100;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	ТекстДляБота = СтрШаблон("Клиент: %1, Дата: %2, Время начала работ: %3, Время окончания работ: %4, Специалист: %5, ",
		Строка(Клиент), Строка(Формат(ДатаПроведенияРабот, "ДЛФ=Д")),
		Строка(Формат(ВремяНачалаРабот, "ДЛФ=В")), Строка(Формат(ВремяОкончанияРабот, "ДЛФ=В")),
		Строка(Специалист)) + Строка(ОписаниеПроблемы);
	
	Если ЭтоНовый() Или МенялсяРеквизит = Истина Тогда
		
		СоздатьНовоеУведомление(ТекстДляБота);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыФункции

Процедура ДвиженияВыполненныеКлиентуРаботы()
	
	// регистр СЕК_ВыполненныеКлиентуРаботы Приход
	Движения.СЕК_ВыполненныеКлиентуРаботы.Записывать = Истина;
	Движение = Движения.СЕК_ВыполненныеКлиентуРаботы.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Клиент = Клиент;
	Движение.Договор = Договор;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	РАЗНОСТЬДАТ(СЕК_ОбслуживаниеКлиента.ВремяНачалаРабот, СЕК_ОбслуживаниеКлиента.ВремяОкончанияРабот, ЧАС) КАК Время,
	|	ДоговорыКонтрагентов.СЕК_СтоимостьЧасаРаботыСпециалиста КАК СтоимостьЧаса
	|ИЗ
	|	Документ.СЕК_ОбслуживаниеКлиента КАК СЕК_ОбслуживаниеКлиента
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|		ПО СЕК_ОбслуживаниеКлиента.Договор = ДоговорыКонтрагентов.Ссылка
	|ГДЕ
	|	СЕК_ОбслуживаниеКлиента.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ВыборкаДетальныеЗаписи.Следующий();
	
	Движение.КоличествоЧасов = ВыборкаДетальныеЗаписи.Время;
	Движение.СуммаКОплате = Движение.КоличествоЧасов * ВыборкаДетальныеЗаписи.СтоимостьЧаса;
	
КонецПроцедуры

Процедура СоздатьНовоеУведомление(ТекстДляБота)
	
	НовыйЭлемент = Справочники.СЕК_УведомленияТелеграмБоту.СоздатьЭлемент();
	НовыйЭлемент.ТекстСообщения = ТекстДляБота;
	НовыйЭлемент.Записать();
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли