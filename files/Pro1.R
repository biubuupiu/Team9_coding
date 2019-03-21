library(ggplot2)
library(sp)

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

#画出图像
plot(datac,main=result,xaxt="n",yaxt="n")
axis(1,at=seq(1,9,1))
axis(2,at=seq(1,9,1))
grid(nx=3,ny=3,lwd=1,lty=2,col="blue")

VMR








