# 1. 训练/开发/测试集

​		最佳决策取决于拥有的数据量。

​		应用深度学习是典型的迭代过程。

​		搭建训练集、验证集、测试集能够加速神经网络，更有效地衡量算法的偏差和方差

​		流程：对训练集执行训练算法，接着通过验证集（简单交叉验证集）选择最好的模型，最后在测试集上评估。

<img src="Week 1 Practical aspects of Deep Learning.assets/1572969763340.png" alt="1572969763340" style="zoom:80%;" />

​		数据较少时的划分：$70\%$训练集，$30\%$测试集；或$60\%$训练集，$20\%$验证集，$20\%$测试集。数据较多时，测试集和验证集的占比很小。测试集是为了对最终所选定的模型做出无偏估计，若不需要该无偏估计，也可省略测试集。

​		要确保训练集、验证集、测试集的数据来自同一分布。

# 2. 偏差、方差

假设训练集、验证集来自同一分布：

- 训练集误差显著低于验证集，说明方差较高，出现过拟合。

- 训练集与测试集误差相近且较高，说明偏差较高，出现欠拟合。
- 训练集误差显著低于验证集，且二者都很高，说明方差、偏差都很高，出现过拟合和欠拟合（即对部分正确样本欠拟合，而对部分错误样本过拟合）

- 但误差的下界为最优误差（贝叶斯误差）。

# 3. 机器学习基础

```flow
st=>start: 开始
hb=>condition: 偏差太大？
bn=>operation: 更大的网络，更长的训练时间；更合适的框架
hv=>condition: 方差太大？
md=>operation: 更多数据；正则化；更合适的框架
e=>end: 结束
st->hb
hb(yes)->bn
hb(no)->hv
hv(yes)->md
hv(no)->e
```

现在，可减少偏差（或方差）而不明显影响方差（偏差）。

# 4. 正则化

## 逻辑回归

​		求解的问题：$\min_{w,b}J(w,b)$

### $L1$正则化

$$
\displaystyle J(w,b)=\frac{1}{m}\sum_{i=1}^{m}\mathcal{L}(\hat{y}^{(i)}, y)+\frac{\lambda}{2m}\left\|w\right\|_1
$$

其中，$\left\|w\right\|_1=\sum_{j=1}^{n_x}\left|w_j\right|=w^Tw$，$\lambda$为正则化参数，通常使用验证集或交叉验证来配置$\lambda$。

​		$L1$正则化更易得到稀疏解（即$w$向量中有很多0）。

### $L2$正则化

$$
\displaystyle J(w,b)=\frac{1}{m}\sum_{i=1}^{m}\mathcal{L}(\hat{y}^{(i)}, y)+\frac{\lambda}{2m}\left\|w\right\|^2_2
$$

其中，$\left\|w\right\|_2^2=\sum_{j=1}^{n_x}w_j^2=w^Tw$。

​		因为$w$是高维参数矢量，足够表达高偏差问题，$w$几乎涵盖所有参数，而$b$只是单个数字，故一般正则化不加$b$。

​		**优点**：$L2$正则化训练时间较长，会使得超参数搜索空间更容易分解和搜索，

​		**缺点**：需要试验很多$\lambda$的值，导致计算代价较高。

## 神经网络

​		求解的问题：
$$
\min_{w^{[l]}, b^{[l]}} J(w^{[1]}, b^{[1]}, \cdots, w^{[L]}, b^{[L]}) 
$$


### Frobenius范数（$L2$范数）

$$
J(w^{[1]}, b^{[1]}, \cdots, w^{[L]}, b^{[L]})=\frac{1}{m}\sum_{i=1}^{m}\mathcal{L}(\hat{y}^{(i)}, y)+\frac{\lambda}{2m}\left\|W^{[l]}\right\|^2_F
$$

其中，$\left\|W^{[l]}\right\|_F^2=\sum_i^{n^{[l]}} \sum_j^{n^{[l-1]}} w_{ij}^2$，$W$的维度为$(n^{[l]}, n^{[l-1]})$。

​		**正则化后的反向传播过程**：
$$
dW^{[l]}=\frac{\partial J}{\partial W^{[l]}}+\frac{\lambda}{m}W^{[l]}\\
W^{[l]}=(1-\alpha \frac{\lambda}{m})W^{[l]}-\alpha dW^{[l]}
$$
​		由于$(1-\alpha \frac{\lambda}{m})<1 $，因此$L2$正则化也被称为**权重衰减**。

# 5. 为什么正则化可以减少过拟合？

​		若$\lambda$足够大，则导致$W^{[l]}\approx 0$，即把许多隐层单元的权重设置为$w\approx 0$，使得隐层的有效单元减少（原因见下），网络减小到等同于一个$LR$单元，可以使过拟合转变为欠拟合。在过拟合和欠拟合之间存在合适的$\lambda$值达到正好拟合的状态。

<img src="Week 1 Practical aspects of Deep Learning.assets/1573096813620.png" alt="1573096813620" style="zoom:80%;" />

​		以$g(z)=\tanh(z)$为例，当$z$很小时，$g(z)$接近于线性函数。

<img src="Week 1 Practical aspects of Deep Learning.assets/tanh.png" alt="1573096813620" style="zoom:50%;" />

​		由于$\lambda$足够大会导致$w^{[l]}\approx 0$，则根据$z^{[l]}=w^{[l]}a^{[l-1]}+b^{[l]}$也会有$z^{[l]}\approx 0$。又根据“当$z$很小时，$g(z)$接近于线性函数”得到，此时该单元近似于线性单元，则只能计算线性函数，成为“无效单元”。

# 6. Dropout正则化

## dropout

​		**dropout**（随机失活）：即以一定概率随机删除隐层的各个节点及其连接（即使得该节点激活函数$a=g(x)=0$），则达到正则化的效果。

<div align="center">
    <img src="Week 1 Practical aspects of Deep Learning.assets/1573113510496.png" alt="1573113510496" style="zoom:80%;" />
    <br>
    <b>初始网络</b>
</div>

<div align="center">
<div align="center">
    <img src="Week 1 Practical aspects of Deep Learning.assets/1573122991330.png" alt="1573122991330" style="zoom:80%;" />
    <br>
    <b>dropout后的网络（失活概率为0.5）</b>
</div>

​		dropout之后再进行反向传播。

## 实现dropout

​		对第$l$层进行dropout：

```python
dl = np.random.rand(al.shape[0], al.shape[1]) < keep_prob
al = np.multiply(al, dl)
```

其中`keep_prob`表示保留某个隐藏单元的概率。

**inverted dropout**（反向dropout）：通过给al除以keep_prob以确保al的期望值不变。

```python
al /= keep_prob
```



# 7. 理解Dropout

​		不同层的`keep_prob`可以不同，可根据各层过拟合的可能性来设置。

​		**缺点**：成本函数$J$的定义不再明确。

# 8. 其他正则化方法

## 数据增强（Data augmentation）

​		例如对图片进行翻转、裁剪等

## 早停法

​		由于训练集误差单调减小，而验证集误差先减后增，因此在验证集误差达到最小时即停止迭代。此时迭代次数较少，仍然有$w\approx 0$，达到正则化效果。

​		**缺点**：过早停止训练，且使得下述的深度学习的两个任务不再**正交化**（为了避免过拟合而停止优化$J$。

​		深度学习的两个任务：

- 选择算法（如**SGD**）来优化成本函数$J$。
- 避免过拟合：正则化、数据增强等。

上述两个任务应该分开执行，即**正交化**。

# 9. 归一化输入

​		归一化能够使得成本函数各方向更对称、$x$各个分量的取值范围相似，使得**SGD**能够使用更大的步长，以更快达到（局部）最小值。

​		原始输入：

<img src="Week 1 Practical aspects of Deep Learning.assets/1573134422865.png" alt="1573134422865" style="zoom:60%;" />

​		归一化输入的步骤：

1. **$0$均值化**：移动训练集，使其均值为$0$：

$$
\displaystyle
\begin{aligned}
\mu&=\frac{1}{m}\sum_{i=1}{m}x^{(i)}\\
x&=x-\mu
\end{aligned}
$$

<img src="Week 1 Practical aspects of Deep Learning.assets/1573134698623.png" alt="1573134698623" style="zoom:60%;" />

2. **归一化方差**：使各分量方向的方差都为$1$：

$$
\displaystyle
\begin{aligned}
\sigma^2&=\frac{1}{m}\sum_{i=1}^m (x^{(i)})^2\\
x/&=\sigma^2
\end{aligned}
$$

<img src="Week 1 Practical aspects of Deep Learning.assets/1573135463379.png" alt="1573135463379" style="zoom: 60%;" />

注意训练集的归一化参数$\mu$和$\sigma$要与测试集相同。

# 10. 梯度消失与梯度爆炸

​		设$g(z)=z,b^{[l]}=0$，则
$$
\begin{aligned}
\hat{y}&=a^{[L]}=g(z^{[L]})=z^{[L]}=W^{[L]}a^{[L-1]}=\cdots \\
&=W^{[L]}W^{[L-1]}\cdots W^{[1]}x
\end{aligned}
$$
​		设权重矩阵$W^{[l]}=\begin{bmatrix} 1.5 & 0\\0 & 1.5 \end{bmatrix}, l=1,2,\cdots,L$，则易得$\hat{y}=\begin{bmatrix} 1.5^{L} & 0\\0 & 1.5^{L} \end{bmatrix}x$，激活函数爆炸式增长。

​		设权重矩阵$W^{[l]}=\begin{bmatrix} 0.5 & 0\\0 & 0.5 \end{bmatrix}, l=1,2,\cdots,L$，则易得$\hat{y}=\begin{bmatrix} 0.5^{L} & 0\\0 & 0.5^{L} \end{bmatrix}x$，激活函数急剧减小。

> [梯度消失参考文章]( https://blog.csdn.net/fishmemory/article/details/53885691 )

# 11. 神经网络的权重初始化

​		忽略偏置$b$，则$z=w_1x_1+w_2x_2+\cdots+w_nx_n$，显然为避免梯度爆炸或消失，输入的$x$维度越大，则$w_i$应当越小。可在初始化时，令$Var(w_i)=\frac{1}{n}$。代码如下：

```python
WL=np.random.randn(n, n_prev)*np.sqrt(1/n_prev)
```

| 激活函数 | 初始化权重时的方差$Var(w_i)$（也是超参数）                   |
| -------- | ------------------------------------------------------------ |
| ReLU​     | $\frac{2}{n_{prev}}$                                         |
| $\tanh$  | $\frac{1}{n_{prev}}$(Xavier initialization)<br />或$\frac{1}{n_{prev}+n}$ |

# 12. 梯度的数值逼近

<div align="center">
    <img src="Week 1 Practical aspects of Deep Learning.assets/1573879505858.png" alt="1573879505858" style="zoom:80%;" />
</div>

​		执行梯度检验时，为更加准确，使用双边误差，即$f^{'}(\theta)=\frac{f(\theta+\epsilon)-f(\theta-\epsilon)}{2\epsilon}$

# 13. 梯度检验

​		将$W^{[1]}, b^{[1]},\cdots,W^{[L]}, b^{[L]}$合并成为一个向量$\theta$，即$J(W^{[1]}, b^{[1]},\cdots,W^{[L]}, b^{[L]})=J(\theta)$。

​		将$dW^{[1]}, db^{[1]},\cdots,dW^{[L]}, db^{[L]}$合并成为一个向量$d\theta$。

梯度检验(Grad Check)
$$
\begin{aligned}
d\theta_{approx}[i]&=\frac{J(\theta_1, \theta_2,\cdots,\theta_{i-1}, \theta_{i}+\epsilon,\cdots)-J(\theta_1, \theta_2,\cdots,\theta_{i-1}, \theta_{i}-\epsilon,\cdots)}{2\epsilon}\\
&\approx d\theta[i]=\frac{\partial J}{\partial \theta_i}
\end{aligned}
$$
​		检查$d\theta_{approx}$的误差，即计算：
$$
\frac{\left\|d\theta_{approx}-d\theta\right\|_2}{\left\|d_{approx}\right\|_2+\left\|d\theta\right\|_2}
$$
如，若该式$<\epsilon$，则梯度逼近很正确，若显著$>\epsilon$，则需要检查该向量$\theta$的所有项

# 14. 关于梯度检验实现的标记

- 梯度检验仅用于调试
- 若$d\theta_{approx}$与$d\theta$的差距较大，则检查所有的$d\theta_{approx}[i]$。

- 若有正则化，不要忘记对正则项的导数
- 有dropout时无法实现梯度检验，因为神经元会被随机删除，无法计算代价函数。若要实现梯度检验，需要先关闭dropout。

