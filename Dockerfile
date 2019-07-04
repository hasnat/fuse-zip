FROM alpine as builder
WORKDIR /usr/local/src/fuse
RUN apk --no-cache add g++ make pkgconfig libzip-dev fuse-dev
COPY . .
RUN make
FROM alpine

COPY --from=builder /usr/local/src/fuse/fuse-zip /usr/local/bin/fuse-zip
CMD fuse-zip