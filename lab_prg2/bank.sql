CREATE DATABASE Bankingenterprise;
USE Bankingenterprise;
CREATE TABLE Branch(
	  branch_name varchar(20) primary key,
    branch_city varchar(40),
    assets real
   );
CREATE TABLE BankAccount(
	  accno int primary key,
    branch_name varchar(20),
    balance real,
    foreign key(branch_name) references BRANCH(branch_name)
    );

CREATE TABLE BankCustomer(
	  customer_name varchar(20) primary key,
    customer_street varchar(40),
    customer_city varchar (20)
    );

CREATE TABLE Depositor(
	 customer_name varchar(20),
   accno int
   PRIMARY KEY(customer_name, accno),
	 foreign key(accno) references BankAccount(accno),
	 foreign key(customer_name) references BankCustomer(customer_name)
   );

CREATE TABLE Loan(
	  loan_number int primary key,
    branch_name varchar(20),
    amoount real,
    foreign key(branch_name) references Branch(branch_name)
    );

INSERT INTO Branch VALUES('SBI_Chamrajpet', 'BANGALORE',50000),('SBI_ResidencyRoad', 'BANGALORE',10000),
('SBI_ShivajiRoad', 'Bombay',20000),('SBI_ParlimentRoad', 'Delhi',10000),
('SBI_Jantarmantar', 'Delhi',20000);


INSERT INTO BankAccount VALUES(1,'SBI_Chamrajpet',2000),(2,'SBI_ResidencyRoad',5000),
(3,'SBI_ShivajiRoad',6000),(4,'SBI_ParlimentRoad',9000),(5,'SBI_Jantarmantar',8000),(6,'SBI_ShivajiRoad',4000),
(8,'SBI_ResidencyRoad',4000),(9,'SBI_ParlimentRoad',3000),(10,'SBI_ResidencyRoad',5000),
(11,'SBI_Jantarmantar',2000);


INSERT INTO BankCustomer VALUES ("Avinash","Bull_Temple_Road","Bangalore"),("Dinesh","Bannergatta_Road","Bangalore"),
("Mohan","NationtalCollege__Road","Bangalore"),("Nikil","Akbar_Road","Delhi"),
("Ravi","Prithviraj_Road","Delhi");


INSERT INTO Loan VALUES (1,'SBI_Chamrajpet',1000),(2,'SBI_ResidencyRoad',2000),(3,'SBI_ShivajiRoad',3000),
 (4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantar',5000);


INSERT INTO Depositor VALUES ("Avinash",1),("Dinesh",2),("Nikil",4),("Ravi",5),("Avinash",8),("Nikil",9),("Dinesh",10),("Nikil",11);

SELECT * FROM BRANCH;
SELECT * FROM BankAccount;
SELECT * FROM BankCustomer;
SELECT * FROM Depositor;
SELECT * FROM Loan;

SELECT * FROM BankCustomer WHERE customer_name IN(SELECT customer_name FROM depositor group by customer_name having COUNT(customer_name)>=2);

SELECT d.customer_name 
FROM BankAccount a, Depositor d, Branch b 
WHERE d.accno=a.accno AND b.branch_name=a.branch_name AND b.branch_city="Bangalore"
GROUP BY d.customer_name
HAVING count(distinct b.branch_name)=
			(SELECT COUNT(branch_name)
            FROM branch  
            WHERE branch_city="Bangalore"); 

DELETE FROM depositor
WHERE accno IN 
(SELECT accno
FROM Branch b, BankAccount a
WHERE branch_city = 'delhi' and b.branch_name = a.branch_name);
DELETE FROM BankAccount WHERE branch_name IN(SELECT branch_name FROM BRANCH WHERE branch_city='delhi'); 

SELECT * FROM BankAccount;

