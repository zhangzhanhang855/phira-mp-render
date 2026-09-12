#!/bin/sh
PORT="${PORT:-10000}"

# 1. 启动 phira 服务端监听本地 127.0.0.1:12346
/app/phira-mp-server --port 12346 &

# 2. 启动 websockify，对外暴露 Render 分配的 $PORT，并将流量转给本地 12346
exec websockify 0.0.0.0:"$PORT" 127.0.0.1:12346
