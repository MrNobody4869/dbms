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

























// ===============================================
// THEORY NOTES – MongoDB Aggregation on Books Dataset
// ===============================================

// use Bookstore;
// -- Switches or creates the "Bookstore" database.

// db.books.insertMany([...])
// -- Inserts multiple documents (records) into the "books" collection.
// -- Each document has fields: title, author, genre, price, published_date.

// ===============================================
// AGGREGATION & OPERATIONS CONCEPTS
// ===============================================

// Aggregation
// -- Process of transforming and combining data using pipeline stages like $group, $sort, $match, etc.
// -- Similar to SQL GROUP BY with aggregate functions.

// $group
// -- Groups documents by a specified key (_id).
// -- Used with accumulator operators like $sum, $avg, $max, $min.

// $avg
// -- Calculates the average value of a numeric field across grouped documents.

// $sum
// -- Counts total documents when given as $sum:1 or sums numeric field values when given a field.

// $sort
// -- Sorts documents based on specified field(s).
// -- 1 for ascending order, -1 for descending order.

// $first
// -- Returns the first document in each group (depends on sort order applied before grouping).

// $limit
// -- Restricts the number of documents in the output.

// find().sort()
// -- Used for simple sorting on a collection outside of aggregation.
// -- Example: sort by date descending or price ascending.

// createIndex()
// -- Creates an index on specified fields to speed up query performance.
// -- Example: index on "title" for faster text search and sorting.

// getIndexes()
// -- Displays all indexes defined in a collection.

// ===============================================
// QUERY-WISE EXPLANATION
// ===============================================

// 1️⃣ Average Price of All Books
// -- Groups all documents (_id: null) and calculates the average of 'price' field.

// 2️⃣ Count of Books by Genre
// -- Groups by 'genre' field and counts number of books in each genre using $sum:1.

// 3️⃣ Most Expensive Book in Each Genre
// -- First sorts books in descending order of price.
// -- Then groups by genre and picks the first (highest-priced) book title and price.

// 4️⃣ Author with Maximum Books
// -- Groups by 'author' and counts total books per author.
// -- Sorts result by bookCount descending and limits to 1 author with maximum books.

// 5️⃣ Sort by Published Date (Descending)
// -- Displays books ordered by latest published_date first.

// 6️⃣ Sort by Price (Ascending)
// -- Displays books ordered from lowest to highest price.

// 7️⃣ Index Creation and Viewing
// -- Creates ascending index on title field for faster lookups.
// -- getIndexes() shows all indexes including default _id index.

// ===============================================
// OUTPUT SUMMARY
// ===============================================
// -- Aggregation outputs display computed statistics or grouped data.
// -- find().sort() outputs documents in sorted order.
// -- getIndexes() displays index structure details.


