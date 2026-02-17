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
