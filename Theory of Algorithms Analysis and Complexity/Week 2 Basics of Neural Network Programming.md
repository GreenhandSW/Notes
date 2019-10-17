# 1. 二分分类

$\displaystyle ( x,y) \ \ \ \ x\in \mathbb{R}^{n_{x}} ,\ y\ \in \{0,1\}$
训练样本 $\displaystyle \left\{\left( x^{( 1)} ,\ y^{( 1)}\right) ,\left( x^{( 2)} ,\ y^{( 2)}\right) ,\ \cdots ,\ \left( x^{( m)} ,\ y^{( m)}\right) \ \right\} ,\ m=m_{train}$
训练集: $\displaystyle X=\begin{bmatrix}
x^{( 1)} & x^{( 2)} & \cdots  & x^{( m)}
\end{bmatrix}$,  $\displaystyle X\in \mathbb{R}^{n_{x} \times m}$ 或 $\displaystyle X=\begin{bmatrix}
x^{( 1)^{T}}\\
x^{( 2)^{T}}\\
\vdots \\
x^{( m)^{T}}
\end{bmatrix}$

```python
X.shape = (nx, m)
```

 $\displaystyle Y=\left[ y^{( 1)} ,\ y^{( 2)} ,\ \cdots ,\ y^{( m)}\right] ,\ \ \ Y\in \mathbb{R}^{1\times m}$ 

```python
Y.shape = (1, m)
```

$\displaystyle m_{train}$: 训练样本数量
$\displaystyle m_{test}$: 测试样本数量

# 2. Logistic回归

给定$\displaystyle \ x$，希望得到$\displaystyle \ \hat{y} =P( y=1|x)$

1. 输入： $\displaystyle x\in \mathbb{R}$
2. 参数： $\displaystyle w\in \mathbb{R}^{n_{x}} ,\ b\in \mathbb{R}$
3. 输出： $\displaystyle \hat{y}$

logistic回归模型：$\displaystyle \hat{y} =\sigma \left( w^{T} x+b\right)$。令$\displaystyle z=w^{T} x+b$，则有
$$
\hat{y} =\sigma ( z) =\frac{1}{1+e^{-z}}\\
\lim _{z\rightarrow+\infty } \sigma ( z) =1\\
\lim _{z\rightarrow-\infty } \sigma ( z) =0
$$
各量的其他记法：
$$
\displaystyle x\in \mathbb{R}^{n_{x} +1} ,\ x_{0} =1\\
\hat{y} =\sigma \left( \theta ^{T} x\right) ,\ \theta =\begin{bmatrix}
\theta ^{( 1)^{T}}\\
\theta ^{( 2)^{T}}\\
\vdots \\
\theta ^{( m)^{T}}
\end{bmatrix} ,\ 其中\ \theta ^{( 1)^{T}} =b,\ \begin{bmatrix}
\theta ^{( 2)^{T}}\\
\vdots \\
\theta ^{( m)^{T}}
\end{bmatrix} =w^{T} \
$$

# 3. Logistic回归成本函数

给定训练样本$\displaystyle \left\{\left( x^{( 1)} ,\ y^{( 1)}\right) ,\left( x^{( 2)} ,\ y^{( 2)}\right) ,\ \cdots ,\ \left( x^{( m)} ,\ y^{( m)}\right) \ \right\}$，希望得到$\displaystyle \hat{y}^{( i)} \approx y^{( i)}$，其中上标$\displaystyle i$表示第$\displaystyle i$个样本。
**损失函数**：（衡量$\displaystyle w,\ b$在单个训练样本上的表现，对每一个训练样本都输出$\displaystyle y^{( i)}$，并与样本标签$\displaystyle \hat{y}^{( i)}$比较。越小越好）
$$
\displaystyle \mathcal{L}\left(\hat{y}^{( i)} ,y^{( i)}\right) =-\left[ y^{( i)}\log\left(\hat{y}^{( i)}\right) +\left( 1-y^{( i)}\right)\log\left( 1-\hat{y}^{( i)}\right)\right]
$$
​	当$\displaystyle y^{( i)} =1$时，$\displaystyle \mathcal{L}\left(\hat{y}^{( i)} ,y^{( i)}\right) =-\log\left(\hat{y}^{( i)}\right)$，要使$\displaystyle \mathcal{L}$尽可能小，则要使$\displaystyle \hat{y}^{( i)}$尽可能大；
​	当$\displaystyle y^{( i)} =0$时，$\displaystyle \mathcal{L}\left(\hat{y}^{( i)} ,y^{( i)}\right) =-\log\left( 1-\hat{y}^{( i)}\right)$，要使$\displaystyle \mathcal{L}$尽可能小，则要使$\displaystyle \hat{y}^{( i)}$尽可能小；
**成本函数**：（衡量$\displaystyle w,\ b$在全体训练样本上的表现）
$\displaystyle J( w,b) =\frac{1}{m}\sum ^{m}_{i=1}\mathcal{L}\left(\hat{y}^{( i)} ,y^{( i)}\right) =-\frac{1}{m}\sum ^{m}_{i=1}\left[ y^{( i)}\log\left(\hat{y}^{( i)}\right) +\left( 1-y^{( i)}\right)\log\left( 1-\hat{y}^{( i)}\right)\right]$

# 4. 梯度下降法

作用：用于习得合适的$\displaystyle w,\ b$，使得$\displaystyle J( w,b)$最小。

|                             图像                             | 计算过程                                                     |
| :----------------------------------------------------------: | :----------------------------------------------------------- |
| <img src="Week 2 Basics of Neural Network Programming.assets/timg.jpg" alt="一维梯度下降" style="zoom:50%;" /> | repeat{<br />         $w=w-\alpha \frac{dJ( w)}{dw}$<br />}<br />>注：编程时使用$\displaystyle dw$ 作为$\displaystyle \frac{dJ( w)}{dw}$ 的变量名 |

