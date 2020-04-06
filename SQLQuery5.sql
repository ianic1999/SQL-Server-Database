
-- Modify the type of a column --
alter table Products alter column Price varchar(10);
alter table Products alter column Price float;

-- Add/Drop a column from the table --
alter table Doctors add Country varchar(20)
alter table Doctors drop column Country;

-- Add/Drop a default constraint --
alter table Dogs add constraint df_Photo default 'www.google.com' for Photo;
alter table Dogs drop constraint df_Photo

-- Add/Drop a primary key --
alter table Orders add constraint PK_Oid primary key (Oid);
alter table Orders drop constraint PK_Oid;

--Add/Drop a candidate key--
alter table Eat alter column DogId int not null;
alter table Eat alter column FoodId int not null;
alter table Eat add constraint PK_Dog_Food primary key (DogId, FoodId);
alter table Eat drop constraint PK_Dog_Food;

--Add/Drop a foreign Key--
alter table Dogs add constraint FK_Dog_Doctor foreign key (DoctorCNP) references Doctors(DCNP);
alter table Dogs drop constraint FK_Dog_Doctor;

--Create/Remove a table--
create table Employees
(
ECNP char(13) constraint PK_ECNP primary key,
FirstName varchar(30),
LastName varchar(30)
)
drop table Employees;

create table Versions
(
	ProcedureUp varchar(50),
	ProcedureDown varchar(50),
	VersionId int,
	Active smallint
)

insert into Versions(ProcedureUp, ProcedureDown, VersionId, Active)
values('-','-',0,1),
('modifyColumnType','returnColumnType', 1, 0),
('addColumn', 'removeColumn', 2, 0),
('addDefault', 'removeDefault', 3, 0),
('addPrimaryKey', 'removePrimaryKey', 4, 0),
('addCandidateKey', 'removeCandidateKey', 5, 0),
('addForeignKey', 'removeForeignKey', 6, 0),
('createTable', 'removeTable', 7, 0);


select * from Versions
drop table Versions

create table CurrentVersion(
[Current Version] int
);

insert into CurrentVersion
values(2);

select * from CurrentVersion;
