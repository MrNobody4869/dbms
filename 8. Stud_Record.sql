

-- Create Student Table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY AUTO_INCREMENT,
    Student_Name VARCHAR(50),
    Class VARCHAR(20),
    Address VARCHAR(100),
    Subject_Name VARCHAR(50),
    Grades CHAR(2),
    Attendance INT,                -- Attendance percentage
    Enrollment_Date DATE
);

-- Insert Sample Data
INSERT INTO Student (Student_Name, Class, Address, Subject_Name, Grades, Attendance, Enrollment_Date)
VALUES
('Ronit', 'FY BTech AI-DS', 'Pune', 'Mathematics', 'A', 92, '2025-07-01'),
('Aditya', 'FY BTech AI-DS', 'Mumbai', 'Data Science', 'B+', 85, '2025-07-01'),
('Rony', 'FY BTech AI-DS', 'Nashik', 'Programming', 'A', 95, '2025-07-01'),
('Tony', 'FY BTech AI-DS', 'Kolhapur', 'Physics', 'B', 70, '2025-07-01');

-- Create Index on Student Name
CREATE INDEX idx_student_name ON Student (Student_Name);

-- View: Student Performance Summary
CREATE OR REPLACE VIEW vw_student_performance AS
SELECT 
    Student_Name,
    Class,
    Subject_Name,
    Grades
FROM Student;

-- View: Attendance Summary with Remarks
CREATE OR REPLACE VIEW vw_attendance_summary AS
SELECT 
    Student_Name,
    Class,
    Attendance,
    CASE 
        WHEN Attendance >= 90 THEN 'Excellent'
        WHEN Attendance BETWEEN 75 AND 89 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS Attendance_Remark
FROM Student;

-- Display Data from Views
SELECT * FROM vw_student_performance;
SELECT * FROM vw_attendance_summary;

-- Show Index Details
SHOW INDEX FROM Student;
























-- ===============================================
-- THEORY NOTES – Student Table, Views & Index Creation
-- ===============================================

-- ===============================================
-- TABLE CREATION
-- ===============================================

-- Student Table:
-- Stores complete academic and attendance information of students.
-- Fields:
--   Student_ID       → Unique identifier for each student (Primary Key, Auto Increment)
--   Student_Name     → Name of the student
--   Class            → Current class or program enrolled
--   Address          → City or location of the student
--   Subject_Name     → Subject associated with the record
--   Grades           → Academic grade achieved (A, B+, etc.)
--   Attendance       → Attendance percentage (integer value)
--   Enrollment_Date  → Date of joining the course

-- Concepts Used:
--   → PRIMARY KEY ensures each student has a unique identifier.
--   → AUTO_INCREMENT automatically generates Student_ID values.
--   → VARCHAR used for textual data; CHAR used for fixed-length grades.

-- ===============================================
-- SAMPLE DATA INSERTION
-- ===============================================
-- INSERT INTO Student (...) VALUES (...);
-- Adds sample student records with grades, subjects, and attendance percentages.

-- Purpose:
-- Provides data for further operations like indexing and creating views.

-- ===============================================
-- INDEX CREATION
-- ===============================================

-- CREATE INDEX idx_student_name ON Student (Student_Name);
-- Creates a non-clustered index on 'Student_Name' column.

-- Concept:
--   → Index improves search and sorting performance on Student_Name.
--   → Especially useful for queries with WHERE or ORDER BY clauses.
--   → Syntax: CREATE INDEX index_name ON table_name (column_name);

-- SHOW INDEX FROM Student;
-- Displays details about all indexes on the Student table, including key name, column name, and type.

-- ===============================================
-- VIEW CREATION
-- ===============================================

-- What is a View?
--   → A view is a virtual table based on the result of a SELECT query.
--   → It does not store data itself; it presents data dynamically from base tables.
--   → Used for simplifying queries and improving data security.

-- ===============================================
-- View 1: vw_student_performance
-- ===============================================

-- CREATE OR REPLACE VIEW vw_student_performance AS
-- SELECT Student_Name, Class, Subject_Name, Grades FROM Student;

-- Purpose:
--   → To display academic performance summary (subject and grades).
--   → Focuses only on relevant columns — hides address, attendance, etc.
--   → Simplifies reporting of grades per student.

-- Concepts Used:
--   → CREATE OR REPLACE VIEW replaces existing view if already present.
--   → SELECT statement defines columns visible through the view.

-- ===============================================
-- View 2: vw_attendance_summary
-- ===============================================

-- CREATE OR REPLACE VIEW vw_attendance_summary AS
-- SELECT Student_Name, Class, Attendance,
-- CASE
--     WHEN Attendance >= 90 THEN 'Excellent'
--     WHEN Attendance BETWEEN 75 AND 89 THEN 'Good'
--     ELSE 'Needs Improvement'
-- END AS Attendance_Remark
-- FROM Student;

-- Purpose:
--   → Displays attendance performance and provides a remark based on attendance percentage.
--   → Uses CASE expression for conditional evaluation.

-- Concepts Used:
--   → CASE WHEN THEN ELSE END – control structure for conditional logic.
--   → BETWEEN operator to check attendance range.
--   → Aliasing – “Attendance_Remark” as derived column name.

-- ===============================================
-- DATA RETRIEVAL FROM VIEWS
-- ===============================================
-- SELECT * FROM vw_student_performance;
-- SELECT * FROM vw_attendance_summary;

-- Purpose:
--   → To retrieve summarized information from both views.
--   → Data fetched dynamically from base Student table.

-- ===============================================
-- OUTPUT SUMMARY
-- ===============================================
-- View 1 (vw_student_performance):
--   Displays → Student_Name | Class | Subject_Name | Grades

-- View 2 (vw_attendance_summary):
--   Displays → Student_Name | Class | Attendance | Attendance_Remark

-- SHOW INDEX FROM Student:
--   Displays → Details of index (idx_student_name) created on Student_Name column.

-- ===============================================
-- KEY CONCEPTS USED
-- ===============================================
-- 1. CREATE TABLE – Define structure of a relational table.
-- 2. AUTO_INCREMENT – Automatically generate unique numeric IDs.
-- 3. CREATE INDEX – Optimize search and sorting on specific columns.
-- 4. VIEW – Virtual table created from SELECT queries.
-- 5. CASE Expression – Implements conditional logic in SQL queries.
-- 6. SELECT * FROM view_name – Used to query data from a defined view.
-- 7. SHOW INDEX – Displays metadata about created indexes.

