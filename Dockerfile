FROM alpine:3.7

# RUN addgroup -g 1000 node \
#     && adduser -u 1000 -G node -s /bin/sh -D node \
#     &&

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

ARG GIT_NODE_REPO
RUN test -n "$GIT_NODE_REPO"

ARG NODE_BRANCH
RUN test -n "$NODE_BRANCH"

RUN git clone --depth 1 ${GIT_NODE_REPO} -b ${NODE_BRANCH} /opt/node
WORKDIR /opt/node
RUN git checkout v8/toggle-perf-basic-prof
RUN ./configure && make -j$(getconf _NPROCESSORS_ONLN) && make install
RUN apk del .build-deps
RUN rm -Rf /opt/node

ENTRYPOINT ["node"]
