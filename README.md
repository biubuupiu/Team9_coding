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
