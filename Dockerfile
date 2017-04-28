FROM daocloud.io/library/ubuntu:16.04

# RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/docker/apt/repo ubuntu-xenial main" | tee /etc/apt/sources.list.d/docker.list
ADD sources.list /etc/apt/

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial main restricted universe multiverse"> /etc/apt/sources.list
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-updates main restricted universe multiverse">> /etc/apt/sources.list 
RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list

#RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial main restricted universe multiverse"> /etc/apt/sources.list
#RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted universe multiverse">> /etc/apt/sources.list 
#RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted universe multiverse" >> /etc/apt/sources.list

RUN apt-get update


RUN apt-get update && apt-get install -y curl apt-transport-https && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  ruby \
  ruby-dev \
  tzdata \
  yarn \
  zlib1g-dev \
  libssl-dev \
  libreadline-dev \
  libyaml-dev \
  libffi-dev


WORKDIR /circle

RUN gem install bundler
ADD Gemfile /circle/Gemfile
ADD Gemfile.lock /circle/Gemfile.lock
RUN bundle config --global silence_root_warning 1
RUN bundle install
ADD . /circle