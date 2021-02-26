FROM alpine:3.12

RUN apk add --no-cache \
        bash \
        make \
        texlive \
        texmf-dist-latexextra

WORKDIR /usr/src

CMD ["make"]
