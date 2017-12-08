FROM alpine:3.7

RUN apk add --no-cache libstdc++
RUN apk add --no-cache --virtual .build-deps \
        binutils-gold \
        curl \
        g++ \
        gcc \
        gnupg \
        libgcc \
        linux-headers \
        make \
        python \
        git

ARG GIT_NODE_REPO=https://github.com/mmarchini/node
RUN test -n "$GIT_NODE_REPO"

ARG NODE_BRANCH=v8/toggle-perf-basic-prof
RUN test -n "$NODE_BRANCH"

RUN git clone --depth 1 $GIT_NODE_REPO -b $NODE_BRANCH /opt/node
WORKDIR /opt/node
RUN ./configure && make -j$(getconf _NPROCESSORS_ONLN) && make install
RUN apk del .build-deps
RUN rm -Rf /opt/node

ENTRYPOINT ["node"]
