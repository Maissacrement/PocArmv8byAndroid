FROM ubuntu

WORKDIR /app
COPY . .

RUN ls
ENTRYPOINT ["echo" "Hello world"] 