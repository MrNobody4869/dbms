-- ============================================
-- 🧩 Problem Statement 3
-- Write a PL/SQL block (MySQL Stored Procedure) using a parameterized cursor
-- to merge data from N_Roll_Call into O_Roll_Call.
-- If a record already exists in O_Roll_Call, it should be skipped.
-- ============================================


-- ============================================
-- 🏗️ Create Tables
-- Creating two tables: 
-- O_Roll_Call → existing records
-- N_Roll_Call → new incoming records
-- ============================================
CREATE TABLE O_Roll_Call (
  roll_no INT,
  student_name VARCHAR(30),
  attendance_date DATE
);

CREATE TABLE N_Roll_Call (
  roll_no INT,
  student_name VARCHAR(30),
  attendance_date DATE
);
-- ✅ Tables created successfully


-- ============================================
-- 🧾 Insert Sample Data
-- O_Roll_Call already has existing attendance entries
-- N_Roll_Call contains new entries (some overlapping)
-- ============================================
INSERT INTO O_Roll_Call VALUES 
(1, 'Neha', '2024-11-01'),
(2, 'Arjun', '2024-11-01');

INSERT INTO N_Roll_Call VALUES 
(2, 'Arjun', '2024-11-01'),
(3, 'Rohit', '2024-11-02'),
(4, 'Isha', '2024-11-02');
-- ✅ Sample data inserted into both tables


-- ============================================
-- ⚙️ Stored Procedure: merge_roll_call()
-- This procedure merges N_Roll_Call into O_Roll_Call.
-- If a student with the same roll_no and attendance_date already exists,
-- that record is skipped.
-- ============================================
DELIMITER $$

CREATE PROCEDURE merge_rollcall()
BEGIN
    -- Declare local variables
    DECLARE n_roll INT;
    DECLARE n_name VARCHAR(50);
    DECLARE n_date DATE;
    DECLARE done INT DEFAULT 0;
    DECLARE cnt INT DEFAULT 0;
    -- Cursor for new table data
    DECLARE cur CURSOR FOR 
        SELECT roll_no, student_name, attendance_date FROM N_Roll_Call;
    -- Handler to exit loop when no more rows
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Open cursor
    OPEN cur;
    -- Loop through each record in new table
    read_loop: LOOP
        FETCH cur INTO n_roll, n_name, n_date;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Check if record already exists in old table
        SELECT COUNT(*) INTO cnt 
        FROM O_Roll_Call 
        WHERE roll_no = n_roll AND attendance_date = n_date;
        -- If not exists, insert new record
        IF cnt = 0 THEN
            INSERT INTO O_Roll_Call VALUES (n_roll, n_name, n_date);
        END IF;
    END LOOP;

    -- Close cursor
    CLOSE cur;
END$$

DELIMITER ;

-- ✅ Stored procedure created successfully


-- Execute merge procedure, This will merge new data into O_Roll_Call without duplicating existing rows
CALL merge_rollcall();

-- Display merged data
SELECT * FROM O_Roll_Call;





















-- --------------------------------------------------------
-- 🔹 BASIC CONCEPTS USED IN THIS PROGRAM
-- --------------------------------------------------------

-- PL/SQL / STORED PROCEDURE: A block of SQL code stored in the database that executes logic automatically.
-- PARAMETERIZED CURSOR: A cursor that can take parameters to control which data it retrieves (conceptually used here).

-- --------------------------------------------------------
-- 🔹 TABLE CONCEPTS
-- --------------------------------------------------------

-- CREATE TABLE: Defines new tables to store attendance data.
-- O_Roll_Call: Represents existing (old) attendance records.
-- N_Roll_Call: Represents new incoming attendance records.
-- DATA TYPES:
--   INT → Whole numbers (used for roll numbers)
--   VARCHAR(n) → Variable-length string (for names)
--   DATE → Stores calendar dates (attendance dates)

-- --------------------------------------------------------
-- 🔹 SAMPLE DATA INSERTION
-- --------------------------------------------------------

-- INSERT INTO: Adds rows into both old and new roll call tables.
-- Overlapping entries in both tables are used to test duplicate handling.

-- --------------------------------------------------------
-- 🔹 STORED PROCEDURE STRUCTURE
-- --------------------------------------------------------

-- CREATE PROCEDURE merge_rollcall(): Defines the merge operation.
-- BEGIN...END: Marks the start and end of the procedure logic block.
-- DELIMITER $$: Changes statement terminator so the SQL engine doesn’t stop at semicolons inside the procedure.

-- --------------------------------------------------------
-- 🔹 VARIABLE DECLARATIONS
-- --------------------------------------------------------

-- DECLARE: Used to define local variables inside the procedure.
-- n_roll, n_name, n_date: Temporary variables to hold cursor-fetched data.
-- done: Flag to signal when cursor has reached the end.
-- cnt: Counter variable to check for duplicate records.

-- --------------------------------------------------------
-- 🔹 CURSOR USAGE
-- --------------------------------------------------------

-- CURSOR: A pointer that iterates row by row over query results.
-- DECLARE cur CURSOR FOR SELECT...: Cursor defined to read all records from N_Roll_Call.
-- OPEN cur: Activates the cursor for use.
-- FETCH cur INTO...: Retrieves one record at a time into variables.
-- CLOSE cur: Closes the cursor after all rows are processed.

-- --------------------------------------------------------
-- 🔹 HANDLER
-- --------------------------------------------------------

-- DECLARE CONTINUE HANDLER FOR NOT FOUND: Defines action when cursor has no more rows — sets done = 1 to stop looping.

-- --------------------------------------------------------
-- 🔹 LOOP AND CONTROL FLOW
-- --------------------------------------------------------

-- LOOP: Executes repeatedly until explicitly exited.
-- IF done THEN LEAVE read_loop;: Exits loop once all rows are read.
-- SELECT COUNT(*) INTO cnt: Checks if the record already exists in O_Roll_Call.
-- IF cnt = 0 THEN INSERT...: Inserts record only if not already present (prevents duplication).

-- --------------------------------------------------------
-- 🔹 SQL LOGIC IMPLEMENTED
-- --------------------------------------------------------

-- COUNT(*): Counts matching records for duplication check.
-- INSERT INTO: Adds only unique rows to the existing table.
-- WHERE: Filters existing table rows to match roll_no and attendance_date.

-- --------------------------------------------------------
-- 🔹 EXECUTION
-- --------------------------------------------------------

-- CALL merge_rollcall(): Executes the merge process.
-- SELECT * FROM O_Roll_Call: Displays all records after merging (combined old + new without duplicates).

-- --------------------------------------------------------
-- 🔹 GENERAL CONCEPTS
-- --------------------------------------------------------

-- DATA MERGING: Combining new and existing records while avoiding duplication.
-- AUTOMATION: The stored procedure automates this process for efficiency.
-- REUSABILITY: Procedure can be executed anytime to sync data between tables.
-- TRANSACTION SAFETY: Cursor ensures record-by-record controlled insertion.
-- INTEGRITY CHECK: Ensures that no duplicate roll_no with same date is inserted.






