# 构建阶段
FROM rust:latest as builder
WORKDIR /app
RUN git clone https://github.com/TeamFlos/phira-mp.git .
RUN cargo build --release

# 运行阶段
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app

# 注意这里：可执行文件名实际是 phira-mp-server
COPY --from=builder /app/target/release/phira-mp-server /app/phira-mp-server
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
