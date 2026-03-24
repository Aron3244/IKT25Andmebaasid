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

select * FROM Employees
select sum(cast(Salary as int)) from Employees 
--arvutab kõikide palgad kokku

--lisame veeru City ja pikkust on 30 

alter table Employees
add City nvarchar(30)
  
  select City, Gender, sum(cast(Salary as int)) as TotalSalary
  from Employees
  group by City, Gender

  --peaaegu sama päring, aga linnad on tähestikulises järiestuses
  select City, Gender, sum(cast(Salary as int)) as TotalSalary
  from Employees
  group by City, Gender
  order by City

  --on vaja teada, et mitu inimest on nimekirjas
  select count (*) from Employees

  --mitu töötajat on soo ja linna kaupa töötamas

  select Gender, City, sum(cast(Salary as int)) as TotalSalary,
  count (Id) as [Total Employees(s)]
  from Employees
  group by Gender, City
   
  --kuvab kas naised või mehed linnade kaupa 
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

  --kõik, kes teenivad vähem rohkem, kui 4000

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
  --kuvab neid, kellel on DepartmentName all olemas väärtus
  --MITTE kattuvad read eemaldatakse tulemusest
  --ja seelepärast ei näedata Jamesi ja Russelit
  --kuna neil on  DepartmentId null
  select Name, Gender, Salary, DepartmentName
  from Employees
  inner join Department
  on Employees.DepartmentId = Department.Id

  --left join

  select Name, Gender, Salary, DepartmentName
  from Employees
  left join Department --võib kasutada ka LEFT OUTER JOIN-i
  on Employees.DepartmentId = Department.Id
  -- mis on left join?
  --Näitab andmeid, kus vasakpoolsest tabelist isegi, siis kui seal puudub
  --võõrvõtme reas väärtus

  --right join
  select Name, Gender, Salary, DepartmentName
  from Employees
  right join Department
  on Employees.DepartmentId = Department.Id
 --right join näitab paremas (Department) tabelis olevaid väärtuseid,
 --mis ei ühti vasaku (Employees) tabeliga

 --outer join
 select Name, Gender, Salary, DepartmentName
  from Employees
  full outer join Department
  on Employees.DepartmentId = Department.Id
  --mõlema tabeli read kuvab

  --teha cross join
  select Name, Gender, Salary, DepartmentName
  from Employees
  cross join Department
 --korrutab kõik omavahel läbi

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
  --näitab ainult neid, kellel on vasakust tabelist (Employees)
  --DepartmentId null

select Name, Gender, Salary, DepartmentName
  from Employees
  right join Department 
  on Employees.DepartmentId = Department.Id
  where Employees.DepartmentId is null
  --näitab ainult paremas tabelis olevat rida,
  --mis ei kattu Employees-ga

  --full join
  --mõlema tabeli mittekattuvate väärtustega read kuvab välja

  select Name, Gender, Salary, DepartmentName
  from Employees
  full join Department 
  on Employees.DepartmentId = Department.Id
  where Employees.DepartmentId is null
  or Department.id is null
  --teete adventureWorks2019 andmebaasile join päringus
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

	--Mõnikord peab muutuja ette kirjutama tabeli nimetuse nagu on Product.Name,
--et editor saaks aru, et kummma tabeli muutujat soovitakse kasutada ja ei tekiks
--segadust
select Product.Name as [Product Name], ProductNumber, ListPrice, 
ProductModel.Name as [Product Model Name], 
Product.ProductModelId, ProductModel.ProductModelId
--mõnikord peab ka tabeli ette kirjutama täpsustama info
--nagu on SalesLt.Product
from SalesLt.Product
inner join SalesLt.ProductModel
--antud juhul Producti tabelis ProductModelId võõrvõti,
--mis ProductModeli tabelis on primaarvõti
on Product.ProductModelId = ProductModel.ProductModelId

--isnull funktsiooni kastammine
select isnull ('Ingvar', 'No Manager') as Manager

--null asemel kuvab No Manager
select coalesce(NULL, 'No Manager') as Manager

alter table Employees
add ManagerId int

--neile, kellele ei ole ülemust, siis paneb neile No Manager teksti
--kasutage left joini

select E.Name as Employee, isnull(M.Name, 'No Manager') as Manager
from Employees E
left join Employees M
on E.ManagerId = M.Id

 select * from Employees

 --kasutame inner joini
 --kuvab ainult ManagerId all olevate isikute väärtusid

 select E.Name as Employee, M.Name as Manager
from Employees E
inner join Employees M
on E.ManagerId = M.Id

--kõik saavad kõikide ülemused olla
 select E.Name as Employee, M.Name as Manager
from Employees E
cross join Employees M

--lisame tabelisse uued veerud
alter table Employees add
MiddleName nvarchar (30),
LastName nvarchar (30)

--muudame veeru nimetust
sp_rename 'Employees.Name', 'FirstName'


update Employees
set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1

update Employees
set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2

update Employees
set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3

update Employees
set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Smith'
where Id = 4

update Employees
set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5

update Employees
set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Seven'
where Id = 6

update Employees
set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7

update Employees
set FirstName = 'Valerie', MiddleName = 'Balerine', LastName = NULL
where Id = 8

update Employees
set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9

update Employees
set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10

--igas reast võtab esimesena täidetud lahtri ja kuvab ainult seda

SELECT Id, COALESCE(FirstName, MiddleName, LastName) AS Name
FROM Employees

select * from Employees

--loome kaks tabelit

create table IndianCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25),
)

create table UKCustomers
(
Id int identity(1,1),
Name nvarchar(25),
Email nvarchar(25),
)

--sisestame tabelisse andmeid
insert into IndianCustomers (Name, Email)
values ('Raj', 'R@R.com'),
('Sam', 'S@S.com')

insert into ukCustomers (Name, Email)
values ('Ben', 'B@B.com'),
('Sam', 'S@S.com')

select * from IndianCustomers
select * from UKCustomers

--kasutame union all, mis näitab kõiki ridu
--union all ühendab tabelid ja näitab sisu
select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers

--korduvate väärtusetga read pannakse ühte ja ei korrata
select Id, Name, Email from IndianCustomers
union
select Id, Name, Email from UKCustomers
--kasutad union all, aga sorteerid nime järgi

select Id, Name, Email from IndianCustomers
union all
select Id, Name, Email from UKCustomers
ORDER by Name

--stored procedure
--tavaliselt pannakse nimetuse ette sp, mis tähendab procedure
create procedure spGetEmployees
as begin
select FirstName, Gender from Employees
end

--nüüd saab kasutada selle nimelist sp-d
spGetEmployees
exec spGetEmployees
execute spGetEmployees

create proc spGetEmployeesByGenderAndDepartment
--@ tähendab muutujat
@Gender nvarchar(20),
@DepartmentId int
as begin
select FirstName, Gender, DepartmentId from Employees where Gender = @Gender
and DepartmentId = @DepartmentId
end

--kui nüüd allolevat käsklust käima panna, siis nõuab gender parameetrit
spGetEmployeesByGenderAndDepartment

--õige
spGetEmployeesByGenderAndDepartment 'Female', 1


--niimoodi saab sp kirja pamdud järiekorrast mööda minna, kui ise paned muutuja paika
spGetEmployeesByGenderAndDepartment @DepartmentId = 1, @Gender = 'Male'

--saab sp sisu vaadata result vaates
sp_helptext spGetEmployeesByGenderAndDepartment

--kuidas nuuta sp-d ja panna sinna võti peale, et keegi teine ei saaks muuta
--kuskile tuleb lisada with encryption 
alter proc spGetEmployeesByGenderAndDepartment 
--@ tähendab muutujat  
@Gender nvarchar(20),  
@DepartmentId int  
as begin  
select FirstName, Gender, DepartmentId from Employees where Gender = @Gender  
and DepartmentId = @DepartmentId  
end

create proc spGetEmployeeCountByGender
@Gender nvarchar(20),  
@EmployeeCount int output
as begin
select @EmployeeCount = count (Id) from Employees where Gender = @Gender
end

--annab tulemuse, kus loendab ära nõuetele vastavad read
--prindib ka tulemuse kirja teel
--tuleb teha declare muutuja @TotalCount, mis on int
--ececute spGetEmployeesByGenderAndDepartment sp, kus on parameeter Male ja TotalCount
--if ja else, kui TotalCount = 0, siis tuleb tekst TotalCount is null
--lõpus kasuta printi @TotalCounti puhul


DECLARE @TotalCount INT
execute spGetEmployeeCountByGender 'Male', @TotalCount out
IF (@TotalCount = 0)
PRINT '@TotalCount is null'
ELSE
    PRINT '@Total is not null'
PRINT @TotalCount

-- deklareerime muutuja @TotalCount, mis on int andmetüüp
declare @TotalCount int
-- käivitame stored procedure spGetEmployeeCountByGender, kus on parameetrid
-- @EmployeeCount = @TotalCount out ja @Gender 
execute spGetEmployeeCountByGender @EmployeeCount = @TotalCount out, @Gender = 'Female'
--prindib konsooli välja, kui TotalCount on null või mitte null
print @TotalCount

--sp sisu vaatamine
sp_help spGetEmployeeCountByGender
-- tabeli info vaatamine
sp_help Employees
--kui soovid sp teksti näha
sp_helptext spGetEmployeeCountByGender

-- vaatame, millest sõltub meie valitud sp
sp_depends spGetEmployeeCountByGender
-- näitab, et sp sõltub Employees tabelist, kuna seal on count(Id) 
-- ja Id on Employees tabelis

--vaatame tabelit
sp_depends Employees

--teeme sp, mis annab andmeid Id ja Name veergude kohta Employees tabelis
create proc spGetNameById
@Id int,
@Name nvarchar(20) output
as begin
	select @Id = Id, @Name = FirstName from Employees
end

--annab kogu tabeli ridade arvu
create proc spTotalCount2
@TotalCount int output
as begin
	select @TotalCount = count(Id) from Employees
end

-- on vaja teha uus päring, kus kasutame spTotalCount2 sp-d, 
-- et saada tabeli ridade arv

-- tuleb deklareerida muutuja @TotalCount, mis on int andmetüüp
declare @TotalEmployees int
--tuleb execute spTotalCount2, kus on parameeter @TotalEmployees
exec spTotalCount2 @TotalEmployees output
select @TotalEmployees

--mis Id all on keegi nime järgi
create proc spGetNameById1
@Id int,
@FirstName nvarchar(20) output
as begin
	select @FirstName = FirstName from Employees where Id = @Id
end

--annab tulemuse, kus id 1(seda numbrit saab muuta) real on keegi koos nimega
--print tuleb kasutada, et näidata tulemust
declare @FirstName nvarchar(20)
execute spGetNameById1 3, @FirstName output
print 'Name of the employee = ' + @FirstName

--- tehke sama, mis eelmine, aga kasutage spGetNameById sp-d
--FirstName l]pus on outdeclare 
declare @FirstName nvarchar(20)
execute spGetNameById 1, @FirstName out
print 'Name = ' + @FirstName

--output tagastab muudetud read kohe p'ringu tulemsuena
--see on salvestatud protseduuris ja ühe väärtuse tagastamine
--out ei anna mitte midagi, kui seda ei määra execute käsus

sp_help spGetNameById

create proc spGetNameById2
@Id int
--kui on begin, siis peab olema ka end
as begin
return (select FirstName from Employees where Id = @Id)
end
--tuleb veateada kuna kutsusime välja inti, aga Tom on nvarchar
declare @EmployeeName nvarchar(50)
execute @EmployeeName = spGetNameById2 1
print 'Name of the employee = ' + @EmployeeName

--sisseehitatud string funktsioonid
--see konverteerib ASCII tähe väärtuse numbriks
select ASCII('a')

select char(65)

--prindime kogu tähestiku välja
declare @Start int
set @Start = 97
--kasutate while, et näidata kogu tähestiku ette
while (@Start<= 122)
begin
select char (@Start)
set @Start =@Start + 1
end

--eemaldame tühjad kohad sulgudes
select LTRIM('                    Hello')
select('                    Hello')

--tühikute eemaldamine veerust, mis on tabelis
select Ltrim(FirstName), MiddleName, LastName from Employees
--eemaldage tühikud firstName veerust ära

--paremalt poolt tühjad stringid lõikab ära
select RTRIM('                Hello            ')
select ('           Hello            ')
--keerab kooloni sees olevad andmed vastupidiseks
--vastavalt lower-ga ja upper-ga muuta märkide suuruat
--reverse funktsioon pöörab kõik ümber
select REVERSE(upper(ltrim(FirstName))) as FirstName, MiddleName, lower(LastName),
rtrim(ltrim(FirstName)) + ' ' + MiddleName + ' ' + LastName as FullName from Employees

--left. right, substring
--vasakult poolt neli esimest tähte
select left('ABCDEF', 4)
--paremalt poolt kolm
select right('ABCDEF', 3)

--kuvab @-tähemärgi asetust ehk mitmmest on @ märk
select CHARINDEX('@', 'sara@aaa.com')

--esimene nr peale komakohta näitab, et mitmendas alustab ja siis mitu nr
--peale seda kuvab
select SUBSTRING('pam@bbb.com', 5, 2)

--@ märgist kuvab kolm tähemärki. Viimase nr saab määrata pikkust
select substring('pam@bbb.com', charindex('@', 'pam@.com') + 1, 3)

--peale @ märki hakkab kuvama tulemust, nr saab kaugust seadistada
select substring('pam@bbb.com', charindex('@', 'pam@.com') + 2,
len('pam@bbb.com') - charindex('@', 'pam@bbb.com'))

alter table Employees
add Email nvarchar (20)

update Employees
set Email = 'Tom@aaa.com'
where Id = 1

update Employees
set Email = 'Pam@bbb.com'
where Id = 2

update Employees
set Email = 'John@aaa.com'
where Id = 3

update Employees
set Email = 'Sam@bbb.com'
where Id = 4

update Employees
set Email = 'Todd@bbb.com'
where Id = 5

update Employees
set Email = 'Ben@ccc.com'
where Id = 6

update Employees
set Email = 'Sara@ccc.com'
where Id = 7

update Employees
set Email = 'Valerie@aaa.com'
where Id = 8

update Employees
set Email = 'James@bbb.com'
where Id = 9

update Employees
set Email = 'Russel@bbb.com'
where Id = 10

select * from Employees

--soovime teada saada domeeninimesid emailides
select substring (Email, CHARINDEX('@', Email) + 1,
len (Email) - CHARINDEX('@', Email)) as EmailDomain from
Employees

--alates teisest tähest emailis kuni @ märgini on tärnid


select FirstName, LastName ,
substring(Email, 1, 2) + replicate('*', 5) +
substring(Email, charindex('@', Email), len(Email) - charindex('@', Email)+1) as Email
from Employees
--kolm korrda näitab stringis olevat väärtust
select replicate('asd', 3)

--tühiku sisestamine
select SPACE(2)

--tühiku sisestamine FirstName ja LastName vahele

select FirstName + SPACE(25) + LastName as FullName from Employees

--Pattidex
--sama, mis charindex, aga dünaamilisem ja saab kasutada wildcardi
select Email, Patindex('%aaa.com', Email) as FirstOccurence
from Employees
where Patindex('%@aaa.com', Email) > 0
--leiame kõik selle domeini esindajad ja alates mimendast märgist algab @
--kõik .com asendab .net-iga

select Email, Replace(Email, '.com', '.net') as ConvertedEmail from Employees

--soovin asendada peale esimest märki kolme tähte viie tärniga
select FirstName, LastName , Email,
stuff(Email, 2, 3, '*****') as StuffedEmail
from Employees

create table DateTime
(
  c_time time,
  c_date date,
  c_smalldatetime smalldatetime,
  c_datetime datetime,
  c_datetime2 datetime2,
  c_datetimeoffset datetimeoffset,
)

select * from DateTime

--konkreetse masina kella aeg
select getdate(), 'GetDate()'

insert into DateTime
values (getdate(),getdate(),getdate(),getdate(),getdate(),getdate())

select * from DateTime

update DateTime set c_datetimeoffset = '2024-05-10 13:45:00.0000000 -08:00'
where c_datetimeoffset = '2026-03-19 14:25:16.3166667 +00:00'

select CURRENT_TIMESTAMP, 'CURRENT_TIMESTAMP' --aja päring
select SYSDATETIME(), 'SYSDATETIME' --täpsem aja päring
select SYSDATETIMEOFFSET(), 'SYSDATETIMEOFFSET' --täpne aeg koos ajalise nihkega
select GETUTCDATE(),'GETUTCDATE' --UTC aeg

--saab kontrollida, kas on õige andmetüüp
select isdate('asd')--tagastab 0 kuna stringi ei ole date
--kuidas saada vastuseks 1 isdate puhul

select ISDATE('5555')
select ISDATE(GETDATE())
select isdate('2024-05-10 13:45:00.0000000 -08:00333') 
--tagastab null kuna max kolm koma kohta võib olla
select ISDATe('2024-05-10 13:45:00') --tagastab ühe
select Day(Getdate()) --annab tänase päeva nr
select DAY('01/24/2026') --annab stringis oleva kuupäeva ja järisetus peab olema õige
select Month(Getdate()) --annab tänase kuu nr
select Month('01/24/2026')--annab stringis oleva kuu ja järisetus peab olema õige
select Year(Getdate()) --annab tänase aasta nr
select Year('01/24/2026')--annab stringis oleva aasta ja järisetus peab olema õige

select datename(day, '2024-05-10 13:45:00')-- annab stringis oleva päeva nr
select datename(WEEKDAY, '2024-05-10 13:45:00') -- annab stringis oleva nädala nr
select datename(MONTH, '2024-05-10 13:45:00')-- annab stringis oleva kuu nr

create table EmployeesWithDates
(
Id nvarchar(2),
	Name nvarchar(20),
	DateOfBirth datetime
)

insert into EmployeesWithDates (Id, Name, DateOfBirth)
values 

 (3, 'John','1985-08-22 12:03:36.370'),
 (4, 'Sara','1979-11-29 12:59:30.670')

 select  * from  EmployeesWithDates

 --kuidas võtta ühest veerust andmeid ja selle abil luua uued veerud

 --vaatab DoB veerust päeva ja kuvab päeva nimetuse sõnaga
 select Name, DateOfBirth, Datename(weekday, DateOfBirth) as [Day],
 --vaatab veerust kuupäevasid ja kuvab nr
 Month(DateOfBirth) as MonthNumber,
 --vaatab Dob veerust kuud ja kuvab sõnana
 DateNamE(MONTH, DateOfBirth) as [MonthName],
 --võtab Dob veerust aasta
 Year(DateOfBirth) as [Year]
 from EmployeesWithDates

 --kuvab 3 kuna USA nädal algab pühapäeval
 select Datepart(weekday, '2026-03-24 12:59:30.670')
 --tehke sama, aga kasutage kuu-d
 select Datepart(MONTH, '2026-03-24 12:59:30.670')
 --liidab stringis olevale kp 20 päeva juurde
 select Dateadd(day, 20, '2026-03-24 12:59:30.670')
 --lahutab 20 päeva
 select Dateadd(day, -20, '2026-03-24 12:59:30.670')
 --kuvab kahe stringis oleva kuudevahlelist aega nr-ga
 select Datediff(month,'11/20/2026','01/20/2024' )
 --tehke sama, agakasutage aastat
 select Datediff(YEAR,'11/20/2026','01/20/2000' )

 --Alguses uurite, mis on funktsioon MS SQL
 --MS SQL (Microsoft SQL Server) funktsioon on salvestatud andmebaasiobjekt, mis võtab sisendparameetreid, töötleb neid ja tagastab tulemuse (skalaarväärtuse või tabeli).
 --Miks seda vaja on
 --meamiselt SELECT lausetes, WHERE klauslites või JOIN operatsioonides andmete filtreerimiseks ja teisendamiseks.
 --pakkuda DB-s korduvkasutatud funktsionaalsust
 --Eelised: Võimaldavad keerulisi arvutusi teha otse andmebaasi tasemel, mis vähendab võrguliiklust ja suurendab töökiirust.
 --Puudused: madal jõudlus rida-haaval töötlemise tõttu ja piirangud päringute optimeerimisel

create function fnComputeAge(@DOB datetime)
returns nvarchar(50)
as begin
    declare @tempdate datetime, @years int, @months int, @days int
    select @tempdate = @DOB

    select @years = datediff(year, @tempdate, getdate()) - case when (month(@DOB) > month(getdate())) or (month(@DOB) = month(getdate()) and day(@DOB) > day(getdate()))
    then 1 else 0 end
    select @tempdate = dateadd(year, @Years, @tempdate)

    select @months = datediff(month, @tempdate, getdate()) - case when day(@DOB) > day(getdate())
    then 1 else 0 end
    select @tempdate = dateadd(MONTH, @months, @tempdate)

    select @days = datediff(day, @tempdate, getdate())

    declare @Age nvarchar(50)
    set @Age = cast(@years as nvarchar(4)) + ' Years ' + cast(@months as nvarchar(2))
    + ' Months ' + cast(@days as nvarchar(2)) + ' Days old '

    return @Age
end