FROM golang:1.16-alpine as builder

RUN apk add --no-cache libpcap-dev libc-dev gcc linux-headers
ADD . /app
WORKDIR /app
RUN go build -ldflags "-w -s" -o /sx

FROM alpine:3.13

RUN apk add libpcap
COPY --from=builder /sx /sx

ENTRYPOINT ["/sx"]