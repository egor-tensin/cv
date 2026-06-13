FROM alpine:3.24

RUN apk add -q --no-cache \
        bash \
        make \
        texlive-full

COPY [".", "/usr/src/"]

WORKDIR /usr/src

CMD ["make"]
