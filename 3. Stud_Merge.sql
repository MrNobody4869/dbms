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
DELIMITER //

CREATE PROCEDURE merge_roll_call()
BEGIN
  INSERT INTO O_Roll_Call (roll_no, student_name, attendance_date)
  SELECT n.roll_no, n.student_name, n.attendance_date
  FROM N_Roll_Call n
  WHERE NOT EXISTS (
    SELECT 1 FROM O_Roll_Call o
    WHERE o.roll_no = n.roll_no
      AND o.attendance_date = n.attendance_date
  );
END;
//

DELIMITER ;
-- ✅ Stored procedure created successfully


-- ============================================
-- ▶️ Execute the Procedure
-- This will merge new data into O_Roll_Call without duplicating existing rows
-- ============================================
CALL merge_roll_call();
-- ✅ Procedure executed successfully


-- ============================================
-- 📊 Display Final Output
-- To verify that the data was merged correctly
-- ============================================
SELECT * FROM O_Roll_Call;
-- ✅ Displays final merged table
