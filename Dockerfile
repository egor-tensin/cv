FROM alpine:3.23

RUN apk add -q --no-cache \
        bash \
        make \
        texlive-full

COPY [".", "/usr/src/"]

WORKDIR /usr/src

CMD ["make"]
