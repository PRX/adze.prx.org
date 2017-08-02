# Adze.prx.org

## Description

[Phoenix app](http://www.phoenixframework.org) providing an API to ad handling for PRX. This project follows the [standards for PRX services](https://github.com/PRX/meta.prx.org/wiki/Project-Standards#services).

## Installation

### Local

To get started, make sure you have completed the [Phoenix install guide](http://www.phoenixframework.org/docs/installation).  Then:
```
# Get the code
git clone git@github.com:PRX/porter.prx.org.git

# Install dependencies
mix deps.get

# Configure your environment (you'll _probably_ need postgres and AWS credentials)
cp env-example .env
vi .env

# Start the phoenix server
mix phoenix.server

# Or run interactively
iex -S mix phoenix.server

# Or just get a console
iex -S mix

# Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
```

### Docker

Currently on OSX, [Dinghy](https://github.com/codekitchen/dinghy) is probably
the best way to set up your dev environment.  Using VirtualBox is recommended.
Also be sure to install `docker-compose` along with the toolbox.

This project is setup primarily to build a `MIX_ENV=prod` docker image. To avoid
recompiling dependencies every time you run a non-prod docker-compose command,
mount some local directories to mask the build/deps directories in the image.

```
docker-compose build

# mount dev dependencies locally
mkdir _build_docker_compose deps_docker_compose
docker-compose run adze compile

# now you can run a local server
docker-compose up
open http://adze.prx.docker

# or run the tests
docker-compose run adze test

# or run a single test
docker-compose run adze test test/controllers/api/root_controller_test.exs
```

## Dependencies

TODO: maybe feeder to get shows?

## Usage

TODO: localhost:4000

## License

[AGPL License](https://www.gnu.org/licenses/agpl-3.0.html)

## Contributing

Completing a Contributor License Agreement (CLA) is required for PRs to be accepted.
