# mixlr.github.io
Mixlr's dev blog


## Build

To (re)build the Docker image for the blog:

`$ docker build -t mixlr/tech_blog:latest .`

## Run locally

To serve the blog locally at http://0.0.0.0:4000:

`$ docker run -p 4000:4000 -v ${PWD}:/var/www/blog --rm -it mixlr/tech_blog:latest`
