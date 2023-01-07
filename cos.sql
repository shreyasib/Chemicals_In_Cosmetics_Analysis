-- Create Database
CREATE DATABASE project;

-- Pick the Database
USE project;

-- Create Table
CREATE TABLE cosmetics(
product_id INT,
product_name VARCHAR(40),
flavor_id INT,
flavor_name VARCHAR(40),
company_id INT,
company_name VARCHAR(40),
brand_name CHAR(40),
category_id INT,
category_name VARCHAR(40),
sub_id INT,
sub_name VARCHAR(40),
cas_id INT,
cas_name VARCHAR(40),
chemical_num INT,
chemical_name VARCHAR(40),
date_created DATE,
date_modified DATE,
chem_date_reported DATE,
chem_date_modified DATE,
chem_count INT)

-- View Table
SELECT * FROM cosmetics 
LIMIT 10;

------------------------
-- EXPLORING OUR DATA --
------------------------

-- Shape of Dataset
SELECT COUNT(*) AS row_num FROM cosmetics;

--- 27349

SELECT COUNT(*) AS col_num
FROM information_schema.columns
WHERE table_name = 'cosmetics';

--- 20

-- Total number of Products
SELECT COUNT(DISTINCT(product_name)) FROM cosmetics;

--- 2592

-- Total number of Brands
SELECT COUNT(DISTINCT(brand_name)) FROM cosmetics;

--- 323

-- Total number of Companies
SELECT COUNT(DISTINCT(company_name)) FROM cosmetics;

--- 179

-- The number of Chemicals
SELECT COUNT(DISTINCT(chemical_name)) FROM cosmetics;
SELECT DISTINCT(chemical_name) FROM cosmetics;

--- 35

-- Check the distinct values in all columns
SELECT DISTINCT(product_name) FROM cosmetics;
SELECT DISTINCT(company_name) FROM cosmetics;
SELECT DISTINCT(flavor_name) FROM cosmetics;
SELECT DISTINCT(brand_name) FROM cosmetics;
SELECT DISTINCT(category_name) FROM cosmetics;
SELECT DISTINCT(sub_name) FROM cosmetics;
SELECT DISTINCT(cas_name) FROM cosmetics;

SELECT DISTINCT(chem_count) FROM cosmetics;

--- At most, products have 5 chemicals in them

-- TOP 10 PRODUCTS
SELECT product_name, COUNT(*) AS count
FROM cosmetics
GROUP BY product_name
ORDER BY COUNT(*) DESC
LIMIT 10;

--- Top product is Eye color, Nail polish and Eye Shadow.

-- TOP 5 BRANDS
SELECT brand_name, COUNT(product_name) AS count FROM cosmetics
GROUP BY brand_name
ORDER BY COUNT(product_name) DESC
LIMIT 5;

--- Top brand is bareMinerals with 2188 products.

-- TOP 5 CATEGORY
SELECT DISTINCT(category_name), COUNT(category_id) AS count
FROM cosmetics
GROUP BY category_name
ORDER BY COUNT(category_id) DESC
LIMIT 5;

--- Top Category is Makeup products ,followed by Nail Products and Sun-related products.

-- TOP 10 SUBCATEGORY
SELECT sub_name, COUNT(*) AS count
FROM cosmetics
GROUP BY sub_name
ORDER BY COUNT(*) DESC
LIMIT 10;

--- Top Sub-Category is Eye Shadow, followed by Foundations and Bases and Lip Gloss.

-- TOP 5 CHEMICALS
SELECT DISTINCT(chemical_name), COUNT(*) AS count
FROM cosmetics
GROUP BY chemical_name
ORDER BY COUNT(*) DESC
LIMIT 5;

--- Titanium dioxide is the chemical that is found in most products.

-- Products that contain Titanium dioxide
SELECT DISTINCT product_name FROM cosmetics
WHERE chemical_name="Titanium dioxide";

SELECT COUNT(DISTINCT(product_name)) FROM cosmetics
WHERE chemical_name="Titanium dioxide";

--- 2390

-- Brands that contain Titanium dioxide
SELECT DISTINCT brand_name FROM cosmetics
WHERE chemical_name="Titanium dioxide";

SELECT COUNT(DISTINCT(brand_name)) FROM cosmetics
WHERE chemical_name="Titanium dioxide";

--- 273

-- TOP 5 CHEMICAL COUNT
SELECT chem_count, COUNT(*) AS count
FROM cosmetics
GROUP BY chem_count
ORDER BY COUNT(*) DESC;

--- Most products have atleast 1 chemical.

-- Flavor with High chemical count (Above 3) 
SELECT DISTINCT flavor_name, chem_count FROM cosmetics
WHERE chem_count > 3
ORDER BY chem_count DESC;

--- Lots of flavors have a high chemical count.

-- Categories with High chemical count (Above 3) 
SELECT DISTINCT category_name, chem_count FROM cosmetics
WHERE chem_count > 3
ORDER BY chem_count DESC;

--- Makeup and Skincare have the highest chemical count ie 5.

-- Brands with High chemical count (Above 3) 
SELECT DISTINCT brand_name, chem_count FROM cosmetics
WHERE chem_count > 3
ORDER BY chem_count DESC;

-- Product with High chemical count (Above 3) 
SELECT DISTINCT product_name, chem_count FROM cosmetics
WHERE chem_count > 3
ORDER BY chem_count DESC;

--- Liquid Concealer and Retinol have the highest chemical count - 5.

-- Which brands have most number of flavors?
SELECT brand_name, COUNT(DISTINCT(flavor_name)) FROM cosmetics
GROUP BY brand_name
ORDER BY COUNT(flavor_name) DESC
LIMIT 10;

--- bareMinerals have the higest number of flavors used in their products.

-- Number of products reported each year
SELECT COUNT(product_name), YEAR(date_created) FROM cosmetics
GROUP BY YEAR(date_created)
ORDER BY COUNT(product_name) DESC;

--- The highest number of products were reported in the year 2009 - 12932. 

-- Number of Chemicals reported each year
SELECT COUNT(chemical_name), YEAR(chem_date_reported) FROM cosmetics
GROUP BY YEAR(chem_date_reported)
ORDER BY COUNT(chemical_name) DESC;

-- Number of Chemicals used by top 10 brands
SELECT COUNT(DISTINCT(chemical_name)), brand_name FROM cosmetics
GROUP BY brand_name
ORDER BY COUNT(chemical_name) DESC
LIMIT 10;

--- Palladio uses 10 chemicals followed by Sally Hansen which uses 5 chemicals.

-- Number of Chemicals used in Primary Category of Cosmetics
SELECT COUNT(DISTINCT(chemical_name)), category_name FROM cosmetics
GROUP BY category_name
ORDER BY COUNT(chemical_name) DESC
LIMIT 10;

--- Makeup, Skincare and Bath products use the highest number of chemicals.

-- Number of Chemicals used in Secondary Category of Cosmetics
SELECT COUNT(DISTINCT(chemical_name)), sub_name FROM cosmetics
GROUP BY sub_name
ORDER BY COUNT(chemical_name) DESC
LIMIT 10;

--- Eye Shadow, Foundation, Lip Gloss and Nail polishhave the highest number of chemicals - 8.