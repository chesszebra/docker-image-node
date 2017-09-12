FROM debian:latest

RUN apt-get update \
 && apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    dirmngr \
    gcc \
    git \
    gnupg \
    make \
    patch \
    ruby \
    ruby-dev \
    python3 \
    wget \
    xz-utils

# Install SASS
RUN gem install sass --no-user-install

# Install NodeJS && NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get install -y nodejs

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install -y yarn

# Copy over the entry point so we can modify the user
COPY usr/bin/entry-point /usr/bin/entry-point
RUN chmod +x /usr/bin/entry-point

# Add a user which we will run the container with
RUN groupadd --gid 1000 node \
 && useradd --uid 1000 --gid node --shell /bin/bash --create-home node \
 && echo '{ "allow_root": true }' > /home/node/.bowerrc

# The directory to work from
WORKDIR /data

# The volume that can be mounted
VOLUME /data

# Install gosu
ENV GOSU_VERSION 1.10
RUN set -ex; \
	rm -rf /var/lib/apt/lists/*; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
	gpg --keyserver pgp.mit.edu --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 || \
    gpg --keyserver keyserver.pgp.com --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 ; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu nobody true;

ENTRYPOINT ["/usr/bin/entry-point"]
