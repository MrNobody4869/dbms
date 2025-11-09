// ===============================================
// Problem Statement – 4
// Aim: Create collections and perform MongoDB CRUD operations.
// Collections: Teachers (Tname, dno, dname, experience, salary, date_of_joining)
//               Students (Sname, roll_no, class)
// ===============================================


//to initialize MongoDB the bash command is mongosh

// Step 1: Create or switch to the database
use collegeDB;

// Step 2: Insert Data into Collections
db.teachers.insertMany([
  { Tname: "Aakash", dno: 1, dname: "COMP", experience: 5, salary: 12000, date_of_joining: "2019-06-15" },
  { Tname: "Neeta", dno: 2, dname: "IT", experience: 8, salary: 9500, date_of_joining: "2018-03-10" },
  { Tname: "Ramesh", dno: 3, dname: "E&TC", experience: 6, salary: 15000, date_of_joining: "2017-08-20" }
]);

db.students.insertMany([
  { Sname: "Tanya", roll_no: 1, class: "FE" },
  { Sname: "Kunal", roll_no: 2, class: "SE" },
  { Sname: "Manav", roll_no: 3, class: "TE" }
]);

// ===============================================
// CRUD Operations
// ===============================================

// 1. Display all teachers alphabetically
db.teachers.find().sort({ Tname: 1 });

// 2. Display teachers belonging to Computer department
db.teachers.find({ dname: "COMP" });

// 3. Display teachers from COMP, IT, and E&TC departments
db.teachers.find({ dname: { $in: ["COMP", "IT", "E&TC"] } });

// 4. Display teachers from COMP, IT, and E&TC with salary >= 10000
db.teachers.find({ dname: { $in: ["COMP", "IT", "E&TC"] }, salary: { $gte: 10000 } });

// 5. Find students whose roll_no = 2 or name = "xyz"
db.students.find({ $or: [{ roll_no: 2 }, { Sname: "xyz" }] });

// 6. Update Aakash’s experience to 10 (insert if not exists)
db.teachers.updateOne(
  { Tname: "Aakash" },
  { $set: { experience: 10 } },
  { upsert: true }
);

// 7. Update department of all IT teachers to COMP
db.teachers.updateMany(
  { dname: "IT" },
  { $set: { dname: "COMP" } }
);

// 8. Display only teacher name and experience
db.teachers.find({}, { Tname: 1, experience: 1, _id: 0 });

// 9. Delete all IT department teachers
db.teachers.deleteMany({ dname: "IT" });

// 10. Display first 3 teachers alphabetically
db.teachers.find().sort({ Tname: 1 }).limit(3).pretty();




























// -----------------------------------------------------------
// 🔹 BASIC MONGODB CONCEPTS USED
// -----------------------------------------------------------

// MongoDB: A NoSQL document-based database storing data in JSON-like format.
// Collection: Equivalent to a table in SQL; holds related documents.
// Document: A single record in MongoDB (like a row in SQL), stored as a JSON object.
// Field: A key-value pair inside a document (like a column in SQL).

// -----------------------------------------------------------
// 🔹 DATABASE CREATION
// -----------------------------------------------------------

// use collegeDB; → Creates or switches to the database named "collegeDB".
// If it doesn’t exist, MongoDB creates it automatically when data is inserted.

// -----------------------------------------------------------
// 🔹 DATA INSERTION
// -----------------------------------------------------------

// insertMany(): Inserts multiple documents into a collection at once.
// db.teachers → Refers to the "teachers" collection inside "collegeDB".
// db.students → Refers to the "students" collection.
// Each document represents a teacher or student with defined fields.

// Example fields:
// Tname → Teacher name
// dno → Department number
// dname → Department name
// experience → Teaching experience (in years)
// salary → Monthly pay
// date_of_joining → Joining date
// Sname → Student name
// roll_no → Unique student number
// class → Academic year/class

// -----------------------------------------------------------
// 🔹 CRUD OPERATIONS
// -----------------------------------------------------------

// CRUD stands for: Create, Read, Update, Delete
// These are the four basic operations performed on data.

// -----------------------------------------------------------
// 🔹 READ OPERATIONS (FIND)
// -----------------------------------------------------------

// find(): Retrieves documents from a collection.
// sort({ field: 1 }): Sorts ascending; (-1 for descending).
// $in: Matches any value within an array.
// $gte: Greater than or equal to (used for numeric filters).
// $or: Matches documents satisfying at least one of multiple conditions.

// Examples:
// find().sort({ Tname: 1 }) → Lists all teachers alphabetically.
// find({ dname: "COMP" }) → Filters teachers from Computer dept.
// find({ dname: { $in: ["COMP", "IT", "E&TC"] } }) → Multiple dept filter.
// find({ salary: { $gte: 10000 } }) → Teachers with salary ≥ 10000.
// find({ $or: [{ roll_no: 2 }, { Sname: "xyz" }] }) → Roll 2 or name “xyz”.

// -----------------------------------------------------------
// 🔹 UPDATE OPERATIONS
// -----------------------------------------------------------

// updateOne(): Updates first matching document.
// updateMany(): Updates all matching documents.
// $set: Modifies or adds specific fields.
// upsert: If record not found, inserts a new one.

// Examples:
// updateOne({ Tname: "Aakash" }, { $set: { experience: 10 } }) → Updates Aakash.
// updateMany({ dname: "IT" }, { $set: { dname: "COMP" } }) → Converts all IT to COMP.

// -----------------------------------------------------------
// 🔹 PROJECTION (SELECT SPECIFIC FIELDS)
// -----------------------------------------------------------

// find({}, { field1: 1, field2: 1, _id: 0 })
// → Shows only specific fields, hides _id when set to 0.

// Example:
// find({}, { Tname: 1, experience: 1, _id: 0 }) → Shows only name & experience.

// -----------------------------------------------------------
// 🔹 DELETE OPERATION
// -----------------------------------------------------------

// deleteMany({ condition }): Deletes all matching documents.
// Example: deleteMany({ dname: "IT" }) → Deletes all IT teachers.

// -----------------------------------------------------------
// 🔹 LIMIT AND FORMAT OUTPUT
// -----------------------------------------------------------

// limit(n): Restricts number of documents shown.
// pretty(): Formats JSON output for readability.

// Example:
// find().sort({ Tname: 1 }).limit(3).pretty()
// → Displays first 3 teachers alphabetically in readable format.

// -----------------------------------------------------------
// 🔹 GENERAL CONCEPTS
// -----------------------------------------------------------

// BSON: MongoDB internally stores documents in Binary JSON (BSON) format.
// Dynamic Schema: Collections can store documents with varying fields.
// No JOINs: MongoDB uses embedding or referencing instead of joins.
// Case-Sensitive Queries: Field names and string values are case-sensitive.
// Default _id Field: Every document automatically gets a unique _id identifier.

// -----------------------------------------------------------
// 🔹 SUMMARY OF PROGRAM LOGIC
// -----------------------------------------------------------

// 1️⃣ Created database `collegeDB`.
// 2️⃣ Created two collections → teachers, students.
// 3️⃣ Inserted sample teacher and student documents.
// 4️⃣ Performed Read (find), Update (updateOne/updateMany), and Delete (deleteMany) operations.
// 5️⃣ Used sort(), limit(), and pretty() for organized output.
// 6️⃣ Final result: Demonstrated full MongoDB CRUD cycle successfully.

