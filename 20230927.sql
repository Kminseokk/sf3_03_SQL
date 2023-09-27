SELECT * FROM smartfactory.user;

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'hong1234', '8o4bkg', '홍길동', 'M', '1990-01-31', 33 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('sexysung', '87awjkdf', '성춘향', 'F', '1992-03-31', 31 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'power70', 'qxur8sda', '변사또', 'M', '1970-05-02', 53 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'hanjo', 'jk48fn4', '한조', 'M', '1984-10-18', 39 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('widowmaker', '38ewifh3', '위도우', 'F', '1986-06-27', 47 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('dvadva', 'k3f3ah', '송하나', 'F', '1994-06-03', 22 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('jungkrat', '4ifha7f', '정크랫', 'M', '1975-11-11', 24 );

-- ------------------------------------------

USE smartfactory;
-- 연습 데이터베이스 생성


DROP TABLE IF EXISTS customer;
CREATE TABLE customer
( custid    CHAR(10) NOT NULL PRIMARY KEY,
  custname  VARCHAR(10) NOT NULL,
  addr      CHAR(10) NOT NULL,
  phone     CHAR(11),
  birth     DATE
);
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(  orderid   INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
   custid    CHAR(10) NOT NULL,
   prodname  CHAR(6) NOT NULL,
   price     INT  NOT NULL,
   amount    SMALLINT  NOT NULL,
   FOREIGN KEY (custid) REFERENCES customer(custid)
);

CREATE TABLE new_user
(	id		VARCHAR(10) NOT NULL PRIMARY KEY,
	pw		VARCHAR(20) NOT NULL,
    name	VARCHAR(5)	NOT	NULL,
    gender	CHAR(1),
    birthday	DATE	NOT NULL,
    age		INT
);

DESC smartfactory.new_user;

DROP TABLE member;
CREATE TABLE member
(	id		VARCHAR(20) NOT NULL PRIMARY KEY,
    name	VARCHAR(5)	NOT	NULL,
    age		INT,
	gender	VARCHAR(2) NOT NULL,
    email	VARCHAR(50),
    promotion	VARCHAR(2) DEFAULT "X"
);

DESC smartfactory.member;

-- 실습 테이블 수정, 삭제, 추가
ALTER TABLE smartfactory.member MODIFY ID VARCHAR(20);
ALTER TABLE smartfactory.member DROP COLUMN AGE;
ALTER TABLE smartfactory.member ADD interest VARCHAR(100);

DESC smartfactory.member;

-- NULL 을 NOT NULL 로
ALTER TABLE smartfactory.member MODIFY COLUMN interest VARCHAR(100) NOT NULL;

-- NOT NULL 을 NULL 로 
ALTER TABLE smartfactory.member MODIFY COLUMN interest VARCHAR(100);


ALTER TABLE smartfactory.user MODIFY COLUMN gender VARCHAR(2);

-- 테이블 초기화
TRUNCATE TABLE smartfactory.user;

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'hong1234', '8o4bkg', '홍길동', 'M', '1990-01-31', 33 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('sexysung', '87awjkdf', '성춘향', 'F', '1992-03-31', 31 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'power70', 'qxur8sda', '변사또', 'M', '1970-05-02', 53 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES( 'hanjo', 'jk48fn4', '한조', 'M', '1984-10-18', 39 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('widowmaker', '38ewifh3', '위도우', NULL, '1986-06-27', 47 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('dvadva', 'k3f3ah', '송하나', 'F', '1994-06-03', 22 );

INSERT INTO smartfactory.user(id, pw, name, gender, birthday, age)
VALUES('jungkrat', '4ifha7f', '정크랫', 'M', '1975-11-11', 24 );

DESC smartfactory.user;

-- 수정하기 
UPDATE smartfactory.user SET pw = 'songsong' WHERE id = 'dvadva';
UPDATE smartfactory.user SET name = '핫토리' WHERE id = 'hanjo';

UPDATE smartfactory.user SET pw = 'testtest' WHERE name = '홍길동';

--

CREATE TABLE new_customer (
    custid CHAR(10) NOT NULL PRIMARY KEY,
    custname VARCHAR(10) NOT NULL,
    addr CHAR(10) NOT NULL,
    phone CHAR(11),
    birth DATE
);

CREATE TABLE new_orders (
    orderid INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    custid CHAR(10) NOT NULL, 
    prodname CHAR(6) NOT NULL,
    price INT NOT NULL,
    amount smallint NOT NULL,
    FOREIGN KEY (custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

-- -----------------------------

DROP TABLE IF EXISTS customer; 
CREATE TABLE customer 
( custid    CHAR(10) NOT NULL PRIMARY KEY,
  custname  VARCHAR(10) NOT NULL, 
  addr      CHAR(10) NOT NULL, 
  phone     CHAR(11), 
  birth     DATE 
);


DROP TABLE IF EXISTS orders;
CREATE TABLE orders 
(  orderid   INT AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   custid    CHAR(10) NOT NULL, 
   prodname  CHAR(6) NOT NULL, 
   price     INT  NOT NULL, 
   amount    SMALLINT  NOT NULL,
   FOREIGN KEY (custid) REFERENCES customer(custid)
);

INSERT INTO customer VALUES('bunny', '강해린', '대한민국 서울', '01012341234', '2000-02-23');
INSERT INTO customer VALUES('hello', '이지민', '대한민국 포항', '01022221234', '1999-08-08');
INSERT INTO customer VALUES('kiwi', '최지수', '미국 뉴욕', '01050005000', '1990-12-25');
INSERT INTO customer VALUES('imminji01', '강민지', '영국 런던', '01060001000', '1995-01-11');
INSERT INTO customer VALUES('lalala', '홍지수', '미국 로스앤젤레스', '01010109090', '2007-05-16');
INSERT INTO customer VALUES('jjjeee', '홍은정', '대한민국 서울', '01099991111', '2004-08-17');
INSERT INTO customer VALUES('wow123', '이민혁', '일본 삿포로', '01011223344', '1994-05-31');
INSERT INTO customer VALUES('minjipark', '박민지', '프랑스 파리', '01088776655', '1998-04-08');
INSERT INTO customer VALUES('jy9987', '강지연', '일본 삿포로', '01012312323', '1996-09-01');

INSERT INTO orders VALUES(NULL, 'jy9987', '프링글스', 3500, 2);
INSERT INTO orders VALUES(NULL, 'kiwi', '새우깡', 1200, 1);
INSERT INTO orders VALUES(NULL, 'hello', '홈런볼', 4200, 2);
INSERT INTO orders VALUES(NULL, 'minjipark', '맛동산', 2400, 1);
INSERT INTO orders VALUES(NULL, 'bunny', '오감자', 1500, 4);
INSERT INTO orders VALUES(NULL, 'jjjeee', '양파링', 2000, 1);
INSERT INTO orders VALUES(NULL, 'hello', '자갈치', 1300, 2);
INSERT INTO orders VALUES(NULL, 'jjjeee', '감자깡', 1200, 4);
INSERT INTO orders VALUES(NULL, 'bunny', '죠리퐁', 1500, 3);
INSERT INTO orders VALUES(NULL, 'kiwi', '꼬깔콘', 1700, 2);
INSERT INTO orders VALUES(NULL, 'hello', '버터링', 4000, 2);
INSERT INTO orders VALUES(NULL, 'minjipark', '칙촉', 4000, 1);
INSERT INTO orders VALUES(NULL, 'wow123', '콘초', 1700, 3);
INSERT INTO orders VALUES(NULL, 'imminji01', '꼬북칩', 2000, 2);
INSERT INTO orders VALUES(NULL, 'bunny', '썬칩', 1800, 5);
INSERT INTO orders VALUES(NULL, 'kiwi', '고구마깡', 1300, 3);
INSERT INTO orders VALUES(NULL, 'jy9987', '오징어집', 1700, 5);
INSERT INTO orders VALUES(NULL, 'jjjeee', '바나나킥', 2000, 4);
INSERT INTO orders VALUES(NULL, 'imminji01', '초코파이', 5000, 2);

-- 유저 리셋
CREATE TABLE user(
    id VARCHAR(10) NOT NULL PRIMARY KEY,
    pw VARCHAR(20) NOT NULL,
    name VARCHAR(5) NOT NULL,
    gender CHAR(1),
    birthday DATE NOT NULL,
    age INT NOT NULL
);


INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'hong1234', '8o4bkg', '홍길동', 'M', '1990-01-31', 33 );
INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'sexysung', '87awjkdf', '성춘향', 'F', '1992-03-31', 31 );
INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'power70', 'qxur8sda', '변사또', 'M', '1970-05-02', 53 );
INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'hanjo', 'jk48fn4', '한조', 'M', '1984-10-18', 39 );
INSERT INTO user( id, pw, name, birthday, age ) VALUES( 'widowmaker', '38ewifh3', '위도우', '1986-06-27', 47 );
INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'dvadva', 'k3f3ah', '송하나', 'F', '1994-06-03', 22 );
INSERT INTO user( id, pw, name, gender, birthday, age ) VALUES( 'jungkrat', '4ifha7f', '정크랫', 'M', '1975-11-11', 24 );



-- 1. 모든 컬럼을 가져오고, 생일을 기준으로 오름차순 정렬
SELECT * FROM smartfactory.user ORDER BY birthday;

-- 2. 회원 목록중 잰더 값이 m인 회원 목록을 가져오고, 이때 name을 기준으로 내림차순 정렬
SELECT * FROM smartfactory.user WHERE GENDER = 'M' ORDER BY NAME;

-- 3. 1990 년대에 태어난 회원의 아이디와 이름 컬럼 가져오기
SELECT ID, NAME FROM smartfactory.user WHERE BIRTHDAY BETWEEN '1990-01-01' AND '1999-12-31';

-- 4. 6월 생 회원의 목록을 생일 기준으로 오름차순 정렬 
SELECT * FROM smartfactory.user WHERE MONTH(BIRTHDAY) = 6; 

-- 5. 잰더 값이 m 이고 1970년대에 태어난 회원의 목록을 가져오시오

-- 6. 모든 회원목록 중 age를 기준으로 내림차순 정렬, 그때 회원 3개만 출력

-- 7. 모든 회원 목록 중 나이가 25이상 50이하인 회원의 목록 출력




