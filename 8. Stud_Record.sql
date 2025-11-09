

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
