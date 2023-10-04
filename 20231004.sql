SELECT * FROM smartfactory.orders;

-- 231004 과제 복습

-- 1. 모든 컬럼을 가져오고, 생일을 기준으로 오름차순 정렬
SELECT * FROM smartfactory.user ORDER BY birthday;

-- 2. 회원 목록중 잰더 값이 m인 회원 목록을 가져오고, 이때 name을 기준으로 내림차순 정렬
SELECT * FROM smartfactory.user WHERE GENDER = 'M' ORDER BY NAME;

-- 3. 1990 년대에 태어난 회원의 아이디와 이름 컬럼 가져오기
SELECT ID, NAME FROM smartfactory.user WHERE BIRTHDAY BETWEEN '1990-01-01' AND '1999-12-31';
SELECT ID, NAME FROM smartfactory.user WHERE BIRTHDAY LIKE '199%';

-- 4. 6월 생 회원의 목록을 생일 기준으로 오름차순 정렬 
SELECT * FROM smartfactory.user WHERE BIRTHDAY LIKE '%06%';

-- 5. 잰더 값이 m 이고 1970년대에 태어난 회원의 목록을 가져오시오
SELECT * FROM smartfactory.user WHERE GENDER = 'M' AND BIRTHDAY BETWEEN '1970-01-01' AND '1979-12-31';

-- 6. 모든 회원목록 중 age를 기준으로 내림차순 정렬, 그때 회원 3개만 출력
SELECT * FROM smartfactory.user ORDER BY AGE DESC LIMIT 3;

-- 7. 모든 회원 목록 중 나이가 25이상 50이하인 회원의 목록 출력
SELECT * FROM smartfactory.useR WHERE AGE BETWEEN 25 AND 50;

-- 실습 :  order 테이블에서 총 주문 금액이 15000원 이상인 사람의 id와 총 주문 금액 표시(열 이름이 총 주문 금액으로)
SELECT custid, sum(price * amount) as 'total_price' FROM orders WHERE price 
GROUP BY custid 
HAVING sum(price * amount) >= 15000;

SELECT * FROM smartfactory.orders;

-- [실습] 과자 이름 기준으로 많이 팔린 순으로 내림차순 정렬, 표시는 과자 이름과 총 판매 개수, 판매 개수가 동일할때는 과자 이름 순으로 정렬
SELECT prodname, sum(amount) AS 'many_sell' FROM orders 
GROUP BY prodname, amount
ORDER BY amount DESC, prodname asc;

SELECT prodname, sum(amount) AS 'many_sell' FROM orders 
GROUP BY prodname
ORDER BY many_sell DESC, prodname asc;
-- HAVING many_sell > 3

select * from customer, orders where customer.custid = orders.custid;
select * from customer inner join orders on customer.custid = orders.custid;

select custname,prodname from customer, orders where custname = '강해린' and customer.custid = orders.custid;

-- 가가가각가각ㄱ가가가가각가각ㄱ가가가가각가각ㄱ가-- 가가가각가각ㄱ가가가가각가각ㄱ가가가가각가각ㄱ가-- 가가가각가각ㄱ가가가가각가각ㄱ가가가가각가각ㄱ가

USE smartfactory;

DROP TABLE IF EXISTS authors;
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50)
);

DROP TABLE IF EXISTS books;
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    author_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    publication_date DATE NOT NULL
    -- FOREIGN KEY (author_id) REFERENCES authors(author_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO authors (author_id, first_name, last_name, email) VALUES
(1, 'J.K.', 'Rowling', 'jkrowling@gmail.com'),
(2, 'George R.R.', 'Martin', 'grmartin@yahoo.com'),
(3, 'Stephen', 'King', 'sking@hotmail.com'),
(5, '아가사', '크리스티', 'agatha.christie@example.com');

INSERT INTO books (title, author_id, publication_date)
VALUES ('Harry Potter and the Philosopher''s Stone', 1, '1997-06-26'),
       ('A Game of Thrones', 2, '1996-08-06'),
       ('The Shining', 3, '1977-01-28'),
       ('스탠드', 3, '1978-01-01'),
       ('Lucky Day', 4, '2023-03-01');
       
select * from authors left join books on authors.author_id = books.author_id;       
select * from authors right join books on authors.author_id = books.author_id;

select * from books right join authors on authors.author_id = books.author_id;

-- left, right outer join 을 합쳐 조인하기. (full outer join)

select authors.author_id, books.title from authors left join books on authors.author_id = books.author_id
union
select authors.author_id, books.title from authors right join books on authors.author_id = books.author_id;  
       
-- 가가가각가각ㄱ가-- 가가가각가각ㄱ가가가가각가각ㄱ가가가가각가각ㄱ가-- 가가가각가각ㄱ가가가가각가각ㄱ가가가가각가각ㄱ가

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
insert into ORDERS (total) 
VALUES (10000), 
	(20000), 
    (30000);
select * from orders;

-- (3) ID가 JOHN123 인 고객 JOHN PARK 으로 수정








