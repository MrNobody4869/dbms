-- Problem Statement 2: Categorize students into grades based on their marks using a stored procedure.

-- Create input table for storing student names and total marks
CREATE TABLE Stud_Marks(
  name VARCHAR(30),
  total_marks INT
);

-- Create output table to store results with roll number and category
CREATE TABLE Result(
  roll INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30),
  class VARCHAR(30)
);

-- Insert sample student data
INSERT INTO Stud_Marks VALUES
('Riya', 1450),
('Aarav', 960),
('Meera', 880),
('Kiran', 800);

-- Stored procedure to assign class category to each student based on total marks
DELIMITER //

CREATE PROCEDURE proc_Grade()
BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE v_name VARCHAR(30);
  DECLARE v_marks INT;
  DECLARE v_class VARCHAR(30);
  DECLARE cur CURSOR FOR SELECT name, total_marks FROM Stud_Marks;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO v_name, v_marks;
    IF done THEN
      LEAVE read_loop;
    END IF;

    IF v_marks BETWEEN 990 AND 1500 THEN
      SET v_class = 'Distinction';
    ELSEIF v_marks BETWEEN 900 AND 989 THEN
      SET v_class = 'First Class';
    ELSEIF v_marks BETWEEN 825 AND 899 THEN
      SET v_class = 'Higher Second Class';
    ELSE
      SET v_class = 'Fail';
    END IF;

    INSERT INTO Result(name, class) VALUES (v_name, v_class);
  END LOOP;
  CLOSE cur;
END;
//

DELIMITER ;

-- Execute the stored procedure to categorize students
CALL proc_Grade();

-- Display final categorized results
SELECT * FROM Result;


























-- --------------------------------------------------------
-- 🔹 BASIC CONCEPTS USED IN THIS PROGRAM
-- --------------------------------------------------------

-- STORED PROCEDURE: A precompiled block of SQL code stored in the database, executed when called.

-- PROCEDURAL SQL: Allows using logic (loops, conditions, variables) inside SQL programs.

-- DELIMITER: Temporarily changes the statement-ending character so that SQL engine doesn't stop at semicolons inside procedures.

-- --------------------------------------------------------
-- 🔹 TABLE CONCEPTS
-- --------------------------------------------------------

-- CREATE TABLE: Defines a new table structure.
-- AUTO_INCREMENT: Automatically generates sequential numeric values for each new record (used for roll numbers).
-- PRIMARY KEY: Uniquely identifies each record in a table.
-- VARCHAR(n): Variable-length string data type.
-- INT: Integer numeric data type.

-- --------------------------------------------------------
-- 🔹 SAMPLE DATA INSERTION
-- --------------------------------------------------------

-- INSERT INTO: Adds data (student name and marks) into the 'Stud_Marks' table.

-- --------------------------------------------------------
-- 🔹 STORED PROCEDURE STRUCTURE
-- --------------------------------------------------------

-- CREATE PROCEDURE proc_Grade(): Defines a stored procedure named 'proc_Grade'.
-- BEGIN...END: Marks the start and end of the procedure body.

-- --------------------------------------------------------
-- 🔹 VARIABLES & DECLARATIONS
-- --------------------------------------------------------

-- DECLARE: Defines local variables inside a stored procedure.
-- done: A flag variable used to detect the end of data.
-- v_name, v_marks, v_class: Temporary variables to store fetched data.

-- --------------------------------------------------------
-- 🔹 CURSORS
-- --------------------------------------------------------

-- CURSOR: A database pointer used to fetch query results row by row.
-- DECLARE cur CURSOR FOR SELECT...: Defines a cursor to loop through each student record.
-- OPEN cur: Activates the cursor for use.
-- FETCH cur INTO: Retrieves one row at a time into variables.
-- CLOSE cur: Closes the cursor after processing.

-- --------------------------------------------------------
-- 🔹 HANDLERS
-- --------------------------------------------------------

-- DECLARE CONTINUE HANDLER FOR NOT FOUND: Defines what happens when no more rows are available — here it sets 'done = 1'.

-- --------------------------------------------------------
-- 🔹 LOOPING AND CONTROL STRUCTURES
-- --------------------------------------------------------

-- LOOP: Repeats code until explicitly exited.
-- LEAVE: Exits the current loop when condition is met.
-- IF...ELSEIF...ELSE: Conditional branching to check mark ranges and assign grade.

-- --------------------------------------------------------
-- 🔹 LOGIC IMPLEMENTED
-- --------------------------------------------------------

-- Marks 990–1500 → 'Distinction'
-- Marks 900–989  → 'First Class'
-- Marks 825–899  → 'Higher Second Class'
-- Marks <825     → 'Fail'

-- SET: Assigns value to a variable.

-- --------------------------------------------------------
-- 🔹 INSERTING RESULTS
-- --------------------------------------------------------

-- INSERT INTO Result(name, class): Adds processed student name and grade category to the Result table.

-- --------------------------------------------------------
-- 🔹 EXECUTION
-- --------------------------------------------------------

-- CALL proc_Grade(): Executes the stored procedure.
-- SELECT * FROM Result: Displays all final categorized records.

-- --------------------------------------------------------
-- 🔹 GENERAL CONCEPTS
-- --------------------------------------------------------

-- DML (Data Manipulation Language): Used for inserting or updating data (INSERT, UPDATE).
-- DDL (Data Definition Language): Used for defining structures (CREATE TABLE).
-- PROCEDURAL EXTENSIONS: MySQL allows using loops and logic via stored procedures.
-- REUSABILITY: Stored procedures can be executed multiple times without rewriting SQL code.
-- AUTOMATION: Reduces manual data entry for repetitive classification or calculations.
