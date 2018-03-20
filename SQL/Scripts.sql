create database TransactionsDB
go

use TransactionsDB
go

create table InternetOrders (
	OrderId int identity primary key,
	OrderDate datetime,
	Customer int,
	Product int,
	Address nvarchar(50),
	Units int,
	Amount int
)
go

set nocount on;
set transaction isolation level read uncommitted;
declare @counter int = 1;

while(@counter <= 10000)
begin
	declare @orderDate datetime = dateadd(day, (rand() * (365-1)+1), getdate());
	declare @customer int = rand() * (100-1) + 1;
	declare @product int = rand() * (100-1) + 1;
	declare @address nvarchar(50) = 'Bangalore';
	declare @units int = rand() * (100-50) + 50;
	declare @amount int = rand () * (1000 - 500) + 500;

	insert into InternetOrders values
		( @orderDate, @customer, @product, @address, @units, @amount);
	set @counter += 1;
end;
go 10

select count(*) from InternetOrders;
go