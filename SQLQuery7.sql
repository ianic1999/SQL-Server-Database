--- Create Views ---
--- View on 1 table ---
create view vRejOrders
as
select * from RejectedOrders
go

-- View on 2 tables --
create view vDogsPrice
as
select D.[Name], P.Price 
from Products P inner join Dogs D on P.DogId = D.Did
go


-- View with Group By statement --
create view vMaxPricePerBreed
as
select B.[Name], max(P.Price) as MaxPrice
from Products P inner join Dogs D on P.DogId = D.Did inner join Breeds B on D.BreedId = B.Bid
group by B.[Name]
go

create trigger onDogInsert
on Dogs
after insert
as
	insert into Products
	select I.Did, 100
	from inserted I
go

create trigger onDogDelete
on Dogs
after delete
as
	delete from Products
	where DogId in
	(
		select D.Did
		from deleted D
	)
go

drop trigger onDogDelete




