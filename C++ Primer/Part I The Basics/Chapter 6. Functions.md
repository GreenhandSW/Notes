# 6.1. Function Basics

Function control tranfer:

<img src="Chapter 6. Functions.assets/1574173394971.png" alt="1574173394971" style="zoom:80%;" />  

The order in which arguments of a function are evaluated is not guaranteed.

`void` parameter list:

1. implicit

   ```c++
   void f1(){}
   ```

2. explicit

   ```c++
   void f2(void){}
   ```

<font color="blue">Advice</font>: local variables at the outermost scope of the function may not use the same name as any parameter.

## 6.1.1. Local Objects

### Automatic Object

```c++
{
	statements;
	variable definition; // variable created
	statements;
}                        // variable destroyed
```

Parameters are **automatic object**s.

### Local `static` Objects

Local `static`s of built-in type, if not initialized, are default initialized to `0`.

## 6.1.2. Function Declarations

Functions and variables should be <u>declared in header file</u>s and <u>defined in source file</u>s.

## 6.1.3. Separate Compilation

Compile with VS command prompt:

```powershell
cl /EHsc file1.cpp file2.cpp #compile and link, file2 contains main()
link file2.obj	# only link
```

# 6.2. Argument Passing

## 6.2.1. Passing Arguments by Value

## 6.2.2. Passing Arguments by Reference

```c++
void func(int &n)
{/* */}

int main(void)
{
    int n;
    func(n);
}
```

Some `class` types(such as IO types) cannot be passed by value/copy, but can by **reference**.

**Reference** parameters that are not changed inside a function should be **reference**s to `const`:

```c++
// compare the length of two strings
bool isShorter(const string &s1, const string &s2)
{
    return s1.size() < s2.size();
}
```

## 6.2.3. `const` Parameters and Arguments

Passing arguments ignores top-level `const`, so if two functions are only different in the `const`ness of their parameters, they are actually regarded as one function, that is, they are re-defined.

### Use Reference to `const` When Possible

Reference argument passing:

<div align="center">
    <img src="Chapter 6. Functions.assets/1574174717475.png" alt="1574174717475" style="zoom:80%;" />
</div>

## 6.2.4. Array Parameters

Passing an **array** to a function is actually passing the **pointer** to the **array**'s 1st element to the function.

Ways to manage pointer parameters:

- use a marker to specify the extent of an **array**: C-style string's last character is a null **pointer**.
- use the standard library conventions: pass **pointer**s to the first and one past the last element in the **array**.

