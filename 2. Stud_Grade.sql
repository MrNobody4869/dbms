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

-- Explanation:
-- 1. 'Stud_Marks' table holds student names and total marks.
-- 2. 'Result' table stores categorized grades.
-- 3. The stored procedure 'proc_Grade' reads each student record using a cursor.
-- 4. Marks are checked and categorized into Distinction, First Class, Higher Second Class, or Fail.
-- 5. The categorized result is inserted into the Result table.
-- 6. 'CALL proc_Grade()' executes the grading process, and final results are displayed with SELECT.
