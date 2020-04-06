use PetShopDB

select * from Breeds
-- Insert into table Breeds--
insert into Breeds([Name],Color)
values('Afador', 'Black'),
('Dalmatian', 'White-Black'),
('Karelian Bear Dog', 'Black'),
('Otterhound', 'Brown');

select * from Customers
-- Insert into table Customers --
insert into Customers(CCNP, FirstName, LastName, BirthDate, Country)
values('5006007001234', 'Magaleas', 'Vlad', '1990-12-20', 'Romania'),
('4435999000102', 'Vlah', 'Maria', '1981-01-05', 'Moldova'),
('1234987699100', 'Green', 'Harry', '1975-01-25', 'England'),
('2012202000432', 'Wood', 'Mary', '1972-10-20', 'England'),
('1155800910777', 'Ciornii', 'Aliona', '1976-03-05', 'Russia'),
('8887771234098', 'Pop', 'Ioan', '1989-03-31', 'Romania');

select * from Doctors
-- Insert into table Doctors --
insert into Doctors(DCNP, FirstName, LastName, BirthDate)
values('2013200087112', 'Vasiliev', 'Yuri', '1967-04-02'),
('2014954320123', 'Johnson', 'Andrew', '1987-12-27'),
('1111899920010', 'Coman', 'Ion', '1970-06-06');

select * from Owners
-- Insert into table Owners --
insert into Owners(OCNP, FirstName, LastName, BirthDate, Country)
values('2012123499643', 'Macovei', 'Denis', '1993-10-24', 'Moldova'),
('2012521388012', 'Ursu', 'Bianca', '1990-01-18', 'Romania'),
('9900123477001', 'Southgate', 'Alice', '1997-10-10', 'England'),
('7717001210443', 'Volkov', 'Oleg', '1981-07-10', 'Russia');

select * from Dogs
select OCNP from Owners
select DCNP from Doctors
select Bid,[Name] from Breeds
-- Insert into table Dogs --
insert into Dogs([Name], Age, Photo, OwnerCNP, DoctorCNP, BreedId)
values('Black', 1, 'https://www.petguide.com/wp-content/uploads/2017/03/afador.jpg', '3281038271292', '2012293394421', 5),
('Bim', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRzNnZYh4aQAxzL7eY9f35WNp9u-VLCXxx3cW9SmHBKefkvDIV', '3281038271292', '2012293394421', 6),
('Bars', 2, 'https://animals.net/wp-content/uploads/2019/03/Saint-Bernard-3-650x425.jpg', '3281948222294', '2013200087112', 3),
('Molly', 1, 'https://d17fnq9dkz9hgj.cloudfront.net/breed-uploads/2018/08/Otterhound-01.jpg?bust=1539030962&width=355', '7717001210443', '2012201355800', 8),
('Mella', 2, 'https://www.skk.se/globalassets/nku/filer/images/nordic-breeds/karelian_bear_dog_hres-3.jpg', '9900123477001', '2014954320123', 7),
('Balu', 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4hv6GgpTjYHJDRrbOGclzBCCWkp741SXf5QIJD8afjNR3wjXm', '9900123477001', '2014954320123', 2);

select * from Products
select * from Dogs
-- Insert into table Products --
insert into Products(DogId, Price)
values(8, 200.00),
(9,200.00),
(10,250.00),
(11,180.00),
(12,200.00),
(13,350.00);

select * from Orders
select * from Customers
-- Insert into table Orders --
insert into Orders(ProductId, CustomerCNP, OrderDate)
values(8, '1155800910777', '2019-10-22'),
(8, '2012202000432', '2019-10-17'),
(10, '8887771234098', '2019-10-10'),
(11, '8887771234098', '2019-10-10'),
(13, '5006007001234', '2019-09-30'),
(13, '8887771234098', '2019-10-20'),
(13, '2012202000432', '2019-10-13');

insert into Orders(ProductId, CustomerCNP, OrderDate)
values(13, '8887771234098', '2019-10-20');

select * from Eat
select * from Food
-- Insert into table Eat --
insert into Eat(DogId, FoodId, [Times/day], Quantity)
values(8, 5, 3, 1),
(9, 2, 2, 2),
(9, 6, 2, 2),
(10, 5, 2, 2),
(11, 3, 2, 2),
(12, 3, 3, 1),
(13, 5, 3, 1),
(13, 6, 2, 1);

-- Violate referencial integrity constraints --
insert into Orders(ProductId, CustomerCNP, OrderDate)
values(20, '1001002000134', '2019-10-20');

-- UPDATE --
update Customers
set Country = 'England'
where Country = 'London';

update Products
set Price = 400
where DogId = 2 or DogId = 13;

select * from Owners
update Owners
set Country = 'Republic of Moldova'
where Country = 'Moldova';

-- Foreign keys --
alter table Orders
add constraint FK_Orders_Products foreign key (ProductId) references Products(Pid)
on delete cascade
on update cascade;

alter table Orders
add constraint FK_Orders_Customers foreign key (CustomerCNP) references Customers(CCNP)
on delete cascade
on update cascade

alter table Products
add constraint FK_Product_Dog foreign key (DogId) references Dogs(Did)
on delete cascade
on update cascade

alter table Dogs
add constraint FK_Dogs_Owners foreign key (OwnerCNP) references Owners(OCNP)
on update cascade
on delete cascade;

alter table Dogs
add constraint FK_Dogs_Doctors foreign key (DoctorCNP) references Doctors(DCNP)
on update cascade
on delete set null;

alter table Dogs
add constraint FK_Dogs_Breeds foreign key (BreedId) references Breeds(Bid)
on update cascade
on delete cascade;

alter table Eat
add constraint FK_Eat_Dogs foreign key (DogId) references Dogs(Did)
on update cascade
on delete cascade;

alter table Eat
add constraint FK_Eat_Food foreign key (FoodId) references Food(Fid)
on update cascade
on delete set null;

alter table RejectedOrders
add constraint FK_RejOrders_Products foreign key (ProductId) references Products(Pid)
on update cascade
on delete cascade;

alter table RejectedOrders
add constraint FK_RejOrders_Customers foreign key (CustomerCNP) references Customers(CCNP)
on update cascade
on delete cascade;

-- Delete data --
select * from Orders
delete
from Orders
where ProductId in (13,14) and OrderDate = convert(varchar, '2019-10-20', 5);
select * from Dogs
select * from Food;
delete
from Food
where Name like '[P]%';

select * from Eat;

delete from Eat
where FoodId is null;

-- UNION Operation --
select FirstName, LastName, Country from Customers
where Country in ('Republic of Moldova', 'Romania')
union
select FirstName, LastName, Country
from Owners
where Country = 'Republic of Moldova' or Country = 'Romania';

select * from Orders
where OrderDate <= convert(varchar, '2019-10-10', 5)
union all
select * from RejectedOrders
where [Date] <= convert(varchar, '2019-10-10', 5) or ROid > 1;

-- Intersect statement --
select * from Owners
where Country in ('Republic of Moldova', 'Russia')
intersect
select * from Owners
where BirthDate <= convert(varchar, '1990-01-01', 5);

select * from Dogs
where [Name] like '____'
intersect
select * from Dogs
where Age in (1,2);

-- Except statement --
select * from Customers
where Country not in ('Russia', 'Ukraine')
except
select * from Customers
where BirthDate <= convert(varchar, '1990-01-01', 5);

select * from Dogs
where [Name] not in ('Volk', 'Bars')
except
select * from Dogs
where Age > 1;

-- Join queries --
select * from Eat;
select D.*
from Dogs D inner join Eat E on D.Did = E.DogId inner join Food F on E.FoodId = F.Fid
where F.[Name] = 'Milk';

select D.[Name], D.Age, D.Photo
from Dogs D left join Breeds B on D.BreedId = B.Bid
where B.[Name] like 'German%';

select D.[Name], D.Photo, P.Price
from Dogs D full join Products P on P.DogId = D.Did;

select O.*,D.Did,D.[Name], F.[Name]
from Orders O right join Products P on O.ProductId = P.Pid right join Dogs D on P.DogId = D.Did
right join Eat E on D.Did = E.DogId right join Food F on E.FoodId = F.Fid
where F.[Name] in ('Meat', 'Beef', 'Bones');

-- IN operator --
select D.Did,D.[Name], D.Photo
from Dogs D
where D.Did in
(
select E.DogId
from Eat E, Food F
where E.FoodId = F.Fid and F.[Name] = 'Granules'
)

select [Name], Photo, Age
from Dogs
where Did in
(
	select P.DogId
	from Orders O, Products P
	where O.ProductId = P.Pid and O.CustomerCNP in
	(
		select CCNP
		from Customers
		where Country in ('Republic of Moldova','Romania')
	)
)

-- Exist operator --
select D.[Name], D.Photo, D.Age
from Dogs D
where exists
(
	select E.*, F.*
	from Eat E, Food F
	where D.Did = E.DogId and E.FoodId = F.Fid and F.[Name] = 'Milk'
)

select C.FirstName, C.LastName, C.BirthDate
from Customers C
where exists
(
	select O.*
	from Orders O, Products P, Dogs D
	where O.CustomerCNP = C.CCNP and O.ProductId = P.Pid and P.DogId = D.Did and D.[Name] in ('Volk','Bars','Rex')
)

-- Subquery in FROM clause --
select D.[Name], D.Photo, T.[Q/day], T.[Name]
from Dogs D, 
(
select (E.Quantity*E.[Times/day]) as [Q/day], F.[Name], E.DogId as DogId
from Eat E, Food F
where E.FoodId = F.Fid
) T
where T.DogId = D.Did

select PeopleFromRussia.*
from
(
	select C.FirstName, C.LastName, C.Country 
	from Customers C
	where C.Country = 'Russia'
	union
	select O.FirstName, O.LastName, O.Country
	from Owners O
	where O.Country = 'Russia'

) PeopleFromRussia

-- Group by and Having queries --
select count(*) as [Number of dogs], B.[Name]
from Dogs D, Breeds B
where D.BreedId = B.Bid
group by B.[Name]
order by  [Number of dogs] desc;


select avg(P.Price), O.Country 
from Products P, Dogs D, Owners O
where P.DogId = D.Did and D.OwnerCNP = O.OCNP
group by O.Country
having 1 <
(
	select count(*)
	from Owners O2
	where O2.Country = O.Country
)

select sum(P.Price), Dr.FirstName, Dr.LastName
from Products P, Dogs D, Doctors Dr
where P.DogId = D.Did and D.DoctorCNP = Dr.DCNP
group by Dr.FirstName, Dr.LastName
having count(*)>1;

select count(*), D.Did
from Orders O, Products P, Dogs D
where O.ProductId = P.Pid and P.DogId = D.Did and D.Age = 1
group by D.Did
having 1 <
(
	select count(*) from Orders O2, Products P2, Dogs D2
	where O2.ProductId = P2.Pid and P2.DogId = D2.Did and D2.Did = D.Did
)



-- ANY and ALL subqueries --
select D.[Name], D.Photo, P.Price
from Dogs D, Products P
where P.DogId = D.Did and P.Price > all
(
	select avg(P2.Price)
	from Products P2, Dogs D2, Breeds B2
	where P2.DogId = D2.Did and D2.BreedId = B2.Bid
	group by B2.Bid
)

select D.[Name], D.Photo, P.Price  as [Price in Euro], (P.Price * 4.70) as [Price in RON] 
from Products P, Dogs D
where P.DogId = D.Did and P.Price = all
(
	select max(Price)
	from Products
)

select D.Did, D.[Name], (E.Quantity * E.[Times/day]) as [Q/Day], F.[Name]
from Dogs D, Eat E, Food F
where E.DogId = D.Did and E.FoodId = F.Fid and F.[Name] = 'Granules' and (E.Quantity * E.[Times/day]) > any
(
	select E2.Quantity * E2.[Times/day]
	from Dogs D2, Eat E2, Food F2
	where E2.DogId = D2.Did and E2.FoodId = F2.Fid and D2.BreedId = 1 and F2.[Name] = 'Granules'
)

select C.CCNP, C.FirstName, C.LastName, C.BirthDate, D.Did, D.[Name]
from Orders O, Customers C, Products P, Dogs D
where O.CustomerCNP = C.CCNP and O.ProductId = P.Pid and P.DogId = D.Did and C.BirthDate < any
(
select BirthDate
from Customers
where Country = 'Romania'
union
select BirthDate
from Owners
where Country = 'Romania'
)

-- Rewritten with aggregate operators --
select C.CCNP, C.FirstName, C.LastName, C.BirthDate, D.Did, D.[Name]
from Orders O, Customers C, Products P, Dogs D
where O.CustomerCNP = C.CCNP and O.ProductId = P.Pid and P.DogId = D.Did and C.BirthDate <
(
select max(T.BirthDate) from(
	select BirthDate
	from Customers
	where Country = 'Romania'
	union
	select BirthDate
	from Owners
	where Country = 'Romania'
) as T
)

select D.[Name], D.Photo, P.Price
from Dogs D, Products P
where P.DogId = D.Did and P.Price >
(
	select max(T.avgPrice)
	from 
	(
		select avg(P2.Price) as avgPrice
		from Products P2, Dogs D2, Breeds B2
		where P2.DogId = D2.Did and D2.BreedId = B2.Bid
		group by B2.Bid
	) T
)

-- Rewritten with IN operator --
select D.Did, D.[Name], (E.Quantity * E.[Times/day]) as [Q/Day], F.[Name]
from Dogs D, Eat E, Food F
where E.DogId = D.Did and E.FoodId = F.Fid and F.[Name] = 'Granules' and (E.Quantity * E.[Times/day]) not in
(
	select E2.Quantity * E2.[Times/day]
	from Dogs D2, Eat E2, Food F2
	where E2.DogId = D2.Did and E2.FoodId = F2.Fid and D2.BreedId = 1 and F2.[Name] = 'Granules'
	union
	select E3.Quantity * E3.[Times/day]
	from Dogs D3, Eat E3, Food F3
	where E3.DogId = D3.Did and E3.FoodId = F3.Fid and E3.Quantity * E3.[Times/day]<
	(
		select min(E4.Quantity * E4.[Times/day])
		from Dogs D4, Eat E4, Food F4
		where E4.DogId = D4.Did and E4.FoodId = F4.Fid and D4.BreedId = 1 and F4.Fid = 6
	)
)

select D.[Name], D.Photo, P.Price  as [Price in Euro], (P.Price * 4.70) as [Price in RON] 
from Products P, Dogs D
where P.DogId = D.Did and P.Price in
(
	select max(Price)
	from Products
)



