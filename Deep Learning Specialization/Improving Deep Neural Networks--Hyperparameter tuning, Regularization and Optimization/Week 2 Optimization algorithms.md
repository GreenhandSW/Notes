# 1. Mini-batch 梯度下降法

在对整个训练集执行梯度下降法时，可以在处理完所有样本之前先让梯度下降处理一部分。

**Mini-batch**: $X^{\{t\}}$（$t$表示第$t$个mini-batch），则原样本集
$$
X=[x^{(1)}, x^{(2)}, \cdots, x^{(k)}, x^{(k+1)}, x^{(k+2)}, \cdots, x^{(2k)}, \cdots]
$$
可表示为
$$
X=[x^{\{1\}}, x^{\{2\}}, \cdots]
$$
伪代码：

> $$
> \begin{aligned}
> &for \ t=1,\cdots, n/k:\\
> &\ \ \ \ forward \ prop \ on \ X{t}\\
> &\ \ \ \ \ \ \ \ // 向量化实现\\
> &\ \ \ \ \ \ \ \ Z^{(t)}=W^{(t)}X^{(t)}+b^{(t)}\\
> &\ \ \ \ \ \ \ \ A^{[1]}=g^{(1)}(Z^{[1]})\\
> &\ \ \ \ \ \ \ \ \cdots\\
> &\ \ \ \ \ \ \ \ A^{[l]}=g^{(l)}(Z^{[l]})\\
> &\ \ \ \ Compute \ cost Z=\frac 1 k \sum_{i=1}^{l}\mathcal{L}(\hat y^{(i)}, y^{(i)})+\frac \lambda {2\times k} \sum^l_i \|w^{(i)}\|^2_2\\
> &\ \ \ \ Backprop \ to \ compute \ gradient \ w.r.t. \ J^{\{t\}}(Using \ only \ (X^{(t)}, Y^{(t)}))\\
> &\ \ \ \ W^{[l]}=W^{[l]}-\alpha dW^{[l]}
> \end{aligned}
> $$
>

minibatch梯度下降在数据量较大时比batch梯度下降运行更快。

# 2. 理解mini-batch 梯度下降法

<div align="center">
    <img src="Week 2 Optimization algorithms.assets/image-20200412004839666.png" alt="image-20200412004839666" style="zoom: 50%;" />
    <br>
    <b>batch与minibatch梯度下降的损失函数值的区别</b>
</div>

需要选定mini-batch的大小（$size=n$：batch梯度下降；$size=1$：随机梯度下降）

> 随机梯度下降永远不会收敛，只会在最小值附近波动

$size=n$：每次迭代耗时太长

$size=1$：没有向量化，效率低

训练集较小($n<2000$)，直接使用batch梯度下降法

否则，一般$size=64\to512=2^k$

# 3. 指数加权平均

（指数加权移动平均）
$$
v_t=\beta v_{t-1}+(1-\beta)\theta_t
$$
其中$v_0=0$，$v_t$大约是之前$\frac 1 {1-\beta}$个$\theta$的平均值。这是因为$\beta^{\frac 1 {1-\beta}}\approx \frac 1 e$，即$\theta_t$之前第$\frac 1 {1-\beta}$个数据对$\theta_t$的影响下降到$\frac 1 e$之下。

# 4. 理解指数加权平均

$$
v_t=(1-\beta)\theta_t +\beta(1-\beta)\theta_{t-1}+\beta^2(1-\beta)\theta_{t-2}+\cdots+\beta^{t-1}(1-\beta)\theta_1
$$

# 5. 指数加权平均的偏差修正

在每次计算指数加权平均值$v_t$后用下式进行修正：
$$
v_t=\frac {v_t} {1-\beta^t}
$$

一般较少使用该修正。

# 6. 动量梯度下降法

增大朝向极值点的移动幅度，减小垂直于该方向的震动幅度。

过程：

> $v_{dw}=\boldsymbol{0}$
>
> on iteration $t$:
>
> >compute $dw, db$ on current mini-batch
> >
> >$v_{dw}=\beta_1 v_{dw}+(1-\beta_1)dw$
> >
> >$v_{db}=\beta_1 v_{db}+(1-\beta_1)db$
> >
> >$W=W-\alpha v_{dw}$
> >
> >$b=b-\alpha v_{db}$

超参数：$\alpha, \beta_1$， 一般$\beta_1=0.9$。

也可以省略$(1-\beta_1)$项，即将$dw,db$扩大$\frac 1 {1-\beta_1}$倍。

# 7. RMSprop

(root mean squared propagation)

> on iteration $t$:
>
> >compute $dw, db$ on current mini-batch
> >
> >$S_{dw}=\beta_2 S_{dw}+(1-\beta_2)dw^2$
> >
> >$S_{db}=\beta_2 S_{db}+(1-\beta_2)db^2$
> >
> >$W=W-\alpha \frac {dw} {\sqrt{S_{dw}}}$
> >
> >$b=b-\alpha \frac {db} {\sqrt{S_{db}}}$

设$W$轴为朝向极值点的坐标轴，$b$轴为垂直于$W$轴的坐标轴（其中$W,b$皆为高维向量）。则由于数据在$b$方向波动幅度更大，因此$db>dw$，易得$S_{db}>S_{dw}$，则由上面最后两个公式可得$W$的更新幅度更大，而$b$的更新幅度较小，即增大$W$轴方向的运动幅度，减小$b$轴方向的振动幅度。

为避免除数为$0$，一般给$\sqrt{S_{dw}}$加上$\epsilon=10^{-8}$。

# 8. Adam优化算法

Adam: Adaptive Moment Estimation

> $v_{dw}=\boldsymbol{0}, S_{dw}=\boldsymbol{0}, v_{db}=\boldsymbol{0}, S_{db}=\boldsymbol{0}, $
>
> on iteration $t$:
>
> >compute $dw, db$ on current mini-batch
> >
> >// 动量梯度下降
> >
> >$v_{dw}=\beta_1 v_{dw}+(1-\beta_1)dw$
> >
> >$v_{db}=\beta_1 v_{db}+(1-\beta_1)db$
> >
> >// RMSprop
> >
> >$S_{dw}=\beta_2 S_{dw}+(1-\beta_2)dw^2$
> >
> >$S_{db}=\beta_2 S_{db}+(1-\beta_2)db^2$
> >
> >$V_{dw}^{corrected}=\frac{V_{dw}}{1-\beta_1^t}, V_{db}^{corrected}=\frac{V_{db}}{1-\beta_1^t}$
> >
> >$S_{dw}^{corrected}=\frac{S_{dw}}{1-\beta_2^t}, S_{dw}^{corrected}=\frac{S_{dw}}{1-\beta_2^t}$
> >
> >$W=W-\alpha \frac{V_{dw}^{corrected}}{\sqrt{S_{dw}^{corrected}}+\epsilon}$
> >
> >$b=b-\alpha \frac{V_{db}^{corrected}}{\sqrt{S_{db}^{corrected}}+\epsilon}$

|       超参数        | 一般取值（ |
| :-----------------: | :--------: |
|      $\alpha$       |  需要调参  |
| $\beta_1$（第一矩） |   $0.9$    |
| $\beta_2$（第二矩） |  $0.999$   |
|     $\epsilon$      | $10^{-8}$  |

# 9 学习率衰减

(Learning Rate Decay)

若不随着学习减小学习率，则可能使得算法最后在极小值附近波动，而无法达到极小值。

（一代表示对整个数据集进行一次遍历）

| 衰减方法 | 公式                                                       |
| -------- | ---------------------------------------------------------- |
|          | $\alpha=\frac {\alpha_0} {1+decay\_rate\times epoch\_num}$ |
| 指数衰减 | $\alpha=c^{epoch\_num}\alpha_0$                            |
|          | $\alpha=\frac k {\sqrt{epoch\_num}} \alpha_0$$             |
| 离散衰减 | $\alpha=\alpha/2$                                          |

# 10. 局部最优的问题

1. 由于在高维空间中，即使某一点的各方向导数为0，其各方向二阶导数的符号相同的概率也非常小，因此**一般很少出现局部最优解（即极值点）**，而更可能出现的是鞍点。

2. 平稳段的学习比较缓慢。

