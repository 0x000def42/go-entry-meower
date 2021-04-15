FROM golang:alpine AS build  
RUN apk --no-cache add gcc g++ make ca-certificates  
WORKDIR /go/src/github.com/0x000def42/meower

COPY go.mod ./  
RUN go mod download
COPY util util  
COPY event event  
COPY db db  
COPY search search  
COPY schema schema  
COPY meow-service meow-service  
COPY query-service query-service  
COPY pusher-service pusher-service

RUN go install ./...

FROM alpine:3.7  
WORKDIR /usr/bin  
COPY --from=build /go/bin .  
