## 基于NIO的网络通讯系统后台
### 一、项目环境
1. 项目使用java作为主要开发语言，使用版本为 java 8。项目中使用了java 8中Lambda表达式、流以及LocalDateTime等
2. 项目分为前后端及数据库，使用nginx作为图片服务器
3. 项目为多环境开发，需在yml中指定启动开发环境或是部署环境
4. 项目使用git分支提交，提交后合并到master分支，禁止master提交
5. git分支命名格式为 feature/XXX
6. 项目启动时，除mysql外，需额外启动 Redis 及 Nginx，其中redis做为缓存及存储，nginx作为图片服务器，也可部署前端项目并作为后端反向代理

### 二、项目结构
1. nio_im: 根目录
2. nio_core: nio核心模块，使用nio框架Netty,主要定义了通讯协议及通讯功能实现
3. nio_server: 系统服务启动模块，使用springboot+MyBatis-plus+mysql+redis+swagger

### 三、项目部署
1. 项目使用springboot开发，可以使用maven将项目打包为jar包然后上传至服务器，通过  java -jar XXX.jar 的方式运行
2. 也可以将项目部署到docker环境中,详情请见根目录下 --- 如何将本项目部署到docker.pdf（请提前安装docker）