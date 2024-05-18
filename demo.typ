#import "@preview/polylux:0.3.1": *
#import "@preview/cuti:0.2.1": fakeitalic
#import "themes/ncu.typ": *
// #show: show-cn-fakebold
#set text(font: ("Times New Roman", "寒蟬錦書宋"))

#show: ncu-theme.with(footer: [南昌大学 肖君宇], short-title: [GRB数据处理])
 
#title-slide(title: [GRB数据处理], subtitle: [#text(20pt)[
    An #text(red)[*Oversimplified*] Introduction to Bayesian Methods
  ]], authors: ([肖君宇]), date: [2024年5月19日])


#slide(title: [#h(12em)简介])[
  基于MCMC的贝叶斯数据分析方法，几乎被应用在所有科学学科来分析和解释数据。
   
  虽然贝叶斯推理的一系列方法很早就被人提出，但贝叶斯式的计算冗长困难。在20世纪80年代出现MCMC方法之后才被广泛使用。
][
  #set rect(inset: 0pt, fill: rgb("e4e5ea"))
  #grid(
    columns: (auto, auto),
    rows: (auto, auto),
    gutter: 0.2pt,
    rect[#image(height: 80%, "graph/bayes_self_figure.png")],
    rect[#image(height: 80%, "graph/laplace_self_figure.jpg")],
  ) 
]

#slide(
  )[
  #place(top + center, [#image(width: 82%, "graph/bayesian_workflow.png")])
   
][
  频率学派中的“不确定性”依赖于想象的数据抽样的前提。参数和模型都是确定的，没有概率分布，多次重复测量的结果才体现概率分布 \
  \
  贝叶斯方法将随机性视为信息的特质，可能更加符合我们主观上感知的世界运转模式 @van_de_schoot_bayesian_2021
]



#new-section-slide("一点统计知识")

#slide(
  title: [贝叶斯定理],
)[
  #set text(22pt)
  $ P(theta|"data") = (P("data"|theta) dot P(theta))/P("data") $
  \
  #set text(20pt)
  #list(
    indent: 4em,
    [$P(theta)$ --- 先验概率],
    [$P("data"|theta)$ --- 似然 (likelihood)],
    [$P("data")$ --- 证据 (Evidence)],
    [$P(theta|"data")$ --- 后验概率],
  )
  #h(4em)$P(theta|"data") prop P("data"|theta)dot P(theta)$
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
   
  #only(1)[
    #enum(
      indent: 2em,
      [用放缩过的易采样分布$G$(Gaussian)包住目标分布],
      [对G采样得到样本 $x_0$ ,计算$x_0$处目标分布 $t = T(x_0)$],
    )
  ]
   
  #only(2)[
    #enum(
      indent: 2em,
      [用放缩过的易采样分布$G$(Gaussian)包住目标分布],
      [对G采样得到样本 $x_0$ ,计算$x_0$处目标分布 $t = T(x_0)$],
      [对均匀分布[0,$G(x_0)$]取样 g],
      [若 $t >= g$ 则输出 $x_0$],
    )
  ]
   
][
  \
  #image(width: 85%, height: 50%, "graph/rejection_sampling.png") 
  #h(1em) 对重尾分布采样效果$times$@bishop2006pattern
]
 
#slide(title: [Markov Chain])[
  假定存在单一的后验稳态分布\
  和满足遍历性的Markov链......
   
  满足遍历性 (Ergodicity) 时Markov Chain 会收敛到唯一的目标分布
   
  *细致平衡 (detail balance)* $ S(i) T(j|i) = S(j) T(i|j) $
   
][
  #align(center + top, image(width: 50%, "graph/MC_State.png"))
  $ T = mat(p_11, p_12;p_21, p_22) $
  #align(center)[状态转移矩阵 $T(i,j)$]
]


#slide(
  title: [Metropolis-Hastings],
)[
  #set text(23pt)
  $
    S(i) G(j|i) alpha(j|i) = S(j) G(i|j) alpha(i|j)
  $
  #only(1)[其中 $alpha(dot, dot)：$ 对G提案是否接受的修正 ]
   
  (类似转移矩阵) 取分布 $G$ (Gaussian)， 设定采样的初始状态 $x_0$
   
  #only(
    2,
  )[
    从条件分布 $G(x|x_t)， (t = 0,1,2...$) 中采样 $x^star$, 从Uniform [0,1] 中采样 u
     
    $u <= min((p(x^star)cancel(G(x_t|x^star)))/(p(x_t)cancel(G(x^star|x_t))), 1) = alpha (x^star|x_t)$ 则前进到 $x^star$,否则停在原来位置 $x_t$
  ]
   
][
  #align(center + top)[#image(height: 70%, "graph/MH_example.png")MH采样示例]
   
]


#slide(title: [Markov Chain])[
  #set rect(inset: 1pt, fill: rgb("e4e5ea"), width: 100%)
  #grid(
    columns: (8cm, 8cm),
    rows: (auto, auto),
    gutter: 0.2pt,
    rect[#image("graph/MCMC_trap_in.png")],
    rect[#image(width: 100%, height: 65.8%, "graph/curse_of_dim.png")],
  )
][
  #align(center)[
    常遇到的问题 ：
     
    #enum(indent: 1em, [困在局部极值点], [采样结果不收敛], [结束条件不明确], [可能“维度诅咒”])
  ]
]
 
 
#slide(
  )[
  *Nested Sampling*\
  #set text(19pt)
  可以解决Markov Chain的上述问题@ashton_nested_2022 
  $
    integral_theta limits(P("data"|theta))^L(theta) limits(P(theta))^pi(theta) d theta = lim_(|Delta theta arrow 0 |) sum L(theta) pi(theta) Delta theta
  $
  体积元对先验概率加权, $Z = L(X)Delta X$
  #image("graph/nested_sample_graph.png")
][
  #align(center, image("graph/Nested_Sampling.png"))
]
 
#slide()[
  #set text(18.7pt)
  你说的对，但是Nested Sampling 是 Skilling 于2004年在贝叶斯框架下提出的采样方法
   
  采样发生在约束的高维先验下，在这里一定数量的livepoints将被逐渐 “内移” 来引导计算
   
  你将需要非负的似然函数，在分层抽样中计算各个点的似然值，按值的大小去除最小的点
   
  在对后验分布采样的同时，估计体积元大小(e.g. $(X_(i-1)+X_i)/2$)，逐步累计得到估计的Evidence
  $ "Evidence" = sum_i^n_"iter" (X_(i)+X_(i-1))/2 L^star_i $
][
  #align(center, image("graph/Rad_NS.png"))
   
]
 
#new-section-slide("例：GRB谱拟合")
 
 
#slide()[
  #only((1, 2))[
    #text(green, "G")#text(red, "R")#text(blue, "B")
    是自"大爆炸"以来能量最高的一类电磁脉冲的现象，一般认为源于大质量恒星坍缩或致密天体并和
     
    #list(indent: 2em, [恒星的尺度，宇宙起源], [未观测到银河系内GRB], [大概每天观测到一两个])
    e.g. GRB190611B的部分拟合结果
  ]
  #only(3)[
    #set text(20pt)
    #align(top + center)[
      #image(height: 60%, "graph/ncu_plot/nihe.png")
      #image(width: 55%, height: 30%, "graph/ncu_plot/traceplot.png")
    ]
  ]
][
  #only(2)[为什么对GRB谱拟合 $arrow$
     
    老师：
    - 获取极端条件下宝贵物理信息
    - 能谱成分有助于理解发射机制 
    - 
     
    我：根据探测光子数据做统计:p...]
]
 
#slide()[
  除了文献中常见的检查BIC/DIC/WAIC等信息准则
][
  
]
 
#slide(
  )[
  #set text(22pt)
  #bibliography(title: [参考书籍文献], style: "gb-7714-2015-numeric", "ref.bib")
]
 
 
#end-slide(background_color: aqua)[
  #let ferris = image(width: 45%, height: 47%, "graph/Ferris.png")
  #place(
    top + left,
    dx: 27% - ferris .at("width", default: 12cm) / 2,
    dy: 24.7%,
    [ #h(1.5em)
      #text(blue, 45pt)[感谢您的倾听]
      #ferris ],
  )
]
