INSERT INTO public.team (id,"city","name","coach_name","arena_id") VALUES
	 (10,'Барселона','Барселона','Шарунас Ясикявичюс',10),
	 (20,'Мадрид','Реал Мадрид','Пабло Ласо',20),
	 (30,'Москва','ЦСКА','Димитрис Итудис',30),
	 (40,'Пирей','	Олимпиакос','Георгиос Барцокас',40),
	 (50,'Санкт-Петербург','Зенит','Хавьер Паскуаль',50);
INSERT INTO public.player (id,"name","position",height, weight,salary,team_id) VALUES
	 (10,'Рафа Вильяр','защитник',188,85,100000,10),
	 (20,'Кайл Курич','защитник',193,85,100000,10),
	 (30,'Ибу Дьянко Баджи','центровой',211,103,200000,10),
	 (40,'Ник Калатес','разыгрывающий',198,97,150000,10),
	 (50,'Никола Миротич','форвард',208,107,175000,10),
	 (60,'Джейси Кэрролл','защитник',188,82,175000,20),
	 (70,'Эли Джон Ндиайе','центровой',203,110,275000,20),
	 (80,'Уолтер Тавареш','центровой',220,120,273000,20),
	 (90,'Томас Давид Эртель','разыгрывающий',189,88,173000,20),
	 (100,'Гершон Ябуселе','форвард',203,118,99000,20),
	 (110,'Габриэль Иффе Лундберг','защитник',193,96,101000,30),
	 (120,'Юрий Умрихин','защитник',190,75,251000,30),
	 (130,'Иван Анатольевич Ухов','разыгрывающий',193,77,175000,30),
	 (140,'Александр Хоменко','разыгрывающий',192,85,375000,30),
	 (150,'Андрей Лопатин','лёгкий форвард',208,92,205000,30),
	 (160,'Тайлер Дорси','защитник',193,83,205000,40),
	 (170,'Яннулис Ларенцакис','защитник',196,87,75000,40),
	 (180,'Хассан Мартин','центровой',201,107,375000,40),
	 (190,'Михалис Лунцис','разыгрывающий',195,90,475000,40),
	 (200,'Георгиос Принтезис','форвард',205,104,105000,40),
	 (210,'Билли Джеймс Бэрон','защитник',188,88,75000,50),
	 (220,'Артурас Гудайтис','центровой',208,99,165000,50),
	 (230,'Денис Захаров','разыгрывающий',192,88,163000,50),
	 (240,'Миндаугас Кузминскас','лёгкий форвард',204,93,295000,50),
	 (250,'Алекс Пойтресс','форвард',201,108,247000,50);
INSERT INTO public.game (id,owner_team_id ,guest_team_id ,game_date ,winner_team_id,owner_score,guest_score,arena_id) VALUES
	 (10,10,50,'2021-10-22',10,84,58,10),
	 (20,10,30,'2021-11-17',10,81,73,10),
	 (30,10,20,'2021-10-12',10,93,80,10),
	 (40,10,40,'2021-10-15',10,83,68,10),
	 (50,50,20,'2022-12-15',20,68,75,50),
	 (60,50,30,'2022-01-15',30,67,77,50),
	 (70,50,40,'2022-10-20',50,84,78,50),
	 (80,20,30,'2021-10-28',20,71,65,20),
	 (90,20,40,'2022-02-01',20,75,67,20),
	 (100,30,40,'2022-02-02',30,79,78,30);
select *from public.arena name
where "size" > 9000
order by "name" asc;
select *from public.player name
where "position" in ('защитник','форвард')
order by "name" desc;
select *from public.player name
where height >215 or weight >120
order by "name" asc;

Проект 2.3

select name,position from public.player
where height between 188 and 200 and salary between 100000 and 150000
order by "name" desc

select 'город: ' ||city||', команда: ' ||name||', тренер: ' ||coach_name  as "полная информация" from public.team 
order by "полная информация"

select  name, size from public.arena 
where id in (10,30,50)
order by "size" , "name" 

select  name, size from public.arena 
where id not in (10,30,50)
order by "size" , "name" 

select name as "имя игрока", position as "позиция на площадке" from public.player
where height between 188 and 220 and position in ('центровой','защитник')
order by "position" desc ,"name" desc 

Проект 2.4
Упражнение 1

select name from public.arena 
union
select name from public.team 
order by name desc 

Упражнение 2

select name , 'стадион ' as object_type from public.arena 
union
select name, 'команда' as object_type from public.team
order by object_type desc  , name asc 

Упражнение 3

select name, salary from public.player 
order by  ( case 
when  salary =475000 then 1
else salary
end) 
limit 5

Упражнение 4

select id from public.player
except
select id from public.team 
order by id
limit 10

Упражнение 5

(select id from public.arena 
except
select id from public.game)
union
(select id from public.game
except
select id from public.arena)
order by id

/*
 * Проект 3.1
 * 
 * Упражнение 1
 * 
 * Напишите SQL запрос, который вернет список городов, играющих команд, 
 * их наименования и название домашней арены, вместимость которой строго больше чем 10000 мест. 
 * Результат отсортируйте по названию города в убывающем порядке. Обратите внимание на часть ответа ниже 
 * с учетом именования выходных атрибутов вашего запроса.
 */

select team.city as city_name, team.name as team_name, arena.name as arena_name
from public.team inner join public.arena
on team.arena_id =arena.id 
where  arena.size > 10000
order by city_name desc;

/*
 * Упражнение 2
 * 
 * Напишите SQL запрос, который возвращает информацию по играм между командами с указанием имени команды хозяина,
 *  имени гостевой команды, имени команды победителя, финальный счет 
 * (в одном поле score с паттерном “OWNER_SCORE:GUEST_SCORE”) и название стадиона, на котором проводилась игра. 
 * Результат отсортируйте по имени команды хозяина и по имени гостевой команды. 
 * Обратите внимание на часть ответа ниже с учетом именования выходных атрибутов вашего запроса.
*/



select o.name  as owner_team, 
g.name   as guest_team, 
w.name   as winner_team,
concat (game.owner_score, ':', game.guest_score)  as score, 
arena.name as arena_name
from public.game 
inner join public.team  as o on game.owner_team_id = o.id
inner join public.team as g on game.guest_team_id= g.id
inner join public.team as w on game.winner_team_id= w.id
inner join  public.arena on game.arena_id  =arena.id 
order by owner_team,guest_team;

/*
 * Упражнение 3
 * 
 * Напишите DDL SQL запрос, который создает таблицу с именем player_defender, 
 * содержащую всех игроков с позицией на площадке “защитник” (используйте паттерн “CREATE … AS SELECT …”).
 *  Пожалуйста, приложите команду создания таблицы.
*/

create table player_defender as
select* from player 
where position ='защитник';
select * from player_defender;

/*
 * Упражнение 4
 * 
 * Обновите зарплаты всех игроков в таблице player_defender с учетом налогового процента на доход (равный 13%).
 *  Другими словами текущая зарплата должна быть за минусом 13%. Пожалуйста, приложите команду обновления таблицы.
*/


update player_defender
set salary= player_defender.salary - player_defender.salary*0.13;
select * from player_defender;

/*
 * Упражнение 5
 * 
 * Удалите игроков из таблицы player_defender, чья зарплата меньше 100 000 и вес равный 85 кг. 
 * Пожалуйста, приложите команду удаления строк таблицы.
*/

delete from player_defender
where salary <100000 and weight =85;
select * from player_defender;

