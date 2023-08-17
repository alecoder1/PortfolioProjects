SELECT * FROM project.orders;
USE project;
SELECT * FROM lapdata;

-->between
SELECT Product, Price 
FROM lapdata
WHERE Price BETWEEN 1000000 AND 3000000;

-->cast
SELECT product_name, price, CAST(price AS SIGNED) AS new_price FROM orders;