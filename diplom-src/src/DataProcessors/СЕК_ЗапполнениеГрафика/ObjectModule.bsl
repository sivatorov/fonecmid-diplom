
Процедура ЗаполнитьГрафик(ДатаНачала, ДатаОкончания, ВыходныеДни) Экспорт
	
	Набор = РегистрыСведений.СЕК_ГрафикиРаботы.СоздатьНаборЗаписей();
	Набор.Отбор.ГрафикРаботы.Установить(ГрафикРаботы); 
	
	Набор.Прочитать();
	
	ЧислоСекундВСутках = 86400;
	
	Дат = ДатаНачала;
	Для к = 0 По Набор.Количество() - 1 Цикл
		
		Запись = Набор[к];
		Если Запись.Дата < ДатаНачала Тогда
			Продолжить;
		ИначеЕсли Запись.Дата =Дат Тогда
			Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
				Запись.Дней = 0;
			Иначе
				Запись.Дней = 1;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		Иначе
			Пока Дат < Мин(Запись.Дата, ДатаОкончания) Цикл
				НоваяЗапись = Набор.Добавить();
				НоваяЗапись.Дата = Дат;
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					НоваяЗапись.Дней = 0;
				Иначе
					Запись.Дней = 1;
				КонецЕсли;
				Дат = Дат + ЧислоСекундВСутках;
			КонецЦикла;
			Если Запись.Дата > ДатаОкончания Тогда
				Прервать;
			Иначе
				Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
					Запись.Дней = 0;
				Иначе
					Запись.Дней = 1;
				КонецЕсли;
			КонецЕсли;
			Дат = Дат + ЧислоСекундВСутках;
		КонецЕсли;
	КонецЦикла;
	Набор.Записать();
	
	Пока Дат <= ДатаОкончания Цикл
		Запись = Набор.Добавить();
		Запись.Дата = Дат;
		Запись.ГрафикРаботы = ГрафикРаботы;
		Если Найти(ВыходныеДни, Строка(ДеньНедели(Дат))) Тогда
			Запись.Дней = 0;
		Иначе
			Запись.Дней = 1;
		КонецЕсли; 
		Дат = Дат + ЧислоСекундВСутках;
	КонецЦикла;
	Набор.Записать();
КонецПроцедуры
