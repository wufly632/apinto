# Alpine是非常轻量的linux发行版
FROM alpine:3.17

# 创建应用目录
WORKDIR /app

# 复制二进制压缩包，命名需和package.sh一致，Dockerfile构建时用对应架构名称
# 架构变量由workflow的builder拷贝对应文件确定，比如 apinto.linux.amd64.tar.gz
# 固定使用arm64架构

# 复制arm64架构的二进制包
COPY apinto.linux.arm64.tar.gz /app/

# 解压二进制文件
RUN tar -zxvf apinto.linux.arm64.tar.gz --strip-components=1 \
    && chmod +x /app/apinto

# 设置启动命令
CMD ["/app/apinto"]
