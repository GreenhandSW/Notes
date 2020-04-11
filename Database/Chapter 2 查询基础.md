# 2-1 `SELECT`语句基础

## 列的查询

**（匹配）查询**：通过`SELECT`语句查询并选取出必要数据的过程。

**子句**：以`SELECT`, `FROM`等作为起始的短语，是SQL语句的组成要素。

> *语法2-1 基本的`SELECT`语句*
>
> ```mysql
> SELECT <列名>, ... 
> FROM <表名>;
> ```
>

## 查询出表中所有的列

> *语法2-2 查询全部的列*
>
> ```mysql
> SELECT * 
> FROM <表名>
> ```
>

**重点**：可以随意使用换行符，但不能插入空行（MySql可以），否则会造成执行错误。

## 为列设定别名

> *代码清单2-4　为列设定别名*
>
> ```mysql
> SELECT product_id AS id, product_name AS name, purchase_price AS price
> FROM Product;
> -- 使用中文作为别名 --
> SELECT product_id AS 编号, product_name AS "产品命名", purchase_price AS "产品  价格"
> FROM Product;
> ```

## 常数的查询

> *代码清单2-6 查询常数*
>
> ```mysql
> SELECT '商品' AS string, 38 AS number, '2009-02-24' AS date,
>     product_id, product_name
> FROM Product;
> ```

## 从结果中删除重复行

> *代码清单2-7 使用`DISTINCT`删除product_type列中重复的数据*
>
> ```mysql
> SELECT DISTINCT product_type
> FROM Product;
> ```

多行`NULL`也会被合并成为一行。

对多列数据使用`DISTINCT`（只能用在第一个列名之前），会将多列数据组合，并合并重复数据。

> *代码清单2-9 在多列之前使用`DISTINCT`*
>
> ```mysql
> SELECT DISTINCT product_type, regist_date
> FROM Product;
> ```

## 根据`WHERE`语句来选择记录

> *语法2-3 SELECT语句中的`WHERE`子句*
>
> ```mysql
> SELECT <列名>, ……
> FROM <表名>
> WHERE <条件表达式>;
> ```

## 注释的书写方法

>```mysql
>-- 一行注释
>/* 
> * 多行注释
> */
>-- 注释可以插入语句中
>```

# 2-2 算术运算符和比较运算符

## 算术运算符

> *代码清单2-17 SQL语句中也可以使用运算表达式*
>
> ```mysql
> SELECT product_name, sale_price,
>     sale_price * 2 AS "sale_price_x2"
> FROM Product;
> ```

可以使用括号改变运算优先级。

## 需要注意`NULL`

所有包含`NULL`的运算，结果均为`NULL`（因此`NULL/0`不会发生除数为`0`的错误）

> *代码清单2-A 只包含S`ELECT`子句的`SELECT`语句*
>
> ```mysql
> SELECT (100 + 200) * 3 AS calculation;
> ```
>
> 此时可无`FROM`子句。

## 比较运算符

| 运算符 | 含义     |
| ------ | -------- |
| =      | 等于     |
| <>     | 不等于   |
| \>=    | 大于等于 |
| \>     | 大于     |
| <=     | 小于等于 |
| <      | 小于     |

> 代码清单2-22 `WHERE`子句的条件表达式中也可以使用计算表达式
>
> ```mysql
> SELECT product_name, sale_price, purchase_price
> FROM Product
> WHERE sale_price - purchase_price >= 500;
> ```

字符串的大小按照字典排序。

## 不能对`NULL`使用比较运算符

对`NULL`使用比较运算符会得到空白的查询结果。

若要选取值为（或不为）`NULL`的列，需要使用`IS NULL`（或`IS NOT NULL`）运算符。

> *代码清单2-28 选取`NULL`的记录*
>
> ```mysql
> SELECT product_name, purchase_price
> FROM Product
> WHERE purchase_price IS NULL;
> ```

# 2-3 逻辑运算符

## `NOT`运算符

>代码清单2-31 向代码清单2-30的查询条件中添加`NOT`运算符
>
>```mysql
>SELECT product_name, product_type, sale_price
>FROM Product
>WHERE NOT sale_price >= 1000;
>```

## `AND`运算符和`OR`运算符

## 通过括号强化处理

> 代码清单2-36 通过使用括号让OR运算符先于AND运算符执行
>
> ```mysql
> SELECT product_name, product_type, regist_date
> FROM Product
> WHERE product_type = '办公用品'
> AND ( regist_date = '2009-09-11'
> OR regist_date = '2009-09-20');
> ```

## 逻辑运算符和真值

真值：`TRUE`, `FALSE`。

逻辑运算符：`NOT`, `AND`和`OR`。其中逻辑表示对真值进行操作。

## 含有NULL时的真值

三值逻辑（`TRUE`, `FALSE`及`NULL`）

> 表2-6 三值逻辑中的`AND`和`OR`真值表
>
> `AND`
>
> |   P    |   Q    | P AND Q |
> | :----: | :----: | :-----: |
> |   真   |   真   |   真    |
> |   真   |   假   |   假    |
> |   真   | 不确定 | 不确定  |
> |   假   |   真   |   假    |
> |   假   |   假   |   假    |
> |   假   | 不确定 |   假    |
> | 不确定 |   真   | 不确定  |
> | 不确定 |   假   |   假    |
> | 不确定 | 不确定 | 不确定  |
>
> `OR`
>
> |   P    |   Q    | P OR Q |
> | :----: | :----: | :----: |
> |   真   |   真   |   真   |
> |   真   |   假   |   真   |
> |   真   | 不确定 |   真   |
> |   假   |   真   |   真   |
> |   假   |   假   |   假   |
> |   假   | 不确定 | 不确定 |
> | 不确定 |   真   |   真   |
> | 不确定 |   假   | 不确定 |
> | 不确定 | 不确定 | 不确定 |