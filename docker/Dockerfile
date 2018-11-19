FROM ubuntu:16.04 AS firstrubyproject
RUN apt-get update && apt-get install -y sqlite3 libsqlite3-dev openssl libssl-dev libyaml-dev libreadline-dev \
  libxml2-dev libxslt1-dev sudo vim mc curl patch bzip2 gawk g++ gcc make patch autoconf libgdbm-dev libncurses5-dev \
  automake libtool bison pkg-config libffi-dev libgmp-dev imagemagick postgresql-server-dev-9.5 openssh-client \
  net-tools nodejs git locales libmagickwand-dev imagemagick libmagickcore-dev libmagickwand-dev libmagick++-dev \
  webp libwebp-dev redis-server \
  qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x \
  wget phantomjs
RUN useradd -ms /bin/bash hosting &&  echo hosting:passwordhosting | chpasswd –crypt-method=SHA512  && adduser hosting sudo
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN bzip2 -d phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN tar -xvf phantomjs-2.1.1-linux-x86_64.tar
RUN cp phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
USER hosting
WORKDIR /home/hosting
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /home/hosting/workspace
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash
RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
RUN echo "export PATH=\"$PATH:$HOME/.rvm/bin\"" >> .bashrc
RUN  $HOME/.rvm/bin/rvm install 2.2.3 --autolibs=read-only
ENV PATH  = "$HOME/.rvm/bin:$HOME/.rvm/rubies/ruby-2.2.3:${PATH}"
RUN  /bin/bash -l -c "rvm use --default 2.2.3"
RUN  /bin/bash -l -c "rvm use 2.2.3 && gem install bundler"


