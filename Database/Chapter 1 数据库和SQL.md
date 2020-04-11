# 1-1 数据库是什么

## 我们身边的数据库

**数据库**：将大量数据保存起来，通过计算机加工而成的可以进行高效访问的数据集合。

**数据库管理系统**：用来管理数据库的计算机系统。

##   为什么DBMS那么重要

##   DBMS的种类

- **层次数据库**（Hierarchical Database, HDB）：把数据通过<u>层次结构（树形结构）</u>的方式表现出来。

- **关系数据库**（Relational Database, RDB）：采用由<u>行和列组成的二维表</u>来管理数据，简单易懂，使用专门的 **SQL**（Structured Query Language，结构化查询语言）对数据进行操作。对应  **关系数据库管理系统**（Relational Database Management System, RDBMS）。
  - Oracle Database
  - SQL Server
  - DB2
  - PostgreSQL
  - MySQL

- **面向对象数据库**（Object Oriented Database, OODB）
- **XML数据库**（XML Database, XMLDB）
- **键值存储系统**（Key-Value Store, KVS）：单纯用来保存查询所使用的主键（Key）和值（Value）的组合的数据库。

# 1-2 数据库的结构

##   RDBMS的常见系统结构

  最常见的系统结构就是**客户端 / 服务器类型（C/S类型）**。

<div align="center">
    <img src="Chapter 1 数据库和SQL.assets/1571370265016.png" alt="使用RDBMS时的系统结构" style="zoom:80%;" />
    <br>
    <b>使用RDBMS时的系统结构</b>
</div>

## 表的结构

**表**：用来管理数据的二维表在关系数据库中简称为表。

<div align="center">
    <img src="Chapter 1 数据库和SQL.assets/image-20200412010639545.png" alt="image-20200412010639545" style="zoom:80%;" />
    <br>
    <b>数据库和表的关系</b>
</div>

​		<u>根据 SQL 语句的内容返回的数据同样必须是二维表的形式</u>，这也是关系数据库的特征之一。

<div align="center">
    <img src="Chapter 1 数据库和SQL.assets/image-20200412010709940.png" alt="image-20200412010709940" style="zoom:80%;" />
    <br>
    <b>表的示例</b>
</div>！


| 术语   | 含义                                             |
| ------ | ------------------------------------------------ |
| 字段   | 表的列                                           |
| 记录   | 表的行                                           |
| 单元格 | 行和列交汇的方格。一个单元格中只能输入一个数据。 |

> 关系数据库必须以<b>行</b>为单位读写数据。
>
> 一个单元格中只能输入一个数据。

# 1-3 SQL概要

## 标准SQL

## SQL语句及其种类

**SQL语句**：用关键字、表名、列名等组合而成的一条语句（SQL 语句）来描述操作的内容。

根据<u>对 RDBMS 赋予的指令种类</u>的不同， SQL 语句可以分为以下三类：

| 种类                                                   | 作用                                                         | 包含指令                                                     |
| :----------------------------------------------------- | ------------------------------------------------------------ | :----------------------------------------------------------- |
| DDL（Data Definition Language，数据定义语言）          | 创建或者删除存储数据用的数据库以及数据库中的表等对象         | CREATE： 创建数据库和表等对象<br/>DROP： 删除数据库和表等对象<br/>ALTER： 修改数据库和表等对象的结构 |
| <b>DML（Data Manipulation Language，数据操纵语言）</b> | 查询或者变更表中的记录                                       | SELECT：查询表中的数据<br/>INSERT：向表中插入新数据<br/>UPDATE：更新表中的数据<br/>DELETE：删除表中的数据 |
| DCL（Data Control Language，数据控制语言）             | 确认或者取消对数据库中的数据进行的变更，设定用户对数据库中对象的操作权限 | COMMIT： 确认对数据库中的数据进行的变更<br/>ROLLBACK： 取消对数据库中的数据进行的变更<br/>GRANT： 赋予用户操作权限<br/>REVOKE： 取消用户的操作权限 |

##   SQL的基本书写规则

> - 以分号（;）结尾
> - 关键字不区分大小写，但惯例如下：
>   - 关键字大写
>   - 表名首字母大写
>   - 其余（列名等）小写
>
> - 字符串和日期常数需要使用单引号（'）括起来。
> - 数字常数无需加注单引号（直接书写数字即可）。
> - 单词之间需要使用半角空格或者换行符进行分隔。

# 1-4 表的创建

## 表的内容的创建

##   数据库的创建（`CREATE DATABASE`语句）

> *语法1-1	创建数据库的`CREATE DATABASE`语句*
>
> ```mysql
> CREATE DATABASE <数据库名称>;
> ```
>

##   表的创建（`CREATE TABLE`语句）

> *语法1-2	创建表的`CREATE TABLE`语句*
>
>
> ```mysql
> CREATE TABLE <表名> (
>     <列名1> <数据类型> <该列所需约束>,
>     <列名2> <数据类型> <该列所需约束>,
>     <该表的约束1>, <该表的约束2>
> );
> ```
>

> *代码清单1-2	创建**Product**表的`CREATE TABLE`语句*
>
> ```mysql
> CREATE TABLE product (
> 	product_id char(4) NOT NULL,
> 	product_name varchar(100) NOT NULL,
> 	product_type varchar(32) NOT NULL,
> 	sale_price integer,
> 	putchase_price integer,
> 	regist_date date,
> 	PRIMARY KEY (product_id)
> );
> ```
>

## 命名规则

> 数据库名称、表名和列名等：
>
> - 只能使用**半角英文字母、数字、下划线（_）**
>
> - 必须以半角英文字母开头
> - 不能重复

##   数据类型的指定

​		所有的列都必须指定数据类型，包括**数字型**、**字符型**和**日期型**等。每一列都不能存储与该列数据类型不符的数据。

| 基本数据类型                | 含义                                                         |
| --------------------------- | ------------------------------------------------------------ |
| INTEGER                     | 存储整数。                                                   |
| <span id="CHAR">CHAR</span> | 存储字符串（区分大小写）。语法为`CHAR(100)`（100表示最大长度，单位为字符个数或字节长度，字符以[**定长字符串**](#jump)的形式存储）。 |
| VARCHAR                     | 存储字符串。语法同[CHAR](#CHAR)                              |
| DATE                        | 存储日期（年月日）                                           |

<span id="jump"><b>定长字符串</b></span>：当列中存储的字符串长度达不到最大长度的时候，使用半角空格进行补足。

## 约束的设置

| `NOT NULL`      | 不能空白 |
| --------------- | -------- |
| `PRIMARY KEY()` | 主键约束 |

**键**：指定特定数据时使用的列的组合。

**主键**：指定特定（唯一确定）一行数据的列。

# 1-5 表的删除和更新

## 表的删除（ DROP TABLE语句）

> *语法1-3 删除表时使用的`DROP TABLE`语句*
>
> ```mysql
> DROP TABLE <表名>;
> ```
>

## 表定义的更新（ ALTER TABLE语句）

> *语法1-4, 语法1-5　添加、删除列的`ALTER TABLE`语句*
>
> ```mysql
> ALTER TABLE <表名> ADD COLUMN <列名> VARCHAR(100);	/* 添加列 */
> ALTER TABLE <表名> DROP COLUMN <列名>;				/* 删除列 */
> ```
>

## 向Product表中插入数据

> *代码清单1-6 向**Product**表中插入数据的SQL语句*
>
> ```mysql
> -- DML: 插入数据
> START TRANSACTION;
> INSERT INTO product
> VALUES
> 	('0001', 'T恤衫', '衣服', 1000, 500, '2009-09-20', 'TXUSHAN');
> COMMIT;
> ```
>

# 表名的修改

> *代码清单1-A 变更表名*
>
> ```mysql
> RENAME TABLE <原表名> TO <现表名>;
> ```
>