
&НаКлиенте
Процедура Заполнить(Команда)
    ВыполнитьОбработку(); 
    Сообщить("Обработка завершена"); 
КонецПроцедуры                       

&НаСервере
Процедура ВыполнитьОбработку()

	 ОбработкаОбъект = РеквизитФормыВЗначение("Объект"); 
     ОбработкаОбъект.ЗаполнитьГрафик(Объект.Период.ДатаНачала, Объект.Период.ДатаОкончания, Объект.ВыходныеДни); 

КонецПроцедуры

