FROM ubuntu:14.04
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

# Install dependencies for building Ruby / Node.js modules.
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y python-software-properties software-properties-common \
    python python-setuptools git build-essential zlib1g-dev \
    libssl-dev libreadline6-dev libyaml-dev curl unzip && \
  add-apt-repository ppa:chris-lea/node.js && \
  apt-get update && \
  apt-get install -y nodejs=0.10.32-1chl1~trusty1 && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Install Ruby
RUN mkdir /tmp/ruby;\
  cd /tmp/ruby;\
  curl http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p481.tar.gz | tar xz;\
  cd ruby-2.0.0-p481;\
  chmod +x configure;\
  ./configure --disable-install-rdoc;\
  make;\
  make install

# Install Bundler
RUN gem install --no-rdoc --no-ri bundler
