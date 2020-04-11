-- 练习题-第1章
USE mysql;

-- 1.1
CREATE TABLE Addressbook
(
	regist_no INTEGER NOT NULL,
	name VARCHAR(128) NOT NULL,
	address VARCHAR(256) NOT NULL,
	tel_no CHAR(10),
	mail_address CHAR(20),
	PRIMARY KEY (regist_no)
);
-- 1.2
ALTER TABLE Addressbook ADD COLUMN postal_code CHAR
(8) NOT NULL;

INSERT INTO Addressbook
VALUES
	(1, 'shiwei', 'baishui', '1999943243', 'ncepu_sw@163.com', '715600');
SELECT *
FROM Addressbook;

-- 1.3
DROP TABLE Addressbook;

-- 1.4
-- （不备份的话）不能恢复，需要重新创建