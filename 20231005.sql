-- SQL 복습 실습 1 테이블 생성하기 

DROP TABLE IF EXISTS costomers;
CREATE TABLE costomers (
    id VARCHAR(50) NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
	customer_id VARCHAR(50),
    date DATE NOT NULL,
    foreign key (customer_id) references costomers(id) on update cascade on delete cascade
);

DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
	order_id int,
    price int NOT NULL,
    address VARCHAR(255) NOT NULL,
    foreign key (order_id) references orders(id) on update cascade on delete cascade
);

DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
	order_id int,
    item VARCHAR(50) NOT NULL,
    quantity VARCHAR(255) NOT NULL,
    foreign key (order_id) references orders(id) on update cascade on delete cascade
);

desc costomers;
desc orders;
desc order_detail;

-- SQL 복습 실습 2 테이블 데이터 삽입하기
INSERT INTO costomers (id, name, email, address) 
VALUES ('john123', 'John Smith', 'john.smith@gmail.com', '123 Main St, Anytown, USA'),
	('jane456', 'Jane Doe', 'jane.doe@yahoo.com', '456 Oak Ave, Somewhere'),
	('alice789', 'Alice Johnson', 'alice.johnson@hotmail.com', '789 Elm St, Nowhere');

INSERT INTO orders (id, customer_id , date) 
VALUES (1, 'john123', '2022-01-01'),
	(2, 'john123', '2022-02-01'),
	(3, 'jane456', '2022-03-01');

INSERT INTO order_detail (order_id, item, quantity)
VALUES (1, 'pen', 10),
	(1, 'toy', 2),
	(2, 'clothes', 5),
	(3, 'socks', 100);

-- SQL 복습 실습 3 DML, DDL 복습 
-- (1) ORDERS 에 TOTAL 컬럼 추가하기
ALTER TABLE ORDERS ADD total int;
select * from orders;

-- (2) 총 금액 업데이트
UPDATE orders SET total = 10000 WHERE id = 1;
UPDATE orders SET total = 15000 WHERE id = 2;
UPDATE orders SET total = 20000 WHERE id = 3;

select * from orders;

-- (3) ID가 JOHN123 인 고객 JOHN PARK 으로 수정
UPDATE costomers SET name = 'John Park' WHERE id = 'john123';
select * from costomers;

-- 실습 4 SELECT 문 복습

-- (1) 2022-01-01 ~ 2022-02-01 기간동안 주문한 고객의 아이디 중복 없이 가져오기
SELECT distinct customer_id from smartfactory.orders WHERE date BETWEEN '2022-01-01' AND '2022-02-01' ;

-- (2) 2022-01-01 ~ 2022-02-01 기간동안 주문한 이름 중복 없이 가져오기 (서브쿼리)
SELECT distinct costomers.name FROM smartfactory.orders JOIN costomers ON orders.customer_id = costomers.id;

SELECT distinct(
    SELECT costomers.name
    FROM costomers
    WHERE costomers.id = orders.customer_id
) AS customer_name
FROM orders WHERE date BETWEEN '2022-01-01' AND '2022-02-01' ;

-- (3) 총 금액이 가장 높은 데이터 (MAX 쓰지 않기)
SELECT * FROM orders ORDER BY total DESC LIMIT 1 ;

-- (4) 총 금액이 가장 높은 데이터 (MAX)
SELECT MAX(total) FROM orders;
SELECT * FROM orders WHERE total = ( SELECT MAX(total) FROM orders ) ;

-- (5) 각각 커스터머의 주문 개수 order_detail.quantity
SELECT order_id, SUM(quantity) AS total_quantity
FROM order_detail GROUP BY order_id;

SELECT (
	SELECT orders.id
    FROM orders
    WHERE orders.id = order_detail.order_id
) AS ABC, SUM(quantity) AS total_quantity
FROM order_detail GROUP BY order_id;

SELECT (
	SELECT (
		SELECT costomers.name
		FROM costomers
		WHERE costomers.id = orders.customer_id
    )
    FROM orders
    WHERE orders.id = order_detail.order_id
) AS ABC, SUM(quantity) AS total_quantity
FROM order_detail GROUP BY order_id;

SELECT (
	SELECT (
		SELECT costomers.name
		FROM costomers
		WHERE costomers.id = orders.customer_id
        -- GROUP BY costomers.name
    )
    FROM orders
    WHERE orders.id = order_detail.order_id
) AS 'NAME', SUM(quantity) AS total_quantity
FROM order_detail GROUP BY NAME;

-- (6) 21000원이상 결제한 고객의 총 금액 TOTAL_PRICE
SELECT customer_id, sum(total) AS TOTAL_PRICE 
FROM orders group by customer_id
HAVING TOTAL_PRICE >= 21000;

-- (7) 각 주문 정보에 대해 고객 정보와 주문 정보
select * FROM ORDERS LEFT JOIN COSTOMERS ON ORDERS.customer_id = costomers.id;

-- (8) 주문을 하지 않은 고객 정보 가져오기 고객정보 가져와서 주문한 사람 빼기
SELECT * FROM costomers 
WHERE id NOT IN (
	SELECT customer_id
    FROM orders
);


-- 가나다라 가나다라 가나다라 가나다라 가나다라 가나다라 가나다라 가나다라 가나다라 
-- 2022-01-01 ~ 2022-02-01 기간동안 주문한 고객의 아이디를 중복 없이 가져오기
SELECT distinct customer_id from orders where date >= '2022-01-01' AND date <= '2022-02-01' ;
-- 2022-01-01 ~ 2022-02-01 기간동안 주문한 고객의 이름 중복 없이 가져오기 (서브쿼리)
SELECT name from customers where id = (SELECT distinct customer_id from orders where date >= '2022-01-01' AND date <= '2022-02-01');
-- 총 금액이 가장 높은 데이터 가져오기 (MAX 함수 사용하지 않고)
SELECT * from orders ORDER BY total DESC LIMIT 1;
-- 총 금액이 가장 높은 데이터 가져오기(MAX 함수 사용해서)
SELECT max(total) from orders;
SELECT * from orders where total=(SELECT max(total) from orders);
-- 각각의 customer가 몇 개의 주문을 했는지 검색하기
SELECT customer_id, COUNT(customer_id) from orders GROUP BY customer_id;
-- 21000원 이상 결제한 고객의 총 금액 total_price로 가져오기
SELECT customer_id, SUM(total) AS total_price from orders GROUP BY customer_id HAVING total_price >= 21000;
-- 각 주문 정보에 대해 고객 정보와 주문 정보를 함께 가져오기
SELECT o.id, c.id, c.name, c.email, c.address, o.date, o.total FROM orders o INNER JOIN customers c ON o.customer_id = c.id;
-- 주문을 하지 않은 고객 정보도 가져오기
SELECT o.id, c.id, c.name, c.email, c.address, o.date, o.total FROM orders o RIGHT JOIN customers c ON o.customer_id = c.id;

