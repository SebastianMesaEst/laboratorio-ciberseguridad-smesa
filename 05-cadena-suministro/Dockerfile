
FROM alpine:latest

RUN apk add --no-cache python3

WORKDIR /app

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

EXPOSE 10000

CMD ["sh", "./entrypoint.sh"]
