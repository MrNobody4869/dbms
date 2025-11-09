-- Create tables
CREATE TABLE Borrower (
    Roll_no INT PRIMARY KEY,
    Name VARCHAR(50),
    Date_of_Issue DATE,
    Name_of_Book VARCHAR(100),
    Status CHAR(1)
);

CREATE TABLE Fine (
    Roll_no INT,
    Date_of_Fine DATE,
    Amt DECIMAL(10,2)
);

-- Insert sample records
INSERT INTO Borrower VALUES 
(1, 'Ravi', '2025-10-01', 'Book A', 'I'),
(2, 'Sneha', '2025-10-15', 'Book B', 'I'),
(3, 'Karan', '2025-11-01', 'Book C', 'I');


-- Stored Procedure to handle book return and fine calculation
DELIMITER $$

CREATE PROCEDURE ReturnBook(IN p_Roll_no INT, IN p_Book VARCHAR(100))
BEGIN
    DECLARE v_issue_date DATE;
    DECLARE v_status CHAR(1);
    DECLARE v_days INT;
    DECLARE v_fine DECIMAL(10,2) DEFAULT 0;
    DECLARE exit HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'An error occurred while processing the return.' AS Message;
    END;

    -- Retrieve issue date and current status
    SELECT Date_of_Issue, Status INTO v_issue_date, v_status
    FROM Borrower
    WHERE Roll_no = p_Roll_no AND Name_of_Book = p_Book;

    -- Control Structure: Check if book is issued
    IF v_status = 'I' THEN
        SET v_days = DATEDIFF(CURDATE(), v_issue_date);

        -- Fine calculation logic
        IF v_days BETWEEN 15 AND 30 THEN
            SET v_fine = v_days * 5;
        ELSEIF v_days > 30 THEN
            SET v_fine = 30 * 5 + (v_days - 30) * 50;
        ELSE
            SET v_fine = 0;
        END IF;

        -- Update status to 'Returned'
        UPDATE Borrower
        SET Status = 'R'
        WHERE Roll_no = p_Roll_no AND Name_of_Book = p_Book;

        -- Insert into Fine table if fine applicable
        IF v_fine > 0 THEN
            INSERT INTO Fine(Roll_no, Date_of_Fine, Amt)
            VALUES(p_Roll_no, CURDATE(), v_fine);
        END IF;

        SELECT CONCAT('Book returned successfully. Fine: Rs ', v_fine) AS Message;
    ELSE
        SELECT 'Book is already returned or record not found.' AS Message;
    END IF;
END$$

DELIMITER ;

CALL ReturnBook(1, 'Book A');





























-- ===============================================
-- THEORY NOTES – Stored Procedure for Book Return & Fine Calculation
-- ===============================================

-- ===============================================
-- TABLE CREATION
-- ===============================================

-- Borrower Table
-- Stores details of each book borrowed by a student.
-- Fields:
-- Roll_no      → Unique ID of student (Primary Key)
-- Name         → Student name
-- Date_of_Issue→ Date when the book was issued
-- Name_of_Book → Title of the borrowed book
-- Status       → 'I' for Issued, 'R' for Returned

-- Fine Table
-- Stores fine details for late book returns.
-- Fields:
-- Roll_no      → Student ID (Foreign key reference to Borrower)
-- Date_of_Fine → Date when fine was applied
-- Amt          → Fine amount charged

-- ===============================================
-- SAMPLE DATA
-- ===============================================
-- INSERT INTO Borrower VALUES (...);
-- Adds sample borrower records with issue dates and book names.

-- ===============================================
-- STORED PROCEDURE OVERVIEW
-- ===============================================
-- Procedure Name: ReturnBook
-- Purpose: Automates book return and calculates applicable fine.
-- Parameters:
--   p_Roll_no → Student’s roll number
--   p_Book    → Name of book being returned

-- ===============================================
-- DECLARATIONS
-- ===============================================
-- DECLARE v_issue_date DATE;        → To store issue date from Borrower table.
-- DECLARE v_status CHAR(1);         → To store current issue status ('I' or 'R').
-- DECLARE v_days INT;               → To calculate number of days since issue.
-- DECLARE v_fine DECIMAL(10,2);     → To calculate total fine amount.
-- DECLARE exit HANDLER FOR SQLEXCEPTION ...;
--    → Error handling block that executes if any SQL error occurs.

-- ===============================================
-- MAIN LOGIC EXPLANATION
-- ===============================================

-- 1. Retrieve book issue details
-- SELECT Date_of_Issue, Status INTO v_issue_date, v_status
-- Fetches the issue date and current status of the book for the given roll number.

-- 2. Check if the book is currently issued
-- IF v_status = 'I' THEN
-- Proceeds only if book is issued and not already returned.

-- 3. Calculate days between issue date and today
-- SET v_days = DATEDIFF(CURDATE(), v_issue_date);
-- Finds how many days the book has been borrowed.

-- 4. Fine Calculation Logic
-- Based on duration of borrowing:
--    0–14 days → No fine
--    15–30 days → Rs 5 per day
--    >30 days  → Rs 5 per day for first 30 days + Rs 50 per day beyond 30
-- Uses nested IF–ELSEIF–ELSE control structure.

-- 5. Update Borrower Status
-- UPDATE Borrower SET Status = 'R'
-- Marks the book as returned.

-- 6. Insert Fine Record (if applicable)
-- INSERT INTO Fine(Roll_no, Date_of_Fine, Amt)
-- Records the fine details in the Fine table if fine amount > 0.

-- 7. Display Result
-- SELECT CONCAT('Book returned successfully. Fine: Rs ', v_fine)
-- Returns confirmation message with calculated fine.

-- ELSE condition
-- Displays message if the book is already returned or record not found.

-- ===============================================
-- HANDLER SECTION
-- ===============================================
-- DECLARE EXIT HANDLER FOR SQLEXCEPTION
-- Handles unexpected SQL errors gracefully by showing a custom error message.

-- ===============================================
-- PROCEDURE CALL
-- ===============================================
-- CALL ReturnBook(1, 'Book A');
-- Executes procedure for student Roll_no 1 returning "Book A".

-- ===============================================
-- OUTPUT SUMMARY
-- ===============================================
-- Possible Outputs:
-- → "Book returned successfully. Fine: Rs 0"
-- → "Book returned successfully. Fine: Rs 75"
-- → "Book is already returned or record not found."
-- → "An error occurred while processing the return."

-- ===============================================
-- KEY CONCEPTS USED
-- ===============================================
-- 1. Stored Procedure – Block of SQL statements executed together.
-- 2. Control Structures – IF, ELSEIF, ELSE for decision making.
-- 3. DATEDIFF() – Calculates days between two dates.
-- 4. CURDATE() – Fetches current system date.
-- 5. Error Handling – HANDLER ensures procedure doesn’t terminate abruptly.
-- 6. Transactional Update – Updates borrower record and logs fine if needed.


