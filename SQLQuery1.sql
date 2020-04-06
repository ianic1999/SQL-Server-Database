use Lab5
create table R(
	rid int primary key,
	m varchar(50),
	n varchar(50),
	p int,
	q int,
	O int
);

insert into r(rid,m,n,p,q,o)
values(10,'Allons','Le jour',20,1,10),
(1,'enfants','de',21,1,5),
(2,'de','gloire',22,1,null),
(11,'la','est',23,1,null),
(3,'Patrie,','arrive!',24,1,2);

	Select count( distinct p)
	from R
