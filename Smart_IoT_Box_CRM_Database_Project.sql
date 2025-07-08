
-- Smart IoT Box CRM Database Schema

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    contact_info TEXT,
    preferences TEXT
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    model_name VARCHAR(255),
    version VARCHAR(50),
    features TEXT,
    price DECIMAL(10, 2)
);

CREATE TABLE Item (
    item_id INT PRIMARY KEY,
    name VARCHAR(255),
    specification TEXT
);

CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY,
    name VARCHAR(255),
    contact_info TEXT
);

CREATE TABLE Product_Item (
    product_id INT,
    item_id INT,
    PRIMARY KEY (product_id, item_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE Supplier_Item (
    supplier_id INT,
    item_id INT,
    PRIMARY KEY (supplier_id, item_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY,
    supplier_id INT,
    shipment_date DATE,
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Shipment_Item (
    shipment_id INT,
    item_id INT,
    quantity INT,
    PRIMARY KEY (shipment_id, item_id),
    FOREIGN KEY (shipment_id) REFERENCES Shipment(shipment_id),
    FOREIGN KEY (item_id) REFERENCES Item(item_id)
);

CREATE TABLE "Order" (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE Order_Product (
    order_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    name VARCHAR(255),
    role VARCHAR(100)
);

CREATE TABLE Support_Ticket (
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    employee_id INT,
    product_id INT,
    order_id INT,
    issue_description TEXT,
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);

CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_id INT,
    comments TEXT,
    rating INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (order_id) REFERENCES "Order"(order_id)
);

-- Example queries
-- 1. List all orders made by a customer
-- SELECT * FROM "Order" WHERE customer_id = 1;

-- 2. Get all products in an order
-- SELECT p.* FROM Product p JOIN Order_Product op ON p.product_id = op.product_id WHERE op.order_id = 1023;

-- 3. Find all tickets handled by a specific employee
-- SELECT * FROM Support_Ticket WHERE employee_id = 2;

-- 4. Get all items supplied by a specific supplier
-- SELECT i.* FROM Item i JOIN Supplier_Item si ON i.item_id = si.item_id WHERE si.supplier_id = 1;
