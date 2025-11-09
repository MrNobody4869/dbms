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

// ===============================================
// Output: Displays all CRUD results in the MongoDB shell
// ===============================================

