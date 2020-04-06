insert into Customers (CCNP,FirstName,LastName,BirthDate,Country)
values('2002002001111', 'Luca', 'Ion', '12/05/1975', 'Romania')

insert into Customers (CCNP,FirstName,LastName,BirthDate,Country)
values('2002002009832', 'Frunza', 'Vasile', '05/02/1990', 'Moldova')

insert into Customers (CCNP,FirstName,LastName,BirthDate,Country)
values('2002002031921', 'Byron', 'John', '1993-08-30', 'London')

insert into Customers (CCNP,FirstName,LastName,BirthDate,Country)
values('2202042034990', 'Yavorski', 'Yana', '1996-11-03', 'Russia')
use PetShopDB
select * from Customers

insert into Doctors (DCNP,FirstName,LastName,BirthDate)
values('2012201399444', 'Lupasco', 'Eugen', '1970-02-07')

insert into Doctors (DCNP,FirstName,LastName,BirthDate)
values('2012293394421', 'Visca', 'Vasile', '1973-08-08')

insert into Doctors (DCNP,FirstName,LastName,BirthDate)
values('2012201355800', 'Marian', 'Emilia', '1979-10-03')

select * from Doctors

insert into Breeds([Name],Color)
values('German Shepherd','Black-Brown')

insert into Breeds([Name],Color)
values('Chow Chow','Brown')
insert into Breeds([Name],Color)
values('Saint Bernard','White-Brown-Black')
insert into Breeds([Name],Color)
values('Entleburcher','Black-White')

select * from Breeds

insert into Owners(OCNP,FirstName,LastName,BirthDate,Country)
values('3004327842300','Buzau','Ioan','1977-04-04', 'Romania')
insert into Owners(OCNP,FirstName,LastName,BirthDate,Country)
values('2104399842823','Ciobanu','Cristina','1988-12-04', 'Moldova')
insert into Owners(OCNP,FirstName,LastName,BirthDate,Country)
values('2004300842321','Vadu','Vergiliu','1992-10-01', 'Romania')
insert into Owners(OCNP,FirstName,LastName,BirthDate,Country)
values('3281038271292','Moroz','Victorya','1982-07-15', 'Russia'),
('3281948222294','Lennon','Mike','1996-01-20', 'England')

select * from Owners
insert into Dogs([Name],Age,Photo,OwnerCNP,DoctorCNP,BreedId)
values('Rex',2,'https://zveri.guru/images/233453/nemetskaya-ovcharka.jpg','3004327842300','2012293394421',1),
('Marta',1,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQd-etPOksRVeP8JKXj1Pwu_oi92iKs67gS9fE4ImDyHyqUlfw2','3004327842300','2012293394421',1),
('Tarzan',1,'https://www.zooplus.co.uk/magazine/wp-content/uploads/2018/07/gelb-chow-chow-768x510.jpg','3004327842300','2012201355800',2)

select * from Dogs
select * from Owners
select * from Doctors

insert into Dogs([Name],Age,Photo,OwnerCNP,DoctorCNP,BreedId)
values('Bob',2,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZyaX8Hi4VDPLnN_LItLkGrI-Prv88s9XvNfm-2G0reNb6ySUm','2004300842321','2012201399444',1),
('Volk',1,'https://www.veterinarka.ru/images/0001articles/breeds/dogs/v/veo.jpg','2104399842823','2012293394421',1),
('King',2,'https://animals.net/wp-content/uploads/2019/03/Saint-Bernard-6-650x425.jpg','3281948222294','2012201399444',3)

insert into Products(DogId,Price)
values(1,100.00),
(2,85.00),
(3,150.00),
(4,120.00),
(5,75.00),
(6,300.00)

select * from Customers

insert into Orders(ProductId,CustomerCNP,OrderDate)
values(1,'2002002001111','2019-09-09'),
(2,'2002002001111','2019-09-09'),
(1,'2002002009832','2019-09-12'),
(4,'2002002009832','2019-09-12'),
(6,'2202042034990','2019-09-03'),
(6,'2002002031921','2019-10-03'),
(5,'2002002031921','2019-10-03')

insert into Food([Name])
values('Bones'),
('Meat'),
('Pork'),
('Beef'),
('Milk'),
('Granules')

use PetShopDB
select * from Food

insert into Eat(DogId,FoodId,[Times/day],Quantity)
values(1,1,2,2),
(1,2,2,0.5),
(2,1,3,2),
(3,5,3,1),
(3,6,2,0.75),
(4,3,2,1),
(5,3,2,1.5),
(5,6,2,1),
(6,6,3,1),
(6,5,3,1)

select * from Eat
select * from Customers

insert into RejectedOrders(ProductId,CustomerCNP,[Date])
values(1,'2002002009832','2019-09-15'),
(5,'2002002001111','2019-10-01')

use PetShopDB

select * from Products
select * from Dogs
