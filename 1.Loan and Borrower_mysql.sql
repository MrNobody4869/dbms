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
