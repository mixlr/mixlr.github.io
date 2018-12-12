FROM ruby:2.3-alpine
MAINTAINER Mixlr Dev Team "developers@mixlr.com"

RUN apk upgrade --update \
  && apk add --virtual build-dependencies build-base \
  && gem install bundler --no-ri --no-rdoc \
  && rm -rf /var/lib/apt/lists/* \
    /var/cache/apk/* \
    /usr/share/man \
    /tmp/*

# Blog
ENV APP_ROOT=/var/www/blog
WORKDIR $APP_ROOT
COPY .ruby-version Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install --jobs $(nproc)

EXPOSE 4000
ENTRYPOINT ["bundle", "exec"]
CMD ["jekyll", "serve", "-H", "0.0.0.0"]
