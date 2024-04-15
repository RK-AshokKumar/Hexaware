--Task 1

--create database 'HMBank'

Create database HMBank;

--Schema for Customers,Accounts and Transactions

Create table Customers(Customer_id int primary key not null, first_name varchar(20), last_name varchar(20), DOB date, email varchar(30), phone_number varchar(20), address varchar(40));

Create table Accounts(account_id int primary key not null, customer_id int references Customers(Customer_id) not null, account_type varchar(20), balance int);

Create table Transactions(transaction_id int primary key not null, account_id int references Accounts(account_id) not null, transaction_type varchar(20), amount int, transaction_date date);

-- Tasks 2: Select, Where, Between, AND, LIKE:
-- 1. Insert at least 10 sample records into each of the following tables.

-- Insert Values into table Customers
INSERT INTO Customers VALUES
(101, 'Ajeeth', 'Kumar', '2001-01-01', 'ajeeth@gmail.com', '8384798348', 'Noida'),
(102, 'Ashok', 'Kumar', '2002-02-02', 'ashok@gmail.com', '6293879823', 'Jaipur'),
(103, 'Abi', 'Shek', '2002-04-01', 'abishek@gmail.com', '9827398237', 'Mohali'),
(104, 'Barath', 'Kumar', '2003-03-03', 'barath@gmail.com', '7289738723', 'Lucknow'),
(105, 'Gokul', 'Kumar', '2003-03-04', 'gokul@gmail.com', '6928739823', 'Pune'),
(106, 'Arun', 'Siva', '2003-10-05', 'arun@gmail.com', '6099239828', 'Mumbai'),
(107, 'Kirthik', 'Raja', '2003-11-08', 'kirthik@mail.com', '9287398238', 'Bengalore'),
(108, 'Vishnu', 'Prasanth', '2003-01-01', 'vishnu@gmail.com', '8238378723', 'Chennai'),
(109, 'Hari', 'Ram', '2003-03-05', 'hariram@gmail.com', '9297398892', 'Kolkata'),
(110, 'Ram', 'Prasanth', '2002-01-01', 'ram@gmail.com', '7293792838', 'Hyderabad');

Select * from Customers;

-- Insert Values into table Accounts
INSERT INTO Accounts VALUES
(201, 101, 'Current', 5000),
(202, 102, 'Savings', 50000),
(203, 103, 'zero_balance',0),
(204, 104, 'Current', 7000),
(205, 105, 'zero_balance', 0),
(206, 106, 'Savings', 30000),
(207, 107, 'Savings', 45000),
(208, 108, 'Zero_Balance', 0),
(209, 109, 'Savings', 20000),
(210, 110, 'Current', 8000);

Select * from Accounts;

INSERT INTO Accounts VALUES
(211, 101, 'Current', 8000);
-- Insert Values into table Transactions
INSERT INTO Transactions VALUES
(301, 201, 'Withdraw', 2000, '2024-04-12'),
(302, 202, 'Deposit', 5000, '2024-02-02'),
(303, 203, 'transfer', 2000, '2024-03-06'),
(304, 204, 'Withdraw', 1000, '2024-02-01'),
(305, 205, 'Transfer', 2000, '2023-12-29'),
(306, 206, 'Deposit', 7000, '2024-04-12'),
(307, 207, 'deposit', 8000, '2024-04-19'),
(308, 208, 'Transfer', 1500, '2024-01-02'),
(309, 209, 'Deposit', 8000, '2024-04-22'),
(310, 210, 'Withdraw', 1750, '2023-12-09');

Select * from Transactions;

--2. Write SQL queries for the following tasks:

--2- 1. Write a SQL query to retrieve the name, account type and email of all customers.

Select concat(first_name,' ',last_name) as CustomerName, account_type ,email from Customers , Accounts where Customers.customer_id=Accounts.customer_id;

--2- 2. Write a SQL query to list all transaction corresponding customer.

Select  concat(first_name,' ',last_name)  as CustomerName,transaction_id, Accounts.account_id, transaction_type , amount, transaction_date
from Customers  , Accounts  , Transactions  where Customers.customer_id=Accounts.customer_id and Accounts.account_id=Transactions.account_id;

--2- 3. Write a SQL query to increase the balance of a specific account by a certain amount.

Update Accounts set balance = balance+(balance*0.1) where account_type = 'Current';

Select * from Accounts;

--2- 4. Write a SQL query to Combine first and last names of customers as a full_name.

Select concat(first_name,' ',last_name)  as full_name from Customers;

--2- 5. Write a SQL query to remove accounts with a balance of zero where the account
--type is savings.

Insert into Accounts values(212,102,'Savings',0);

Delete from Accounts where balance = 0 and account_type = 'Savings';

Select * from Accounts;

--2. 6. Write a SQL query to Find customers living in a specific city.

Select * from Customers where address like 'Bengalore';

--2- 7. Write a SQL query to Get the account balance for a specific account.

Select balance from Accounts where account_id=210;

--2- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.

Select * from Accounts where account_type = 'Current' and balance > 1000;

--2- 9. Write a SQL query to Retrieve all transactions for a specific account.

Select * from Transactions where account_id=202;

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.

Declare @interestrate int;
SET @interestrate = 10;

Select account_id , balance , balance*@interestrate/100 as InterestAccured from Accounts ;

--11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.

Declare @overdraftlimit int; 
Set @overdraftlimit = 5000;

Select * from Accounts where balance < @overdraftlimit;

--12. Write a SQL query to Find customers not living in a specific city.

Select * from Customers where address not like 'Bengalore';

-- Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:

--1. Write a SQL query to Find the average account balance for all customers.

Select avg(balance) as AverageBalance from Accounts;

--2. Write a SQL query to Retrieve the top 10 highest account balances.

Select top 10 balance as Top_10_Balances from Accounts order by balance;

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.

Select sum(amount) as TotalDeposits from Transactions where transaction_type='Deposit'and transaction_date between '2024-04-13'and '2024-04-20';

--4. Write a SQL query to Find the Oldest and Newest Customers.

-- Oldest Customer
Select top 1 * from Customers order by DOB;

-- Newest Customer
Select top 1 * from Customers order by DOB desc;

--5.Write a SQL query to Retrieve transaction details along with the account type.

Select t.transaction_id , t.transaction_type, t.transaction_date, t.account_id, a.account_type from Transactions t join Accounts a  on t.account_id = a.account_id;

--6. Write a SQL query to Get a list of customers along with their account details.

Select c.customer_id, concat(c.first_name,'',c.last_name ) as CustomerName, a.account_id , a.account_type , balance from Customers c join Accounts a  on c.customer_id = a.customer_id;

--7.  Write a SQL query to Retrieve transaction details along with customer information for a
--specific account.

Select c.customer_id, concat(c.first_name,'',c.last_name ) as CustomerName , t.transaction_id, t.transaction_type, t.amount, t.transaction_date from Customers c  join Accounts a on c.customer_id = a.customer_id join Transactions t on t.account_id = a.account_id where a.account_id=209;

--8. Write a SQL query to Identify customers who have more than one account.
Select c.customer_id, concat(c.first_name,'',c.last_name ) as CustomerName  from Customers c join Accounts a on c.customer_id = a.customer_id group by c.customer_id, c.first_name,c.last_name having count(a.account_id)>1;

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
Select abs(sum(amount * case when transaction_type = 'deposit' then 1 else -1 end)) as Difference from Transactions;

--10. Write a SQL query to Calculate the average daily balance for each account over a specified period.

Select avg(a.balance) as AverageBalance from Accounts a  join  Transactions t on a.account_id = t.account_id   where t.transaction_date  between '2024-04-13' and '2024-04-20' group by a.account_id;

--11. Calculate the total balance for each account type.

Select account_type , sum(balance) as TotalBalance from Accounts group by account_type;

--12. Identify accounts with the highest number of transactions order by descending order.

Select account_id , count(transaction_id) as NumTransactions from Transactions group by account_id  order by NumTransactions desc;

--13. List customers with high aggregate account balances, along with their account types.

Select Concat(c.first_name,' ',c.last_name)  as full_name ,a.account_id ,a.account_type , sum(balance) as HighAccountBalance from Accounts a  join Customers c on a.customer_id = c.customer_id group by c.first_name ,c.last_name ,account_id ,a.account_type order by HighAccountBalance desc;

--14. Identify and list duplicate transactions based on transaction amount, date, and account.
Insert into Transactions values(311, 201, 'deposit', 2000, '2024-04-13');
Insert into Transactions values(312, 201, 'deposit', 2000, '2024-04-13');

SELECT account_id, amount, transaction_date, COUNT(*) AS duplicate_count FROM Transactions
GROUP BY account_id, amount, transaction_date HAVING COUNT(*) > 1;

-- Tasks 4: Subquery and its type:

--1. Retrieve the customer(s) with the highest account balance.

Select customer_id , concat(first_name,' ',last_name)  as full_name from Customers where customer_id = (select top 1 customer_id from Accounts order by balance desc);

--2. Calculate the average account balance for customers who have more than one account.

Select avg(balance) as AverageAccountBalance from Accounts where customer_id in(Select customer_id from Accounts group by customer_id having count(account_id)>1);

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.

Select t.account_id, t.transaction_id, t.transaction_type, t.amount from Transactions t where t.amount > (Select avg(amount) from Transactions);

--4. Identify customers who have no recorded transactions.

Insert into Customers Values
(11, 'Abinav', 'Mukund', '2002-05-15', 'abinav@gmail.com', '9876543211', 'Mumbai');

Select customer_id , concat(first_name,' ',last_name)  as full_name from Customers where customer_id not in(Select a.customer_id from Accounts a join Transactions t on a.account_id=t.account_id );

--5. Calculate the total balance of accounts with no recorded transactions.

Select sum(balance) as TotalBalance from Accounts where account_id not in (Select distinct account_id from Transactions);

--6. Retrieve transactions for accounts with the lowest balance.

Select transaction_id from Transactions where account_id=(Select top 1 account_id from Accounts order by balance asc );

--7. Identify customers who have accounts of multiple types.
Insert into Accounts Values(212,102,'Current',6000);

Select concat(first_name,' ',last_name)  as full_name from Customers where customer_id in (select customer_id from Accounts  group by customer_id having count( distinct account_type)>1);

--8. Calculate the percentage of each account type out of the total number of accounts.

Select account_type , sum(balance) as TotalBalance ,format((sum(balance)*100.0 /(Select sum(balance) from Accounts)),'0.00') as PercentageOfAccount from Accounts  group by account_type;

--9. Retrieve all transactions for a customer with a given customer_id.

Declare @CustomerID int =102;
Select t.transaction_id , t.transaction_type , t.transaction_date ,t.account_id , t.amount from Transactions t 
where t.account_id in (select account_id from Accounts a  where a.customer_id = @CustomerID);

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.

Select account_type ,(Select Sum(balance) from Accounts a1 where a1.account_type=a2.account_type) as TotalBalance  FROM Accounts a2 GROUP BY account_type;
