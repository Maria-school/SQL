/*
 * Проект 2.5 часть 1
 */


create table пациенты(
  id integer not null primary key,
  имя_пациента varchar NOT NULL,
  фамилия_пациента varchar NOT NULL,
  дата_рождения date NOT NULL,
  пол varchar NOT null check (пол in ('М','Ж')),
  адрес_пациента varchar NOT NULL,
  телефон_пациента varchar NOT NULL,
  номер_медицинского_полиса_пациента varchar NOT null unique,
  серия_и_номер_паспорта_пациента varchar NOT null unique
);

create table должности_врачей_специалистов (
  id_должности integer primary key,
  название_должности varchar NOT null unique,
  описание text
  );
 
 create table врачи_специалисты (
  id_врача integer primary key,
  имя_специалиста varchar NOT null,
  фамилия_специалиста varchar NOT null,
  должность integer NOT null REFERENCES должности_врачей_специалистов(id_должности),
  расписание_работы_врача_специалиста varchar NOT null default  'Пн; Вт; Ср; Чт; Пт; Сб; Вс;'
 );
 
create table медицинские_услуги (
 id_мед_услуги integer primary key,
 наименование_мед_услуги varchar NOT null unique,
 описание_мед_услуги text not null,
 статус_оказания_мед_услуги varchar NOT null default 'включено' check (статус_оказания_мед_услуги in ('включено', 'исключено')),
 стоимость_мед_услуги float NOT null default 0
 );
 
create table запись_на_прием_к_врачу_специалисту (
  id_записи integer primary key,
  врач_специалист integer NOT null references врачи_специалисты (id_врача) ,
  пациент integer NOT null references пациенты (id),
  дата_приема timestamp NOT null default current_timestamp,
  статус_записи_на_прием varchar NOT null default 'Запланировано' check (статус_записи_на_прием in ('Запланировано', 'Проведено', 'Отменено')),
  unique (пациент,врач_специалист,дата_приема),
  unique (врач_специалист,дата_приема),
  unique (пациент,дата_приема)
  );
 
 create table оказываемые_мед_услуги (
   id_услуги integer primary key,
   информация_о_записи_на_прием  integer NOT null references запись_на_прием_к_врачу_специалисту (id_записи) ,
   мед_услуга integer NOT null references медицинские_услуги (id_мед_услуги),
   статус_мед_услуги varchar NOT null default 'Запланирована' check (статус_мед_услуги in ('Запланирована', 'Проведена', 'Отменена')),
   unique (информация_о_записи_на_прием,мед_услуга)
   );
   
  create table заключение_врача (
    id_заключения integer primary key,
    внутренний_номер_заключения integer NOT null unique,
    информация_о_записи_на_прием integer NOT null references запись_на_прием_к_врачу_специалисту (id_записи) ,
    врач integer NOT null references врачи_специалисты (id_врача) ,
    записанный_пациент integer NOT null references пациенты (id),
    дата_записи_заключения timestamp NOT null default current_timestamp,
    диагноз text NOT null,
    рекомендации text NOT null
    );
  
   
   
   
   
   
   
   /*
 * Проект 2.5 часть 2
 Введите следующие тестовые данные для вашей модели данных, используя INSERT выражения.

Зарегистрируйте 5 любых врачей-специалистов в вашей поликлинике с должностями:
Врач общей практики (терапевт)
Стоматолог
Кардиолог
Отоларинголог
Педиатр
заполните остальные поля по таблице Врачи-специалисты вашими значениями

Укажите 10 любых медицинских услуг таким образом , чтобы в среднем 2 медицинские услуги оказывались одним врачом-специалистом
Укажите 5 пациентов, которые записались на прием в среднем к 2 специалистам в разные дни для получения** 2 медицинских услуг** в рамках одного приема
Укажите заключения врачей-специалистов на основании вашего количества приемов пациентов
 */

insert into должности_врачей_специалистов (id_должности,  название_должности, описание)
values 
		(10, 'Врач общей практики (терапевт)', 'Перчивиный прием пациентов, распределение пациентов по профилям врачей, общий осмотр и консультация пациентов'),
	    (20, 'Стоматолог', 'Лечение и профилактика заболеваний зубов и органов полости рта'),
	    (30, 'Кардиолог', 'Специалист по лечнию и диагностике заболеваний ССС'),
	    (40, 'Отоларинголог', 'Специалист по лечнию и диагностике заболеваний ЛОР-органов'),
	    (50, 'Педиатр', 'Специалист по диагностике и лечению детских заболеваний');
select*from должности_врачей_специалистов;
/*
 10	Врач общей практики (терапевт)	Перчивиный прием пациентов, распределение пациентов по профилям врачей, общий осмотр и консультация пациентов
20	Стоматолог	Лечение и профилактика заболеваний зубов и органов полости рта
30	Кардиолог	Специалист по лечнию и диагностике заболеваний ССС
40	Отоларинголог	Специалист по лечнию и диагностике заболеваний ЛОР-органов
50	Педиатр	Специалист по диагностике и лечению детских заболеваний
 */

insert into врачи_специалисты (id_врача, имя_специалиста, фамилия_специалиста, должность, расписание_работы_врача_специалиста)
values 
		(10, 'Игорь', 'Даниленко', 10, 'Пн; Вт; Чт; Сб;'),
	    (20, 'Алла', 'Романова', 20, 'Ср; Пт;'),
	    (30, 'Глеб', 'Мартынов', 30, 'Пн; Ср; Чт; Пт;'),
	    (40, 'Маргарита', 'Симонова', 40, 'Вт; Ср; Чт;'),
	    (50, 'Марина', 'Михайлова', 50, 'Пн; Ср; Пт;');
select id_врача, имя_специалиста, фамилия_специалиста, должность, расписание_работы_врача_специалиста 
from врачи_специалисты
inner join должности_врачей_специалистов on должность = id_должности;
/*
 10	Игорь	Даниленко	10	Пн; Вт; Чт; Сб;
20	Алла	Романова	20	Ср; Пт;
30	Глеб	Мартынов	30	Пн; Ср; Чт; Пт;
40	Маргарита	Симонова	40	Вт; Ср; Чт;
50	Марина	Михайлова	50	Пн; Ср; Пт;
 */

insert into пациенты (id, имя_пациента, фамилия_пациента, дата_рождения, пол, адрес_пациента, телефон_пациента, номер_медицинского_полиса_пациента, серия_и_номер_паспорта_пациента)
values
		(10, 'Роман', 'Вятков', '1971-12-10', 'М', 'Проспект Мира, 10', 895248264321, 25615, 22002222),
		(20, 'Милена', 'Гольц', '1997-06-05', 'Ж', 'Пролетарская, 5', 8921654516, 21541, 51522151),
		(30, 'Дмитрий', 'Гребников', '1901-10-11', 'М', 'Ганнушкина, 25', 8924164946, 261215, 48421845),
		(40, 'Захар', 'Гринчев', '2012-03-17', 'М', 'Кислая, 18', 8265165654, 5449121, 48623218),
		(50, 'Влад', 'Мендель', '2019-06-21', 'М', 'Небесный проспект, 13', 822916164, 6543516, 88822021);
select*from пациенты;
/*
10	Роман	Вятков	1971-12-10	М	Проспект Мира, 10
20	Милена	Гольц	1997-06-05	Ж	Пролетарская, 5
30	Дмитрий	Гребников	1901-10-11	М	Ганнушкина, 25
40	Захар	Гринчев	2012-03-17	М	Кислая, 18
50	Влад	Мендель	2019-06-21	М	Небесный проспект, 13
 */

insert into медицинские_услуги (id_мед_услуги, наименование_мед_услуги, описание_мед_услуги, стоимость_мед_услуги)
values
		(10, 'Общий анализ крови', 'забор венозной крови на основные клиничнские показатели', 1000),
		(20, 'Биохимический анализ крови', 'забор венозной крови на основные биохимические показатели', 1400),
		(30, 'Ультрозвуковая профессиональная чистка зубов', 'профессиональная чистка зубов и гигиена полости рта', 5000),
		(40, 'Лечение кариозного зуба', 'Лечение кариозного зуба под местным анестезированием', 6500),
		(50, 'ЭКГ', 'Запись ЭКГ с расшифровкой', 1800),
		(60, 'Эхо-КГ', 'Проведение Эхо-КГ с описанием', 2300),
		(70, 'Чистка ушных каналов', 'Чистка забитых ушных каналов', 1700),
		(80, 'Промывание носовых синусов', 'Промывание носовых пазух гипертоническим раствором', 800),
		(90, 'Вакцинация', 'Вакцинация в рамках прививочного календаря', 1000),
		(100, 'Осмотр на дому (патронаж)', 'Патронаж на дому у пациента', 2000);
select id_мед_услуги, наименование_мед_услуги, описание_мед_услуги, стоимость_мед_услуги
from медицинские_услуги;
/*
10	Общий анализ крови	забор венозной крови на основные клиничнские показатели	1000.0
20	Биохимический анализ крови	забор венозной крови на основные биохимические показатели	1400.0
30	Ультрозвуковая профессиональная чистка зубов	профессиональная чистка зубов и гигиена полости рта	5000.0
40	Лечение кариозного зуба	Лечение кариозного зуба под местным анестезированием	6500.0
50	ЭКГ	Запись ЭКГ с расшифровкой	1800.0
60	Эхо-КГ	Проведение Эхо-КГ с описанием	2300.0
70	Чистка ушных каналов	Чистка забитых ушных каналов	1700.0
80	Промывание носовых синусов	Промывание носовых пазух гипертоническим раствором	800.0
90	Вакцинация	Вакцинация в рамках прививочного календаря	1000.0
100	Осмотр на дому (патронаж)	Патронаж на дому у пациента	2000.0
 */

insert into запись_на_прием_к_врачу_специалисту (id_записи, врач_специалист, пациент, дата_приема, статус_записи_на_прием)
values
		(10, 10, 10, '2023-11-27 12:32', 'Проведено'),
		(20, 10, 20, '2023-11-30 11:45', 'Запланировано'),
		(30, 20, 40, '2023-11-29 10:55', 'Проведено'),
		(40, 20, 30, '2023-12-01 13:15', 'Запланировано'),
		(50, 30, 10, '2023-11-27 10:48', 'Проведено'),
		(60, 30, 20, '2023-11-30 12:30', 'Проведено'),
		(70, 40, 30, '2023-12-01 12:45', 'Запланировано'),
		(80, 40, 50, '2023-11-29 14:20', 'Проведено'),
		(90, 50, 40, '2023-11-30 10:10', 'Запланировано'),
		(100, 50, 50, '2023-11-29 10:35', 'Проведено');
select id_записи, врач_специалист, пациент, дата_приема, статус_записи_на_прием from запись_на_прием_к_врачу_специалисту
inner join врачи_специалисты on врач_специалист = id_врача
inner join пациенты on пациент = id;

/*
10	10	10	2023-11-27 12:32:00.000	Проведено
20	10	20	2023-11-30 11:45:00.000	Запланировано
30	20	40	2023-11-29 10:55:00.000	Проведено
40	20	30	2023-12-01 13:15:00.000	Запланировано
50	30	10	2023-11-27 10:48:00.000	Проведено
60	30	20	2023-11-30 12:30:00.000	Проведено
70	40	30	2023-12-01 12:45:00.000	Запланировано
80	40	50	2023-11-29 14:20:00.000	Проведено
90	50	40	2023-11-30 10:10:00.000	Запланировано
100	50	50	2023-11-29 10:35:00.000	Проведено
 */

insert into оказываемые_мед_услуги (id_услуги, информация_о_записи_на_прием, мед_услуга, статус_мед_услуги)
values
		(10, 10, 10, 'Проведена'),
		(20, 10, 20, 'Проведена'),
		(30, 20, 20, 'Запланирована'),
		(40, 20, 10, 'Запланирована'),
		(50, 30, 30, 'Проведена'),
		(60, 30, 40, 'Проведена'),
		(70, 40, 40, 'Запланирована'),
		(80, 40, 30, 'Запланирована'),
		(90, 50, 50, 'Проведена'),
		(100, 50, 60, 'Проведена'),
		(110, 60, 60, 'Проведена'),
		(120, 60, 50, 'Проведена'),
		(130, 70, 70, 'Запланирована'),
		(140, 70, 80, 'Запланирована'),
		(150, 80, 80, 'Проведена'),
		(160, 80, 70, 'Проведена'),
		(170, 90, 90, 'Запланирована'),
		(180, 90, 100, 'Запланирована'),
		(190, 100, 100, 'Проведена'),
		(200, 100, 90, 'Проведена');
select id_услуги, информация_о_записи_на_прием, мед_услуга, статус_мед_услуги from оказываемые_мед_услуги	
inner join 	запись_на_прием_к_врачу_специалисту on 	информация_о_записи_на_прием = id_записи
inner join медицинские_услуги on мед_услуга = id_мед_услуги;
/*
10	10	10	Проведена
20	10	20	Проведена
30	20	20	Запланирована
40	20	10	Запланирована
50	30	30	Проведена
60	30	40	Проведена
70	40	40	Запланирована
80	40	30	Запланирована
90	50	50	Проведена
100	50	60	Проведена
110	60	60	Проведена
120	60	50	Проведена
130	70	70	Запланирована
140	70	80	Запланирована
150	80	80	Проведена
160	80	70	Проведена
170	90	90	Запланирована
180	90	100	Запланирована
190	100	100	Проведена
200	100	90	Проведена
 */

insert into заключение_врача (id_заключения, внутренний_номер_заключения, информация_о_записи_на_прием, врач, записанный_пациент, дата_записи_заключения, диагноз, рекомендации)
values
		(10, 001, 10, 10, 10, '2023-11-27', 'ГБ 2 ст', 'Лечение в соответствие с назначениями, снизить потребление соли и воды, умеренная физ нагрузка'),
		(20, 002, 30, 20, 40, '2023-11-29', 'Зубной камень', 'Периодическая профессиональная чистка зубов, соблюдение гигиены полости рта, уменьшение потребления сладкого'),
		(30, 003, 50, 30, 10, '2023-11-27', 'ГБ 1 ст', 'Ведение дневника давления, умеренная физическая активность, повторный прием через 1 месяц'),
		(40, 004, 60, 30, 20, '2023-11-30', 'Аритмогенная кардиомиопатия', 'Лечение в соответсвии с назначениями, повторное Эхо-КГ и ЭКГ через 3 месяца, ограничение физических нагрузок и стресса'),
		(50, 005, 80, 40, 50, '2023-11-29', 'Хронический синусит', 'Периодическое промывание носовых пазух изотоническим расствором, прививки в соответсвии с календарем прививок, избегать переохлаждений'),
		(60, 006, 100, 50, 50, '2023-11-29', 'ОРЗ', 'Лечение в соответсвии с назначениями, теплое обильное питье, повторный прием через 7 дней');
select id_заключения, внутренний_номер_заключения, информация_о_записи_на_прием, врач, записанный_пациент, дата_записи_заключения, диагноз, рекомендации
from заключение_врача
inner join запись_на_прием_к_врачу_специалисту on информация_о_записи_на_прием = id_записи
inner join врачи_специалисты on врач = id_врача
inner join пациенты on записанный_пациент = id;

/*
10	1	10	10	10	2023-11-27 00:00:00.000	ГБ 2 ст	Лечение в соответствие с назначениями, снизить потребление соли и воды, умеренная физ нагрузка
20	2	30	20	40	2023-11-29 00:00:00.000	Зубной камень	Периодическая профессиональная чистка зубов, соблюдение гигиены полости рта, уменьшение потребления сладкого
30	3	50	30	10	2023-11-27 00:00:00.000	ГБ 1 ст	Ведение дневника давления, умеренная физическая активность, повторный прием через 1 месяц
40	4	60	30	20	2023-11-30 00:00:00.000	Аритмогенная кардиомиопатия	Лечение в соответсвии с назначениями, повторное Эхо-КГ и ЭКГ через 3 месяца, ограничение физических нагрузок и стресса
50	5	80	40	50	2023-11-29 00:00:00.000	Хронический синусит	Периодическое промывание носовых пазух изотоническим расствором, прививки в соответсвии с календарем прививок, избегать переохлаждений
60	6	100	50	50	2023-11-29 00:00:00.000	ОРЗ	Лечение в соответсвии с назначениями, теплое обильное питье, повторный прием через 7 дней
 */
		






/*
 Напишете SQL запрос, который вернет имена, фамилии и метку что запись относится к пациенту или врачу,
 зарегистрированных пациентов с годом рождения 2000 (вы можете указать ваш год с учетом ваших данных) и врачей,
 работающих только по вторникам и средам (вы можете указать ваше расписание врача-специалиста с учетом ваших данных),
 в одном списке  следующем виде (в данном примере показаны тестовые данные автора). 
 Отсортируйте результат по имени и фамилии человека
 */
select имя_пациента as "Имя", фамилия_пациента as "Фамилия", 'Пациент' as "Метка"
from пациенты
where extract (year from дата_рождения) = 2012 or extract (year from дата_рождения) = 2019
union
select имя_специалиста, фамилия_специалиста, 'Врач' as "Метка"
from врачи_специалисты
where расписание_работы_врача_специалис = 'Ср; Пт;' or расписание_работы_врача_специалис = 'Вт; Ср; Чт;'
order by "Имя", "Фамилия"

/*
/Имя/		/Фамилия/		/Метка/
Алла		Романова		Врач
Влад		Мендель			Пациент
Захар		Гринчев			Пациент
Маргарита	Симонова		Врач
*/