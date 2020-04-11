# 3-1 对表进行聚合查询

## 聚合函数

聚合（集）函数：用于汇总的函数。

常用聚合函数：`COUNT`, `SUM`, `AVG`, `MAX`, `MIN`。

- **只有`COUNT`才能将\*作为作为参数。**
- 聚合函数若以列名为参数，则会自动排除含有`NULL`的行，然后再计算。
- `SUM`和`AVG`只能对数值类型使用，而`MAX`和`MIN`适用于任何数据类型。

## 计算表中数据的行数

> *代码清单3-1 计算全部数据的行数*
>
> ```mysql
> SELECT COUNT(*)
> FROM Product;
> ```

## 计算NULL之外的数据的行数

>*代码清单3-2 计算`NULL`之外的数据行数*
>
>```mysql
>SELECT COUNT(purchase_price)
>FROM Product;
>```
>
>通过将列名设定为参数来计算该列除`NULL`之外的行数

## 计算合计值

## 计算平均值

## 计算最大值和最小值

## 使用聚合函数删除重复值（关键字`DISTINCT`）

> *代码清单3-10 计算去除重复数据后的数据行数*
>
> ```mysql
> SELECT COUNT(DISTINCT product_type)
> FROM Product;
> ```

# 3-2 对表进行分组

## GROUP BY子句

> *语法3-1　使用GROUP BY子句进行汇总*
>
> ```mysql
> SELECT <列名1>, <列名2>, <列名3>, ……
> FROM <表名>
> GROUP BY <列名1>, <列名2>, <列名3>, ……;
> ```

> *代码清单3-13 按照商品种类统计数据行数*
>
> ```mysql
> SELECT product_type, COUNT(*)
> FROM Product
> GROUP BY product_type;
> ```

**聚合键（分组列）**：在`GROUP BY`子句中指定的按照该列将表分组的列。

子句书写顺序：`SELECT`$\to$`FROM`$\to$`WHERE`$\to$`GROUP BY`

- 使用`GROUP BY`子句时， `SELECT`子句中不能出现聚合键之外的列名。

## 聚合键中包含`NULL`的情况

当聚合键中包含`NULL`时，也会将`NULL`作为一组特定的数据。

## 使用`WHERE`子句时`GROUP BY`的执行结果

> *代码清单3-15 同时使用WHERE子句和GROUP BY子句*
>
> ```mysql
> SELECT purchase_price, COUNT(*)
> FROM Product
> WHERE product_type = '衣服'
> GROUP BY purchase_price;
> ```

执行顺序：`FROM`$\to$`WHERE`$\to$`GROUP BY`$\to$`SELECT`

## 与聚合函数和`GROUP BY`子句有关的常见错误

**`GROUP BY`和聚合函数的语法规范：**

1. 只能写在`SELECT`子句之中
2. `GROUP BY`子句中不能使用SELECT子句中列的别名
3. `GROUP BY`子句的聚合结果是无序的
4. `WHERE`子句中不能使用聚合函数（只有`SELECT`, `HAVING`, `ORDER BY`子句能够使用聚合函数）
5. 在`SELECT`子句中只能书写聚合键和`GROUP BY`中包含的列名

> *代码清单3-16 在`SELECT`子句中书写聚合键之外的列名会发生错误*
>
> ```mysql
> -- 错误示范 --
> SELECT product_name, purchase_price, COUNT(*)
> FROM Product
> GROUP BY purchase_price;
> ```
>
> 不过只有MySQL不受此约束。（为啥我试的结果是MySQL也不支持？）

> *代码清单3-A `DISTINCT`和`GROUP BY`能够实现相同的功能*
>
> ```mysql
> SELECT DISTINCT product_type
> FROM Product;
> 
> SELECT product_type
> FROM Product
> GROUP BY product_type;
> ```

## 3-3 为聚合结果指定条件

使用COUNT函数等对表中数据进行汇总操作时，为其指定条件的不是WHERE子句，而是HAVING子句。

聚合函数可以在SELECT子句、 HAVING子句和ORDER BY子句中使用。

HAVING子句要写在GROUP BY子句之后。

WHERE子句用来指定数据行的条件， HAVING子句用来指定分组的条件。