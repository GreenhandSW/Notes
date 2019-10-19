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

