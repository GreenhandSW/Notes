# 3.1. Namespace `using` Declarations

```c++
using namespace::name;
```

**Tips**:

1. A separate `using` declaration is required for each name.
2. headers should not include `using` declarations.

# 3.2. Library `string` Type

## 3.2.1. Defining and Initializing `string`s

### Ways to Initialize a `string`

| way                   | meaning                                                      |
| --------------------- | ------------------------------------------------------------ |
| `string s1`           | Default initialization; `s1` is the empty string.            |
| `string s2(s1)`       | `s2` is a copy of  `s1`.                                     |
| `string s2 = s1`      | Equivalent to `s2(s1)`, `s2` is a copy of `s1`.              |
| `string s3("value")`  | `s3` is a copy of the `string` **literal**, not including the `null`. |
| `string s3 = "value"` | Equivalent to  `s3("value")`, s3 is a copy of the `string` **literal**. |
| `string s4(n, 'c')`   | Initialize `s4`  with `n​` copies of the character `'c'`.     |

### Direct and Copy Forms of Initialization

1. Copy initialization

   ```c++
   string s("abcd");
   string s(4, 'c');
   ```

2. Direct initialization

   ```c++
   string s = "abcd";
   string s = string(4, 'c');
   ```

## 3.2.2. Operations on `string`s

### `string` operations

| operation                        | meaning                                                      |
| -------------------------------- | ------------------------------------------------------------ |
| `os << s`                        | Writes s onto  output stream `os`. Returns `os`.             |
| `is >> s`                        | Reads whitespace-separated string from `is` into `s`. Returns `is`.<br />(reads and discards any leading whitespace like spaces, newlines, tabs) |
| `getline(is,  s)`                | Reads a line of input from `is` into `s`. Returns `is`.<br />(reads a line and discards one newline) |
| `s.empty()`                      | Returns true if `s` is empty; otherwise returns `false`.     |
| `s.size()`                       | Returns the number of characters in `s`.                     |
| `s[n]`                           | Returns a reference to the `char` at position `n` in `s`; positions start at `0`, |
| `s1 + s2`                        | Returns a `string` that is the concatenation of `s1` and `s2`. |
| `s1 = s2`                        | Replaces characters in `s1` with a copy of `s2`.             |
| `==`, `!=`, `<`, `<=`, `>`, `>=` | Comparisons are case-sensitive and use dictionary ordering.  |

`string::size_type` is `unsigned`.

```c++
auto len = line.size(); // len has type string::size_type.
```

Adding **Literal**s and `string`s gets the concatenation of them, note that at least one of the operand of the first `+` operator must be a string.

```c++
string s2 = "hello" + s1 + "world"; // ok: the right operand of the first "+" is a string
string s3 = "hello" + "world" + s1; // error: none of the operand of the first "+" is a string
```

## 3.2.3. Dealing with the Characters in a `string`

### `cctype` functions

|   function    | meaning                                                      |
| :-----------: | :----------------------------------------------------------- |
| `isalnum(c)`  | `true` if `c` is  a letter or a digit.                       |
| `isalpha(c)`  | `true` if `c` is a letter.                                   |
| `iscntrl(c)`  | `true` if `c` is a control character.                        |
| `isdigit(c)`  | `true` if `c` is a digit.                                    |
| `isgraph(c)`  | `true` if `c` is not a space but is  printable.              |
| `islower(c)`  | `true` if `c` is a lowercase letter.                         |
| `isprint(c)`  | `true` if `c` is a printable character(i.e.,  a space or a character that has a visible representation). |
| `ispunct(c)`  | `true` if `c` is a punctuation  character(i.e., a character that is not a control character, a digit, a  letter, or a printable whitespace). |
| `isspace(c)`  | `true` if `c` is whitespace(i.e., a space,  tab, vertical tab, return, newline, or formfeed). |
| `isupper(c)`  | `true` if `c` is an uppercase letter.                        |
| `isxdigit(c)` | `true` if `c` is a hexadecimal digit.                        |
| `tolower(c)`  | If `c` is an uppercase letter, returns its  lowercase equivalent; otherwise returns `c` unchanged. |
| `toupper(c)`  | If `c` is a lowercase letter, returns its  uppercase equivalent; otherwise returns `c` unchanged. |

### **range** `for`

**range** `for` controls statement that iterates through a specified collection of values.

```c++
string s = "Hello World!";
for(auto c : s)// for every char in s
    cout << c << endl;
// use reference to change characters in s
for (auto &c : s)
    c = toupper(c);
```

# 3.3. Library `vector` Type

`vector`: a `vector` is a `class` template, it can hold objects of most any **non-reference** type.

```c++
#include<vector>
using std::vector;
vector<mytype> x;          // holds objects of mytype
// vector whose elements are vectors. mytype can't be const in vs2015.
vector<vector<string>> x;  // new format
vector<vector<string> > x; // old format
```

## 3.3.1.   Defining and Initializing `vector`s

###   Ways to Initialize a `vector`

| way                        | meaning                                                      |
| -------------------------- | ------------------------------------------------------------ |
| `vector<T> v1`             | `vector` that  holds objects of type `T`. Default initialization; `v1` is empty. |
| `vector<T> v2(v1)`         | `v2` has a copy of each element in `v1`.                     |
| `vector<T> v2 = v1`        | Equivalent to `v2(v1)`, `v2` is a copy of the elements in `v1`. |
| `vector<T> v3(n, val)`     | `v3` has `n` elements with value `val`.                      |
| `vector<T> v4(n)`          | `v4` has `n` copies of a value-initialized  object.          |
| `vector<T> v5{a, b, c}`    | `v5` has as many elements as there are  initializers; elements are initialized by corresponding initializers. |
| `vector<T> v5 = {a, b, c}` | Equivalent to `v5{a, b, c ...}`.                             |

**Exceptions**: if we use curly braces and the given initializers can't be used to list initialize the object, then those values will be used to construct the object.

```c++
vector<string> s1{10}; // s1 has 10 empty strings
vector<string> s2{10, "Hi"};// s2 has 10 "Hi" strings
```

## 3.3.2 Adding Elements to a `vector`

```c++
vector<string> s;
s.push_back("Hello");// append object to vector
```

<font color="red">Warning</font>: The body of a **range** `for` must not change the size of the sequence over which it is iterating, such as a `vector`.

## 3.3.3. Other `vector` Operations

| `v.empty()`                       | Returns `true` if `v` is empty; otherwise returns `false`.   |
| --------------------------------- | ------------------------------------------------------------ |
| `v.size()`                        | Returns the number of elements in `v`.                       |
| `v.push_back(t)`                  | Adds an element with value `t` to end of `v`.                |
| `v[n]`                            | Returns a reference to the element at position `n` in `v`.   |
| `v1 = v2`                         | Replaces the elements in `v1` with a copy of the elements in `v2`. |
| `v1 = {a, b, c ...}`              | Replaces the elements in `v1` with a copy of the elements in the comma-separated list. |
| `==`, `!=`,  `<`, `<=`, `>`, `>=` | Have their normal meanings using dictionary ordering.        |

```c++
vector<T> v;
auto len = v.size();	// len has type vector<T>::size_type.
```

# 3.4. Introducing Iterators

## 3.4.1. Using Iterators

| function    | meaning                                                      |
| ----------- | ------------------------------------------------------------ |
| `v.begin()` | first element in `vector`(the same as `v.end()` when `vector` is empty) |
| `v.end()`   | (off-the-end **iterator**)  :one past the last element in `vector` |

### standard container iterator operations

| `*iter`     | Returns a  reference to the element denoted by the iterator `iter`. |
| ----------- | ------------------------------------------------------------ |
| `iter->mem` | Dereferences `iter` and fetches the member  named `mem` from the underlying element. Equivalent to `(*iter).mem`. |
| `++iter`    | Increments `iter` to refer to the next  element in the container. |
| `--iter`    | Decrements `iter` to refer to the previous  element in the container. |
| `==`, `!=`  | Compares two iterators for equality  (inequality). Two iterators are equal if they denote the same element or if  they are the off-the-end iterator for the same container. |

<font color="blue">Advice</font>: most **library container**s have **iterator**s, all of the **iterator**s support `==` and `!=` operators, but few support `<` operator. So it's better using `!=` and `==` in the `for` loops.

### Iterator Types

```c++
// it1, it2 can read and write the corresponding object
vector<mytype>::iterator it1;
string::iterator it2;
// it1, it2 can only read the corresponding object
vector<mytype>::const_iterator cit1;
string::const_iterator cit2;
```

Rules of `const` **iterator**:

<img src="Chapter 3. Strings, Vectors, and Arrays.assets/1574146622214.png" alt="1574146622214" style="zoom:80%;" />

### the `begin` and `end` operations

| type of  returned iterator | `const`  type          | type                   |
| -------------------------- | ---------------------- | ---------------------- |
| `v.begin()`, `v.end()`     | `type::const_iterator` | `type::iterator`       |
| `v.cbegin()`, `v.cend()`   | `type::const_iterator` | `type::const_iterator` |

## 3.4.2. Iterator Arithmetic

### Operations Supported by `vector` and `string` Iterators

| operation                 | meaning                                                      |
| ------------------------- | ------------------------------------------------------------ |
| `iter + n`, `iter - n`    | Adding (subtracting) an integral value `n` to (from) an iterator yields an iterator that many elements forward (backward) within the container. The resulting iterator must denote elements in, or one past the end of, the same container. |
| `iter += n`,  `iter -= n` | Compound-assignment for iterator addition and subtraction. Assigns to `iterl` the value of adding `n` to, or subtracting `n` from, `iterl`. |
| `iterl -  iter2`          | Subtracting two iterators yields the number(type: `difference_type`) that when added to the right-hand iterator yields the left-hand iterator. The iterators must denote elements in, or one past the end of, the same container. |
| `>`,  `>=`, `<`, `<=`     | Relational operators on iterators. One iterator is less than another if it refers to an element that appears in the container before the one referred to by the other iterator. The iterators must denote elements in, or one past the end of, the same container. |

# 3.5. Arrays

## 3.5.1. Defining and Initializing Built-in Arrays

### Definition and Dimension

**Array**: a compound that can hold a specific amount of objects of a certain kind of non-reference type.

The number of elements in an **array** is part of the **array**’s type. As a result, the dimension must be known at compile time, which means that the dimension must be a **constant expression**.

### Complicated array declarations

```c++
// ptrs is an array of 10 pointers to int
int *ptrs[10];
// p points to an array of 10 ints
int (*p)[10] = &arr;
// ref refers to an array of 10 ints
int (&ref)[10] = arr;
```

### Default Initialization

**Array** defined outside of any function is default-initialized.

## 3.5.2. Accessing the Elements of an Array

```c++
// a size_t number is required to subscript an array
#include <cstddef>
size_t index; // index can be negative
arr[index];
```

## 3.5.3. Pointers and Arrays

### Array to Pointer Conversion

When we use an **array**, the compiler ordinarily converts the **array** to a **pointer**:

```c++
int arr[] = {0, 1, 2, 3};
auto arr2(arr);                 // arr2 is actually a pointer
decltype(arr) arr3 = {0, 1, 2}; // but arr3 is an array
```

### The Library `begin` and `end` Functions

```c++
#include <iterator>
```

| function  | meaning                                                      |
| --------- | ------------------------------------------------------------ |
| `begin()` | return a **pointer** to the first element of  given **array** |
| `end()`   | return  a **pointer**one past the last  element of given **array** |

### Pointer Arithmetic

```c++
null - null = 0
null - 0 = null
```

### Subscripts and Pointers

```c++
int *p = &arr[2]; // p points to the element indexed by 2
int k = p[-2];    // p[-2] is the same element as arr[0]
```

## 3.5.4. C-Style Character Strings

<font color="red">Warning</font>: Although C++ supports C-style strings, they should not be used by C++ programs. C-style strings are a surprisingly rich source of bugs and are the root cause of many security problems. They’re also harder to use!

### C-Style Character String Functions

```c++
#include <cstring>
```

| function          | meaning                                                      |
| ----------------- | ------------------------------------------------------------ |
| `strlen(p)`       | Returns the length of `p`, not counting the `null`.          |
| `strcmp(pl,  p2)` | Compares p1 and p2 for equality. Returns `0` if `p1 == p2`, a positive value if `p1 > p2`, a negative value if `p1 < p2`. |
| `strcat(p1,  p2)` | Appends `p2` to `p1`. Returns `p1`.                          |
| `strcpy(pl,  p2)` | Copies `p2` into `p1`. Returns `p1`.                         |

<font color="red">Warning</font>:

```c++
char ca[] = {'C', '+', '+'}; // not null terminated
cout << strlen(ca) << endl;  // disaster: ca isn't null terminated
```

## 3.5.5. Interfacing to Older Code

### Mixing Library `string`s and C-Style Strings

1. Use a null-terminated character array to initialize or assign a `string`.

2. Use a null-terminated character array as one operand (but not both operands) to the `string` addition operator or as the right-hand operand in the `string` compound assignment (`+=`) operator.

3. Use a `string` to initialize a null-terminated character array.

   ```c++
   const char *str = s.c_str();
   ```

### Using an Array to Initialize a `vector`

```c++
int arr[] = {1, 2 ,3};
vector<int> subvec(begin(arr) + 1, end(arr));
```

# 3.6. Multidimensional Arrays

### Traverse Multidimensional Array

To use a multidimensional **array** in a **range** `for`, the loop control variable for all but the innermost **array** must be **reference**s.

```c++
int arr[3][4];
for (auto &li : arr)
    for (auto &x : li)
        x = 9;
// the upper and the lower implementation are equivalent
for (int(*sub)[4] = begin(arr); sub != end(arr); sub++)
    for (int *p = begin(*sub); p!=end(*sub); p++)
        *p = 9;
```

### Type Aliases Simplify Pointers to Multidimensional Arrays

```c++
// 2 ways of defining int_array as an array of 4 ints.
using int_array = int[4];
typedef int int_array[4];
```

