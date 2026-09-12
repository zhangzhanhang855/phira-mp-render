# 构建阶段：固定使用 bookworm，确保产出的二进制与 Debian 12 兼容
FROM rust:1-bookworm as builder
WORKDIR /app
RUN git clone https://github.com/TeamFlos/phira-mp.git .
RUN cargo build --release

# 运行阶段：同样使用 bookworm-slim
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
WORKDIR /app

COPY --from=builder /app/target/release/phira-mp-server /app/phira-mp-server
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
