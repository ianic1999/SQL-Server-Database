-- Procedures --
-- Procedure to test View 1 --
create procedure testView1 @TestRunId int
as
begin
	declare @startAt datetime;
	declare @endAt datetime;
	set @startAt = GETDATE();
	select * from vOrders;
	set @endAt = GETDATE();
	--- Insert into TestRunViews ---
	insert into TestRunViews
	values(@TestRunId, 1, @startAt, @endAt);
end
go

--- Procedure to test View 2 ---
create procedure testView2 @TestRunId int
as
begin
	declare @startAt datetime;
	declare @endAt datetime;
	set @startAt = GETDATE();
	select * from vDogsPrice;
	set @endAt = GETDATE();
	--- insert into TestRunViews ---
	insert into TestRunViews
	values(@TestRunId, 2, @startAt, @endAt);
end
go

--- Procedure to test View 3 ---
create procedure testView3 @TestRunId int
as
begin
	declare @startAt datetime;
	declare @endAt datetime;
	set @startAt = GETDATE();
	select * from vMaxPricePerBreed;
	set @endAt = GETDATE();
	--- insert into TestRunViews ---
	insert into TestRunViews
	values(@TestRunId, 3, @startAt, @endAt);
end
go


