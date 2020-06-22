CREATE DATABASE IF NOT EXISTS Sales;

USE Sales;

CREATE TABLE sales (
    purchase_number INT NOT NULL AUTO_INCREMENT,
    date_of_purchase DATE NOT NULL,
    customer_id INT,
    item_code VARCHAR(10) NOT NULL,
PRIMARY KEY (purchase_number)
);

ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;


-- Need to drop FK before altering field
ALTER TABLE sales
DROP FOREIGN KEY Constraint_1;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;