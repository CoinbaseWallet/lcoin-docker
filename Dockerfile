FROM node:8-alpine AS base

RUN mkdir /code
WORKDIR /code
CMD "lcoin"

ENV LCOIN_VERSION=${LCOIN_VERSION} \
    LCOIN_REPO=https://github.com/petejkim/lcoin.git

RUN apk upgrade --no-cache && \
    apk add --no-cache bash git

RUN git clone $LCOIN_REPO /code && \
    git checkout $LCOIN_VERSION

FROM base AS build

# Install build dependencies
RUN apk add --no-cache g++ gcc make python2
RUN npm install --production

# Copy built files, but don't include build deps
FROM base
ENV PATH="${PATH}:/code/bin:/code/node_modules/.bin"
COPY --from=build /code /code/

# Main-net and Test-net
EXPOSE 8334 8333 8332 18334 18333 18332
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "lcoin-cli info >/dev/null" ]
