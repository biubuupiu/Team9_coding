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
