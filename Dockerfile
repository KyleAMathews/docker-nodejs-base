FROM ubuntu
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list

# Install dependencies for building Ruby / Node.js modules.
RUN apt-get install -y python-software-properties software-properties-common python python-setuptools git build-essential build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev curl

# Install node.js
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get -y update
RUN apt-get install -y nodejs

# Node 
#RUN npm config set strict-ssl false

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

# Cleanup
RUN apt-get clean
