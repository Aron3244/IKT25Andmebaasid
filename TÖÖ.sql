
 select count (*) from SalesLT.Customer
 
select count_big(*) as TotalTransaction from SalesLT.SalesOrderHeader

select Max(Totaldue) as MaxOrder from SalesLT.SalesOrderHeader

select Min(Totaldue) as MinOrder from SalesLT.SalesOrderHeader

select Sum(Totaldue) from SalesLT.SalesOrderHeader

select count (*) from


  select count (ListPrice)
  from SalesLT.Product
  where ListPrice > 100

  select Max(ListPrice) as MaxOrder from SalesLT.Product
  where ListPrice < 1000


    select Min(ListPrice) as MaxOrder from SalesLT.Product
  where ListPrice > 0

  select Sum(ListPrice) from SalesLT.Product
  where  Color is not NULL

  select count(ModifiedDate) from SalesLT.Customer
  where ModifiedDate < isdate('2010-00-00 13:45:00.0000000 -08:00333') 

    select Min(ModifiedDate) from SalesLT.Customer
	where ModifiedDate > isdate('2008-01-01 13:45:00.0000000 -08:00333') 

	select sum(TotalDue) from SalesLT.SalesOrderHeader
	group by CustomerId

	select Status
	from SalesLT.SalesOrderHeader
	inner join SalesLT.Customer 
	on SalesOrderHeader.CustomerID = SalesOrderHeader.CustomerID
	