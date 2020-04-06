create procedure addTest @testName varchar(20)
as
begin
	if @testName in
	(
		select [Name]
		from Tests
	)
	begin
		declare @mess varchar(100) = 'The test is already in the table';
		raiserror(@mess,10,3);
	end;
	else
	begin
		insert into Tests values(@testName);
	end;
end
go

create procedure addTable @tableName varchar(20)
as
begin
	if @tableName in
	(
		select [Name]
		from Tables
	)
	begin
		raiserror('This tables is already in the table',10,3);
	end;
	else
	begin
		insert into Tables values(@tableName);
	end;
end
go

create procedure addTestTables @testId int, @tableId int, @nor int, @pos int
as
begin
	insert into TestTables values(@testId, @tableId, @nor, @pos);
end
go

create procedure addView @viewName varchar(50)
as
begin
	if @viewName in
	(
		select [Name]
		from Views
	)
	begin
		raiserror('This view is already in the table',10,3);
	end;
	else
	begin
		insert into Views values(@viewName);
	end;
end
go

create procedure addTestView @testId int, @viewId int
as
begin
	insert into TestViews values(@testId, @viewId);
end
go

create procedure addTestRunView @testRunId int, @viewId int
as
begin
	declare @startAt datetime;
	declare @endAt datetime;
	set @startAt = GETDATE();
	select T.* from
	(
		select [Name]
		from Views
		where ViewID = @viewId
	) as T;
	set @endAt = GETDATE();
	insert into TestRunViews values(@testRunId, @viewId, @startAt, @endAt);
end
go

--- This procedure start a test and populate all the tables and views related to the test ---
create procedure execTestRun @description varchar(2000), @testId int
as
begin
	set identity_insert TestRuns ON;
	declare @id int = (select count(*) from TestRuns) + 1;
	insert into TestRuns(TestRunID, [Description]) values(@id,@description);
	declare @startAt datetime;
	declare @endAt datetime;
	set @startAt = GETDATE();
	declare @testName nvarchar(50) =
	(select [Name]
	from Tests
	where TestID = @testId
	);
	exec sp_executesql @testName;
	exec addTestRunView @testRunId = @testId, @viewId = 4;
	exec addTestRunView @testRunId = @testId, @viewId = 5;
	exec addTestRunView @testRunId = @testId, @viewId = 6;

	set @endAt = GETDATE();
	update TestRuns
	set StartAt = @startAt, EndAt = @endAt
	where TestRunID = @id;
end
go

create procedure addTestRunTable @trid int, @tid int, @start datetime, @finish datetime
as
begin
	insert into TestRunTables values(@trid, @tid, @start, @finish);
end
go

--- This procedure is the test that delete data from 3 tables and insert into them, in reverse order ---
create procedure execTest
as
begin
	declare @table1 varchar(50) = 
	(
		select T.[Name]
		from TestTables TT inner join Tables T on TT.TableID = T.TableID
		where TT.Position = 1 and TT.TableID = 1
	);
	declare @table2 varchar(50) = 
	(
		select T.[Name]
		from TestTables TT inner join Tables T on TT.TableID = T.TableID
		where TT.Position = 2 and TT.TableID = 1
	);
	declare @table3 varchar(50) = 
	(
		select T.[Name]
		from TestTables TT inner join Tables T on TT.TableID = T.TableID
		where TT.Position = 3 and TT.TableID = 1
	);
	exec('delete from '+@table1);
	exec('delete from '+@table2);
	exec('delete from '+@table3);

	declare @index int = 0;
	declare @length int;
	declare @begin datetime;
	declare @end datetime;
	declare @testRunId int;
	declare @tableId int;
	if(select count(*) from TestRuns) > 0
	begin
		set @testRunId = (select max(TestRunId) from TestRuns);
	end
	else
	begin
		set @testRunId = 1;
	end
	set @length = 
	(
		select NoOfRows
		from TestTables
		where Position = 3
	);
	set @begin = GETDATE();
	while @index < @length
	begin
		declare @breed varchar(10) = '''Breed_'+cast(@index as varchar(10))+'''';
		declare @color varchar(10) = '''Color_'+cast(floor(rand() * 7)-1 as varchar(10))+'''';
		exec('insert into '+@table3+'([Name],Color) values('+@breed+','+@color+')');
		set @index = @index + 1;
	end;
	set @end = GETDATE();
	set @tableId = (select TableId from Tables where [Name] = @table3);

	exec addTestRunTable @trid = @testRunId, @tid = @tableId, @start = @begin, @finish = @end; 

	set @index = 0;
	set @length = 
	(
		select NoOfRows
		from TestTables
		where Position = 2
	);
	set @begin = GETDATE();
	while @index < @length
	begin
		declare @name varchar(10) = '''Name_'+cast(@index as varchar(10))+'''';
		declare @age varchar(3) = ltrim(str(floor(rand()*5)+1));
		declare @photo varchar(10) = '''Link_'+cast(@index as varchar(10))+'''';
		declare @ocnp char(15) = ''''+(select top 1 OCNP from Owners order by newid())+'''';
		declare @dcnp char(15) = ''''+(select top 1 DCNP from Doctors order by newid())+'''';
		declare @bid varchar(30) = ltrim(str((select top 1 Bid from Breeds order by newid())));
		exec('insert into '+@table2+'([Name],Age,Photo,OwnerCNP,DoctorCNP,BreedId) values('+@name+','+@age+','+@photo+','+@ocnp+','+@dcnp+','+@bid+')');
		set @index = @index + 1;
	end;
	set @end = GETDATE();
	set @tableId = (select TableId from Tables where [Name] = @table2);

	exec addTestRunTable @trid = @testRunId, @tid = @tableId, @start = @begin, @finish = @end;

	set @index = 0;
	set @length = 
	(
		select NoOfRows
		from TestTables
		where Position = 1
	);
	set @begin = GETDATE();
	while @index < @length
	begin
		declare @ccnp char(15) = ''''+(select top 1 CCNP from Customers order by newid())+'''';
		declare @pid varchar(10) = ltrim(str((select top 1 Pid from Products order by newid())));
		declare @date varchar(50) = ''''+cast(GETDATE() as varchar(20))+'''';
		exec('insert into '+@table1+'(ProductId,CustomerCNP,[Date]) values('+@pid+','+@ccnp+','+@date+')');
		set @index = @index + 1;
	end;
	set @end = GETDATE();
	set @tableId = (select TableId from Tables where [Name] = @table1);

	exec addTestRunTable @trid = @testRunId, @tid = @tableId, @start = @begin, @finish = @end;s
end
go

drop procedure execTest
drop procedure execTestRun

