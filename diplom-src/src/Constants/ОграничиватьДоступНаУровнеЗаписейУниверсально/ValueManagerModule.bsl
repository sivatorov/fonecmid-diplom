///////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022, ООО 1С-Софт
// Все права защищены. Эта программа и сопроводительные материалы предоставляются 
// в соответствии с условиями лицензии Attribution 4.0 International (CC BY 4.0)
// Текст лицензии доступен по ссылке:
// https://creativecommons.org/licenses/by/4.0/legalcode
///////////////////////////////////////////////////////////////////////////////////////////////////////

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОписаниеПеременных

Перем СтароеЗначение;

#КонецОбласти

#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	СтароеЗначение = Константы.ОграничиватьДоступНаУровнеЗаписейУниверсально.Получить();
	
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если Не УправлениеДоступомСлужебный.ВариантВстроенногоЯзыкаРусский() Тогда
		Значение = Истина;
	КонецЕсли;
	
	Если Значение И Не СтароеЗначение Тогда // Включено.
		УправлениеДоступомСлужебный.ОчиститьПоследнееОбновлениеДоступа();
		РегистрыСведений.ПараметрыОграниченияДоступа.ОбновитьДанныеРегистра();
		ПараметрыПланирования = УправлениеДоступомСлужебный.ПараметрыПланированияОбновленияДоступа();
		ПараметрыПланирования.Описание = "ВключеноОграничиватьДоступНаУровнеЗаписейУниверсально";
		УправлениеДоступомСлужебный.ЗапланироватьОбновлениеДоступа(Неопределено, ПараметрыПланирования);
	КонецЕсли;
	
	Если Не Значение И СтароеЗначение Тогда // Выключено.
		МенеджерЗначения = Константы.ПервоеОбновлениеДоступаЗавершилось.СоздатьМенеджерЗначения();
		МенеджерЗначения.Значение = Ложь;
		ОбновлениеИнформационнойБазы.ЗаписатьДанные(МенеджерЗначения);
		УправлениеДоступомСлужебный.ВключитьЗаполнениеДанныхДляОграниченияДоступа();
	КонецЕсли;
	
	Если Значение <> СтароеЗначение Тогда // Изменено.
		УправлениеДоступомСлужебный.ОбновитьПараметрыСеанса();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Иначе
ВызватьИсключение НСтр("ru = 'Недопустимый вызов объекта на клиенте.'");
#КонецЕсли