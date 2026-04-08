FROM golang:1.26 AS builder
WORKDIR /build
COPY ./ /build
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build

FROM debian:13-slim
COPY --from=builder /build/s3bucket_exporter /bin/s3bucket_exporter
RUN apt-get update && apt-get install -y curl
WORKDIR /tmp
ENTRYPOINT ["/bin/s3bucket_exporter"]
