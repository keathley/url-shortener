FROM elixir:1.11.2-alpine AS dev

# install build dependencies
RUN apk add --no-cache \
  chromium \
  chromium-chromedriver \
  bash \
  build-base \
  npm \
  git \
  postgresql-client \
  inotify-tools

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=dev

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

CMD ["mix", "phx.server"]

