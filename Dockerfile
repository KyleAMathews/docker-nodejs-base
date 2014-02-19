FROM ubuntu
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get -y update

# Install node.js
RUN apt-get install -y python-software-properties software-properties-common python python-setuptools git build-essential build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev curl
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get -y update
RUN apt-get install -y nodejs

# Install various node.js globals needed.
RUN npm config set strict-ssl false
RUN npm install -g coffee-script brunch bower

# Install Ruby
RUN mkdir /tmp/ruby;\
  cd /tmp/ruby;\
  curl http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.gz | tar xz;\
  cd ruby-2.0.0-p353;\
  chmod +x configure;\
  ./configure --disable-install-rdoc;\
  make;\
  make install

# Install compass and other SCSS related gems
RUN gem install --no-rdoc --no-ri compass --pre
RUN gem install --no-rdoc --no-ri susy compass-normalize sassy-buttons

# Cleanup
RUN apt-get clean
