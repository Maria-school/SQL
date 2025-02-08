
2.3

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




