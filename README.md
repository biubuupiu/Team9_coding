# 第一次实验
# 1、样方分析法
## 1、数据说明
  根据老师给的“seat.csv”文件的综合分析，我们选取了“4月11日”这一天的数据，并且将gpa的值设定为3，筛选之后得到数据为：58 21 10 16  3  4  7  9  5 31 39 67 62 35 71 60 24 11 55.
## 2、样方分析原理
![](https://github.com/cuit201608/Team9_coding/blob/master/files/%E6%A0%B7%E6%96%B9%E5%88%86%E6%9E%90%E5%8E%9F%E7%90%86.JPG)
## 3、实验过程
### 1、数据预处理
```R
#将csv文件读入mydata表
mydataAll<-read.csv(file = "G:/seat.csv", header = T)

#选取mydataAll中gpa.all属性大于3的数据，组成新表mydata
mydata<-subset(mydataAll,gpa.all>3)

#选取mydata中第四列数据
n4<-mydata$X4月11日

#删掉数据中的无效值
nu5 <- as.vector(na.omit(n4))

#将座位号转化为坐标
xc = nu5%%9+1  
yc = nu5%/%9+1+1
datac = cbind(xc,yc) 
```
### 2、选取样方及计算
```R
quadrat <- c(1,2,3,0,2,1,3,4,3)#样方值
mean <- mean(quadrat)#平均值
variance <-var(quadrat)#方差
VMR<- variance/mean #VMR

result=""

if(VMR>1.5){
  result = "聚集分布"
}else if(VMR<0.5){
  result = "均匀分布"
}else{
  result = "随机分布"
}
```
### 3、画出图像
```R
plot(datac,main=result,xaxt="n",yaxt="n")
axis(1,at=seq(1,9,1))
axis(2,at=seq(1,9,1))
grid(nx=3,ny=3,lwd=1,lty=2,col="blue")
```
## 4、结论
根据我们计算得出`VMR=0.7631579`，由样方分析原理得知属于`随机分布`，并画出随机分布图。
![](https://github.com/cuit201608/Team9_coding/blob/master/files/%E9%9A%8F%E6%9C%BA%E5%88%86%E5%B8%83%E5%9B%BE.JPG)

## 2. 核密度分析法
--- 
   - **数据说明**
      - 此次数据来源于老师提供的`seat.csv`文件，这是一个包含了不同成绩的学生每天的座位序号的一个文本文件。
      - 为了表现成绩好的学生的作为规律，我们提取出`GPA > 3.0`的行，作为此次分析的数据
   - **核密度分析原理**
      - 通过计算以这个点为中心，一定距离为半径（一般取**带宽**）的范围内事件点的数量，作为该点的密度
      - 具体的计算公式如图：
      !['KDE_theory'](https://github.com/cuit201608/Team9_coding/blob/master/files/KDE_theory.jpg)
   - **实验过程**
      - 数据预处理
         - 这一步的目的是：提取出`GPA > 3.0`的学生并去除4月4日那天没有座位号的记录
         - 具体代码如下：
         ```
          # 读入数据
          data_origin_df <- read.csv("seat.csv")
          # 提取某一天的座位和GPA
          data_day_df <- data.frame(cbind(data_origin_df$gpa.all, data_origin_df$X4月4日))
          names(data_day_df) <- c('gpa', 'position')
          # 提取GPA > 3.0 的数据
          data_deal01_day_df <- subset(data_day_df, data_day_df$gpa > 3.0)
          # 删除座位号为空的那一行的数据
          data_deal02_day_df <- na.omit(data_deal01_day_df, cols="position")
          ```
      - 生成坐标矩阵并创建空间点
         - 目的：将座位号转换成在15 * 5的网格中的坐标，并以此构建空间点
         - 具体代码如下：
         ```
          # 座位号转换成坐标
          data_deal02_day_df$x <- data_deal02_day_df$position %% 15 
          data_deal02_day_df$y <- data_deal02_day_df$position %/% 15 + 1 
          ```
         ```
          #将座位号坐标放到矩阵中
          point_sp[ , 1] <- data_deal02_day_df$x
          point_sp[ , 2] <- data_deal02_day_df$y
          names(point_sp)
          colnames(point_sp) <- c("x", "y")
          point_sp
          # 创建坐标对应的SpatialPoints对象
          points_sp <- SpatialPoints(coords = point_sp, proj4string = CRS("+proj=longlat +datum=WGS84"))
         ```

      - 创建空间网格和核密度的计算区域：
         - 这一步创建原点在左下角，15:5比例的网格以及左下角为`(0,0)`，右上角为`(15, 5)`的核密度计算区域
         - ```
           grid_topo <- GridTopology(cellcentre.offset = cell_offset, cellsize = cell_size, cells.dim = cell_dim)
           ```
           ```
           polygon_kernel <- as.points(c(0,15,15,0),c(5,5,0,0))
           ```
      - 计算核密度
          - 这一步使用spkernel2d()函数计算核密度，其中参数指定要*计算的空间点、计算范围、带宽数值、网格区域*
          - 具体代码如下：
             ```
             # 计算核密度
             kernel_density <- spkernel2d(pts = points_sp, poly = polygon_kernel, h0 = 1, grd = grid_topo)
             ```
      - 创建空间网格数据框对象，并进行绘制
          - 这一步将之前创建的**网格拓扑对象**与**计算出的核密度**一起构建空间网格数据框对象，并使用sp包中的增强绘图函数spplot()进行绘制
          - 关键代码如下：
            ```
            # 创建空间网格 grid_spdf <- SpatialGridDataFrame(grid = grid_topo, data = kd_df)
            ``` 
            ```
            # 绘图 spplot(grid_spdf)
            ```
          - 最终结果：!['核密度图'](https://github.com/cuit201608/Team9_coding/blob/master/files/KDE_result.jpg)
   - **结果分析：**
       - 从图中可以看出：大部分成绩好的学生喜欢坐在教室的中前方，小部分喜欢坐在教室的后排
   - **声明**
       - `15 * 5网格`的原点在左下角，`X轴`和`Y轴`正方向分别朝右和朝上


