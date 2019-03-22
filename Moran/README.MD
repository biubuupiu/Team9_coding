## 实验二：莫兰指数计算
***
### 概念：

![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/3.png)
![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/4.png)


## 实验步骤
***

### 一、数据预处理
#### &nbsp; &nbsp; &nbsp;&nbsp;将seat.csv文件读入到变量data-origin-df中，然后通过R自带的函选出4月11日GPA>3的数据，然后将其转换为坐标的形式，代码如下图所示：
![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/1.png)

---
### 二、转换空间对象
#### &nbsp; &nbsp; &nbsp;&nbsp;将所形成的的坐标放入矩阵中，创建坐标对应的SpatialPoint对象，代码如下图：
![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/2.png)

---
### 三、进行邻居分析，得到邻接矩阵。
#### &nbsp; &nbsp; &nbsp;&nbsp;通过参考老师的代码，我们知道了如何得到邻接矩阵，即:nbk1 <- knn2nb(knearneigh(points_sp))用该函数找到邻居。通过网上查询，我们找到了另外一种找邻居的方法：通过“欧氏距离”来找邻居，用到的函数是： dnearneigh(points-sp, 0, all.linked)
#### 具体代码如下图：

![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/5.png)

---
### 四、画出邻接线
#### &nbsp; &nbsp; &nbsp;&nbsp;通过邻接矩阵，画出邻接线。
#### &nbsp; &nbsp; &nbsp;&nbsp;代码为：plot(col.nb.0.all, cbind(point_df$x , point_df$y))

#### &nbsp; &nbsp; &nbsp;&nbsp;结果如下图：

![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/6.png)
***
### 五、计算莫兰指数
#### &nbsp; &nbsp; &nbsp;&nbsp;通过成绩指数来检查空间自相关性
#### &nbsp; &nbsp; &nbsp;&nbsp;代码为：moran.test(data_deal02_day_df$gpa, nb2listw(snbk1))

#### &nbsp; &nbsp; &nbsp;&nbsp;结果如下图：

![](https://github.com/cuit201608/Team9_coding/blob/master/Moran/莫兰指数图片/7.png)
***
### 六、实验结论
#### &nbsp; &nbsp; &nbsp;&nbsp;由上图可知，莫兰指数为-0.09450012，是一个非常接近于0的负数，可得出结论：<font face="宋体" color=red>成绩相近的同学并不是趋向于坐在一起.</font>



