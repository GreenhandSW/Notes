2.1. Primitive Built-in Types

## 2.1.1. Arithmetic Types

| Type          | Meaning                           | Minimum Size        |
| ------------- | --------------------------------- | ------------------- |
| `bool`        | boolean                           | NA                  |
| `char`        | character                         | 8 bits              |
| `wchar_t`     | wide character                    | 16 bits             |
| `char16_t`    | Unicode character                 | 16 bits             |
| `char32_t`    | Unicode character                 | 32 bits             |
| `short`       | short integer                     | 16 bits             |
| `int`         | integer                           | 16 bits             |
| `long`        | long integer                      | 32 bits             |
| `long long`   | long integer                      | 64 bits             |
| `float`       | single-precision floating-point   | 6 significant bits  |
| `double`      | double-precision floating-point   | 10 significant bits |
| `long double` | extended-precision floating-point | 10 significant bits |

Where,

1. The usage of some characters are:

   |          type          | usage                                        |
   | :--------------------: | :------------------------------------------- |
   |         `char`         | for  machine's basic character set           |
   | `char16_t`, `char32_t` | for  Unicode characters                      |
   |       `wchar_t`        | for machine's largest extended character set |

2. The significant digits are:

   |   Type   | significant  digits(a number's digits it can represent) |
   | :------: | :-----------------------------------------------------: |
   | `float`  |                           7~8                           |
   | `double` |                          15~16                          |

3. Implementation of `char` is:

   |      Type       |     Implementation     |
   | :-------------: | :--------------------: |
   |  `signed char`  |     `signed char`      |
   | `unsigned char` |    `unsigned char`     |
   |     `char`      | `signed/unsigned char` |

**Tips**:

- Do not use `char`, `bool` in arithmetic expressions, because `char` is **signed** on some machines and **unsigned ** in others. If you need a tiny integer, use `signed char` or `unsigned char`.
- Use `double` for floating-point computations; `float` usually does not have enough precision, and the cost of double-precision calculations versus single-precision is negligible. In fact, on some machines, double-precision operations are faster than single. The precision offered by `long double` usually is unnecessary and often entails considerable run-time cost.

## 2.1.2. Type Conversions

if we assign an out-of-range value to an object of `signed` type, the result is **undefined**.

<font color="blue">Advice</font>: Avoid undefined and implementation-defined （编译器实现的） behavior.

## 2.1.3. Literals

|    literal     |        type         |
| :------------: | :-----------------: |
|    decimal     |      `signed`       |
|     octal      | `signed`/`unsigned` |
|  hexadecimal   | `signed`/`unsigned` |
| `true`/`false` |      `boolean`      |
|   `nullptr`    |      `pointer`      |

### Character and Character String Literals

| Prefix |             Meaning              |    Type    |
| :----: | :------------------------------: | :--------: |
|  `u`   |       Unicode 16 character       | `char16_t` |
|  `U`   |       Unicode 32 character       | `char32_t` |
|  `L`   |          wide character          | `wchar_t`  |
|  `u8`  | utf-8 (string **literal**s only) |   `char`   |

### Integer Literals

|  Suffix   | Minimum Type |
| :-------: | :----------: |
|  `u`/`U`  |  `unsigned`  |
|  `l`/`L`  |    `long`    |
| `ll`/`LL` | `long long`  |

### Floating-Point Literals

| Suffix  |     Type      |
| :-----: | :-----------: |
| `f`/`F` |    `float`    |
| `l`/`L` | `long double` |

# 2.2. Variables

## 2.2.1. Variable Definitions

### Initializers

```c++
std::string s("Hello");
```

<font color="red">Warning</font>: Initialization is not assignment. Initialization happens when a variable is given a value when it is created. Assignment obliterates an object’s current value and replaces that value with a new one.

### List Initialization

```c++
// Initialize a integer x
int x=0;
int x={0};
int x{0};        // List Initialization
int x(0);
```

**Tips**: List Initialization with not be allowed to be used in initializing variables of built-in type if the initializer might lead to loss of information.

### Default Initialization

| object         | definition area        | value(if  uninitialized)                                     |
| -------------- | ---------------------- | ------------------------------------------------------------ |
| variable       | outside  function body | 0                                                            |
|                | inside  function body  | uninitialized                                                |
| `class` object |                        | up to the `class`<br />e.g.: the value of uninitialized `string` is `""`. |

## 2.2.2. Variable Declarations and Definitions

|     ` `     | function                                                     | Times |
| :---------: | ------------------------------------------------------------ | :---: |
| Declaration | specifies type and name                                      | many  |
| Definition  | 1. specifies type, name<br />2. allocates storage<br />3. (may) initialize it |   1   |

1. **Declaration**:

   ```c++
   extern int i;// declaration
   ```

2. **Definition**:

   ```c++
   int j;            // definition
   int i = 1;        // line1 in file1
   extern int i = 2; // line2 in file2
   // compile the upper two lines will cause an error.
   // and the extern isn't in the scope of file2
   ```

<font color="red">Warning</font>: It is an error to provide an **initializer** on an `extern` <u>inside a function</u>.

## 2.2.3. Identifiers

**Not allowed identifiers**: `_xxx` (when defined outside a function), `__xxx`, `_Xxx`

**Conventions for Variable Names**:

1. variable name: lower case
2. classes: begin with an uppercase letter
3. Identifiers with multiple words: `XxxXxxx` or `xxx_xxxx`

## 2.2.4. Scope of a Name

<font color="blue">Advice</font>: Define variables Where You First Use Them.

<font color="red">Warning</font>: It is almost always a bad idea to define a local variable with the same name as a global variable that the function uses or might use.

**Scope**:

1. global scope
2. block scope
3. Nested Scopes(Inner Scope, Outer Scope)

# 2.3. Compound Types

## 2.3.1. References

```c++
int Val = 2;
int &refVal = Val;        // reference
```

A reference must be initialized and bound only to an object of the same type, not to a literal or to the result of a more general expression.

<font color="green">Focus</font>: a **reference** is just another name for an already existing object.

## 2.3.2. Pointers

### obtain a `nullptr`

```c++
int *p = nullptr;     // equivalent to int *p = 0
int *p = 0;           // directly initialize p from the literal constant 0
// must #include cstdlib
int *p = NULL;        // equivalent to int *p = 0
```

**Tips**:

- Avoid using `NULL`, use `nullptr` instead.

- It is illegal to assign an `int` variable to a **pointer**, even if the variable’s value happens to be `0`.

<font color="blue">Advice</font>: Initialize all **pointer**s.

### `void *` Pointers

The type of the object at the address of `void *` **pointer** is unknown.

### Reference to Pointers

```c++
int i = 42, *p;
int *&r = p;        // r is reference to the pointer
```

# 2.4. `const` Qualifier

By default, `const` objects are local to a file.

## 2.4.1. References to `const`

```C++
const int Val = 1;
const int &refVal = Val;
```

```c++
const type &x = 2;
// the upper definition is actually:
const type tmp = 2;
const type &x = tmp;
```

Rules of **reference** to `const` between same type and different types:

<div align="center">
    <img src="Chapter 2. Variables and Basic Types.assets/1574087803671.png" alt="1574087803671" style="zoom:80%;" />
</div>



## 2.4.2. Pointers and `const`

Rules of pointer to `const` between same type and different types:

<div align="center">
    <img src="Chapter 2. Variables and Basic Types.assets/1574087952815.png" alt="1574087952815" style="zoom:80%;" />
</div>

## 2.4.3.   **Top-Level** `const`

| level of `const`  |            definition            |
| :---------------: | :------------------------------: |
| top-level `const` | `const` **pointer** to an object |
| low-level `const` | **pointer**  to a `const` object |

  ## 2.4.4. `constexpr` and Constant Expressions

### `constexpr`

**constant expression**: an expression whose value <u>cannot be changed</u> and that can be <u>evaluated at compile time</u>.

**`constexpr`** variable: Variable that represents a constant expression.

**literal** types: arithmetic, **reference**, **pointer**.

### Pointers and `constexpr`

The address of an object defined <u>outside of any function</u> is a **constant expression**, and so may be used to initialize a `constexpr` **pointer**.

```c++
// p is a const pointer to type1(so p is top-level)
constexpr type1 *p = nullptr;
```

# 2.5. Dealing with Types

## 2.5.1. Type Aliases

```c++
typedef type1 alias1, *ptr1;
using alias1 = type1;
```

### Pointers, `const`, and Type Aliases

A `const` that appears in the base type modifies the given type. Such as in the following example, the base type is a **pointer**(to type1), so `const` makes it a `const` **pointer**(to type1).

```c++
// p1 is a const pointer to type1, 
// not a pointer to const type1.
const ptr1 p1 = 0;
```

## 2.5.2. the `auto` Type Specifier

```c++
// the type of item is deduced from the type of the result of adding val1 and val2.
auto item = val1 + val2;
```

`auto` variable must be initialized.

When defining multiple variables using `auto`. Because a declaration can involve only a single base type, the initializers for all the variables in the declaration must have types that are consistent with each other:

```c++
auto i = 0, *p = &i;    // ok: i is int and p is a pointer to int
auto sz = 0, pi = 3.14; // error: inconsistent types for sz and pi
```

## 2.5.3. the `decltype` Type Specifier

```c++
// y has the same type as the result of expression1
decltype(expression1) y = expression2;
```

When the expression to which we apply `decltype` is a variable, `decltype` returns the type of that variable, <u>including top-level `const` and **reference**s</u>.

### `decltype` and References

```c++
int i = 2, &r1 = i;
decltype(r1) r2 = i;        // r2 is int& (reference to int)
decltype(r1 + 0) r3 = i;    // r3 is int
decltype(*p1) p2 = i;	    // p2 is int& (reference to int)
decltype(expression1) k = i;// expression1: such as (i), ((i)) , ..., i=3, *p1, etc.
```

# 2.6. Defining Our Own Data Structures

**Preprocessor**: such as **header guard**(in *0.4. Terminology*).

Preprocessor variable names do not respect C++ scoping rules(in *2.2.4. Scope of a Name*), and are usually written in all uppercase.

