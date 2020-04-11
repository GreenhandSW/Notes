USE mysql;
-- DROP TABLE Product;
/*
 * 第1章
 */


-- 创建Product表
CREATE TABLE Product
(
    product_id CHAR(4) NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_type VARCHAR(32) NOT NULL,
    sale_price INTEGER ,
    purchase_price INTEGER ,
    regist_date DATE ,
    PRIMARY KEY (product_id)
);

ALTER TABLE Product CONVERT TO CHARACTER
SET utf8mb4;
-- DML ：插入数据
START TRANSACTION;
INSERT INTO Product
VALUES
    ('0001', 'T恤衫', '衣服',
        1000, 500, '2009-09-20');
INSERT INTO Product
VALUES
    ('0002', '打孔器', '办公用品',
        500, 320, '2009-09-11');
INSERT INTO Product
VALUES
    ('0003', '运动T恤', '衣服',
        4000, 2800, NULL);
INSERT INTO Product
VALUES
    ('0004', '菜刀', '厨房用具',
        3000, 2800, '2009-09-20');
INSERT INTO Product
VALUES
    ('0005', '高压锅', '厨房用具',
        6800, 5000, '2009-01-15');
INSERT INTO Product
VALUES
    ('0006', '叉子', '厨房用具',
        500, NULL, '2009-09-20');
INSERT INTO Product
VALUES
    ('0007', '擦菜板', '厨房用具',
        880, 790, '2008-04-28');
INSERT INTO Product
VALUES
    ('0008', '圆珠笔', '办公用品',
        100, NULL, '2009-11-11');
COMMIT;

-- SELECT *
-- FROM Product;



/*
 * 第2章
 */


-- SELECT product_id, product_name, purchase_price
-- FROM Product;

-- SELECT product_id AS 编号, product_name AS "产品命名", purchase_price AS "产品  价格"
-- FROM Product;

-- SELECT DISTINCT product_type FROM Product;

-- SELECT DISTINCT product_type, regist_date FROM Product;

-- SELECT product_name AS "名称", product_type AS "品类"
-- from Product
-- WHERE product_type="衣服";


-- SELECT product_name, sale_price, sale_price / 2 AS 一半儿 FROM Product;

-- SELECT (300+3)/4 AS Calc;

-- SELECT product_name, sale_price, purchase_price
-- FROM Product
-- WHERE sale_price -purchase_price>=500;

-- CREATE TABLE Chars
-- (
--     chr CHAR(3) NOT NULL,
--     PRIMARY KEY (chr)
-- );

-- -- DML
-- ALTER TABLE Product CONVERT TO CHARACTER
-- SET utf8mb4;

-- START TRANSACTION;

-- INSERT INTO Chars
-- VALUES
--     ('1');
-- INSERT INTO Chars
-- VALUES
--     ('2');
-- INSERT INTO Chars
-- VALUES
--     ('3');
-- INSERT INTO Chars
-- VALUES
--     ('10');
-- INSERT INTO Chars
-- VALUES
--     ('11');
-- INSERT INTO Chars
-- VALUES
--     ('222');

-- COMMIT;

-- SELECT chr
-- FROM Chars
-- WHERE chr > '2';

-- DROP TABLE Chars;

-- SELECT product_name, purchase_price
-- FROM Product
-- WHERE purchase_price IS NULL;

-- SELECT (NULL AND TRUE) AS ONE, (NULL AND FALSE) AS TWO;



/*
 * 第3章
 */


-- SELECT AVG(regist_date) FROM Product;
-- SELECT regist_date FROM Product;


-- SELECT product_type, AVG(purchase_price) FROM Product GROUP BY product_type;

DROP TABLE Product;