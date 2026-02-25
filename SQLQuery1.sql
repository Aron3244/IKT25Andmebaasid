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

insert into Person (Id, Name, Email)
values (1, 'Superman', 's@s.com', 1)

insert into Person (Id, Name, Email,GenderId)
values (4, 'Aquaman', 'a@a.com', 2)

insert into Person (Id, Name, Email,GenderId)
values (6, 'Antman', 'ant"ant.com', 2)

insert into Person (Id, Name, Email,GenderId)
values (5, 'Catwoman', 'c@c.com', 1)

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

 --kolm esimest, aga tabeli järiestus on Age ja siis on Name

 SELECT TOP 3 Age, Name from Person

 --näita esimesed 50% tabelist

 select top 50 PERCENT * from Person 

 --järiestada vanuse järgi isikud

 select * from Person order by Age desc
 -- casti abil saa andmeüüpi muuta
 --muudab Age muuuja int-ks näitab vanuselise järiestuses
 select * from Person order by cast(Age as int) desc

 -- kõikide isikute koondvanus e liidab kõik kokku
 select sum(CAST(Age as int)) from Person

 --kõige noorem isik üles leida

 select min(cast(Age as int)) from Person

 --kõige vanem isik 
  select max(cast(Age as int)) from Person

  --muudame Age mutuja int peale
  --näeme konkreetsetest linnades olevate iskute koondvanust
  select City, sum(Age) as TotalAge from Person	group by City

  --kuidas saab koodiga muuta andmetüüpi ja selle pikust
  alter table Person
  alter column Name nvarchar(25)

  --kuvab esimeses reas välja toodud järiestuses ka kuvab Age-i
  --TotalAge-ks
  --järjest City-s olevate nimede järgi ja siis Genderid järgi
  --kasutada group by ja order by
  select City, GenderId, sum(Age) as TotalAge from Person
  group by City, GenderId
  order by City

 --näitab, et mitu rida andmeid on selles tabelis

  select COUNT(*) from Person
  --näitab tulemust, et mitu inimest on Genderid väärtusega 2
  --konkreetses linnas
  --arvutab vanused kokku selles linnas
  select GenderId, City, sum(Age) as TotalAge, count(Id) as
  [Total Person(s)] from Person
  where GenderId ='2'
  group by GenderId, City

--näitab ära inimeste koondvanused,´mis on üle 41 a ja 
--kui palju neid igas linnas elab
--eristab inimese soo ära

select GenderId, City, sum(Age) as TotalAge, count(Id) as
  [Total Person(s)] from Person
  where GenderId = '2'
  group by GenderId, City having sum(Age) > 41

  --loome tabelid Employees ja Department

  create table Department
  (
  Id int primary key,
  DepartmentName nvarchar(50),
  Location nvarchar(50),
  DepartmentHead nvarchar(50)
  )

  create table Employees
  (
  Id int primary key,
  Name nvarchar(50),
  Gender nvarchar(50),
  Salary nvarchar(50),
  DepartmentId int
  )

 insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1),
(2, 'Pam', 'Female', 3000, 3),
(3, 'John', 'Male', 3500, 1),
(4, 'Sam', 'Male', 4500, 2),
(5, 'Todd', 'Male', 2800, 2),
(6, 'Ben', 'Male', 7000, 1),
(7, 'Sara', 'Female', 4800, 3),
(8, 'Valarie', 'Female', 5500, 1),
(9, 'James', 'Male', 6500, NULL),
(10, 'Russell', 'Male', 8800, NULL)

insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick'),
(2, 'Payroll', 'Delhi', 'Ron'),
(3, 'HR', 'New York', 'Christie'),
(4, 'Other Department ', 'Sydney', 'Cindrella')

select * from Department
select * from Employees

select Name, Gender, salary, DepartmentName
from Employees
left join Department
on Employees.DepartmentId = Department.Id

--arvutab kõikide palgad kokku Employees tabelist

select sum(CAST(Salary as int)) from Employees
--arvutab kõikide palgad kokku

--kõige väiksema palga saaja

select min(CAST(Salary as int)) from Employees

--näitab veerge Location ja palka. Palga veerg kuvatakse TotalSalary-ks
--teha left join Departmen tabeliga
--grupitab Locationiga

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location
