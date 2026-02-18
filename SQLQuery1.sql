-- teeme andmebaasi e db
create database IKT25tar

--andmebaasi valimine
use IKT25tar

--andmebaasi kustutamine

DROP DATABASE IKT25tar;

--teema uuesti andmebaasi IKT25tar
create database IKT25tar


--teeme tabeli
CREATE TABLE Gender
(
--Meil on muutuja id,
--mis,on siis täisarv andmetüüp,
--kui sisestad andmed,
--siis see veerg peab olema täidetud,
--tegemist on primaarvõtmega
Id int not null primary key,
--veeru nimi on siis Gender,
--10 tähemärki on max pikkus,
--andmed peavad olema sisestatud ehk
--ei tohiu olla tühik
Gender nvarchar(10) not null
)

--andmete sisestamine
-- Id 1, Gender Male
-- Id 2, Gender Female

Insert into Gender (Id, Gender)
Values (1, 'Male'),
(2, 'Female')

--vaatame tabeli sisu
--* tähendab, et näita kõike sela sees olevat imfot
select * from Gender

--teeme tabeli nimega Person
--veeru nimimed: id int not null primary key,
--Name nvarchar (30)
--Email nvarchar (30)
--GenderId int

Create Table Person
(
id int not null primary key,
Name nvarchar (30),
Email nvarchar (30),
GenderId int
)
alter table Person add constraint tblPerson_GenderiD
add constraint DF_Person_GenderId

alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

insert into Gender (Id, Gender)
values (3, 'Unknown')

insert into Person (Id, Name, Email,GenderId)
values (7, 'Black Panther', 'b@b.com', NULL)

insert into Person (Id, Name, Email)
values (9, 'Spiderman', 'spider@man.com')

select * from Person

--piirangu kustutamine
alter table Person
drop constraint DF_Persons_GenderId

--kuidas lisada veergu tabelile Person
--veeru nime on Age nvarchar(10)

alter table Person 
add Age nvarchar(10)

alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

--kuidas uuendada andmeid
update Person
set Age = 159
Where Id = 7

--soovin kustutada ühe rea
delete from Person where id = 8

--lisame uue veeru City nvarchar(50)
alter table Person
add City nvarchar(50)

select * from Person

--kõik, kes elavad Gothami linnas 
select * from Person where City = 'Gotham'
--kõik, kes ei ela Gothamis
SELECT * FROM Person WHERE City != 'Gotham'
--varjan number 2
SELECT * FROM Person WHERE City <> 'Gotham'

--näitab teatud vanusega inimesi
--valime 151, 35, 25
select * from Person where Age in (151, 35, 26)
select * from Person where Age = 151 or Age = 35 or Age = 26

--soovin näha inimesi vahemikus 22 kuni 41

select * from Person where Age > 22 And Age < 41
select * from Person where Age between 22 and 41

--Wilcard ehk näitab kõike g-tähega linnad
select * from Person where City like 'g%'
--otsib emailid @-märgiga
select * from Person where  Email like '%@%'

--tahan näha, kellel on emailis ees ja peale @-märk üks täht
select * from Person where Email like '_@_.com%'

--kõik, kelle nimes ei ole esimene tähte W, A, S
select * from Person where Name not like '[^WAS]%' 

--kõik, kes elavad Gothamis ja New  Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

--kõik, kes elavad Gothamis ja New Yorkis ning peavad olema 
-- vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
 and Age >= 30

 --kuvab tähestikulises järiekorras inimesi ja võtab aluseks 
 --Name veeru
 select * from Person order by Name
 select * from Person

--võtab kolm esimest rida Person tabelist
 SELECT TOP 3 * FROM Person 

 
