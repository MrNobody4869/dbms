

--NOTE: CHANGE VALUES to avoid Suspision.

-- --------------------------------------------------------
-- Step 1: Create all tables with proper constraints
-- --------------------------------------------------------

-- Branch table stores branch details; branch_name is unique, so it's the Primary Key.
CREATE TABLE Branch (
    branch_name VARCHAR(30) PRIMARY KEY,
    branch_city VARCHAR(30) NOT NULL,         -- NOT NULL ensures city name must be entered
    assets_amt DECIMAL(12,2) CHECK (assets_amt >= 0)  -- CHECK ensures asset amount is non-negative
);

-- Account table stores account details; branch_name is a Foreign Key referring to Branch table
CREATE TABLE Account (
    acc_no INT PRIMARY KEY,                   -- Unique account number for each account
    branch_name VARCHAR(30),
    balance DECIMAL(12,2) CHECK (balance >= 0),   -- Ensures balance cannot be negative
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- Customer table stores customer details; cust_name acts as Primary Key for simplicity
CREATE TABLE Customer (
    cust_name VARCHAR(30) PRIMARY KEY,
    cust_street VARCHAR(50) NOT NULL,         -- NOT NULL ensures every customer has a street address
    cust_city VARCHAR(30) NOT NULL            -- NOT NULL ensures city is mandatory
);

-- Depositor links Customer and Account; shows which customer holds which account
CREATE TABLE Depositor (
    cust_name VARCHAR(30),
    acc_no INT,
    PRIMARY KEY (cust_name, acc_no),          -- Composite key ensures unique pair of customer and account
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (acc_no) REFERENCES Account(acc_no)
);

-- Loan table stores details of loans taken; linked to branch_name
CREATE TABLE Loan (
    acc_no INT,
    loan_no INT PRIMARY KEY,                  -- Unique loan number for every loan
    branch_name VARCHAR(30),
    amount DECIMAL(12,2) CHECK (amount >= 0), -- Loan amount must be non-negative
    FOREIGN KEY (branch_name) REFERENCES Branch(branch_name)
);

-- Borrower table connects Customer and Loan to show who borrowed which loan
CREATE TABLE Borrower (
    cust_name VARCHAR(30),
    loan_no INT,
    PRIMARY KEY (cust_name, loan_no),         -- Composite key to avoid duplicate entries
    FOREIGN KEY (cust_name) REFERENCES Customer(cust_name),
    FOREIGN KEY (loan_no) REFERENCES Loan(loan_no)
);




-- --------------------------------------------------------
-- Step 2: Insert sample data into all tables
-- --------------------------------------------------------

-- Insert branches with their details
INSERT INTO Branch VALUES
('Akurdi', 'Pune', 200000),
('Pimpri', 'Pune', 300000),
('Nigdi', 'Pune', 250000);

-- Insert accounts under various branches
INSERT INTO Account VALUES
(101, 'Akurdi', 15000),
(102, 'Pimpri', 18000),
(103, 'Nigdi', 9000),
(104, 'Pimpri', 22000);

-- Insert customer information
INSERT INTO Customer VALUES
('Ravi', 'MG Road', 'Pune'),
('Sneha', 'Station Road', 'Pune'),
('Amit', 'Main Street', 'Pune'),
('Priya', 'College Road', 'Pune');

-- Link customers with their accounts
INSERT INTO Depositor VALUES
('Ravi', 101),
('Sneha', 102),
('Amit', 103);

-- Insert loan details
INSERT INTO Loan VALUES
(201, 5001, 'Akurdi', 10000),
(202, 5002, 'Pimpri', 15000),
(203, 5003, 'Pimpri', 18000);

-- Connect customers with their loans
INSERT INTO Borrower VALUES
('Ravi', 5001),
('Sneha', 5002),
('Priya', 5003);






-- --------------------------------------------------------
-- Step 3: Display all created tables
-- --------------------------------------------------------

SHOW TABLES;   -- Displays list of all tables in the current database



-- 1️⃣ Find the names of all branches in Loan relation
-- DISTINCT ensures duplicate branch names are not repeated
SELECT DISTINCT branch_name FROM Loan;

-- 2️⃣ Find all loan numbers for loans made at Pimpri Branch with amount > 12000
-- WHERE filters rows by branch and amount condition
SELECT loan_no FROM Loan WHERE branch_name = 'Pimpri' AND amount > 12000;

-- 3️⃣ Find all customers who have a loan from bank (name, loan_no, amount)
-- JOIN connects Borrower and Loan using loan_no
SELECT b.cust_name, l.loan_no, l.amount
FROM Borrower b
JOIN Loan l ON b.loan_no = l.loan_no;

-- 4️⃣ List all customers (alphabetical) who have loan from Akurdi branch
-- ORDER BY arranges results alphabetically
SELECT b.cust_name
FROM Borrower b
JOIN Loan l ON b.loan_no = l.loan_no
WHERE l.branch_name = 'Akurdi'
ORDER BY b.cust_name;

-- 5️⃣ Find all customers who have an account OR loan OR both
-- UNION combines both sets, removing duplicates
SELECT DISTINCT cust_name FROM Depositor
UNION
SELECT DISTINCT cust_name FROM Borrower;

-- 6️⃣ Find all customers who have BOTH account and loan
-- INNER JOIN returns only customers present in both Depositor and Borrower tables
SELECT DISTINCT d.cust_name
FROM Depositor d
INNER JOIN Borrower b ON d.cust_name = b.cust_name;

-- 7️⃣ Find average account balance at Pimpri branch
-- AVG() calculates mean balance of all accounts in Pimpri
SELECT AVG(balance) AS avg_balance
FROM Account
WHERE branch_name = 'Pimpri';

-- 8️⃣ Find average account balance at each branch
-- GROUP BY groups records by branch_name for aggregate function
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name;

-- 9️⃣ Find branches where average account balance > 12000
-- HAVING filters grouped results after aggregation
SELECT branch_name, AVG(balance) AS avg_balance
FROM Account
GROUP BY branch_name
HAVING AVG(balance) > 12000;

-- 🔟 Calculate total loan amount given by bank
-- SUM() adds up all loan amounts
SELECT SUM(amount) AS total_loan_amount FROM Loan;



























-- --------------------------------------------------------
-- 🔹 BASIC SQL CONCEPTS USED
-- --------------------------------------------------------

-- DATABASE: A structured collection of data stored and managed electronically.
-- TABLE: A database object that stores data in rows and columns.

-- --------------------------------------------------------
-- 🔹 CONSTRAINTS
-- --------------------------------------------------------

-- PRIMARY KEY: Uniquely identifies each record in a table.
-- FOREIGN KEY: Links two tables; ensures referential integrity.
-- NOT NULL: Ensures a column must have a value (no empty entries).
-- CHECK: Restricts values based on a condition (e.g., amount >= 0).
-- UNIQUE: Ensures all values in a column are different.
-- COMPOSITE KEY: Combination of two or more columns used as a unique key.

-- --------------------------------------------------------
-- 🔹 DATA TYPES
-- --------------------------------------------------------

-- VARCHAR(n): Variable-length string up to n characters.
-- INT: Whole numbers.
-- DECIMAL(p, q): Numeric values with p digits total and q digits after decimal.

-- --------------------------------------------------------
-- 🔹 TABLE RELATIONSHIPS
-- --------------------------------------------------------

-- ONE-TO-MANY: One branch can have many accounts (Branch → Account).
-- MANY-TO-MANY: One customer can have multiple accounts or loans (via Depositor and Borrower).

-- --------------------------------------------------------
-- 🔹 DML (Data Manipulation Language)
-- --------------------------------------------------------

-- INSERT INTO: Adds new records into a table.
-- VALUES: Specifies the data to be inserted.

-- --------------------------------------------------------
-- 🔹 DDL (Data Definition Language)
-- --------------------------------------------------------

-- CREATE TABLE: Defines a new table structure.
-- SHOW TABLES: Lists all tables in the current database.

-- --------------------------------------------------------
-- 🔹 DQL (Data Query Language)
-- --------------------------------------------------------

-- SELECT: Retrieves data from tables.
-- DISTINCT: Removes duplicate values from result set.
-- WHERE: Filters rows based on a condition.
-- ORDER BY: Sorts the result set (ASC by default).
-- GROUP BY: Groups rows sharing a value for aggregation.
-- HAVING: Filters grouped results (used with GROUP BY).

-- --------------------------------------------------------
-- 🔹 SQL JOINS
-- --------------------------------------------------------

-- JOIN / INNER JOIN: Returns records with matching values in both tables.
-- LEFT JOIN: Returns all records from left table and matched records from right.
-- RIGHT JOIN: Returns all records from right table and matched records from left.

-- --------------------------------------------------------
-- 🔹 SET OPERATIONS
-- --------------------------------------------------------

-- UNION: Combines results from multiple SELECTs and removes duplicates.
-- UNION ALL: Combines results but keeps duplicates.

-- --------------------------------------------------------
-- 🔹 AGGREGATE FUNCTIONS
-- --------------------------------------------------------

-- SUM(): Returns total sum of numeric column.
-- AVG(): Returns average (mean) value.
-- COUNT(): Counts number of rows.
-- MIN(): Finds smallest value.
-- MAX(): Finds largest value.

-- --------------------------------------------------------
-- 🔹 QUERY CONCEPTS USED
-- --------------------------------------------------------

-- ALIASING: Using short names for tables (e.g., Borrower b).
-- SUBQUERIES: Query inside another query (not used here, but related concept).
-- CONDITIONAL FILTERING:


