create database stage;
create schema elt;
USE DATABASE STAGE;
USE SCHEMA ELT;


-- Crear tabla de Dim_date
create TABLE DIM_Date (
  date_id INT PRIMARY KEY,
  date DATE,
  year INT,
  month INT,
  day int
);

-- Crear tabla de Dim_Product
create TABLE DIM_Product (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(50),
  supplier_id INT,
  category_id INT,
  quantity_per_unit VARCHAR(50),
  unit_price NUMERIC(10,2),
  units_in_stock INT,
  units_on_order INT,
  reorder_level INT
);

-- Crear tabla de Dim_Customer
create TABLE DIM_Customer (
  customer_id VARCHAR(16777216) PRIMARY KEY,
  company_name VARCHAR(50),
  contact_name VARCHAR(50),
  contact_title VARCHAR(50),
  address VARCHAR(50),
  city VARCHAR(50),
  region VARCHAR(50),
  postal_code VARCHAR(50),
  country VARCHAR(50),
  phone VARCHAR(50),
  fax VARCHAR(50)
);

-- Crear tabla de DIM_SalesPerson
create TABLE DIM_SalesPerson (
  employee_id INT,
  territory_id INT,
  PRIMARY KEY (employee_id, territory_id)
);

-- Crear tabla de DIM_Supplier
create TABLE DIM_Supplier (
  supplier_id INT PRIMARY KEY,
  company_name VARCHAR(50),
  contact_name VARCHAR(50),
  contact_title VARCHAR(50),
  address VARCHAR(50),
  city VARCHAR(50),
  region VARCHAR(50),
  postal_code VARCHAR(50),
  country VARCHAR(50),
  phone VARCHAR(50),
  fax VARCHAR(50)
);

-- Crear tabla de Dim_Orders
create TABLE DIM_Orders (
  order_id VARCHAR(16777216) PRIMARY KEY,
  customer_id VARCHAR(16777216),
  employee_id VARCHAR(16777216),
  order_date DATE,
  required_date DATE,
  shipped_date DATE,
  freight NUMERIC(10,2),
  ship_name VARCHAR(50),
  ship_address VARCHAR(50),
  ship_city VARCHAR(50),
  ship_region VARCHAR(50),
  ship_postal_code VARCHAR(50),
  ship_country VARCHAR(50)
);

-- Crear tabla de FCT_Sales
create TABLE FCT_Sales (
  sales_id VARCHAR(16777216) PRIMARY KEY,
  date_id VARCHAR(16777216),
  product_id VARCHAR(16777216),
  customer_id VARCHAR(16777216),
  employee_id VARCHAR(16777216),
  quantity INT,
  unit_price NUMERIC(10,2),
  discount NUMERIC(10,2),
  subtotal NUMERIC(10,2),
  total NUMERIC(10,2)
);
