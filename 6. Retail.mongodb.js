// Create or switch to database
use RetailDB;

// Step 1: Insert Sample Data into Collection
db.customer.insertMany([
  { cid: 1, cname: "Ravi", amount: 500, product_name: "Laptop" },
  { cid: 2, cname: "Sneha", amount: 300, product_name: "Phone" },
  { cid: 1, cname: "Ravi", amount: 200, product_name: "Mouse" },
  { cid: 3, cname: "Karan", amount: 400, product_name: "Keyboard" },
  { cid: 2, cname: "Sneha", amount: 100, product_name: "Charger" }
]);

// The map function emits each customer's name and their amount spent
var mapFunction = function() {
    emit(this.cname, this.amount);
};

// The reduce function adds up all the emitted values for each customer
var reduceFunction = function(key, values) {
    return Array.sum(values);
};

// Running the MapReduce job to aggregate total spending per customer
db.customer.mapReduce(
    mapFunction,
    reduceFunction,
    { out: "customer_total_amount" }
);

// View the summarized total amount spent by each customer
db.customer_total_amount.find().pretty();























// ===============================================
// THEORY NOTES – MongoDB MapReduce on Customer Dataset
// ===============================================

// use RetailDB;
// -- Switches or creates the "RetailDB" database for performing operations.

// ===============================================
// CONCEPT OVERVIEW
// ===============================================

// MapReduce
// -- A data processing model used to perform aggregation on large datasets.
// -- It has two main functions: map and reduce.
// -- Similar to SQL GROUP BY with aggregate functions like SUM or AVG.

// map() function
// -- Emits (key, value) pairs for each document.
// -- Here, key = customer name (cname), value = amount spent.

// reduce() function
// -- Receives all values for a given key from the map phase.
// -- Performs aggregation (like summing or averaging) on those values.
// -- Returns a single value per key.

// emit(key, value)
// -- A built-in function used in the map phase to output data pairs for processing.

// Array.sum(values)
// -- Sums all numeric values in the array passed from the map phase to reduce phase.

// out parameter
// -- Specifies the name of the output collection where results will be stored.
// -- Example: { out: "customer_total_amount" } stores results in a new collection.

// ===============================================
// QUERY-WISE EXPLANATION
// ===============================================

// db.customer.insertMany([...])
// -- Inserts multiple documents into the "customer" collection with fields:
//    cid (customer ID), cname (name), amount (purchase amount), product_name (product bought).

// var mapFunction = function() { emit(this.cname, this.amount); };
// -- Emits each customer’s name as key and amount spent as value.

// var reduceFunction = function(key, values) { return Array.sum(values); };
// -- Receives customer name and all their spending values, sums total spending per customer.

// db.customer.mapReduce(mapFunction, reduceFunction, { out: "customer_total_amount" });
// -- Executes MapReduce operation to compute total spending of each customer.
// -- Stores result in new collection named "customer_total_amount".

// db.customer_total_amount.find().pretty();
// -- Displays the final summarized results.
// -- Each document contains:
//    _id: customer name,
//    value: total amount spent.

// ===============================================
// OUTPUT SUMMARY
// ===============================================
// -- Shows each customer with their total spending aggregated from multiple purchases.
// -- Example Output:
//    { "_id": "Ravi", "value": 700 }
//    { "_id": "Sneha", "value": 400 }
//    { "_id": "Karan", "value": 400 }

// ===============================================
// KEY DIFFERENCE: MAPREDUCE vs AGGREGATION
// ===============================================
// -- MapReduce is script-based, suitable for complex data processing logic.
// -- Aggregation pipeline is faster and preferred for straightforward aggregations.




