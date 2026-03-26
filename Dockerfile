FROM alpine:3.18

RUN apk add -q --no-cache \
        bash \
        make \
        texlive-full

WORKDIR /usr/src

CMD ["make"]
