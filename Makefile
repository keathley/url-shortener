.PHONY: $(MAKECMDGOALS)

# `make setup` will be used after cloning or downloading to fulfill
# dependencies, and setup the the project in an initial state.
# This is where you might download rubygems, node_modules, packages,
# compile code, build container images, initialize a database,
# anything else that needs to happen before your server is started
# for the first time
setup:
	docker-compose build
	docker-compose run --rm --no-deps app mix deps.get
	docker-compose run --rm app mix ecto.setup

# `make server` will be used after `make setup` in order to start
# an http server process that listens on any unreserved port
#	of your choice (e.g. 8080).
server:
	docker-compose up app

# `make test` will be used after `make setup` in order to run
# your test suite.
test:
	docker-compose run --rm -e MIX_ENV=test -e DB_URL=postgres://postgres:postgres@postgres/url_shortener_test app mix test
