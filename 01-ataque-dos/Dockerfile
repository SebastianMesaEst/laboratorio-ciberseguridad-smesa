
FROM alpine:latest

RUN apk add --no-cache curl python3

WORKDIR /app

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 10000

CMD ["./entrypoint.sh"]
