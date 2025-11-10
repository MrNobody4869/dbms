1. install MySQL connector:
pip install mysql-connector-python

-----------------------

CREATE DATABASE college;
USE college;

----------------------------
do below code by creating a py file, paste th code in it then run 

2. code: 

# -------------------------------
# CONNECT TO MYSQL DATABASE
# -------------------------------
con = mysql.connector.connect(
    host="localhost",
    user="root",
    password="yourpassword",
    database="college"
)

cursor = con.cursor()

# -------------------------------
# CREATE TABLE (Run Only Once)
# -------------------------------
cursor.execute("""
CREATE TABLE IF NOT EXISTS student(
    roll INT PRIMARY KEY,
    name VARCHAR(50),
    marks INT
)
""")

# -------------------------------
# FUNCTIONS FOR CRUD OPERATIONS
# -------------------------------

def add_student():
    r = int(input("Enter Roll No: "))
    n = input("Enter Name: ")
    m = int(input("Enter Marks: "))
    query = "INSERT INTO student VALUES (%s, %s, %s)"
    values = (r, n, m)
    cursor.execute(query, values)
    con.commit()
    print("Record Added Successfully!")


def view_students():
    cursor.execute("SELECT * FROM student")
    rows = cursor.fetchall()
    print("\n--- Student Records ---")
    for row in rows:
        print(row)


def edit_student():
    r = int(input("Enter Roll No to Update: "))
    new_marks = int(input("Enter New Marks: "))
    query = "UPDATE student SET marks=%s WHERE roll=%s"
    values = (new_marks, r)
    cursor.execute(query, values)
    con.commit()
    print("Record Updated Successfully!")


def delete_student():
    r = int(input("Enter Roll No to Delete: "))
    query = "DELETE FROM student WHERE roll=%s"
    cursor.execute(query, (r,))
    con.commit()
    print("Record Deleted Successfully!")


# -------------------------------
# MENU-DRIVEN FRONT END
# -------------------------------
while True:
    print("\n1. Add Record")
    print("2. View Records")
    print("3. Edit Record")
    print("4. Delete Record")
    print("5. Exit")

    choice = int(input("Enter your choice: "))

    if choice == 1:
        add_student()
    elif choice == 2:
        view_students()
    elif choice == 3:
        edit_student()
    elif choice == 4:
        delete_student()
    elif choice == 5:
        break
    else:
        print("Invalid Choice!!")

# Close connection
con.close()

---------------------------------



3. how to run: 
py "file_name.py"
































# ---------------------------------------------
# PYTHON MYSQL CRUD PROGRAM (STUDENT DATABASE)
# ---------------------------------------------

# 1. INSTALL MYSQL CONNECTOR
# --------------------------
# Run in terminal/command prompt:
# pip install mysql-connector-python
# This library allows Python to connect and interact with MySQL databases.

# 2. CREATE DATABASE
# ------------------
# Open MySQL command line or workbench and execute:
# CREATE DATABASE college;
# USE college;
# This creates a database called 'college' which we will use.

# 3. IMPORT MYSQL CONNECTOR
# -------------------------
import mysql.connector

# -------------------------------
# CONNECT TO MYSQL DATABASE
# -------------------------------
# Provide your MySQL credentials and database name
con = mysql.connector.connect(
    host="localhost",        # Database host
    user="root",             # MySQL username
    password="yourpassword", # MySQL password
    database="college"       # Database name
)

# Create a cursor object to execute SQL queries
cursor = con.cursor()

# -------------------------------
# CREATE TABLE (Run Only Once)
# -------------------------------
# SQL query to create table if it doesn't exist
cursor.execute("""
CREATE TABLE IF NOT EXISTS student(
    roll INT PRIMARY KEY,       -- Unique Roll Number
    name VARCHAR(50),           -- Student Name
    marks INT                   -- Student Marks
)
""")

# -------------------------------
# FUNCTIONS FOR CRUD OPERATIONS
# -------------------------------

# 1. ADD STUDENT RECORD
def add_student():
    r = int(input("Enter Roll No: "))        # Input Roll Number
    n = input("Enter Name: ")                # Input Name
    m = int(input("Enter Marks: "))          # Input Marks
    query = "INSERT INTO student VALUES (%s, %s, %s)"  # SQL INSERT
    values = (r, n, m)                       # Values to insert
    cursor.execute(query, values)            # Execute query
    con.commit()                             # Commit changes to DB
    print("Record Added Successfully!")

# 2. VIEW ALL STUDENT RECORDS
def view_students():
    cursor.execute("SELECT * FROM student")  # SQL SELECT all
    rows = cursor.fetchall()                  # Fetch all results
    print("\n--- Student Records ---")
    for row in rows:
        print(row)                            # Display each record

# 3. EDIT STUDENT MARKS
def edit_student():
    r = int(input("Enter Roll No to Update: "))    # Select student
    new_marks = int(input("Enter New Marks: "))    # Input new marks
    query = "UPDATE student SET marks=%s WHERE roll=%s"  # SQL UPDATE
    values = (new_marks, r)
    cursor.execute(query, values)                  # Execute query
    con.commit()
    print("Record Updated Successfully!")

# 4. DELETE STUDENT RECORD
def delete_student():
    r = int(input("Enter Roll No to Delete: "))    # Select student
    query = "DELETE FROM student WHERE roll=%s"    # SQL DELETE
    cursor.execute(query, (r,))
    con.commit()
    print("Record Deleted Successfully!")

# -------------------------------
# MENU-DRIVEN FRONT END
# -------------------------------
# Allows user to choose operation repeatedly
while True:
    print("\n--- Student Database Menu ---")
    print("1. Add Record")
    print("2. View Records")
    print("3. Edit Record")
    print("4. Delete Record")
    print("5. Exit")

    choice = int(input("Enter your choice: "))

    if choice == 1:
        add_student()
    elif choice == 2:
        view_students()
    elif choice == 3:
        edit_student()
    elif choice == 4:
        delete_student()
    elif choice == 5:
        break  # Exit program
    else:
        print("Invalid Choice!!")

# Close database connection
con.close()

# ---------------------------------------------
# THEORY / ORAL NOTES
# ---------------------------------------------
# 1. What is MySQL Connector?
#    - A Python library to connect, execute queries, and manage MySQL databases.
# 2. What is a cursor?
#    - Cursor executes SQL commands and fetches results.
# 3. What is commit()?
#    - Saves changes to database permanently.
# 4. CRUD Operations:
#    - C: Create (INSERT)
#    - R: Read (SELECT)
#    - U: Update (UPDATE)
#    - D: Delete (DELETE)
# 5. Why use 'IF NOT EXISTS' in CREATE TABLE?
#    - Prevents error if table already exists.
# 6. Why use parameterized queries (%s)?
#    - Prevents SQL injection attacks and safely passes values.
# 7. Menu-driven approach:
#    - Makes program interactive and allows repeated operations.
# 8. How to run:
#    1. Save code in file, e.g., student_db.py
#    2. Open terminal
#    3. Run: py "student_db.py"
