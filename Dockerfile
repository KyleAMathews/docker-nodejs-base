FROM ubuntu:14.04
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.5
ENV NODEJS_VERSION 0.10.35

# Install dependencies for building Ruby / Node.js modules.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y python-software-properties software-properties-common \
    python python-setuptools git build-essential zlib1g-dev \
    libssl-dev libreadline6-dev libyaml-dev curl unzip autoconf && \
  add-apt-repository ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get install -y nodejs=$NODEJS_VERSION-1chl1~trusty1 && \
  apt-get purge -y --auto-remove python-software-properties software-properties-common && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN mkdir /usr/src/ruby \
  && curl -SL "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.bz2" \
    | tar -xjC /usr/src/ruby --strip-components=1 \
  && cd /usr/src/ruby \
  && cd /usr/src/ruby \
  && autoconf \
  && ./configure --disable-install-doc \
  && make -j"$(nproc)" \
  && make install \
  && rm -r /usr/src/ruby

# Install Bundler
RUN gem install --no-rdoc --no-ri bundler
