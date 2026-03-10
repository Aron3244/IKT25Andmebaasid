

create database Raamat

create table Raamatud
(
id int not null primary key,
pealkiri VARCHAR(100),
autor VARCHAR(100),
aasta int,
hind Decimal(5,2)
)

insert into Raamatud (id, pealkiri, autor, aasta, hind)
values (1, 'Sipsik','Kersti Kaljulaid', 2020, 10),
(2, 'Kärau Kaarel', 'Tiit Marvel', 2019, 30),
(3, 'Rehepapp', 'Andrus Kivirähk', 2005, 10),
(4, 'Kaka ja kevad', 'Ivo Linna', 2010, 10),
(5, 'Muumid', 'Jaan Aru', 2000, 20)

select * from Raamatud

update Raamatud
set hind = 20
where id = 1

update Raamatud
set autor = 'Superman'
where id = 2

alter table Raamatud
add laos_kogus int

update Raamatud
set laos_kogus = 12
where id = 1
update Raamatud
set laos_kogus = 2
where id = 3
update Raamatud
set laos_kogus = 122
where id = 5

alter table Raamatud
drop column hind

update Raamatud
set pealkiri = NULL
where Id = 2

