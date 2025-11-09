// ===============================================
// Problem Statement – 5
// Aim: Perform MongoDB Aggregation operations on a books dataset.
// Fields: title, author, genre, price, published_date
// ===============================================

// Step 1: Create or switch to the database
use Bookstore;

// Step 2: Insert sample data into the "books" collection
db.books.insertMany([
  { title: "Echoes of Tomorrow", author: "Ravi Sharma", genre: "Fiction", price: 500, published_date: ISODate("2021-01-10") },
  { title: "Whispers in the Fog", author: "Anita Rao", genre: "Mystery", price: 600, published_date: ISODate("2020-05-15") },
  { title: "The Last Horizon", author: "Ravi Sharma", genre: "Fiction", price: 700, published_date: ISODate("2022-07-20") },
  { title: "Stars Beyond Reach", author: "Karan Mehta", genre: "Sci-Fi", price: 800, published_date: ISODate("2021-11-05") },
  { title: "The Hidden Truth", author: "Anita Rao", genre: "Mystery", price: 550, published_date: ISODate("2019-09-12") }
]);

// ===============================================
// Aggregation Queries
// ===============================================

// 1. Find the average price of all books
db.books.aggregate([
  { $group: { _id: null, avgPrice: { $avg: "$price" } } }
]);

// 2. Find the count of books in each genre
db.books.aggregate([
  { $group: { _id: "$genre", count: { $sum: 1 } } }
]);

// 3. For each genre, find the most expensive book
db.books.aggregate([
  { $sort: { price: -1 } },
  { $group: { _id: "$genre", mostExpensiveBook: { $first: "$title" }, price: { $first: "$price" } } }
]);

// 4. Find the authors who have written maximum number of books
db.books.aggregate([
  { $group: { _id: "$author", bookCount: { $sum: 1 } } },
  { $sort: { bookCount: -1 } },
  { $limit: 1 }
]);

// 5. Sort books by published_date in descending order
db.books.find().sort({ published_date: -1 }).pretty();

// 6. Sort books by price in ascending order
db.books.find().sort({ price: 1 }).pretty();

// 7. Create an index on title and describe the index details
db.books.createIndex({ title: 1 });
db.books.getIndexes();

// ===============================================
// Output: Displays aggregation results and index details in the shell
// ===============================================


