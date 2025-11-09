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



