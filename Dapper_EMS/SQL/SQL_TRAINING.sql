USE HR;
GO
-- create table
CREATE TABLE Employee
(  
    EmployeeID int,
    FirstName nvarchar(50) NOT NULL,  
    LastName nvarchar(50) NOT NULL, 
    EMail nvarchar(50),
    Phone varchar(15),
    HireDate date,
    Salary Money
);

-- add column
ALTER TABLE dbo.Employee
Add Address varchar(500) NOT NULL;

---- add two more column
ALTER TABLE dbo.Employee
 Add Designation varchar(50) NOT NULL,
 Qualification varchar(100);

EXEC sp_rename 'Employee.Address' ,'TempAddress','COLUMN';

-- rename the table name
EXEC sp_rename 'Employee' ,'Consultant';

-- drop the column name

ALTER TABLE Dbo.Consultant
 Drop column TempAddress, Qualification;


 EXEC sp_rename 'Consultant','Employee';

 --Adding primary key
ALTER TABLE Employee
Add Constraint pk_employee_employeeId PRIMARY KEY (EmployeeID);

--ALTER TABLE Employee
DROP CONSTRAINT pk_employee_employeeId;  

--Adding Unique Constraints

ALTER TABLE Employee   
ADD CONSTRAINT UNQ_Emp_Phone Unique(Phone);

-- Delete the Unique key Constraints

Alter Table Employee
Drop Constraint UNQ_Emp_Phone;

-- Inserting values into the Employee table
INSERT INTO Employee ( FirstName, LastName, EMail, Phone, HireDate, Salary,  Designation)
VALUES 
( 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '2024-01-01', 50000,  'Manager'),
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', '2024-02-01', 45000,  'Developer');

-- Retriving the data from database
select *from Employee;

-- create table for address
CREATE TABLE Address
(
    AddressID int PRIMARY KEY,
    EmployeeID int,
    StreetAddress varchar(255),
    City varchar(100),
    State varchar(50),
    PostalCode varchar(20),
    Country varchar(100),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

--insert into address 
 Inserting values into the Address table
INSERT INTO Address (AddressID, EmployeeID, StreetAddress, City, State, PostalCode, Country)
VALUES 
(1, 1, '123 Main St', 'Anytown', 'CA', '12345', 'USA'),
(2, 2, '456 Oak St', 'Otherville', 'NY', '54321', 'USA');

-- select the data from address
select *from  Address;


-- Update an Employee
UPDATE Employee
SET Email = 'jking@test.com'
WHERE EmployeeID = 1;

-- Increase the dalary by 10 percentage
UPDATE Employee 
SET Salary = Salary + (Salary * 10/100);

INSERT INTO Employee (FirstName, LastName, EMail, Phone, HireDate, Salary, Designation)
VALUES
('Michael', 'Johnson', 'michael.johnson@example.com', '555-555-5555', '2023-03-01', 60000, 'Manager'),
('Emily', 'Williams', 'emily.williams@example.com', '444-444-4444', '2023-04-01', 55000, 'Developer'),
('Christopher', 'Brown', 'christopher.brown@example.com', '333-333-3333', '2023-05-01', 52000, 'Analyst'),
('Jessica', 'Jones', 'jessica.jones@example.com', '222-222-2222', '2023-06-01', 58000, 'Designer'),
('Matthew', 'Garcia', 'matthew.garcia@example.com', '111-111-1111', '2023-07-01', 53000, 'Engineer'),
('Amanda', 'Martinez', 'amanda.martinez@example.com', '999-999-9999', '2023-08-01', 57000, 'Manager'),
('David', 'Robinson', 'david.robinson@example.com', '888-888-8888', '2023-09-01', 54000, 'Analyst'),
('Sarah', 'Lee', 'sarah.lee@example.com', '777-777-7777', '2023-10-01', 56000, 'Developer');

--Delete the data from table
DELETE FROM Employee WHERE EmployeeID=10;


-- Where classs

Select *from Employee where Salary>50000;

-- Between Operator
Select *from Employee where Salary Between 50000 and 55000;

--Subquery 
SELECT * FROM Employee 
WHERE DeptId = (SELECT DeptId FROM Department WHERE DeptName = 'HR');

-- GroupBy(Group the Records)
SELECT Designation, COUNT(EmployeeId) as 'Number of Employees' 
FROM Employee
GROUP BY Designation;

--Having -the HAVING clause includes one or more conditions that should be TRUE for groups of records.
SELECT Designation, COUNT(EmployeeId) as 'Number of Employees' 
FROM Employee
GROUP BY Designation
Having Count(EmployeeId)=2;

--OrderBy
SELECT * FROM Employee
ORDER BY FirstName;

-- orderBy- sorting in ascending and descending order
SELECT * FROM Employee
ORDER BY FirstName DESC;


INSERT INTO Address (AddressID, EmployeeID, StreetAddress, City, State, PostalCode, Country)
VALUES 

(3, 3, '789 Elm St', 'Elmtown', 'TX', '67890', 'USA'),
(4, 4, '101 Pine St', 'Pinetown', 'WA', '98765', 'USA'),
(5, 5, '246 Maple St', 'Mapleville', 'FL', '13579', 'USA'),
(6, 6, '369 Cherry St', 'Cherrytown', 'GA', '24680', 'USA'),
(7, 7, '482 Walnut St', 'Walnutville', 'IL', '97531', 'USA');


--Joins - joins the two or more from two different table
SELECT Employee.FirstName, Employee.LastName, Address.StreetAddress
FROM Employee
INNER JOIN Address ON Employee.EmployeeID = Address.EmployeeID;

--Left Join
SELECT Employee.EmployeeID, Employee.FirstName, Employee.LastName, Address.StreetAddress
FROM Employee
LEFT JOIN Address ON Employee.EmployeeID = Address.EmployeeID;

--Right Join
SELECT Employee.EmployeeID, Employee.FirstName, Employee.LastName, Address.StreetAddress
FROM Employee
Right JOIN Address ON Employee.EmployeeID = Address.EmployeeID;

--Full Join

SELECT Employee.EmployeeID, Employee.FirstName, Employee.LastName, Address.StreetAddress
FROM Employee
Full JOIN Address ON Employee.EmployeeID = Address.EmployeeID;

--self join

SELECT e1.FirstName AS EmployeeFirstName, e1.LastName AS EmployeeLastName,
       e2.FirstName AS ManagerFirstName, e2.LastName AS ManagerLastName
FROM Employee e1
LEFT JOIN Employee e2 ON e1.Designation = 'Manager' AND e2.Designation = 'Manager';






-- If Else Condition

DECLARE @StudentMarks INT = 85;

IF (@StudentMarks > 80)
	BEGIN
		IF @StudentMarks > 90
			PRINT 'A+';
		ELSE
			PRINT 'A-';
	END	
ELSE 
	PRINT 'Below A grade'

--WHILE lOOP with break and continue

DECLARE @i Int = 1;

WHILE (@i < 30)
BEGIN
    IF @i = 10
    BEGIN
        SET @i = @i + 1;
        CONTINUE;
    END

    PRINT @i;
    SET @i = @i + 1;
END;


-- Built in funtions
SELECT ASCII('A') A, ASCII('ABC') ABC

SELECT ASCII('9') AS [9], ASCII('&') AS [&], ASCII(99) AS [99], ASCII('/') AS [/]

select char(64) as char65 

select FirstName + CHAR(9) + LastName as EmpName,
FirstName + char(12) + LastName as EmpName,     
FirstName + char(45) + LastName as EmpName,
FirstName + char(35) + LastName + char(33) as EmpName
FROM Employee;

-- print the employee in seperate line using carriage return  char(13)

select emp.FirstName + ' ' + emp.LastName + CHAR(13) + emp.email 
FROM Employee emp
WHERE EmployeeID = 2;

DECLARE @FullNameEmail NVARCHAR(MAX);

SELECT @FullNameEmail = emp.FirstName + CHAR(13)+ emp.LastName + CHAR(13) + emp.email
FROM Employee emp
WHERE EmployeeID = 2;

PRINT @FullNameEmail;

--CharINdex-is not case sen
--Note: Adding COLLATE Latin1_General_CS_AS makes the search case sensitive

SELECT CHARINDEX('e', 'Hello world') 
SELECT CHARINDEX('h' , 'Hello World')

Select CHARINDEX('nice', 'Have a nice day!')

SELECT CHARINDEX('Good', 'Have a nice day!') AS Result

--Average

SELECT AVG (ALL Salary) AS AllSalary, AVG (DISTINCT Salary) AS DistinctSalary 
FROM Employee;

SELECT EmployeeID, FirstName, Salary FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee)

-- Ceiling
SELECT CEILING(23.34) AS PosInt, CEILING (-23.34) AS NegInt

--Dynamic Sql
DECLARE @sql nvarchar(max) --declare variable
DECLARE @empId nvarchar(max) --declare variable for parameter

set @empId = '5' --assign value to parameter variable
set @sql = 'SELECT * FROM EMPLOYEE WHERE EmployeeID =' + @empId --build query string with parameter

exec(@sql) --execute sql query

--Database Objects

--views


CREATE VIEW dbo.EmployeeAddress  
AS 
SELECT emp.FirstName, emp.LastName, emp.HireDate, addr.StreetAddress AS Address
FROM Employee emp 
JOIN Address addr ON emp.EmployeeID = addr.EmployeeID;

-- Execute the View
SELECT * FROM dbo.EmployeeAddress;

-- Modifying the View
ALTER VIEW dbo.EmployeeAddress  
AS 
    SELECT emp.FirstName, emp.LastName, emp.HireDate, addr.StreetAddress As Address
    FROM Employee emp JOIN Address addr 
    on emp.EmployeeID = addr.EmployeeID
    WHERE emp.HireDate > '01/01/2024';

select * from dbo.EmployeeAddress;

-- Delete a view
DROP VIEW dbo.EmployeeAddress;  

--Functions

-- Scalar Function -returns single value
CREATE FUNCTION dbo.GetTotalSalary()
RETURNS MONEY
AS
BEGIN
    DECLARE @TotalSalary MONEY;

    SELECT @TotalSalary = SUM(Salary)
    FROM Employee;

    RETURN @TotalSalary;
END;


SELECT dbo.GetTotalSalary() AS TotalSalary;

--Table Valued Function return more than two rows

CREATE OR ALTER FUNCTION dbo.GetEmployeeList(@hiredate DATE)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Employee
    WHERE HireDate > @hiredate
);
GO

---- Example usage:
SELECT * FROM dbo.GetEmployeeList('2023-06-01');

-- Stored Procedure

CREATE PROCEDURE GetEmployeeByID
    @EmployeeID INT
AS
BEGIN
    SELECT * FROM Employee WHERE EmployeeID = @EmployeeID;
END;

EXECUTE GetEmployeeByID @EmployeeID = 4;

CREATE PROCEDURE uspGetEmployeeList
AS
BEGIN
   SELECT EmployeeID
	 ,FirstName
	 ,LastName
   FROM dbo.Employee
END

EXEC dbo.uspGetEmployeeList;

-- Use sp_help or sp_helptext to see the text of an existing stored procedure, as shown below.
sp_helptext uspGetEmployeeList;

-- Alter Procedure
ALTER PROCEDURE dbo.uspGetEmployees
AS
BEGIN
   SELECT EmployeeID
	 ,FirstName
	 ,LastName
     ,Salary
   FROM dbo.Employee
END

sp_rename 'uspGetEmployeeList','uspGetEmployees' 

-- Drop the Procedure
DROP PROCEDURE dbo.uspGetEmployees;

CREATE PROCEDURE UpdateEmployee_Salary
    @EmployeeID INT,
    @NewSalary MONEY
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION; -- Start a transaction

        -- Update the salary
        UPDATE Employee
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        -- If no errors occurred, commit the transaction
        COMMIT;
    END TRY
    BEGIN CATCH
        -- If an error occurred, rollback the transaction
        IF @@TRANCOUNT > 0
            ROLLBACK;

        -- Print error message with additional error information
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorNumber INT = ERROR_NUMBER();
        DECLARE @ErrorState INT = ERROR_STATE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorProcedure NVARCHAR(200) = ERROR_PROCEDURE();

        PRINT 'An error occurred:';
        PRINT 'Error message: ' + @ErrorMessage;
        PRINT 'Error number: ' + CAST(@ErrorNumber AS NVARCHAR);
        PRINT 'Error state: ' + CAST(@ErrorState AS NVARCHAR);
        PRINT 'Error severity: ' + CAST(@ErrorSeverity AS NVARCHAR);
        PRINT 'Error procedure: ' + @ErrorProcedure;
    END CATCH;
END;

EXECUTE UpdateEmployee_Salary @EmployeeID = 2, @NewSalary = 60000;

-- Indexes- for easy data access
-- clustered index
-- Unclustered index


CREATE TABLE dbo.EmployeeDetails(
	EmployeeID int NOT NULL,
	PassportNumber varchar(50) NULL,
	ExpiryDate date NULL
)

Insert into EmployeeDetails values(3,'A5423215',null);
Insert into EmployeeDetails values(5,'A5423215',null);
Insert into EmployeeDetails values(2,'A5423215',null);
Insert into EmployeeDetails values(8,'A5423215',null);
Insert into EmployeeDetails values(1,'A5423215',null);
Insert into EmployeeDetails values(4,'A5423215',null);
Insert into EmployeeDetails values(6,'A5423215',null);
Insert into EmployeeDetails values(7,'A5423215',null);


select *from EmployeeDetails;

-- create the clustered index
CREATE CLUSTERED INDEX CIX_EmpDetails_EmpId
ON dbo.EmployeeDetails(EmployeeID)

select *from EmployeeDetails;

CREATE NONCLUSTERED INDEX NCI_Employee_EmpId
ON dbo.EmployeeDetails(EmployeeID);

select *from EmployeeDetails;

-- alter the index
ALTER INDEX NCI_Employee_Email ON dbo.Employee
SET (IGNORE_DUP_KEY = ON);


-- Delete the index
DROP INDEX CIX_EmpDetails_EmpId
ON dbo.EmployeeDetails