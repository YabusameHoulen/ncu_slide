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
  #lorem(20)
][
  #lorem(20)
]

#new-section-slide("一点统计知识")

#slide(
  title: [贝叶斯定理],
)[
  $ P(theta|"data") = (P("data"|theta) dot P(theta))/P("data") $
  #list(
    indent: 1.5em,
    [$P(theta)$ --- 先验概率],
    [$P("data")$ --- 证据(Evidence)],
    [$P(theta|"data")$ --- 后验概率],
  )
  \
  #h(2em)$P(theta|"data") prop P("data")dot P(theta)$
][
  MLE看作MAP特例 (形式上) :
  $ theta_"MAP" & = d \
              & = "arg"attach(max, b: theta) sum_i log P(x_i|theta) +log P(theta) arrow \
              & = g$
]
 
#slide[
  计算上困难主要在于高维积分
   
  如果参数的维数比较少，可以直接使用格点近似、二项逼近...
   
  参数太多时，为了兼顾计算效率，使用MCMC等概率方法:
  #list(indent: 2em, [Metropolis-Hastings], [Nested Sampling...])
][
  对参数的贝叶斯估计 ：
  $ theta.alt = (integral_theta theta pi(theta) p(x|theta)d theta)/(integral_theta pi(theta) p(x|theta)d theta) $
  对参数的函数有 @2020天文学中的概率统计 ：
  $ f(theta.alt) = (integral_theta f(theta) pi(theta) p(x|theta)d theta)/(integral_theta pi(theta) p(x|theta)d theta) $
]
 
 
#new-section-slide("采样方法简介")

#slide(title: [Rejection Sampling])[
  使用容易采样的分布采样目标分布
   
  东方
][
  #image(width: 85%, height: 50%, "graph/rejection_sampling.png") 
]

#slide(title: [Markov Chain])[
  定义遍历马尔可夫链（假定存在单一的稳态分布），其中可能状态的集合是样本空间，稳态分布是要采样的后验分布
   
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
    rect[#image("graph/curse_of_dim.png")],
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
  #text(18pt)[你说的对，但是Nested Sampling 是 Skill 在2004年]
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