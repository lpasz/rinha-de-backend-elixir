FROM elixir:1.12-alpine as builder
ENV MIX_ENV=prod
COPY lib ./lib
COPY mix.exs .
COPY mix.lock .
RUN mix local.rebar --force \
    && mix local.hex --force \
    && mix deps.get \
    && mix release

FROM alpine:3
RUN apk add --no-cache --update bash openssl
WORKDIR /app
COPY --from=builder _build/prod/rel/elix/ .
CMD ["/app/bin/elix", "start"]
