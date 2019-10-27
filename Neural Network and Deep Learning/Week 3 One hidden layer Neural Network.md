# 1. 神经网络概览
| 上标  | 含义            |
| :---: | --------------- |
| $[i]$ | 第$i$层         |
| $(i)$ | 第$i$个训练样本 |
## 神经元计算损失函数图示

<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets/1571485950093.png" alt="1571485950093" style="zoom:80%;" />
    <br>
    <b>神经元</b>
</div>

<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets/1571485976533.png" alt="1571485976533" style="zoom:80%;" />
    <br>
    <b>计算损失函数</b>
</div>

## 神经网络计算损失函数图示

<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets/1571485987000.png" alt="1571485987000" style="zoom:80%;" />
    <br>
    <b>单隐层神经网络</b>
</div>

<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets/1571485999018.png" alt="1571485999018" style="zoom:80%;" />
    <br>
    <b>计算损失函数</b>
</div>

**正向传播**：正向计算$\displaystyle z^{[i]}, a^{[i]}, \mathcal{L}(a^{[i]}, y)$。
**反向传播**：反向计算$\displaystyle dw, db$等。

# 2. 神经网络表示
<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets\1571492569430.png" alt="" style="zoom:80%">
    <br>
    <b>双层（单隐层）神经网络</b>
</div>

输入特征的数值也可用$a^{[0]}$表示，即对第$0$层有$x=a^{[0]}$，其中$a$表示“**激活**”，表示网络中不同层的值会传递给后面的层。$a^{[j]}_{i}$表示第$j$层的第$i$个单元。
输出层（此图中为$a^{[2]}$）的值即预测值$\hat{y}$。

# 3. 计算神经网络的输出

<div align="center">
    <img src="Week 3 One hidden layer Neural Network.assets/1571493264680.png" alt="1571493264680" style="zoom:80%;" />
    <br>
    <b>单个神经元及其计算过程</b>
</div>

神经网络计算过程（$l$层）

| 非向量化 | $z^{[j]}_{i}=w^{[j]T}_{i}x+b^{[j]}_{i}, a^{[j]}_{i}=\sigma(z^{[j]}_{i})$ |
| -------- | :----------------------------------------------------------- |
| 向量化   | $z^{[j]}=W^{[j]}x+b^{[j]}, a^{[j]}=\sigma(z^{[j]})$<br />令$a^{[0]}=x$，则有<br />$z^{[j]}=W^{[j]}a^{[j-1]}+b^{[j]}, a^{[j]}=\sigma(z^{[j]})$ |

​		其中：
$$
W^{[ j]} =W^{T}=\begin{bmatrix}
w^{[ j]T}_{1}\\
w^{[ j]T}_{2}\\
\vdots \\
w^{[ j]T}_{n}
\end{bmatrix},
w_i^{[j]}=\begin{bmatrix}
w_i^{[j](1)}\\
w_i^{[j](2)}\\
\vdots \\
w_i^{[j](n_x)}
\end{bmatrix},
b^{[j]}=\begin{bmatrix}
b^{[j](1)}\\
b^{[j](2)}\\
\vdots \\
b^{[j](n_x)}
\end{bmatrix},
j=0,1,\cdots,l
$$


注：

>由于第$j$层的输入实际上是第$j-1$层的输出，因此：
>对第1层有：
>$z^{[1]}=W^{[1]}a^{[0]}+b^{[1]}$（即：$z^{[1]}=W^{[1]}x+b^{[1]}$）
>$a^{[1]}=\sigma(z^{[1]})$
>但对第二层有：
>$z^{[2]}=W^{[2]}a^{[1]}+b^{[2]}$
>$a^{[2]}=\sigma(z^{[2]})$
>对最后一层有$\hat{y}=a^{[j]}$

# 4. 多个例子中的向量化

对样本集的正向传播过程进行向量化
$$
x\to a^{[2]}=\hat{y}
$$
​		即：
$$
\begin{bmatrix}
x^{(1)}\\
x^{(2)}\\
\vdots\\
x^{(m)}
\end{bmatrix}
\to
\begin{bmatrix}
a^{[l](1)}\\
a^{[l](2)}\\
\vdots\\
a^{[l](m)}
\end{bmatrix}
=
\begin{bmatrix}
\hat{y}^{(1)}\\
\hat{y}^{(2)}\\
\vdots\\
\hat{y}^{(m)}\\
\end{bmatrix}
$$

| 非向量化                                                     | 向量化                                                       |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| $for\ i=1\ to\ m:\\\ \ \ \ z^{[1](i)}=W^{[1](i)}x^{(i)}+b^{[1]}\\\ \ \ \ a^{[1](i)}=\sigma(z^{[1](i)})\\\ \ \ \ z^{[2](i)}=W^{[2](i)}x^{(i)}+b^{[2]}\\\ \ \ \ a^{[2](i)}=\sigma(z^{[2](i)})$ | $Z^{[1]}=W^{[1]}X+b^{[1]}(或Z^{[1]}=W^{[1]}A^{[0]}+b^{[1]})\\A^{[1]}=\sigma(Z^{[1]})\\Z^{[2]}=W^{[2]}X+b^{[2]}\\A^{[2]}=\sigma(Z^{[2]})$<br />注意$Z^{[l]}$的计算过程使用了广播机制 |

​		此处与[Week2](./Week 2 Basics of Neural Network Programming.md)第10节的代码相同，只是添加了表示层数的上标$[i]$，其中$Z^{[1]},W^{[1]},X^{[1]},A^{[1]}$等均为对应列向量横向堆叠得到。如$A^{[1](j)}_{i}$表示第$i$个隐藏单元对第$j$个训练样本的激活函数。即纵坐标表示不同的输入样本，横坐标表示不同的输入特征。

# 5. 向量化实现的解释

略（实际上讲的是各个矩阵的列向量的堆叠过程）

# 6. 激活函数

- $a=\sigma(z)$：一般用于取值为$0,1$的<u>输出层</u>。

- $a=g(z)=\tanh(z)=\frac{e^{z}-e^{-z}}{e^{z}+e^{-z}}$：$\sigma(z)$平移后的函数，一般表现比$\sigma(z)$好，因为其平均值更接近$0$，可达到数据中心化的效果，方便下一层的学习。但若输出层的取值为$0,1$，则显然使用$\sigma(z)$更合适。

- $a=\max(0,z)$：即ReLU函数。当$|z|$过大时，$\sigma(z),\ \tanh(z)$的斜率都过小，因此改用此函数。（注意它在$z=0$处没有导数，但实践中在$z=0$处求导的概率极低，且可通过令$dz=0$或$dz=1$来规避。ReLU的斜率很大，相对能大幅提高学习速率。虽然$z<0$时斜率为$0$，但有足够多的隐藏单元令$z>0$，通常情况下仍然很快。

选择激活函数的经验法则：

- 一般默认使用ReLU，且预先定义其在零点的导数值（或使用Leaky ReLU: $a=\max(0.01z,z)$）。
- 二分分类时，输出层使用$\sigma(z)$，其他层使用ReLU。

<img src="Week 3 One hidden layer Neural Network.assets/1572195450428.png" alt="1572195450428" style="zoom:50%;" />