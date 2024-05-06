#language: ru

@tree

Функционал: Создание трех обслуживаний на специалистов от имени Менеджера

Как тестировщик я хочу
показать процесс создания простого сценария тестирования 
чтобы разобрать процесс созданий обслуживаний    

Сценарий: Создание трех обслуживаний на специалистов от имени Менеджера
		  И я подключаю TestClient "DiplomУправлениеITФирмой" логин "Василий Менеджер" пароль ""
		* И я выбираю в "Добавленные объекты" - "Обслуживание клиента"
			И В командном интерфейсе я выбираю 'Добавленные объекты' 'Обслуживание клиента'
			Тогда открылось окно 'Обслуживание клиента'
		* И я создаю первый документ
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно 'Обслуживание клиента (создание)'
			И из выпадающего списка с именем "Клиент" я выбираю точное значение 'ООО "Офисный Мир КМ"'
			И я нажимаю кнопку выбора у поля с именем "Договор"
			Тогда открылось окно 'Договоры контрагентов'
			И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000004' | 'Основной'     |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Обслуживание клиента (создание) *'
			И из выпадающего списка с именем "Специалист" я выбираю точное значение 'Владимир'
			И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
			И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '20.05.2024'
			И в поле с именем 'ВремяНачалаРабот' я ввожу текст ' 9:00:00'
			И я перехожу к следующему реквизиту
			И в поле с именем 'ВремяОкончанияРабот' я ввожу текст '11:00:00'
			И я перехожу к следующему реквизиту
			И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Диагностика'
			И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
			И я жду закрытия окна 'Обслуживание клиента (создание) *' в течение 20 секунд
		Тогда открылось окно 'Обслуживание клиента'
		* И я создаю второй документ
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно 'Обслуживание клиента (создание)'
			И из выпадающего списка с именем "Клиент" я выбираю точное значение 'ООО "Умный Ретейлер"'
			И я нажимаю кнопку выбора у поля с именем "Договор"
			Тогда открылось окно 'Договоры контрагентов'
            И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000006' | 'Основной'     |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Обслуживание клиента (создание) *'
			И из выпадающего списка с именем "Специалист" я выбираю точное значение 'Петр'
			И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
			И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '20.05.2024'
			И в поле с именем 'ВремяНачалаРабот' я ввожу текст ' 9:30:00'
			И я перехожу к следующему реквизиту
			И в поле с именем 'ВремяОкончанияРабот' я ввожу текст '11:30:00'
			И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Решение проблемы'
			И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
			И я жду закрытия окна 'Обслуживание клиента (создание) *' в течение 20 секунд
		Тогда открылось окно 'Обслуживание клиента'
		* И я создаю третий документ
			И я нажимаю на кнопку с именем 'ФормаСоздать'
			Тогда открылось окно 'Обслуживание клиента (создание)'
			И из выпадающего списка с именем "Клиент" я выбираю точное значение 'ИП Махатрян'
			И я нажимаю кнопку выбора у поля с именем "Договор"
			Тогда открылось окно 'Договоры контрагентов'
            И в таблице "Список" я перехожу к строке:
				| 'Код'       | 'Наименование' |
				| '000000007' | 'Основной'     |
			И в таблице "Список" я выбираю текущую строку
			Тогда открылось окно 'Обслуживание клиента (создание) *'
			И из выпадающего списка с именем "Специалист" я выбираю точное значение 'Дима'
			И я нажимаю кнопку выбора у поля с именем "ДатаПроведенияРабот"
			И в поле с именем 'ДатаПроведенияРабот' я ввожу текст '21.05.2024'
			И в поле с именем 'ВремяНачалаРабот' я ввожу текст ' 9:00:00'
			И я перехожу к следующему реквизиту
			И в поле с именем 'ВремяОкончанияРабот' я ввожу текст '10:00:00'
			И я перехожу к следующему реквизиту
			И в поле с именем 'ОписаниеПроблемы' я ввожу текст 'Знакомство'
			И я нажимаю на кнопку с именем 'ФормаПровестиИЗакрыть'
			И я жду закрытия окна 'Обслуживание клиента (создание) *' в течение 20 секунд
		* И я проверяю наличие новых строк в "Обслуживание клиента"
			И таблица "Список" содержит строки: 
				| 'Клиент'               | 'Договор'    |'Специалист'|'Начало' |'Окончание'|'Описание проблемы'|
				| 'ООО "Офисный Мир КМ"' | 'Основной'   |'Владимир'  |'9:00:00'|'11:00:00 '|'Тестирования'     |
				| 'ООО "Умный Ретейлер"' | 'Основной'   |'Петр'      |'9:30:00'|'11:30:00 '|'Решение проблемы' |
				| 'ИП Махатрян           | 'Основной'   |'Дима'      |'9:00:00'|'10:00:00 '|'Командировка'     |
