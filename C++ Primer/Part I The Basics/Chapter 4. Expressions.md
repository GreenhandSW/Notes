

# 4.1. Fundamentals

## 4.1.1. Basic Concepts

### overloaded operators

(in *0.4. Terminology*)

### lvalue and rvalue

(in *0.4)

Roughly speaking, when we use an object as an **rvalue**, we use the <u>object’s value (its contents)</u>. When we use an object as an **lvalue**, we use the <u>object’s identity (its location in memory)</u>.

`decltype(lvalue)` gets a reference type.

## 4.1.2. Precedence and Associativity

## 4.1.3. Order of Evaluation

Operands of `&&`, `||`, `?:`, `,` are orderly evaluated, others are not.

# 4.2. Arithmetic Operators

### Arithmetic Operators (Left Associative)

| Order | Operator |    Meaning     |      Use      |
| :---: | :------: | :------------: | :-----------: |
|   1   |   `+`    |   unary plus   |   `+ expr`    |
|   1   |   `-`    |  unary minus   |   `- expr`    |
|   2   |   `*`    | multiplication | `expr * expr` |
|   2   |   `/`    |    division    | `expr / expr` |
|   2   |   `%`    |   remainder    | `expr % expr` |
|   3   |   `+`    |    addition    | `expr + expr` |
|   3   |   `-`    |  subtraction   | `expr - expr` |

Unary `+`, `-`:

- The unary `+`, `-` return a possibly promoted (negative) copy of the value of its operand.

- ```c++
  bool a = true;
  bool b = -a;   // b is still true.
  ```

- Rules of unary operators (except for the obscure case where `-m` overflows):

  - `(-m)/n = m/(-n) = -(m/n)`

  - `m%(-n) = m%n`
  - ``(-m)%n = -(m%n)`

# 4.3. Logical and Relational Operators

###   Logical and Relational Operators

| Order | Associativity | Operator |        Meaning        |      Use       |
| :---: | :-----------: | :------: | :-------------------: | :------------: |
|   1   |      `!`      |  Right   |     Logical `NOT`     |    `!expr`     |
|   2   |      `<`      |   Left   |       less than       | `expr < expr`  |
|   2   |     `<=`      |   Left   |  less than or equal   | `expr <= expr` |
|   2   |      `>`      |   Left   |     greater than      | `expr > expr`  |
|   2   |     `>=`      |   Left   | greater than or equal | `expr >= expr` |
|   3   |     `==`      |   Left   |       equality        | `expr == expr` |
|   3   |     `!=`      |   Left   |      inequality       | `expr != expr` |
|   4   |     `&&`      |   Left   |     logical `AND`     | `expr && expr` |
|   5   |     `||`      |   Left   |     logical `OR`      | `expr || expr` |

```c++
// if val is not a boolean value, expr only runs when val == 1
if (val == true)
    expr;
```

# 4.4. Assignment Operators

Assignment operators are <u>right associative</u>.

Each object in a multiple assignment must have the same type as its right-hand neighbour or a type to which that neighbour can be converted.

# 4.5. Increment and Decrement Operators

<font color="blue">Advice</font>: Use Postfix Operators only When Necessary.

# 4.6. The Member Access Operators

`ptr->mem` is a synonym for `(*ptr).mem`.

# 4.7. The Conditional Operator

Conditional operator(`?:`) is <u>left associative</u>.

# 4.8. The Bitwise Operators

### Bitwise Operators (Left Associative)

| Order | Operator |   Function    |       Use        |
| :---: | :------: | :-----------: | :--------------: |
|   1   |   `~`    | bitwise `NOT` |     `~expr`      |
|   2   |   `<<`   |  left shift   | `expr1 << expr2` |
|   2   |   `>>`   |  right shift  | `expr1 >> expr2` |
|   3   |   `&`    | bitwise `AND` | `expr1 & expr2`  |
|   4   |   `^`    | bitwise `XOR` | `expr1 ^ expr2`  |
|   5   |   `|`    | bitwise `OR`  | `expr1 | expr2`  |

These operators can also be used in types from library `<bitset>`.

<font color="red">Warning</font>: Bitwise operations on `signed` value is <u>machine-dependent</u>. Using `<<` on a `signed` value that changes sign bit is UB.

**Tips**: use `unsigned` types with the bitwise operators.

# 4.9. The `sizeof` Operator

Two forms of `sizeof`:

```c++
sizeof(type)
sizeof type
```

`sizeof` does not evaluate its operand, for example, `sizeof(*p)` returns size of `*p` even `p` is uninitialized.

`sizeof` an **array** returns <u>size of the entire **array**</u> (it doesn't convert **array** to a **pointer**).

# 4.10. Comma Operator

Comma Operator: `,`

The result of a comma expression is the value of its right-hand expression.

# 4.11. Type Conversions

When **implicit conversion**s (in *0.4. Terminology*) occur:

|                                                              | type before  conversion           | type after  conversion            |
| ------------------------------------------------------------ | --------------------------------- | --------------------------------- |
| most expressions                                             | integral types smaller than `int` | appropriate  larger integral type |
| conditions                                                   | non-`bool`                        | `bool`                            |
| arithmetic, relational exprs                                 | mixed types                       | common type                       |
| signedness differs and type of `unsigned` operand ≥ type of `signed` operand | `signed`                          | `unsigned`                        |
| signedness differs and type of `signed` operand ≥ type of `unsigned` operand |                                   |                                   |

## 4.11.1. The Arithmetic Conversions

### Integral Promotions

(in *0.4. Terminology*)

### Operands of Unsigned Type

## 4.11.2. Other Implicit Conversions

| Conversions                                       | Automatic?             | When                                                         | Type before conversion                       | Type after conversion |
| ------------------------------------------------- | ---------------------- | ------------------------------------------------------------ | -------------------------------------------- | --------------------- |
| **array** to **pointer**                          | yes                    | in most exprs except when used with `decltype`, address-of(`&`), `sizeof`, `typeid`, or initialize a **reference** to an **array**. | **array**                                    | **pointer**           |
| **pointer** to **pointer**                        |                        |                                                              | constant integral `0`, **literal** `nullptr` | any **pointer** type  |
|                                                   |                        |                                                              | any non-`const` **pointer**                  | `void *`              |
|                                                   |                        |                                                              | any **pointer**                              | `const void *`        |
| others to `bool`                                  | yes                    |                                                              | arithmetic, **pointer**                      | `bool`                |
| non-`const` to `const`                            | no                     |                                                              | non-`const`                                  | `const`               |
| `class` to `bool`<br />(defined by `class` types) | yes<br />(by complier) | e.g.: using `istream` in a condition                         | `istream`                                    | `bool`                |

## 4.11.3. Explicit Conversions

When we do an **explicit cast**, the <u>warning message is turned off</u>.

### Named Casts

`cast_name<Type> (expr)`

Type of cast (in *0.4. Terminology*):

1. `static_cast`

   ```c++
   double d = static_cast<double>(j) / i;
   ```

2. `dynamic_cast`

3. `const_cast`

   ```c++
   const char *pc;
   char *p = const_cast<char *>(pc);// ok: but writing through p is undefined
   ```

4. `reinterpret cast`

   ```c++
   int *ip;
   char *pc = reinterpret_cast<char*>(ip);
   ```

### Old-Style Casts

| notation                       | syntax         |
| ------------------------------ | -------------- |
| function-style cast notation   | `type (expr)`  |
| C-language-style cast notation | `(type)  expr` |

When we use an old-style cast where a `static_cast` or `const_cast` would be legal, the old style is equivalent to either of them, or else is equivalent to `reinterpre_cast`.

# 4.12. Operator Precedence Table

<div align="center">
    <img src="Chapter 4. Expressions.assets/clip_image001-1574167598608.png" alt="Operator Precedence Table" style="zoom:80%;" />
    <img src="Chapter 4. Expressions.assets/clip_image001-1574167682230.png" alt="Operator Precedence Table" style="zoom:80%;" />
</div>