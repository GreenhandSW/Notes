# 1. <span id="1">神经网络概览</span>
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
**正向传播**：正向计算$z^{[i]}, a^{[i]}, \mathcal{L}(a^{[i]}, y)$。
**反向传播**：反向计算$dw, db$等。

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
<span id="jump1">神经网络计算过程（$l$层）</span>

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

| 非向量化                                                     | <span id="jump2">向量化</span>                               |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| $for\ i=1\ to\ m:\\\ \ \ \ z^{[1](i)}=W^{[1](i)}x^{(i)}+b^{[1]}\\\ \ \ \ a^{[1](i)}=\sigma(z^{[1](i)})\\\ \ \ \ z^{[2](i)}=W^{[2](i)}x^{(i)}+b^{[2]}\\\ \ \ \ a^{[2](i)}=\sigma(z^{[2](i)})$ | $Z^{[1]}=W^{[1]}X+b^{[1]}(或Z^{[1]}=W^{[1]}A^{[0]}+b^{[1]})\\A^{[1]}=\sigma(Z^{[1]})\\Z^{[2]}=W^{[2]}X+b^{[2]}\\A^{[2]}=\sigma(Z^{[2]})$<br />注意$Z^{[i]}$的计算过程使用了广播机制 |

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

# 7. 为什么需要非线性激活函数

​		若使用线性激活函数（或称恒等激活函数），即令
$$
a^{[i]}=z^{[i]}
$$
​		则模型的输出（$y$或$\hat{y}$）是输入特征$x$的线性组合，由[第3节](#jump1)中的公式递推得出
$$
a^{[l]}=(\prod_{i=l \to 0}^l W[i])a^{[l]}+\sum_{i=1}^l (\prod_{j=l \to i+1}^l W^{[j]})b^{[i]}
$$
​		这种模型的复杂度与没有任何隐藏层的标准LR是一样的，因为线性函数的组合仍然是线性函数。

​		只有<u>当计算回归问题的时候，才能在输出层使用线性激活函数</u>。

# 8. 激活函数的导数

## sigmoid

$$
a=g(z)=\sigma(z)=\frac{1}{1+e^{-z}}\\
g^{'}(z)=\frac{d}{dz}g(z)=\frac{1}{1+e^{-z}}(1-\frac{1}{1+e^{-z}})=g(z)(1-g(z))=a(1-a)
$$

## tanh

$$
a=g(z)=\tanh(z)=\frac{e^{z}-e^{-z}}{e^{z}+e^{-z}}\\
g^{'}(z)=\frac{d}{dz}g(z)=1-(\frac{e^{z}-e^{-z}}{e^{z}+e^{-z}})^2=1-(\tanh(z))^2=1-a^2
$$

## ReLU

$$
a=g(z)=\max(0,z)\\
g^{'}(z)=\frac{d}{dz}g(z)=\left\{\begin{aligned}
0 & ,\ z<0\\
1 & ,\ z>0\\undefined &,\ z=0\end{aligned}\right.
$$

## Leaky ReLU

$$
a=g(z)=\max(0.0z,z)\\
g^{'}(z)=\frac{d}{dz}g(z)=\left\{\begin{aligned}
0.01 &,\ z<0\\
1 & ,\ z>0\\undefined &,\ z=0\end{aligned}\right.
$$

# 9. 神经网络的梯度下降法

参数：$W^{[1]}_{n^{[1]} \times n^{[0]}}, b^{[1]}_{n^{[1]} \times 1}, W^{[2]}_{n^{[2]} \times n^{[1]}}, b^{[2]}_{n^{[2]} \times 1}=b^{[2]}_{1 \times 1}$（各层单元数：$n^{[0]}=n_x,n^{[1]},n^{[2]}=1$）

损失函数：$J(W^{[1]},b^{[1]},W^{[2]},b^{[2]})=\frac{1}{m}\sum^m_{i=1} \mathcal{L}(\hat{y}, y)=\frac{1}{m}\sum^m_{i=1} \mathcal{L}(a^{[2]}, y)$

梯度下降：

> Repeat
>
> >计算预测值：$(\hat{y}^{(i)},\ i=1,2,\cdots,m)$
> >
> >计算导数：$dW^{[1]}=\frac{dJ}{dW^{[1]}}, db^{[1]}=\frac{dJ}{db^{[1]}},\cdots$（实际应当是偏导）
> >
> >$W^{[1]}=W^{[1]}-\alpha dW^{[1]}$
> >
> >$b^{[1]}=b^{[1]}-\alpha db^{[1]}$
> >
> >$\cdots$

计算偏导的公式（对整个样本集）

- 正向传播：公式见[第4节](#jump2)

- 反向传播：

  | 单个样本                                                     | 样本集                                                       |
  | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | $$\begin{aligned}dz^{[2]}&=z^{[2]}-y\\dW^{[2]}&=dz^{[2]}a^{[1]T}\\db^{[2]}&=dz^{[2]}\\dz^{[1]}&=W^{[2]T}dz^{[2]}* g^{[1]'}(z^{[1]})\\dW^{[1]}&=dz^{[1]}x^{T}\\db^{[1]}&=dz^{[1]}\end{aligned}$$ | $$\begin{aligned}dZ^{[2]}&=A^{[2]}-Y\\dW^{[2]}&=\frac{1}{m}dZ^{[2]}A^{[1]T}\\db^{[2]}&=\frac{1}{m}np.sum(dZ^{[2]},\ axis=1,\ keepdims=True)\\dZ^{[1]}&=W^{[2]T}dZ^{[2]}* g^{[1]'}(Z^{[1]})\\dW^{[1]}&=\frac{1}{m}dZ^{[1]}X^{T}\\db^{[1]}&=\frac{1}{m}np.sum(dZ^{[1]},\ axis=1,\ keepdims=True)\end{aligned}$$ |

  ​	其中，默认输出层采用sigmoid函数

# 10. 直观理解反向传播

​		示意图见[Week3-第1节](#1)

​		反向计算导数的过程见Week2-9.2小节及Week3-9节，仅需加上表示层数的上标即可。

# 11. 随机初始化

​		对于LR，将参数全部初始化为0即可，但对于神经网络，全部初始化为0会造成梯度下降完全无效。

<img src="Week 3 One hidden layer Neural Network.assets/1572249530925.png" alt="1572249530925" style="zoom:80%;" />

​		如图，若参数全部初始化为0，则有
$$
W^{[ 1]} =\begin{bmatrix}
0 & 0\\
0 & 0
\end{bmatrix} ,\ b^{[ 1]} =\begin{bmatrix}
0\\
0
\end{bmatrix}
$$
​		则正向传播时，$a_1^{[1]}=a_2^{[1]}$；反向传播时，$dz_1^{[1]}=dz_2^{[1]}$，即同一隐藏层的各节点完全相同（对称）。$dW$矩阵的各行相同，更新后仍然相同。

​		针对上述问题，可选择对参数$W$进行**随机初始化**；由于$b$没有对称性问题，因此初始化为$0$即可。即
$$
\begin{aligned}
W^{[1]}&=np.random.randn((2,2))*c\\
b^{[1]}&=np.zero((2,1))\\
W^{[2]}&=np.random.randn((2,2))*c\\
b^{[2]}&=np.zero((2,1))
\end{aligned}
$$
​		其中使用常数$c$（表示很小的值，如$0.01$）是因为：在激活函数中，要尽量使得参数$z=W^Tx+b$的绝对值尽可能地小，才能避免进入其平缓部分，从而避免导数过小、梯度下降过慢的问题。

