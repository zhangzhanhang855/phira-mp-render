#!/bin/sh
PORT="${PORT:-10000}"
exec /app/phira-mp-server --port "$PORT"
