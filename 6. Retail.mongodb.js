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

