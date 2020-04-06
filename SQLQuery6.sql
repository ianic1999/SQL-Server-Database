--Modify the type of a column--
create procedure modifyColumnType
as
begin
alter table Products alter column Price varchar(10);
end
go

--Return back the type of the column--
create procedure returnColumnType
as
begin
alter table Products alter column Price float;
end
go

--Add a column to the table--
create procedure addColumn
as
begin
alter table Doctors add Country varchar(20)
end
go

--Remove column from the table--
create procedure removeColumn
as
begin
alter table Doctors drop column Country;
end
go

--Add a default constraint--
create procedure addDefault
as
begin
alter table Dogs add constraint df_Photo default 'www.google.com' for Photo;
end
go

--Remove default constraint--
create procedure removeDefault
as
begin
alter table Dogs drop constraint df_Photo
end
go

--Add a primary key--
create procedure addPrimaryKey
as
begin
alter table Orders add constraint PK_Oid primary key (Oid)
end
go

--Remove a primary key--
create procedure removePrimaryKey
as
begin
alter table Orders drop constraint PK_Oid
end
go

--Add canidate key--
create procedure addCandidateKey
as
begin
alter table Eat add constraint PK_Dog_Food primary key (DogId, FoodId);
end
go

--Remove a candidate key--
create procedure removeCandidateKey
as
begin
alter table Eat drop constraint PK_Dog_Food;
end
go

--Add a foreign key--
create procedure addForeignKey
as
begin
alter table Dogs add constraint FK_Dog_Doctor foreign key (DoctorCNP) references Doctors(DCNP);
end
go

--Remove a foreign key--
create procedure removeForeignKey
as
begin
alter table Dogs drop constraint FK_Dog_Doctor;
end
go

--Create a table--
create procedure createTable
as
begin
create table Employees
(
ECNP char(13) constraint PK_ECNP primary key,
FirstName varchar(30),
LastName varchar(30)
)
end
go

--Remove a table--
create procedure removeTable
as
begin
drop table Employees
end
go

create procedure bringDatabaseToVersion @version int
as
begin
declare @currentVersion smallint =
(
select VersionId
from Versions
where Active = 1
);
if @version < 0 or @version > 7
begin
	raiserror('Invalid version!', 20, 1)
end
else if @currentVersion < @version
begin
	while @currentVersion < @version
	begin
		declare @commandUp nvarchar(50) = 
		(
			select ProcedureUp
			from Versions
			where VersionId = @currentVersion + 1
		);
		set @currentVersion = @currentVersion + 1;
		update CurrentVersion
		set [Current Version] = @currentVersion;
		exec sp_executesql @commandUp;
	end
end
else if @currentVersion > @version
begin
	while @currentVersion > @version
	begin
		declare @commandDown nvarchar(50) =
		(
			select ProcedureDown
			from Versions
			where VersionId = @currentVersion
		);
		set @currentVersion = @currentVersion - 1;
		update CurrentVersion
		set [Current Version] = @currentVersion;
		exec sp_executesql @commandDown;
	end
end;
if @version >= 0 or @version <= 7
begin
	update Versions
	set Active = 0
	where Active = 1;
	update Versions
	set Active = 1
	where VersionId = @version;
end
end
go

exec bringDatabaseToVersion @version = 0;
select * from Versions;

select * from CurrentVersion;



