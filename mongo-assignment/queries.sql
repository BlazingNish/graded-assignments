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