use Lab5

create table Ta(
	aid int primary key identity(1,1),
	a2 int unique 
);

create table Tb(
	bid int primary key identity(1,1),
	b2 int
);

create table Tc(
	cid int primary key identity(1,1),
	aid int foreign key references Ta(aid),
	bid int foreign key references Tb(bid)
);

drop table Ta;
drop table Tb;
drop table Tc;

insert into Ta values
(1),(2),(4),(10),(9),(8),(3),(5),(7),(6);

insert into Tb values
(101),(102),(104),(110),(109),(108),(103),(105),(107),(106);

declare @i int = 0;
while @i < 15
begin
	declare @a int = (select top 1 aid from Ta order by newid());
	declare @b int = (select top 1 bid from Tb order by newid());
	insert into Tc(aid,bid) values(@a, @b);
	set @i = @i + 1;
end;


-- point A --
-- clustered index scan--
select aid,Description from Ta;

--clustered index seek--
select * from Ta where aid > 4;

--nonclustered index scan--
select a2 from Ta;

--nonclustered index seek--
select a2 from Ta where a2 < 5;

--key lookup--
select * from Ta
where a2 = 3
with (index(UQ__Ta__3213A9FAFFB80C70));

--Point B--
select b2,Description from Tb
where b2 = 2;
--0.0032952--

create nonclustered index idx_b2 on Tb(b2) include(Description);
create nonclustered index idx_c_ab on Tc(cid,aid,bid);

select b2,Description from Tb
where b2 = 2
--0.0032842--

--point C--
create view vABC
as
select c.cid, a.a2, b.b2
from Ta a inner join Tc c on a.aid = c.aid inner join Tb b on b.bid = c.cid 
where b.b2 > 3;

select * from vABC;




