-- add a test --
exec addTest @testName = 'execTest';

--add tables--
exec addTable @tableName = 'Breeds';
exec addTable @tableName = 'Dogs';
exec addTable @tableName = 'RejectedOrders';

select * from Tables;

--add TestTables--
exec addTestTables @testId = 1, @tableId = 6, @nor = 50, @pos = 1;
exec addTestTables @testId = 1, @tableId = 4, @nor = 100, @pos = 3;
exec addTestTables @testId = 1, @tableId = 5, @nor = 200, @pos = 2;

--add Views--
exec addView @viewName = 'vRejOrders';
exec addView @viewName = 'vDogsPrice';
exec addView @viewName = 'vMaxPricePerBreed';

--add TestViews--
exec addTestView @testId = 1, @viewId = 4;
exec addTestView @testId = 1, @viewId = 5;
exec addTestView @testId = 1, @viewId = 6;

exec execTestRun @description = 'Call proc. execTest and views', @testId = 1;

select * from TestRuns;
select * from TestRunTables;
select * from TestRunViews;

select * from Tests;
select * from Tables;
select * from Views;
select * from TestTables;
select * from TestViews;

delete from TestRuns;
delete from TestRunTables;
delete from TestRunViews;

delete from Tests;
delete from Tables;
delete from Views;
delete from TestTables;
delete from TestViews;

select * from RejectedOrders;
select * from Dogs;
select * from Breeds;