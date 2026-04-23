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

select Id, Name, DateOfBirth, dbo.fnComputeAge(DateOfBirth) as Age from EmployeesWithDates

--kui kasutame seda funktsiooni, siis saame teada tänase päeva stringis väljha tooduga
select dbo.fnComputeAge('02/24/2010') as Age

--nr peale DOB muutujat näitab, et mismoodi kuvada DOB-d
select Id, Name, DateOfBirth,
convert(nvarchar, DateOfBirth, 110) as ConvertedDOB
from EmployeesWithDates

select Id, Name, Name + ' - ' + cast(Id as nvarchar) as [Name-Id] from EmployeesWithDates

select CAST(getdate() as date) --tänane kp
--tänane kp, aga kasutate converti, et kuvada stringid
select CONVERT(date, GETDATE()) 

--matemaatilised funktsioonid
select ABS(-5) --absuluutväärtusega number ja tulemuseks saame ilma miinus märgita 5
select CEILING(4.2) --cealing ümardab ülesepoole
select CEILING(-4.2)
select floor(15.2)-- floor ümardab allapoole
select floor(-15.2)
select POWER(9, 2) -- ruudus, esimene on number teine on aste  
select SQUARE(9) --antud juhul 9 ruudus
select SQRT(16) --antud juhul 16 ruutjuur
select rand() --rand on funktsioon, mis genereerib juhusliku numbri vahemikus 0 kuni 1
--kuidas saada täisnumber iga kord
select floor(rand() * 100) --korrutab sajaga iga suvaise numbri

--iga kord näitab 10 suvalist numbrit
declare @counter int
set @counter = 1
while (@counter <= 10)
begin
print floor(rand() * 1000)
set @counter = @counter + 1
end

select ROUND(850.556, 2) --ümardab kaks  koma kohta ja tulemuseks on 850.56
select ROUND(850.556, 2, 1) -- ümardab kaks komakohta ja kui parameeter on 1, siis ümardb alla
select round(850.556, 1) -- ümardab ühe komakohaga ja tulemuseks saame 850.600
select round(850.556, 1, 1)-- ümardab ühe komakoha pealt alla
select round(850.556, -2) -- ümardab täisnr ülesepoole ja tulemuseks saame 900
select round(850.556, -1) --ümardab täisnumbri alla ja tulemus on 850


create function dbo.CalculateAge(@DOB date)
returns int
as begin 
declare @Age int
set @Age = DATEDIFF(year, @DOB, Getdate()) -
case
when (MONTH(@DOB) > MONTH(GETDATE())) or
(MONTH(@DOB) = MONTH(GETDATE()) and day(@DOB) > day(Getdate()))
then 1 else 0 end
return @Age
end
exec dbo.CalculateAge '1980-12-30'

--arvutab välja, kui vana on iskik ja võtab arvesse kuud ning päevad
--antud juhul näitab kõike, kes on üle 36 a vanad

select Id, Name, dbo.CalculateAge(DateOfBirth) as Age from EmployeesWithDates
where dbo.CalculateAge(DateOfBirth) > 36


--inline tabel valued functions
alter table EmployeesWithDates
add DepartmentId int 
alter table EmployeesWithDates
add Gender nvarchar(10) 

update EmployeesWithDates
set DepartmentId = 1
where Id = 1

update EmployeesWithDates
set DepartmentId = 2
where Id = 2

update EmployeesWithDates
set DepartmentId = 1
where Id = 3

update EmployeesWithDates
set DepartmentId = 3
where Id = 4

update EmployeesWithDates
set DepartmentId = 1
where Id = 5



update EmployeesWithDates
set Gender = 'Male'
where Id = 1

update EmployeesWithDates
set Gender = 'Female'
where Id = 2

update EmployeesWithDates
set Gender = 'Male'
where Id = 3

update EmployeesWithDates
set Gender = 'Female'
where Id = 4

update EmployeesWithDates
set Gender = 'Male'
where Id = 5

Insert into EmployeesWithDates (Id, Name, DateOfBirth)
Values (5, 'Todd', '1979-11-29 12:59:30.670')

select * from EmployeesWithDates

--scalar functio annb mingis vahemikus olevaid andmeid
--inline table values ei kasuta begin ja end funktsioone
--scalar annab väärtused ja inline annab tabeli

create function fn_EmployeesByGender(@Gender nvarchar(10))
returns table
as 
return (select Id, Name, DateOfBirth, DepartmentId, Gender
from EmployeesWithDates
where Gender = @Gender)

--kuidas leida kõik naised tabelis EmployeesWithDates ja kasutada funktsiooni fn_EmployeesByGender

SELECT * FROM dbo.fn_EmployeesByGender('Female')

--Tahaks ainult Pami nime näha


SELECT * FROM dbo.fn_EmployeesByGender('Female')
WHERE Name = 'Pam'

--kahest erinevast tabelist andmete võtmine ja koos kuvamine
--esimene on funktsioon ja teine tabel

select Name, Gender, DepartmentName
from fn_EmployeesByGender('Male') E
join Department D on D.Id = E.DepartmentId

--multi tabel statment
--inline funktsioon
create function fn_Employees()
returns table as
return (select Id, Name, cast(DateofBirth as date)
as DOB
from EmployeesWithDates)

select * from fn_Employees()

--multi-state puhul peab defineerima uue tabeli verrud koos muutujatega
--funktsiooni nimi on fn_MS_GetEmployees()
--peab edastama meile Id, Name, DOB tabelist EmployeesWithDates

CREATE FUNCTION fn_MS_GetEmployees()
RETURNS @Table TABLE (
    Id INT,
    Name NVARCHAR(20),
    DOB DATE
)
AS
BEGIN
    INSERT INTO @Table
    SELECT Id, Name, cast(DateOfBirth as date)
    FROM EmployeesWithDates
    RETURN
END



select * from fn_MS_GetEmployees()


--inline tabeli funktsioonid on paremad töötamas kuna käsitletakse vaatena
--multi puhul on pm tegemist stored procduriga ja kulub ressurssi rohkem

--muudame andmeid ja vaatame, kas inline funktsioonis on muutused kajastatud
update fn_Employees() set Name = 'Sam1' where Id = 1
select * from fn_Employees() --saab muta andmeid

update fn_MS_GetEmployees() set Name = 'Sam2' where Id = 1

--derministic vs non-derministic funktsioon
--determinic funktsioon annavad erineva tulemuse, kui sisend on sama
select count(*) from EmployeesWithDates
select SQUARE(4) 

--non-derministic funktsioon annavad  erineva tulemuse, kui on sama
select getdate()
select Current_Timestamp
select rand()

-- 1. GetAllCustomers_ITVF
CREATE FUNCTION GetAllCustomers_ITVF()
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        CustomerID,
        FirstName
    FROM SalesLT.Customer
)


select * from GetAllCustomers_ITVF()

-- 2. GetCustomerByID_ITV
Create function GetCustomerByID_ITV(@CustomerID int)
returns  table 
as return
(
select FirstName, LastName 
from SalesLT.Customer
where CustomerID = @CustomerID)


SELECT * FROM dbo.GetCustomerByID_ITV(1);

--3. GetOrdersByCustomer_ITVF
create function GetOrdersByCustomer_ITVF(@CustomerID int)
returns table
as returns
(
select CustomerId, ProductId,Name
from SalesLT.Product(71774) SalesLT.Customer
join SalesLT.Product  on SalesLT.Product.Id = SalesLT.Customer.ProductId
)


CREATE FUNCTION GetOrdersByCustomer_ITVF(@CustomerID int)
RETURNS TABLE
AS
RETURN 
(
    SELECT 
        SalesLT.Customer.FirstName,
        SalesLT.Customer.LastName,
        SalesLT.SalesOrderHeader.SalesOrderID,
        SalesLT.SalesOrderHeader.OrderDate,
        SalesLT.SalesOrderHeader.TotalDue
    FROM SalesLT.Customer
    JOIN SalesLT.SalesOrderHeader 
        ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
    WHERE SalesLT.Customer.CustomerID = @CustomerID
)

SELECT * FROM dbo.GetOrdersByCustomer_ITVF(29847)

--4. GetProductsByPrice_ITVF
create function GetProductsByPrice_ITVF(@MinPrice int, @MaxPrice int)
returns table
as return
(
SELECT 
        SalesLT.Product.ProductID,
        SalesLT.Product.Name,
        SalesLT.Product.ListPrice
    FROM SalesLT.Product
    WHERE SalesLT.Product.ListPrice >= @MinPrice 
      AND SalesLT.Product.ListPrice <= @MaxPrice
)
select * from GetProductsByPrice_ITVF(100,300)

--5 GetTopExpensiveProducts_ITVF
create function GetTopExpensiveProducts_ITVF()
returns table 
as return
(
select
top 10
SalesLT.Product.ProductID,
SalesLT.Product.Name,
SalesLT.Product.ListPrice
from SalesLT.Product
ORDER BY SalesLT.Product.ListPrice Desc
)


drop function GetTopExpensiveProducts_ITVF
select * from GetTopExpensiveProducts_ITVF()

--osa 2
CREATE FUNCTION GetTopExpensiveProducts_MSTVF()
RETURNS @TopProducts TABLE 
(
   
    ProductName NVARCHAR(50),
    ListPrice MONEY
)
AS
BEGIN
    INSERT INTO @TopProducts (ProductName, ListPrice)
    SELECT TOP 10 
        SalesLT.Product.Name, 
        SalesLT.Product.ListPrice
    FROM SalesLT.Product
    ORDER BY SalesLT.Product.ListPrice DESC;
    RETURN;
END

SELECT * FROM dbo.GetTopExpensiveProducts_MSTVF();

--6. GetCustomerFullInfo_MSTVF
CREATE FUNCTION GetCustomerFullInfo_MSTVF(@CustomerID INT)
RETURNS @Result TABLE 
(
    FullName NVARCHAR(200),
    EmailAddress NVARCHAR(50),
    Phone NVARCHAR(30)
)
AS
BEGIN
    INSERT INTO @Result
    SELECT 
        SalesLT.Customer.FirstName + ' ' + SalesLT.Customer.LastName,
        SalesLT.Customer.EmailAddress,
        SalesLT.Customer.Phone
    FROM SalesLT.Customer
    WHERE SalesLT.Customer.CustomerID = @CustomerID;

    RETURN;
END

SELECT * FROM dbo.GetCustomerFullInfo_MSTVF(29485)

--7. GetCustomerOrderSummary_MSTVF
CREATE FUNCTION GetCustomerOrderSummary_MSTVF(@CustomerID INT)
RETURNS @SummaryTable TABLE
(
    OrderCount INT,
    TotalSpent MONEY
)
AS
BEGIN
    INSERT INTO @SummaryTable
    SELECT 
        COUNT(SalesLT.SalesOrderHeader.SalesOrderID),
        SUM(SalesLT.SalesOrderHeader.TotalDue)
    FROM SalesLT.SalesOrderHeader
    WHERE SalesLT.SalesOrderHeader.CustomerID = @CustomerID;

    RETURN;
END

SELECT * FROM dbo.GetCustomerFullInfo_MSTVF(29485);

--8. GetProductPriceCategory_MSTVF
CREATE FUNCTION GetProductPriceCategory_MSTVF()
RETURNS @ProductCategoryTable TABLE
(
    ProductName NVARCHAR(50),
    ListPrice MONEY,
    PriceCategory NVARCHAR(20)
)
AS
BEGIN
    INSERT INTO @ProductCategoryTable
    SELECT 
        SalesLT.Product.Name,
        SalesLT.Product.ListPrice,
        CASE 
            WHEN SalesLT.Product.ListPrice < 100 THEN 'Odav'
            WHEN SalesLT.Product.ListPrice BETWEEN 100 AND 1000 THEN 'Keskmine'
            ELSE 'Kallis'
        END
    FROM SalesLT.Product;

    RETURN;
END

SELECT * FROM dbo.GetProductPriceCategory_MSTVF();

--9. GetCustomersWithOrders_MSTVF
CREATE FUNCTION GetCustomersWithOrders_MSTVF()
RETURNS @CustomerList TABLE
(
    CustomerID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50)
)
AS
BEGIN
    INSERT INTO @CustomerList
    SELECT DISTINCT
        SalesLT.Customer.CustomerID,
        SalesLT.Customer.FirstName,
        SalesLT.Customer.LastName
    FROM SalesLT.Customer
    JOIN SalesLT.SalesOrderHeader 
        ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID;

    RETURN;
END
SELECT * FROM dbo.GetCustomersWithOrders_MSTVF();

--10. GetTopCustomersBySpending_MSTVF
CREATE FUNCTION GetTopCustomersBySpending_MSTVF()
RETURNS @TopSpendingTable TABLE
(
    FullName NVARCHAR(200),
    TotalSpending MONEY
)
AS
BEGIN
    INSERT INTO @TopSpendingTable
    SELECT TOP 5
        SalesLT.Customer.FirstName + ' ' + SalesLT.Customer.LastName,
        SUM(SalesLT.SalesOrderHeader.TotalDue)
    FROM SalesLT.Customer
    JOIN SalesLT.SalesOrderHeader 
        ON SalesLT.Customer.CustomerID = SalesLT.SalesOrderHeader.CustomerID
    GROUP BY 
        SalesLT.Customer.FirstName, 
        SalesLT.Customer.LastName
    ORDER BY SUM(SalesLT.SalesOrderHeader.TotalDue) DESC;

    RETURN;
END
SELECT * FROM dbo.GetTopCustomersBySpending_MSTVF();

--loome funktsiooni
create function fn_GetNameById(@id int)
returns nvarchar(30)
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

---kasutame funktsiooni, leides Id 1 all oleva inimene
select dbo.fn_GetNameById(1)

select * from EmployeesWithDates

--saab näha funktsiooni sisu
sp_helptext fn_GetNameById

--nüüd muudate funktsiooni nimega fn_GetNameById
--ja panete sinna encryption, et keegi peale teie ei saaks sisu näha
alter function fn_GetNameById(@Id int)
returns nvarchar(30)
with encryption
as begin
	return (select Name from EmployeesWithDates where Id = @id)
end

--kui nüüd sp_helptexti kasutada, siis ei näe funktsiooni sisu
sp_helptext fn_GetNameById

--kasutame schemabindingut, et näha, mis on funktsiooni sisu
alter function dbo.fn_GetNameById(@Id int)
returns nvarchar(30)
with schemabinding
as begin
	return (select Name from dbo.EmployeesWithDates where Id = @id)
end
--schemabinding tähendab, et kui keegi üritab muuta EmployeesWithDates 
--tabelit, siis ei lase seda teha, kuna see on seotud 
--fn_GetNameById funktsiooniga

--ei saa kustutada ega muuta tabelit EmployeesWithDates, 
--kuna see on seotud fn_GetNameById funktsiooniga
drop table dbo.EmployeesWithDates


---temporary tables
--see on olemas ainult selle sessiooni jooksul
--kasutatakse # sümbolit, et saada aru, et tegemist on temporary tabeliga
create table #PersonDetails (Id int, Name nvarchar(20))

insert into #PersonDetails values (1, 'Sam')
insert into #PersonDetails values (2, 'Pam')
insert into #PersonDetails values (3, 'John')

select * from #PersonDetails

--temporary tabelite nimekirja ei näe, kui kasutada sysobjects 
--tabelit, kuna need on ajutised
select Name from sysobjects
where name like '#PersonDetails%'

--kustutame temporary tabeli
drop table #PersonDetails

--loome sp, mis loob temporary tabeli ja paneb sinna andmed
create proc spCreateLocalTempTable
as begin
create table #PersonDetails (Id int, Name nvarchar(20))

insert into #PersonDetails values (1, 'Sam')
insert into #PersonDetails values (2, 'Pam')
insert into #PersonDetails values (3, 'John')

select * from #PersonDetails
end
---
exec spCreateLocalTempTable

--globaalne temp tabel on olemas kogu 
--serveris ja kõigile kasutajatele, kes on ühendatud
create table ##GlobalPersonDetails (Id int, Name nvarchar(20))

--index
create table EmployeeWithSalary
(
	Id int primary key,
	Name nvarchar(20),
	Salary int,
	Gender nvarchar(10)
)

insert into EmployeeWithSalary values(1, 'Sam', 2500, 'Male')
insert into EmployeeWithSalary values(2, 'Pam', 6500, 'Female')
insert into EmployeeWithSalary values(3, 'John', 4500, 'Male')
insert into EmployeeWithSalary values(4, 'Sara', 5500, 'Female')
insert into EmployeeWithSalary values(5, 'Todd', 3100, 'Male')

select * from EmployeeWithSalary

--otsime inimesi, kelle palgavahemik on 5000 kuni 7000
select * from EmployeeWithSalary
where Salary between 5000 and 7000

--loome indeksi Salary veerule, et kiirendada otsingut
--mis asetab andmed Salary veeru järgi järjestatult
create index IX_EmployeeSalary 
on EmployeeWithSalary(Salary asc)

--saame teada, et mis on selle tabeli primaarvõti ja index
exec sys.sp_helpindex @objname = 'EmployeeWithSalary'

--tahaks IX_EmployeeSalary indeksi kasutada, et otsing oleks kiirem
select * from EmployeeWithSalary
where Salary between 5000 and 7000

--näitab, et kasutatakse indeksi IX_EmployeeSalary, 
--kuna see on järjestatud Salary veeru järgi
select * from EmployeeWithSalary with (index(IX_EmployeeSalary))

--indeksi kustutamine
drop index IX_EmployeeSalary on EmployeeWithSalary --1 variant
drop index EmployeeWithSalary.IX_EmployeeSalary --2 variant

---- indeksi tüübid:
--1. Klastrites olevad
--2. Mitte-klastris olevad
--3. Unikaalsed
--4. Filtreeritud
--5. XML
--6. Täistekst
--7. Ruumiline
--8. Veerusäilitav
--9. Veergude indeksid
--10. Välja arvatud veergudega indeksid

-- klastris olev indeks määrab ära tabelis oleva füüsilise järjestuse 
-- ja selle tulemusel saab tabelis olla ainult üks klastris olev indeks

create table EmployeeCity
(
	Id int primary key,
	Name nvarchar(20),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeCity

-- andmete õige järjestuse loovad klastris olevad indeksid 
-- ja kasutab selleks Id nr-t
-- põhjus, miks antud juhul kasutab Id-d, tuleneb primaarvõtmest
insert into EmployeeCity values(3, 'John', 4500, 'Male', 'New York')
insert into EmployeeCity values(1, 'Sam', 2500, 'Male', 'London')
insert into EmployeeCity values(4, 'Sara', 5500, 'Female', 'Tokyo')
insert into EmployeeCity values(5, 'Todd', 3100, 'Male', 'Toronto')
insert into EmployeeCity values(2, 'Pam', 6500, 'Male', 'Sydney')

-- klastris olevad indeksid dikteerivad säilitatud andmete järjestuse tabelis 
-- ja seda saab klastrite puhul olla ainult üks

select * from EmployeeCity
create clustered index IX_EmployeeCityName
on EmployeeCity(Name)
--põhjus, miks ei saa luua klastris olevat 
--indeksit Name veerule, on see, et tabelis on juba klastris 
--olev indeks Id veerul, kuna see on primaarvõti

--loome composite indeksi, mis tähendab, et see on mitme veeru indeks
--enne tuleb kustutada klastris olev indeks, kuna composite indeks 
--on klastris olev indeksi tüüp
create clustered index IX_EmployeeGenderSalary
on EmployeeCity(Gender desc, Salary asc)
-- kui teed select päringu sellele tabelile, siis peaksid nägema andmeid, 
-- mis on järjestatud selliselt: Esimeseks võetakse aluseks Gender veerg 
-- kahanevas järjestuses ja siis Salary veerg tõusvas järjestuses

select * from EmployeeCity

--mitte klastris olev indeks on eraldi struktuur, 
--mis hoiab indeksi veeru väärtusi
create nonclustered index IX_EmployeeCityName
on EmployeeCity(Name)
--kui nüüd teed select päringu, siis näed, et andmed on 
--järjestatud Id veeru järgi
select * from EmployeeCity

--- erinevused kahe indeksi vahel
--- 1. ainult üks klastris olev indeks saab olla tabeli peale, 
--- mitte-klastris olevaid indekseid saab olla mitu
--- 2. klastris olevad indeksid on kiiremad kuna indeks peab tagasi 
--- viitama tabelile juhul, kui selekteeritud veerg ei ole olemas indeksis
--- 3. Klastris olev indeks määratleb ära tabeli ridade slavestusjärjestuse
--- ja ei nõua kettal lisa ruumi. Samas mitte klastris olevad indeksid on 
--- salvestatud tabelist eraldi ja nõuab lisa ruumi

create table EmployeeFirstName
(
	Id int primary key,
	FirstName nvarchar(20),
	LastName nvarchar(20),
	Salary int,
	Gender nvarchar(10),
	City nvarchar(50)
)

exec sp_helpindex EmployeeFirstName

insert into EmployeeFirstName values(1, 'John', 'Smith', 4500, 'Male', 'New York')
insert into EmployeeFirstName values(1, 'Mike', 'Sandoz', 2500, 'Male', 'London')

drop index EmployeeFirstName.PK__Employee__3214EC07EFD14A37
--- kui käivitad ülevalpool oleva koodi, siis tuleb veateade
--- et SQL server kasutab UNIQUE indeksit jõustamaks väärtuste 
--- unikaalsust ja primaarvõtit koodiga Unikaalseid Indekseid 
--- ei saa kustutada, aga käsitsi saab

create unique nonclustered index UIX_Employee_FirstName_LastName
on EmployeeFirstName(FirstName, LastName)

--lisame uue piirnagu peale
alter table EmployeeFirstName
add constraint UQ_EmployeeFirstNameCity
unique nonclustered (City)

--sisestage kolmas rida andmetega, mis on id-s 3, FirstName-s John, 
--LastName-s Menco ja linn on London
insert into EmployeeFirstName values(3, 'John', 'Menco', 3500, 'Male', 'London')

--saab vaadata indeksite infot
exec sp_helpconstraint EmployeeFirstName

-- 1.Vaikimisi primaarvõti loob unikaalse klastris oleva indeksi, 
-- samas unikaalne piirang loob unikaalse mitte-klastris oleva indeksi
-- 2. Unikaalset indeksit või piirangut ei saa luua olemasolevasse tabelisse, 
-- kui tabel juba sisaldab väärtusi võtmeveerus
-- 3. Vaikimisi korduvaid väärtuseid ei ole veerus lubatud,
-- kui peaks olema unikaalne indeks või piirang. Nt, kui tahad sisestada 
-- 10 rida andmeid, millest 5 sisaldavad korduviad andmeid, 
-- siis kõik 10 lükatakse tagasi. Kui soovin ainult 5
-- rea tagasi lükkamist ja ülejäänud 5 rea sisestamist, siis selleks 
-- kasutatakse IGNORE_DUP_KEY

--näide
create unique index IX_EmployeeFirstName
on EmployeeFirstName(City)
with ignore_dup_key

insert into EmployeeFirstName values(5, 'John', 'Menco', 3512, 'Male', 'London1')
insert into EmployeeFirstName values(6, 'John', 'Menco', 3123, 'Male', 'London2')
insert into EmployeeFirstName values(6, 'John', 'Menco', 3220, 'Male', 'London2')
--- enne ignore käsku oleks kõik kolm rida tagasi lükatud, aga
--- nüüd läks keskmine rida läbi kuna linna nimi oli unikaalne
select * from EmployeeFirstName

--view on virtuaalne tabel, mis on loodud ühe või mitme tabeli põhjal
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId

create view vw_EmployeesByDetails
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId
--otsige ülesse view

--kuidas view-d kasutada: vw_EmployeesByDetails
select * from vw_EmployeesByDetails
-- view ei salvesta andmeid vaikimisi
-- seda tasub võtta, kui salvestatud virtuaalse tabelina

-- milleks vaja:
-- saab kasutada andmebaasi skeemi keerukuse lihtsutamiseks,
-- mitte IT-inimesele
-- piiratud ligipääs andmetele, ei näe kõiki veerge

--teeme view, kus näeb ainult IT-töötajaid
create view vITEmployeesInDepartment
as
select FirstName, Salary, Gender, DepartmentName
from Employees
join Department
on Department.Id = Employees.DepartmentId
where Department.DepartmentName = 'IT'
-- ülevalpool olevat päringut saab liigitada reataseme turvalisuse 
-- alla. Tahan ainult näidata IT osakonna töötajaid

select * from vITEmployeesInDepartment

--veeru taseme turvalisus
-- peale selecti määratled veergude näitamise ära
create view vEmployeesInDepartmentSalaryNoShow
as
select FirstName, Gender, DepartmentName
from Employees
join Department
on Employees.DepartmentId = Department.Id

select * from vEmployeesInDepartmentSalaryNoShow

--saab kasutada esitamaks koondandmeid ja üksikasjalike andmeid
--view, mis tagastab sumeeritud andmeid

create view vEmployeesCountByDepartment
as
select DepartmentName, count(Employees.Id) as TotalEmployees
from Employees
join Department
on Employees.DepartmentId = Department.Id
group by DepartmentName

select * from vEmployeesCountByDepartment

--kui soovid vaadata view sisu
sp_helptext vEmployeesCountByDepartment
--kui soovid muuta, siis kastad alter view

--kuisoovid kustutada, siis kasutada drop view
drop view vEmployeesCountByDepartment
--andmete uuendamine läbi view
create view vEmployeesDataExceptSalary
as
select Id, FirstName, Gender, DepartmentId
from Employees

update vEmployeesDataExceptSalary
set [FirstName] = 'Pam' where Id = 2

--kustutage Id 2 rida ära
DELETE FROM vEmployeesDataExceptSalary 
WHERE Id = 2

select * from Employees

--andmete sisestamine läbi view
--Id 2, Female, osakond 2, Pam

insert into vEmployeesDataExceptSalary (Id, FirstName, Gender, DepartmentId)
values (2, 'Pam','Female', 2)

--indekseeritud view 
--MS SQL-s on indekseeritud view nime all ja 
--Oracles materjaliseeritud view nimega

Create table Product
(
Id int primary key,
Name nvarchar(20),
UnitPrice int
)

Insert into Product (Id, Name, UnitPrice)
Values(1, 'Books', 20),
(2, 'Pens', 14),
(3, 'Pencils', 11),
(4, 'Clips', 10)

select * from Product

Create table ProductSales
(
Id int,
QuanitySold int,
)

insert into ProductSales (Id, QuanitySold)
values(1, 10),
(3, 23),
(4, 21),
(2, 12),
(1, 13),
(3, 12),
(4, 13),
(1, 11),
(2, 12),
(1, 14)

select * from ProductSales

--loome view, mis annab meile veerud TotalSales ja TotalTransaction
create view vTotalSalesByProduct
with schemabinding
as
select Name,
sum(isnull((QuanitySold * UnitPrice), 0)) as TotalSales,
count_big(*) as TotalTransaction
from dbo.ProductSales
join dbo.Product
on dbo.Product.Id = dbo.ProductSales.Id
group by Name

select * from vTotalSalesByProduct

--- kui soovid luua indeksi view sisse, siis peab järgima teatud reegleid
-- 1. view tuleb luua koos schemabinding-ga
-- 2. kui lisafunktsioon select list viitab väljendile ja selle tulemuseks
-- võib olla NULL, siis asendusväärtus peaks olema täpsustatud.
-- Antud juhul kasutasime ISNULL funktsiooni asendamaks NULL väärtust
-- 3. kui GroupBy on täpsustatud, siis view select list peab
-- sisaldama COUNT_BIG(*) väljendit
-- 4. Baastabelis peaksid view-d olema viidatud kahesosalie nimega
-- e antud juhul dbo.Product ja dbo.ProductSales.

create unique clustered index UIX_vTotalSalesByProtuct_Name
on vTotalSalesByProduct(Name)

select * from vTotalSalesByProduct

--view pirangud create view vEmployeeDetails
create view vEmployeeDetails
@Gender nvarchar(20)
as 
Select Id, FirstName, Gender, DepartmentId
from Employees
where Gender = @Gender
--mis on selles views valesti
--vaatesse ei saa kaasa panna parameetreid ehk siis antud juhul Gender
create view vEmployeeDetails
as 
Select Id, FirstName, Gender, DepartmentId
from Employees
go

SELECT * FROM vEmployeeDetails WHERE Gender = 'Male'


--teha funktsioon kus parameetriks on Gender 
--sooviks näha veerge: Id, FirstName, Gender, DepartmentId
 create function fnEmployeesDetails
 (
    @Gender nvarchar(20)
 )
 RETURNS TABLE
AS
RETURN
select Id, FirstName, Gender, DepartmentId
FROM Employees
WHERE Gender = @Gender

--kasutame funktsiooni koos parameetriga
select * from dbo.fnEmployeesDetails('Female')

--order by kasutamine 
create view vEmployeeDetailsStored
as
select Id, FirstName, Gender, DepartmnetId
from Emloyees 
order by Id
--ORFER BY-D ei saa kasutada

--temp tabeli kasutamine
create table ##TestTempTable(Id int, FirstName Nvarchar(20), Gender Nvarchar(20))

insert into ##TestTempTable values(101, 'Mark', 'Male')
insert into ##TestTempTable values(102, 'Joe', 'Female')
insert into ##TestTempTable values(103, 'Pam', 'Female')
insert into ##TestTempTable values(104, 'James', 'Male')

--view nimi on vOnTempTable
--kasutame ##TestTempTable
create view vOnTempTable
as
select Id, FirstName, Gender
from  ##TestTempTable
--view-id ja funktsioone ei saa teha ajutisetele tabelitele

--Triggerid

--DML trigger
--kokku kolme tüüpi: DML, DDL, ja LOGON

--- trigger on stored procedure eriliik, mis automaatselt käivitub,
--- kui mingi tegevus
--- peaks andmebaasis aset leidma

--- DML - data manipulation language
--- DML-i põhilised käsklused: insert, update ja delete

--DML triggereid saab klassiftseerida kahte tüüpi:
--1. After trigger (kutsutakse ka FOR triggeriks)
--2. Insert of trigger (selemt trigger e selle asemel trigger)

--after trigger käivitub peale sündmust, kui kuskil on tehtud insert
--update ja delete

create table EmployeeAudit
(
Id int identity(1, 1) primary key,
AuditData nvarchar(1000)
)

--peale igat töötaja sisestamist tahme teada saada töötaja Id-d
--päeva ning aega
--kõik andmed tulevad EmployeeAudit tabelisse
--andmed sisestame Employees tabelisse

create trigger trEmployeeForInsert
on Employees 
for insert 
as begin 
declare @Id int
select @Id = Id from inserted 
insert into EmployeeAudit
values ('New employee with Id = ' + cast(@Id as nvarchar(5)) + ' is added at '
+ cast(getdate() as nvarchar(20)))
end

select * from Employees

insert into Employees Values 
(11, 'Bob', 'Blob', 'Bomb', 'Male', 3000, 1, 3, 'bob@bob.com')
go 
select * from EmployeeAudit

--delete trigger 
DELETE 
as begin 
declare @Id int
select @Id = Id from deleted 

CREATE TRIGGER tr_EmployeeAudit_Delete
ON Employees
FOR DELETE
AS
BEGIN
    DECLARE @Id int
    SELECT @Id = Id FROM deleted
    INSERT INTO EmployeeAudit
    VALUES('An existing employee with Id = ' + CAST(@Id as nvarchar(5)) +
    ' is deleted at ' + CAST(GETDATE() as nvarchar(20)))
END


DELETE from Employees where Id = 11
SELECT * from EmployeeAudit

--update trigger
CREATE TRIGGER trEmployeeforupdate
ON Employees
FOR update
AS
BEGIN
--muutujate deklareerimine
declare @Id int 
declare @OldGender nvarchar(20), @NewGender nvarchar(20)
declare @OldSalary int, @NewSalary int
declare @OldDepartmentId int, @NewDepartmentId int
declare @OldManagerId int, @NewManagerId int
declare @OldFirstName nvarchar(20), @NewFirstName nvarchar(20)
declare @OldMiddelName nvarchar(20), @NewMiddelName nvarchar(20)
declare @OldLastName nvarchar(20), @NewLastName nvarchar(20)
declare @OldEamil nvarchar(50), @NewEmail nvarchar(50)

--muutuja, kuhu läheb lõpptekst
declare @AuditString nvarchar(1000)

--laeb kõik uuendarud andmed temp tabli alla
select * from ##TestTable
from inserted

--käin läbi kõik andmed temp tabelis
while(exists(select Id from ##TestTable))
begin
set @AuditString = ''
-- selekteerib esimese rea andmed temp tabelist 
select top 1 @Id = Id, @NewGender = Gender, 
@NewSalary = Salary, @NewDepartmentId = DepartmentId,
@NewManagerId = ManagerId, @NewFirstName = FirstName,
@NewMiddelName = MiddelName, @NewLastName = LastName,
@NewEmail = Email
from #TempTable
--võtab vanad anndmed kustutatud tabeist
select @OldGender = Gender,
@OldSalary = Salary, @OldDepartmentId = DepartmentId,
@OldManagerId = ManagerId, @OldFirstName = FirstName,
@OldMiddelName = MiddelName, @OldLastName = LastName,
@OldEmail = Email
from deleted where Id = @Id




