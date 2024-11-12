-- 1.1creating the customers collection

db.createCollection("customers", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["name", "email", "phone"],
      properties: {
        name: {
          bsonType: "string",
          description: "must be a string and is required"
        },
        email: {
          bsonType: "string",
          description: "must be a string and is required"
        },
        phone: {
          bsonType: "string",
          description: "must be a string and is required"
        },
        address:{
            bsonType: "object",
            required:["city", "street", "zipcode"],
            properties:{
                city:{
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                street:{
                    bsonType: "string",
                    description: "must be a string and is required"
                },
                zipcode:{
                    bsonType: "string",
                    description: "must be a string and is required"
                }
            }
        },
        registration_date:{
            bsonType: "date",
            description: "must be a date and is required"
      }
    }
  }}
});


-- inserting 5 documents into the customers collection
db.customers.insertOne({"name": "John Doe", "email": "johndoe@example.com", "address": { "street": "123 Main St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-1234", "registration_date": ISODate("2023-01-01T12:00:00Z") });

db.customers.insertOne({"name": "Jane Smith", "email": "janesmith@example.com", "address": { "street": "456 Elm St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-5678", "registration_date": ISODate("2023-01-01T12:00:00Z") });

db.customers.insertOne({"name": "Alice Johnson", "email": "alicejhonson@example.com", "address": { "street": "789 Oak St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-9012", "registration_date": ISODate("2023-01-01T12:00:00Z") });

db.customers.insertOne({"name": "Bob Brown", "email": "bobbrown@example.com", "address": { "street": "101 Pine St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-3456", "registration_date": ISODate("2023-01-01T12:00:00Z") });

db.customers.insertOne({"name": "Eve Davis", "email": "evedavis@example.com", "address": { "street": "121 Willow St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-7890", "registration_date": ISODate("2023-01-01T12:00:00Z") });

-- creating the orders collection

db.createCollection("orders", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["customer_id", "total_value", "items", "order_id", "order_date", "status"],
      properties: {
        order_id:{
            bsonType: "int",
            description: "must be an integer and is required"
        },
        customer_id: {
          bsonType: "objectId",
          description: "must be an objectId and is required"
        },
        order_date:{
            bsonType: "date",
            description: "must be a date and is required"
        },
        status:{
            bsonType: "string",
            description: "must be a string and is required"
        },
        items: {
          bsonType: "array",
          description: "must be an array and is required",
          items: {
            bsonType: "object",
            required: ["product_name", "quantity", "price"],
            properties: {
              name: {
                bsonType: "string",
                description: "must be a string and is required"
              },
              quantity: {
                bsonType: "int",
                description: "must be an integer and is required"
              },
              price: {
                bsonType: "int",
                description: "must be a decimal and is required"
            }
          }
        }},
        total_value: {
          bsonType: "int",
          description: "must be a decimal and is required"
      }
    }
  }}
});

-- inserting 5 documents into the orders collection

db.orders.insertOne({"order_id": 1, "customer_id": ObjectId('67337d59809c8ae19c0d8192'), "order_date": ISODate("2023-01-01T12:00:00Z"), "status": "shipped", "items": [{"product_name": "product1", "quantity": 2, "price": 10.00}, {"product_name": "product2", "quantity": 1, "price": 20.00}], "total_value": 40.00 });

db.orders.insertOne({"order_id": 2, "customer_id": ObjectId('67337d7f809c8ae19c0d8193'), "order_date": ISODate("2023-01-01T12:00:00Z"), "status": "shipped", "items": [{"product_name": "product3", "quantity": 3, "price": 30.00}, {"product_name": "product4", "quantity": 2, "price": 40.00}], "total_value": 150.00 });

db.orders.insertOne({"order_id": 3, "customer_id":  ObjectId('67337d93809c8ae19c0d8194'), "order_date": ISODate("2023-01-01T12:00:00Z"), "status": "shipped", "items": [{"product_name": "product5", "quantity": 4, "price": 50.00}, {"product_name": "product6", "quantity": 3, "price": 60.00}], "total_value": 350.00 });

db.orders.insertOne({"order_id": 4, "customer_id": ObjectId('67337dba809c8ae19c0d8195'), "order_date": ISODate("2023-01-01T12:00:00Z"), "status": "shipped", "items": [{"product_name": "product7", "quantity": 5, "price": 70.00}, {"product_name": "product8", "quantity": 4, "price": 80.00}], "total_value": 550.00 });

db.orders.insertOne({"order_id": 5, "customer_id":  ObjectId('67337dd6809c8ae19c0d8196', "order_date": ISODate("2023-01-01T12:00:00Z"), "status": "shipped", "items": [{"product_name": "product9", "quantity": 6, "price": 90.00}, {"product_name": "product10", "quantity": 5, "price": 100.00}], "total_value": 750.00 });


--1.2script to find orders placed by user jhon doe using his customer id

db.orders.find({"customer_id": ObjectId('67337d59809c8ae19c0d8192')});

-- output
-- [
--   {
--     _id: ObjectId('67338158809c8ae19c0d819e'),
--     order_id: 1,
--     customer_id: ObjectId('67337d59809c8ae19c0d8192'),
--     order_date: ISODate('2023-01-01T12:00:00.000Z'),
--     status: 'shipped',
--     items: [
--       { product_name: 'product1', quantity: 2, price: 10 },
--       { product_name: 'product2', quantity: 1, price: 20 }
--     ],
--     total_value: 40
--   }
-- ]

--1.3finding the customer for a specific order using order_id
const customer_id = db.orders.findOne({"order_id": 1}).customer_id;
db.customers.find({"_id": customer_id});
--output
-- [
--   {
--     _id: ObjectId('67337d59809c8ae19c0d8192'),
--     name: 'John Doe',
--     email: 'johndoe@example.com',
--     address: { street: '123 Main St', city: 'Springfield', zipcode: '12345' },
--     phone: '555-1234',
--     registration_date: ISODate('2023-01-01T12:00:00.000Z')
--   }
-- ]


--1.4updating order status to delivered for order_id 1
db.orders.updateOne({"order_id": 1}, {$set: {"status": "delivered"}});
-- output
-- {
--   acknowledged: true,
--   insertedId: null,
--   matchedCount: 1,
--   modifiedCount: 1,
--   upsertedCount: 0
-- }

-- 1.5 deleting an order with order_id 1
db.orders.deleteOne({"order_id": 1});
-- output
-- { acknowledged: true, deletedCount: 1 }


-- 2.1 Write a script to calculate the total value of all orders for each customer. This should return each customer’s name and the total order value.

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $group: {
      _id: "$customer.name",
      total_order_value: { $sum: "$total_value" }
    }
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      total_order_value: 1
    }
  }
]);

-- output
-- [
--   { total_order_value: 750, customer_name: 'Eve Davis' },
--   { total_order_value: 150, customer_name: 'Jane Smith' },
--   { total_order_value: 550, customer_name: 'Bob Brown' },
--   { total_order_value: 350, customer_name: 'Alice Johnson' }
-- ]

-- 2.2 Write a script to group orders by their status (e.g., “shipped”, “delivered”, etc.) and count how many orders are in each status.

db.orders.aggregate([
  {
    $group: {
      _id: "$status",
      count: { $sum: 1 }
    }
  },
  {
    $project: {
      _id: 0,
      status: "$_id",
      count: 1
    }
  }
]);

-- output
-- [ { count: 4, status: 'shipped' } ]

--2.3 Write a script to find each customer and their most recent order. Include customer information such as name, email, and order details (e.g., order_id, total_value).

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $sort: { order_date: -1 }
  },
  {
    $group: {
      _id: "$customer.name",
      email: { $first: "$customer.email" },
      order: {
        $first: {
          order_id: "$order_id",
          total_value: "$total_value"
        }
      }
    }
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      email: 1,
      order: 1
    }
  }
]);

-- output
-- [
--   {
--     email: 'alicejhonson@example.com',
--     order: { order_id: 3, total_value: 350 },
--     customer_name: 'Alice Johnson'
--   },
--   {
--     email: 'bobbrown@example.com',
--     order: { order_id: 4, total_value: 550 },
--     customer_name: 'Bob Brown'
--   },
--   {
--     email: 'janesmith@example.com',
--     order: { order_id: 2, total_value: 150 },
--     customer_name: 'Jane Smith'
--   },
--   {
--     email: 'evedavis@example.com',
--     order: { order_id: 5, total_value: 750 },
--     customer_name: 'Eve Davis'
--   }
-- ]

-- 2.4 Write a script to find the most expensive order for each customer. Return the customer’s name and the details of their most expensive order (e.g., order_id, total_value).

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $sort: { total_value: -1 }
  },
  {
    $group: {
      _id: "$customer.name",
      order: {
        $first: {
          order_id: "$order_id",
          total_value: "$total_value"
        }
      }
    }
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      order: 1
    }
  }
]);

--output

-- [
--   {
--     order: { order_id: 3, total_value: 350 },
--     customer_name: 'Alice Johnson'
--   },
--   {
--     order: { order_id: 4, total_value: 550 },
--     customer_name: 'Bob Brown'
--   },
--   {
--     order: { order_id: 2, total_value: 150 },
--     customer_name: 'Jane Smith'
--   },
--   {
--     order: { order_id: 5, total_value: 750 },
--     customer_name: 'Eve Davis'
--   }
-- ]

-- 3.1 Write a script to find all customers who have placed at least one order in the last 30 days. Return the customer name, email, and the order date for their most recent order.

db.orders.aggregate([
  {
    $match: {
      order_date: {
        $gte: new Date(new Date().getTime() - 30 * 24 * 60 * 60 * 1000)
      }
    }
  },
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $sort: { order_date: -1 }
  },
  {
    $group: {
      _id: "$customer.name",
      email: { $first: "$customer.email" },
      order: {
        $first: {
          order_date: "$order_date"
        }
      }
    }
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      email: 1,
      order: 1
    }
  }
]);

--3.2 Write a script to find all distinct products ordered by a customer with the name “John Doe”. Include the product name and the total quantity ordered.

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $match: {
      "customer.name": "John Doe"
    }
  },
  {
    $unwind: "$items"
  },
  {
    $group: {
      _id: "$items.product_name",
      total_quantity: { $sum: "$items.quantity" }
    }
  },
  {
    $project: {
      _id: 0,
      product_name: "$_id",
      total_quantity: 1
    }
  }
]);

--output
-- [
--   { total_quantity: 1, product_name: 'product2' },
--   { total_quantity: 2, product_name: 'product1' }
-- ]

--3.3 Write a script to find the top 3 customers who have spent the most on orders. Sort the results by total order value in descending order.

db.orders.aggregate([
  {
    $lookup: {
      from: "customers",
      localField: "customer_id",
      foreignField: "_id",
      as: "customer"
    }
  },
  {
    $unwind: "$customer"
  },
  {
    $group: {
      _id: "$customer.name",
      total_order_value: { $sum: "$total_value" }
    }
  },
  {
    $sort: { total_order_value: -1 }
  },
  {
    $limit: 3
  },
  {
    $project: {
      _id: 0,
      customer_name: "$_id",
      total_order_value: 1
    }
  }
]);

--output

-- [
--   { total_order_value: 750, customer_name: 'Eve Davis' },
--   { total_order_value: 550, customer_name: 'Bob Brown' },
--   { total_order_value: 350, customer_name: 'Alice Johnson' }
-- ]

--3.4 Write a script to add a new order for a customer with the name “Jane Smith”. The order should include at least two items, such as “Smartphone” and “Headphones”.

const customer_id = db.customers.findOne({ "name": "Jane Smith" })._id;
db.orders.insertOne({
  "order_id": 6,
  "customer_id": customer_id,
  "order_date": ISODate("2023-01-01T12:00:00Z"),
  "status": "shipped",
  "items": [
    { "product_name": "Smartphone", "quantity": 1, "price": 500.00 },
    { "product_name": "Headphones", "quantity": 1, "price": 100.00 }
  ],
  "total_value": 600.00
});

--output

-- {
--   acknowledged: true,
--   insertedId: ObjectId('673385ca809c8ae19c0d81a4')
-- }