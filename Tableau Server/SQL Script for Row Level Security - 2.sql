create database GSTrainingDB
go

use GSTrainingDB
go

create table Orders (
	OrderId int identity primary key,
	OrderDate datetime default getdate(),
	CustomerId int,
	Store nvarchar(50),
	Units int,
	Amount int
)


insert into Orders values
	( getdate(), 1, 'Store 11', 10, 1000 ),
	( getdate(), 1, 'Store 11', 20, 2000 ),
	( getdate(), 2, 'Store 11', 30, 3000 ),
	( getdate(), 3, 'Store 11', 40, 4000 ),
	( getdate(), 2, 'Store 12', 50, 5000 ),
	( getdate(), 3, 'Store 13', 60, 6000 ),
	( getdate(), 2, 'Store 11', 10, 7000 ),
	( getdate(), 2, 'Store 11', 10, 8000 ),
	( getdate(), 1, 'Store 12', 20, 9000 ),
	( getdate(), 2, 'Store 12', 20, 1100 ),
	( getdate(), 4, 'Store 12', 30, 1200 ),
	( getdate(), 4, 'Store 11', 40, 1300 ),
	( getdate(), 1, 'Store 11', 50, 1400 ),
	( getdate(), 2, 'Store 12', 60, 1500 ),
	( getdate(), 3, 'Store 12', 10, 1600 );

select * from Orders;
go

create table StoreManagers (
	RecordId int identity primary key,
	StoreName nvarchar(50),
	ManagerUser nvarchar(100)
)

insert into StoreManagers values
	( 'Store 11', 'administrator' ),
	( 'Store 12', 'administrator' ),
	( 'Store 13', 'administrator' ),
	( 'Store 11', 'gsuser1' ),
	( 'Store 12', 'gsuser1' ),
	( 'Store 11', 'gsuser2' ),
	( 'Store 12', 'gsuser3' ),
	( 'Store 13', 'gsuser3' );

select * from StoreManagers;


select sum(amount) from orders;

select t.StoreName,
    STUFF((
        select ',' + ManagerUser
        from StoreManagers t1
        where t1.StoreName = t.StoreName
        for xml path(''), type
    ).value('.', 'varchar(max)'), 1, 1, '') [values]
from StoreManagers t
group by StoreName