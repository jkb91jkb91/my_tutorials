FROM python:3.12-alpine

RUN apk add --no-cache curl \
  && pip install requests
  
WORKDIR /app

COPY entrypoint.py .
COPY targets.conf .

RUN chmod 0755 entrypoint.py
RUN chmod 0644 targets.conf
ENTRYPOINT ["python", "-u", "entrypoint.py"]

