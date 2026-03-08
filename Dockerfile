FROM node:20-alpine
LABEL maintainer="OpenClaw Community"
LABEL version="1.0.0"
LABEL description="OIAFlow - 目标驱动AI Agent协同工作流框架"
# 安装依赖
RUN apk add --no-cache git curl
# 创建工作目录
WORKDIR /app
# 复制技能文件
COPY . .
# 安装OpenClaw SDK
RUN npm install @openclaw/sdk --production
# 环境变量
ENV NODE_ENV=production
ENV OPENCLAW_CONFIG_PATH=/app/config
# 暴露端口
EXPOSE 18789
# 挂载配置目录
VOLUME ["/app/config"]
# 启动命令
CMD ["node", "src/index.js"]