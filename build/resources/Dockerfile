# Alpine是非常轻量的linux发行版
FROM alpine:3.17

# 创建应用目录
WORKDIR /app

# 复制二进制压缩包，命名需和package.sh一致，Dockerfile构建时用对应架构名称
# 架构变量由workflow的builder拷贝对应文件确定，比如 apinto.linux.amd64.tar.gz
ARG ARCH=amd64

# 这里固定内容，workflow中替换文件名即可
COPY apinto.linux.${ARCH}.tar.gz /app/

# 解压二进制文件
RUN tar -zxvf apinto.linux.${ARCH}.tar.gz \
    && chmod +x /app/apinto

# 设置启动命令
CMD ["/app/apinto"]
