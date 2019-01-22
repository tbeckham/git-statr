#######
#
# This image will contain severl git statistic gathering tools:
#  git-stats --------- https://github.com/IonicaBizau/git-stats
#  sloc -------------- https://www.npmjs.com/package/sloc
#  gitstats ---------- http://gitstats.sourceforge.net/
#  git-quick-stats --- https://github.com/arzzen/git-quick-stats
#

# Use official ubuntu as a parent image
FROM ubuntu:latest

LABEL description="git stats toolbox" \
version="0.1.0"

# # Set the working directory to /git-statr
# WORKDIR /git-statr
# VOLUME ["/git-statr"]

# Copy the current directory contents into the container at /awsms-builder
# COPY . /awsms-builder

# Install Build dependencies:
# build-essential
# curl
# git
# pip
# Python3
# node 11
# gitstats
# sudo
# apt-utils
# bsdmainutils
RUN apt-get update
RUN apt-get install -y sudo curl git python python3 python-pip python3-pip build-essential apt-utils bsdmainutils gitstats

## install git-quick-stats
#  https://github.com/arzzen/git-quick-stats
#
RUN git clone https://github.com/arzzen/git-quick-stats.git
WORKDIR /git-quick-stats
RUN sudo make install

## add node source and install
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN apt-get -y install nodejs

## pip it up
RUN hash -r pip
RUN yes | pip install --upgrade pip

## installing git-stats. Needs workaround for npm first
#  https://github.com/IonicaBizau/git-stats
#  https://github.com/Microsoft/WSL/issues/14#issuecomment-207504657
RUN npm config set unsafe-perm=true
RUN npm i -g git-stats

## install sloc
#  https://www.npmjs.com/package/sloc
#
RUN sudo npm install -g sloc

# # lastly pip install what is found in requirements.txt
# # RUN pip install --trusted-host pypi.python.org -r requirements.txt
