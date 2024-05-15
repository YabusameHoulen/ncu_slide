#import "@preview/polylux:0.3.1": *
#import "themes/ncu.typ": *


#show: ncu-theme.with(footer: [南昌大学 肖君宇 ], short-title: [GRB数据处理])
 
#title-slide(
  title: [GRB数据处理],
  subtitle: [贝叶斯方法],
  authors: ([肖君宇]),
  date: [2024年5月19日],
)

#slide(title: [First slide title])[
  #lorem(20)
]

#new-section-slide("新章节")

#slide(title: [Slide with multiple columns])[
  #lorem(20)
][
  #lorem(10)
][
  #lorem(30)
]

#end-slide(background_color:aqua)[
  _感谢聆听!_

  请各位老师同学批评指教 

  #text(size: 7pt,fill: yellow)[#h(4em)回答不上来直接拉倒(]
]