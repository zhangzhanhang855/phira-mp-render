FROM rust:1-bookworm as builder
WORKDIR /app
RUN git clone https://github.com/TeamFlos/phira-mp.git .
RUN cargo build --release

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates websockify && rm -rf /var/lib/apt/lists/*
WORKDIR /app

COPY --from=builder /app/target/release/phira-mp-server /app/phira-mp-server
COPY run.sh /app/run.sh
RUN chmod +x /app/run.sh

CMD ["/app/run.sh"]
