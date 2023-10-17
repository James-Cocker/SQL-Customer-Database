-- using http://sqlfiddle.com/




-- ----  Creating Tables  ---- --


CREATE TABLE customer
(
  customer_id  INT PRIMARY KEY,
  first_name   VARCHAR(20),
  last_name    VARCHAR(20),
  email        VARCHAR(30),
  address      VARCHAR(30),
  city         VARCHAR(30),
  county       VARCHAR(20),
  postcode     VARCHAR(8)
 );
 
INSERT INTO customer (customer_id,first_name,last_name,email,
                      address,city,county,postcode)
VALUES (1,'Arthur','Balfour','abalfour@gov.co.uk',
        'Fisher''s Hill', 'Woking','Surrey','GU15 5HH'), 
        
        (2,'Henry','Campbell-Bannerman','hbannerman@gov.co.uk',
        '10 Downing Street', 'Westminster','London','SW1A 2AA'),
        
        (3,'Herbert','Asquith','hasquith@gov.co.uk',
        '43 Church Street', 'Abingdon','Oxfordshire','OX14 4NJ'),
        
        (4,'David','George','dgeorge@gov.co.uk',
        'Ty Newydd', 'Llanystumdwy','Gwynedd','LL52 0LW');
        
		
CREATE TABLE customer_order
(
  order_id     INT PRIMARY KEY,
  order_date   DATE,
  amount       DECIMAL(6,2),
  customer_id  INT -- Foreign key isn't specified when initialising
);        

INSERT INTO customer_order (order_id, order_date, amount, customer_id)
VALUES (1, '2017-07-04', 154.00, 1),
       (2, '2017-10-14', 234.76, 3),
       (3, '2018-02-01', 161.89, 3),
       (4, '2018-03-01', 345.99, 2),
       (5, '2018-06-07', 98.96, 3),
       (6, '2018-07-10', 298.32, 1);




-- ----  Queries  ---- --


-- Creating a SELECT query that show the first name, surname, 
-- order date and amount for all orders, using ‘JOIN’ to link the tables

SELECT customer.first_name, customer.last_name, customer_order.order_date,
customer_order.amount FROM customer
JOIN customer_order ON customer.customer_id = customer_order.customer_id;


-- Creating a SELECT query that show the first name, surname, 
-- order date and amount columns for all orders greater than 
-- the amount of the one placed on 01/02/2018

SELECT customer.first_name, customer.last_name, customer_order.order_date,
customer_order.amount FROM customer
JOIN customer_order ON customer.customer_id = customer_order.customer_id
WHERE (customer_order.amount > 
(SELECT amount FROM customer_order WHERE order_date = '2018-02-01')); 


--  Changing David George's email to iluvfrances@gov.co.uk
--  Using an update query

UPDATE customer
SET email = 'iluvfrances@gov.co.uk'
WHERE first_name = 'David' and last_name = 'George';


-- Cancelling order 6

DELETE FROM customer_order
WHERE order_id = 6
