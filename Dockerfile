FROM ruby:2.6.3-alpine

RUN apk update && apk add nodejs \
    libxml2 libxml2-dev libxml2-utils \
    libxslt libxslt-dev zlib-dev zlib \
    libffi-dev build-base \
    make gcc g++ tzdata mysql-dev git\
    --no-cache bash

RUN mkdir /myapp

WORKDIR /myapp

COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . .

