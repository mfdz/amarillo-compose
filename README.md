# amarillo-compose
Docker compose files for [Amarillo](https://github.com/mfdz/amarillo), [Amarillo-enhancer](https://github.com/mfdz/amarillo-enhancer) and [GTFS generator](https://github.com/mfdz/amarillo-gtfs-generator/) for quickly deploying an Amarillo instance.

# Quick start

To get Amarillo running quickly:

```bash
git clone https://github.com/mfdz/amarillo-compose.git
cd amarillo-compose
cp .env.example .env    # you should adjust .env configuration as needed
mkdir data && cp -r ./sampledata/* data     # copies sample data with 1 agency and 1 repeating trip
sudo docker compose --profile enhancer --profile generator up # starts amarillo, amarillo-enhancer and amarillo-gtfs-generator 
 ```

# Basic setup

Configure the `ADMIN_TOKEN`, `METRICS_USER` and `METRICS_PASSWORD`  environment variables in the shell or a `.env` file:

```bash
ADMIN_TOKEN="<secret_here>"
METRICS_USER="<username here>"
METRICS_PASSWORD="<password_here>"
```
`METRICS_USER` and `METRICS_PASSWORD` define the credentials to access the /metrics endpoint. 

To use [Mitanand GRFS generation](https://github.com/mitanand/grfs), change the generator image:
```bash
AMARILLO_GENERATOR_IMAGE="git.gerhardt.io/amarillo/amarillo-grfs-generator"
```


For launching Amarillo

```bash
docker compose --profile enhancer --profile generator up
```

This will launch Amarillo together with a local enhancer and gtfs-generator service with the container images published to the [GI package registry](https://git.gerhardt.io/amarillo/-/packages).

# External services

You can override the images used with the `AMARILLO_ENHANCER_IMAGE` and `AMARILLO_GENERATOR_IMAGE`.

In case you want to use an external service for the enhancer and/or generator, you should omit the corresponding `--profile` argument and configure `AMARILLO_ENHANCER_URL` / `AMARILLO_GENERATOR_URL`.
