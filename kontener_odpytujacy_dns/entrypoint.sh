#!/usr/bin/env sh
set -eu

: "${SERVICE:=http-probe}"
: "${CONFIG_FILE:=/etc/probe/targets.conf}"
: "${INTERVAL_SECONDS:=10}"
: "${TIMEOUT_SECONDS:=5}"

now_ms() { date +%s%3N; }

emit_emf() {
  ts="$1"; name="$2"; ok="$3"; latency_ms="$4"; code="$5"
  # Jedna linia JSON (CloudWatch EMF-friendly)
  printf '
{
  "_aws": {
    "Timestamp": %s,
    "CloudWatchMetrics": [{
      "Namespace": "Probes",
      "Dimensions": [["service","target"]],
      "Metrics": [
        {"Name":"availability_ok","Unit":"Count"},
        {"Name":"latency_ms","Unit":"Milliseconds"}
      ]
    }]
  },
  "service": "%s",
  "target": "%s",
  "availability_ok": %d,
  "latency_ms": %d,
  "http_code": %d
}
' "$ts" "$SERVICE" "$name" "$ok" "$latency_ms" "$code" | tr -d '\n'
  echo
}

check_one() {
  name="$1"
  url="$name"
  echo "$name" | grep -qE '^https?://' || url="https://$name"

  out="$(curl -o /dev/null -s -w '%{http_code} %{time_total}' --max-time "$TIMEOUT_SECONDS" "$url" || echo "000 0")"
  code="$(echo "$out" | awk '{print $1}')"
  time_s="$(echo "$out" | awk '{print $2}')"

  latency_ms="$(awk -v t="$time_s" 'BEGIN { printf("%d", t*1000 + 0.5) }')"

  ok=0
  [ "$code" -ge 200 ] && [ "$code" -lt 400 ] && ok=1

  ts="$(now_ms)"
  emit_emf "$ts" "$name" "$ok" "$latency_ms" "$code"
}

main_loop() {
  while :; do
    if [ -f "$CONFIG_FILE" ]; then
      while IFS= read -r line; do
        target="$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
        [ -z "$target" ] && continue
        echo "$target" | grep -qE '^#' && continue

        check_one "$target"
      done < "$CONFIG_FILE"
    else
      echo "Config file not found: $CONFIG_FILE" >&2
    fi

    sleep "$INTERVAL_SECONDS"
  done
}

main_loop

