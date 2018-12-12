# mixlr.github.io
Mixlr's dev blog


## Build

To (re)build the Docker image for the blog:

`$ docker build -t mixlr/tech_blog:latest .`

## Run locally

To serve the blog locally at http://0.0.0.0:4000:

`$ docker run -p 4000:4000 -v ${PWD}:/var/www/blog --rm -it mixlr/tech_blog:latest`

## Testing

1) Launch a browser using selenium-chrome-standalone

```
$ docker run -d \
  --name selenium-chrome \
  --net bridge \
  -p 4444:4444 \
  -v /dev/shm:/dev/shm \
  selenium/standalone-chrome:latest
```

2) Run tests

```
$ docker run --rm \
  --link selenium-chrome:hub \
  --net bridge \
  -v /dev/shm:/dev/shm \
  -v $PWD:/var/www/blog \
  mixlr/tech_blog:latest rspec
```
