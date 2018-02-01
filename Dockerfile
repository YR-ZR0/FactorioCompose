FROM frolvlad/alpine-glibc:alpine-3.7

ENV PORT=34197 \
    RCON_PORT=27015

ARG VERSION

VOLUME /factorio

    RUN mkdir -p /opt && \
        apk add --update --no-cache pwgen && \
        apk add --update --no-cache --virtual .build-deps curl && \
        curl -sSL https://www.factorio.com/get-download/$VERSION/headless/linux64 \
            -o /tmp/factorio_headless_x64_$VERSION.tar.xz && \
        tar xf /tmp/factorio_headless_x64_$VERSION.tar.xz --directory /opt && \
        chmod ugo=rwx /opt/factorio && \
        rm /tmp/factorio_headless_x64_$VERSION.tar.xz && \
        ln -s /factorio/saves /opt/factorio/saves && \
        ln -s /factorio/mods /opt/factorio/mods && \
        apk del .build-deps

EXPOSE $PORT/udp $RCON_PORT/tcp

COPY ./docker-entrypoint.sh /
HEALTHCHECK --interval=5m --timeout=10s \
  CMD nc -zu 127.0.0.1 34197
ENTRYPOINT ["/docker-entrypoint.sh"]
