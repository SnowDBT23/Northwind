-- Establecer la base de datos y schema
USE DATABASE Stage;
USE SCHEMA ELT;


-- Insertar datos a  DIM_Date
INSERT INTO DIM_DATE (date_id, date, year, month, day)
SELECT DISTINCT 
    DATEDIFF(day, '1990-01-01', CAST(OrderDate AS DATE)) AS date_id,
    CAST(OrderDate AS TIMESTAMP) AS date, 
    YEAR(CAST(OrderDate AS DATE)) AS year, 
    MONTH(CAST(OrderDate AS DATE)) AS month,
    DAY(CAST(OrderDate AS DATE)) AS day
FROM NORTHWIND.nw.orders;


//Exito. Ejecutar select si lo halla necesario Select*from dim_date




-- Insertar datos a DIM_product
INSERT INTO dim_product (product_id, product_name, supplier_id, category_id, quantity_per_unit, unit_price, units_in_stock, units_on_order, reorder_level)
SELECT ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel
FROM Northwind.nw.Products;

//Exito. Ejecutar select si lo halla necesario Select*from dim_product



-- insertar datos a dim_customer
INSERT INTO dim_customer (customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax
FROM Northwind.nw.Customers;

//Exito. Ejecutar select si lo halla necesario Select*from dim_customer



--- insertar datos a dim_SalesPerson
INSERT INTO DIM_SalesPerson (employee_id, territory_id)
SELECT EmployeeID, TerritoryID
FROM Northwind.nw.Employee_Territories
GROUP BY EmployeeID, TerritoryID;


//Exito. Ejecutar select si lo halla necesario Select*from dim_salesperson



-- insertar datos a dim_Supplier
INSERT INTO DIM_SUPPLIER (supplier_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax)
SELECT SupplierID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax
FROM Northwind.nw.Suppliers;

//Exito. Ejecutar select si lo halla necesario Select*from dim_supplier



-- insertar datos a dim_Orders
INSERT INTO DIM_Orders (order_id, customer_id, employee_id, order_date, required_date, shipped_date, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country)
SELECT OrderID, CustomerID, EmployeeID, TRY_TO_DATE(OrderDate), TRY_TO_DATE(RequiredDate), TRY_TO_DATE(ShippedDate), Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
FROM Northwind.nw.Orders;

//Exito. Ejecutar select si lo halla necesario Select*from dim_orders


-- insertar datos a fct_sales
INSERT INTO stage.elt.FCT_Sales (sales_id, date_id, product_id, customer_id, employee_id, quantity, unit_price, discount, subtotal, total)
SELECT o.OrderID AS sales_id, 
  DATE_PART(year, CAST(o.OrderDate AS DATE))*10000+DATE_PART(month, CAST(o.OrderDate AS DATE))*100+DATE_PART(day, CAST(o.OrderDate AS DATE)) AS date_id, 
  od.ProductID AS product_id, 
  o.CustomerID AS customer_id, 
  o.EmployeeID AS employee_id, 
  od.Quantity AS quantity, 
  od.UnitPrice AS unit_price, 
  od.Discount AS discount, 
  od.Quantity * od.UnitPrice AS subtotal,
  od.Quantity * od.UnitPrice * (1 - od.Discount) AS total
FROM northwind.nw.Orders o
JOIN northwind.nw.Order_Details od ON o.OrderID = od.OrderID;


//Exito. Ejecutar select si lo halla necesario Select*from fct_sales



