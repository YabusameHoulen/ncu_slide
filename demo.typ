#import "@preview/polylux:0.3.1": *
#import "@preview/cuti:0.2.1": fakebold
#import "themes/ncu.typ": *
// #show: show-cn-fakebold
#set text(font: ("Times New Roman", "寒蟬錦書宋"))

#show: ncu-theme.with(footer: [南昌大学 肖君宇], short-title: [GRB数据处理])
 
#title-slide(
  title: [GRB数据处理],
  subtitle: [贝叶斯方法],
  authors: ([肖君宇]),
  date: [2024年5月19日],
)


#slide(title: [#h(12em)简介])[
  基于MCMC的
][
  #lorem(20)
]

#new-section-slide("一点统计知识")

#slide(
  title: [贝叶斯定理],
)[
  #set text(22pt)
  $ P(theta|"data") = (P("data"|theta) dot P(theta))/P("data") $
  \
  #list(
    indent: 4em,
    [$P(theta)$ --- 先验概率],
    [$P("data")$ --- 证据(Evidence)],
    [$P(theta|"data")$ --- 后验概率],
  )
  \
  #h(3em)$P(theta|"data") prop P("data")dot P(theta)$
][
  #set text(22pt)
  MLE看作MAP特例 (形式上) :
  $ theta_"MAP" & = "arg"attach(max, b: theta) product_i P(x_i|theta) dot P(theta) \
              & = "arg"attach(max, b: theta) sum_i log P(x_i|theta) + log P(theta) \
              & = "arg"attach(max, b: theta) sum_i log P(x_i|theta) \
              & = theta_"MLE" $
]
 
#slide[
  计算上困难主要在于高维积分
   
  如果参数的维数比较少，可以直接使用格点近似、二项逼近...
   
  参数太多时，为了兼顾计算效率，使用MCMC等概率方法:
  #list(indent: 2em, [Metropolis-Hastings], [Nested Sampling], [......])
][
  对参数的贝叶斯估计 ：
  $ hat(theta) = (integral_theta theta pi(theta) p(x|theta)d theta)/(integral_theta pi(theta) p(x|theta)d theta) $
  对参数的函数有 @2020天文学中的概率统计 ：
  $ f(hat(theta)) = (integral_theta f(theta) pi(theta) p(x|theta)d theta)/(integral_theta pi(theta) p(x|theta)d theta) $
]
 
 
#new-section-slide("采样方法简介")

#slide(title: [Rejection Sampling])[
用容易采样的分布采样目标分布
 
#set text(22pt)
```py
    import test
    print("hello world !!!")
    while true:
        gulludsg
```
][
  #image(width: 85%, height: 50%, "graph/rejection_sampling.png") 
]

#slide(title: [Markov Chain])[
  假定存在单一的稳态分布,定义遍历的Markov链，可能状态的集合是样本空间，稳态分布是要采样的后验分布
  
  状态转移矩阵
   
  一致平稳 
   
  细致平衡 $ pi(i) P(i,j) = pi(j) P(j,i) $
   
]
 
 
#slide(title: [Markov Chain])[
  #set rect(inset: 1pt, fill: rgb("e4e5ea"), width: 100%)
  #grid(
    columns: (8cm, 8cm),
    rows: (auto, auto),
    gutter: 0.2pt,
    rect[#image("graph/MCMC_trap_in.png")],
    rect[#image(width: 100%,height: 65.8%,"graph/curse_of_dim.png")],
  )
][
  #align(center)[
    常遇到的问题 ：
     
    #enum(indent: 1em, [困在局部极值点], [采样结果不收敛], [结束条件不明确], [可能“维度诅咒”])
  ]
]


#slide(title: [Nested Sampling])[
  咕噜咕噜 @ashton_nested_2022
]
 
#slide(title: [Nested Sampling])[
  #text(20pt)[
    你说的对，但是Nested Sampling 是 Skilling 在2004年在贝叶斯框架下提出的采样方法

    采样发生在约束的高维先验下，在这里被选中的livepoints将被逐个内移引导先验估计
    
    你将需要非负的积分函数，在自由的_中邂逅性格各异、能力独特的_们，和它们一起击败。
    得到后验密度估计的同时，逐步计算Evidence的真值
    ]
][

]
 
#new-section-slide("简单例子")
 
 
#slide(title: [GRB220209A])[
  #lorem(20) 
][
  #lorem(10)
]
 
#slide()[
  #lorem(20) 
][
  #lorem(10)
][
  #lorem(20)
]
 
#slide()[
  #lorem(20) 
][
  #lorem(10)
][
  #lorem(20)
]
 
#slide(
  )[
  #bibliography(title: [#text(25pt)[参考书籍文献]], style: "gb-7714-2015-numeric", "ref.bib")
]
 
 
#end-slide(background_color: white)[
  感谢聆听!
   
  各位老师同学批评指正 
   
  #text(size: 6pt, fill: aqua)[#h(4em)回答不上来直接拉倒]
]