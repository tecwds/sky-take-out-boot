#!/usr/bin/env bash

# 1. 前置变量
# sky_take_out 默认路径
SKY_HOME=/~/docker/workspace/sky_take_out

if [ $# -ne 1 ]; then
  echo "用法：程序名称 [SKY_HOME路径]"
  echo "将使用默认参数: $SKY_HOME"
else
  SKY_HOME=$1
  # echo "SKY_HOME: $SKY_HOME"

fi

echo "SKY_HOME = $SKY_HOME"

echo "设置环境变量"
export SKY_HOME=$SKY_HOME

if [ -d "$SKY_HOME" ]; then
  echo "文件夹存在, 忽略"
else
  echo "创建文件夹"
  mkdir -p "$SKY_HOME"
fi

# 2. 复制文件
cp -ur ./mysql "$SKY_HOME"
cp -ur ./nginx "$SKY_HOME"
cp -ur ./redis "$SKY_HOME"

# 2.1 解压文件
unzip "$SKY_HOME"/nginx/html.zip
mv "$SKY_HOME"/nginx/html.zip /tmp

# 2.2 设置文件权限
chmod a+r "$SKY_HOME"/redis/conf/redis.conf

# 3. 检查
docker-compose config -q
docker-compose up -d
