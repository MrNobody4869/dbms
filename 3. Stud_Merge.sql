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

