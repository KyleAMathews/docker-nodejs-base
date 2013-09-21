FROM ubuntu:latest
MAINTAINER Kyle Mathews "mathews.kyle@gmail.com"

# Install node.js
RUN apt-get install -y python-software-properties software-properties-common python python-setuptools ruby rubygems git
RUN add-apt-repository ppa:chris-lea/node.js
RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y nodejs

# Install various node.js globals needed.
RUN npm install -g coffee-script brunch

# Install compass and other SCSS related gems
RUN gem install compass --pre
RUN gem install susy compass-normalize sassy-buttons
