USE Sales;

/* Creating table */
CREATE TABLE customers (
    customer_id 			INT,
    first_name 				VARCHAR(255),
    last_name 				VARCHAR(255),
    gender 					ENUM('M', 'F'),
    email_address 			VARCHAR(255),
    number_of_complaints 	INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD unique key (email_address);

ALTER TABLE customers
DROP INDEX email_address;

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

ALTER TABLE customers
CHANGE COLUMN customer_id customer_id INT AUTO_INCREMENT;

ALTER TABLE customers
CHANGE column gender gender enum('M','F');

INSERT INTO customers (first_name, last_name, gender)
VALUES('John', 'McKinley', 'M');

SELECT * from customers;

INSERT INTO customers (first_name, last_name, gender)
VALUES('Peter', 'Figaro', 'M');