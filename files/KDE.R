# 读入数据
data_origin_df <- read.csv("seat.csv")
# 提取某一天的座位和GPA
data_day_df <- data.frame(cbind(data_origin_df$gpa.all, data_origin_df$X4月4日))
names(data_day_df) <- c('gpa', 'position')
# 提取GPA > 3.0 的数据
data_deal01_day_df <- subset(data_day_df, data_day_df$gpa > 3.0)
# 删除座位号为空的那一行的数据
data_deal02_day_df <- na.omit(data_deal01_day_df, cols="position")
# 座位号转换成坐标
data_deal02_day_df$x <- data_deal02_day_df$position %% 15 
data_deal02_day_df$y <- data_deal02_day_df$position %/% 15 + 1
# 导入一些包
library(sp)
library(splancs) # 提供点模式分析的一些方法
# 查看导入的包
search()
# 生成一个coords matrix
point_sp <- matrix(NA, nrow = length(data_deal02_day_df$x), ncol = 2)
class(point_sp)
#将座位号坐标放到矩阵中
point_sp[ , 1] <- data_deal02_day_df$x
point_sp[ , 2] <- data_deal02_day_df$y
names(point_sp)
colnames(point_sp) <- c("x", "y")
point_sp
# 创建坐标对应的SpatialPoints对象
points_sp <- SpatialPoints(coords = point_sp, proj4string = CRS("+proj=longlat +datum=WGS84"))
summary(points_sp)
# 创建空间网格
coord_max <- c(15, 5)
cell_offset <- c(0,0)
cell_size <- c(0.1, 0.1)
cell_dim <- (coord_max - cell_offset) / cell_size
grid_topo <- GridTopology(cellcentre.offset = cell_offset, cellsize = cell_size, cells.dim = cell_dim)
# 创建核密度的范围
polygon_kernel <- as.points(c(0,15,15,0),
                            c(5,5,0,0))
class(polygon_kernel)
# 计算核密度
kernel_density <- spkernel2d(pts = points_sp, poly = polygon_kernel, h0 = 1, grd = grid_topo)
# 创建空间网格
kd_df <- data.frame(KD = kernel_density)
grid_spdf <- SpatialGridDataFrame(grid = grid_topo, data = kd_df)
# 绘图
spplot(grid_spdf)
