FROM alpine:3.23

RUN apk add -q --no-cache \
        bash \
        make \
        texlive-full

WORKDIR /usr/src

CMD ["make"]
