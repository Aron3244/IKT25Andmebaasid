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
--mis,on siis t‰isarv andmet¸¸p,
--kui sisestad andmed,
--siis see veerg peab olema t‰idetud,
--tegemist on primaarvıtmega
Id int not null primary key,
--veeru nimi on siis Gender,
--10 t‰hem‰rki on max pikkus,
--andmed peavad olema sisestatud ehk
--ei tohiu olla t¸hik
Gender nvarchar(10) not null
)

--andmete sisestamine
-- Id 1, Gender Male
-- Id 2, Gender Female

Insert into Gender (Id, Gender)
Values (1, 'Male'),
(2, 'Female')

--vaatame tabeli sisu
--* t‰hendab, et n‰ita kıike sela sees olevat imfot
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

--soovin kustutada ¸he rea
delete from Person where id = 8

--lisame uue veeru City nvarchar(50)
alter table Person
add City nvarchar(50)

select * from Person

--kıik, kes elavad Gothami linnas 
select * from Person where City = 'Gotham'
--kıik, kes ei ela Gothamis
SELECT * FROM Person WHERE City != 'Gotham'
--varjan number 2
SELECT * FROM Person WHERE City <> 'Gotham'

--n‰itab teatud vanusega inimesi
--valime 151, 35, 25
select * from Person where Age in (151, 35, 26)
select * from Person where Age = 151 or Age = 35 or Age = 26

--soovin n‰ha inimesi vahemikus 22 kuni 41

select * from Person where Age > 22 And Age < 41
select * from Person where Age between 22 and 41

--Wilcard ehk n‰itab kıike g-t‰hega linnad
select * from Person where City like 'g%'
--otsib emailid @-m‰rgiga
select * from Person where  Email like '%@%'

--tahan n‰ha, kellel on emailis ees ja peale @-m‰rk ¸ks t‰ht
select * from Person where Email like '_@_.com%'

--kıik, kelle nimes ei ole esimene t‰hte W, A, S
select * from Person where Name not like '[^WAS]%' 

--kıik, kes elavad Gothamis ja New  Yorkis
select * from Person where (City = 'Gotham' or City = 'New York')

--kıik, kes elavad Gothamis ja New Yorkis ning peavad olema 
-- vanemad, kui 29
select * from Person where (City = 'Gotham' or City = 'New York')
 and Age >= 30

 --kuvab t‰hestikulises j‰riekorras inimesi ja vıtab aluseks 
 --Name veeru
 select * from Person order by Name
 select * from Person

--vıtab kolm esimest rida Person tabelist
 SELECT TOP 3 * FROM Person 

 --kolm esimest, aga tabeli j‰riestus on Age ja siis on Name

 SELECT TOP 3 Age, Name from Person

 --n‰ita esimesed 50% tabelist

 select top 50 PERCENT * from Person 

 --j‰riestada vanuse j‰rgi isikud

 select * from Person order by Age desc
 -- casti abil saa andme¸¸pi muuta
 --muudab Age muuuja int-ks n‰itab vanuselise j‰riestuses
 select * from Person order by cast(Age as int) desc

 -- kıikide isikute koondvanus e liidab kıik kokku
 select sum(CAST(Age as int)) from Person

 --kıige noorem isik ¸les leida

 select min(cast(Age as int)) from Person

 --kıige vanem isik 
  select max(cast(Age as int)) from Person

  --muudame Age mutuja int peale
  --n‰eme konkreetsetest linnades olevate iskute koondvanust
  select City, sum(Age) as TotalAge from Person	group by City

  --kuidas saab koodiga muuta andmet¸¸pi ja selle pikust
  alter table Person
  alter column Name nvarchar(25)

  --kuvab esimeses reas v‰lja toodud j‰riestuses ka kuvab Age-i
  --TotalAge-ks
  --j‰rjest City-s olevate nimede j‰rgi ja siis Genderid j‰rgi
  --kasutada group by ja order by
  select City, GenderId, sum(Age) as TotalAge from Person
  group by City, GenderId
  order by City

 --n‰itab, et mitu rida andmeid on selles tabelis

  select COUNT(*) from Person
  --n‰itab tulemust, et mitu inimest on Genderid v‰‰rtusega 2
  --konkreetses linnas
  --arvutab vanused kokku selles linnas
  select GenderId, City, sum(Age) as TotalAge, count(Id) as
  [Total Person(s)] from Person
  where GenderId ='2'
  group by GenderId, City

--n‰itab ‰ra inimeste koondvanused,¥mis on ¸le 41 a ja 
--kui palju neid igas linnas elab
--eristab inimese soo ‰ra

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

--arvutab kıikide palgad kokku Employees tabelist

select sum(CAST(Salary as int)) from Employees
--arvutab kıikide palgad kokku

--kıige v‰iksema palga saaja

select min(CAST(Salary as int)) from Employees

--n‰itab veerge Location ja palka. Palga veerg kuvatakse TotalSalary-ks
--teha left join Departmen tabeliga
--grupitab Locationiga

select Location, sum(cast(Salary as int)) as TotalSalary
from Employees
left join Department
on Employees.DepartmentId = Department.Id
group by Location

select * FROM Employees
select sum(cast(Salary as int)) from Employees 
--arvutab kıikide palgad kokku

--lisame veeru City ja pikkust on 30 

alter table Employees
add City nvarchar(30)
  
  select City, Gender, sum(cast(Salary as int)) as TotalSalary
  from Employees
  group by City, Gender

  --peaaegu sama p‰ring, aga linnad on t‰hestikulises j‰riestuses
  select City, Gender, sum(cast(Salary as int)) as TotalSalary
  from Employees
  group by City, Gender
  order by City

  --on vaja teada, et mitu inimest on nimekirjas
  select count (*) from Employees

  --mitu tˆˆtajat on soo ja linna kaupa tˆˆtamas

  select Gender, City, sum(cast(Salary as int)) as TotalSalary,
  count (Id) as [Total Employees(s)]
  from Employees
  group by Gender, City
   
  --kuvab kas naised vıi mehed linnade kaupa 
  --kasutage where
  select Gender, City, sum(cast(Salary as int)) as TotalSalary,
  count (Id) as [Total Employees(s)]
  from Employees
  where Gender = 'Male'
  group by Gender, City

  --sama tulemus nagu eelmine kord, aga kasutage having
  select Gender, City, sum(cast(Salary as int)) as TotalSalary,
  count (Id) as [Total Employees(s)]
  from Employees
  group by Gender, City
  having Gender = 'Female'

  --kıik, kes teenivad v‰hem rohkem, kui 4000

  select * from Employees where sum(cast(Salary as int)) > 4000

  --teeme variandi, kus saame tulemuse

  select Gender, City, sum(cast(Salary as int)) as TotalSalary,
  count (Id) as [Total Employees(s)]
  from Employees
  group by Gender, City
  having sum(cast(Salary as int)) > 4000

  --loome tabeli, milles hakatakse automaatselt nummerdama id-d

  create table Test1
  (
  Id int identity(1,1),
  Value nvarchar(20)
  )

  insert into Test1 values('X')
  select * from Test1
  select * from Test1

  --kustutame veeru nimega City Employee tabelist

  alter table Employees
  drop column City

  select * from Employees

  --inner join
  --kuvab neid, kellel on DepartmentName all olemas v‰‰rtus
  --MITTE kattuvad read eemaldatakse tulemusest
  --ja seelep‰rast ei n‰edata Jamesi ja Russelit
  --kuna neil on  DepartmentId null
  select Name, Gender, Salary, DepartmentName
  from Employees
  inner join Department
  on Employees.DepartmentId = Department.Id

  --left join

  select Name, Gender, Salary, DepartmentName
  from Employees
  left join Department --vıib kasutada ka LEFT OUTER JOIN-i
  on Employees.DepartmentId = Department.Id
  -- mis on left join?
  --N‰itab andmeid, kus vasakpoolsest tabelist isegi, siis kui seal puudub
  --vıırvıtme reas v‰‰rtus

  --right join
  select Name, Gender, Salary, DepartmentName
  from Employees
  right join Department
  on Employees.DepartmentId = Department.Id
 --right join n‰itab paremas (Department) tabelis olevaid v‰‰rtuseid,
 --mis ei ¸hti vasaku (Employees) tabeliga

 --outer join
 select Name, Gender, Salary, DepartmentName
  from Employees
  full outer join Department
  on Employees.DepartmentId = Department.Id
  --mılema tabeli read kuvab

  --teha cross join
  select Name, Gender, Salary, DepartmentName
  from Employees
  cross join Department
 --korrutab kıik omavahel l‰bi

  --teha left join, kus Employees tabelist DepartmentId on null
 select Name, Gender, Salary, DepartmentName
  from Employees
  left join Department 
  on Employees.DepartmentId = Department.Id
  where Employees.DepartmentId is null

  --teine variant ja sama tulemus
  select Name, Gender, Salary, DepartmentName
  from Employees
  left join Department 
  on Employees.DepartmentId = Department.Id
  where Department.Id is null
  --n‰itab ainult neid, kellel on vasakust tabelist (Employees)
  --DepartmentId null

select Name, Gender, Salary, DepartmentName
  from Employees
  right join Department 
  on Employees.DepartmentId = Department.Id
  where Employees.DepartmentId is null
  --n‰itab ainult paremas tabelis olevat rida,
  --mis ei kattu Employees-ga

  --full join
  --mılema tabeli mittekattuvate v‰‰rtustega read kuvab v‰lja

  select Name, Gender, Salary, DepartmentName
  from Employees
  full join Department 
  on Employees.DepartmentId = Department.Id
  where Employees.DepartmentId is null
  or Department.id is null
  --teete adventureWorks2019 andmebaasile join p‰ringus
  --inner join, left join, right join, cross join ja full join
 --tabeleid sellese andmebaasi juurde ei tohi uusi tabeleid teha

 SELECT c.FirstName, a.AddressLine1
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca 
on c.CustomerID = ca.CustomerID
INNER JOIN SalesLT.Address a
ON ca.AddressID = a.AddressID

SELECT c.FirstName, a.AddressLine1
FROM SalesLT.Customer c
left join SalesLT.CustomerAddress  
ON c.CustomerID = ca.CustomerID
left join SalesLT.Address a
ON ca.AddressID = a.AddressID

SELECT c.FirstName, a.AddressLine1
FROM SalesLT.Customer c
right join SalesLT.CustomerAddress ca 
ON c.CustomerID = ca.CustomerID
right join SalesLT.Address a
ON ca.AddressID = a.AddressID

SELECT c.FirstName, a.AddressLine1
FROM SalesLT.Customer c
CROSS JOIN SalesLT.Address a

SELECT c.FirstName,
       a.AddressLine1
FROM SalesLT.Customer c
FULL OUTER JOIN SalesLT.CustomerAddress ca
    ON c.CustomerID = ca.CustomerID
FULL OUTER JOIN SalesLT.Address a
    ON ca.AddressID = a.AddressID

	--mımikord peab muutuja ette kirjutama tabeli nimetuse nagu on
	--product, Name
	--et editro saaks aru et kummma tabeli mnuutujat soovitakse kasutada
	-- ja ei tekiks segatust
	--mınikord peab tabeli ette kirjutama t‰psutava info nagu on
	--SalseLTproduckt
	--Antud juhul on producti tabelis id vıırvıti, produckmodel on primaarvıti
