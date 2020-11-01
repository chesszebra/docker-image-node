FROM node:15-alpine

# Configure the system
RUN apk add --no-cache \
    bash \
    gcc \
    git \
    g++ \
    make \
    shadow \
    ruby \
    openssh-client \
    python \
    py-pip \
    python3 \
 && python3 -m ensurepip

# Install gosu
ENV GOSU_VERSION 1.11
RUN set -eux; \
	\
	apk add --no-cache --virtual .gosu-deps \
		dpkg \
		gnupg \
	; \
	\
	dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')"; \
	wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch"; \
	wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$dpkgArch.asc"; \
	\
# verify the signature
	export GNUPGHOME="$(mktemp -d)"; \
# for flaky keyservers, consider https://github.com/tianon/pgp-happy-eyeballs, ala https://github.com/docker-library/php/pull/666
	gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4; \
	gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu; \
	command -v gpgconf && gpgconf --kill all || :; \
	rm -rf "$GNUPGHOME" /usr/local/bin/gosu.asc; \
	\
# clean up fetch dependencies
	apk del --no-network .gosu-deps; \
	\
	chmod +x /usr/local/bin/gosu; \
# verify that the binary works
	gosu --version; \
	gosu nobody true

# Add the entry point
ADD usr/local/bin/docker-image-entrypoint.sh /usr/local/bin/docker-image-entrypoint

# Add Bower to the image
RUN npm install -g bower

# The directory to work from
WORKDIR /data

# The volume that can be mounted
VOLUME /data

# Run all commands via the entry point
ENTRYPOINT ["/usr/local/bin/docker-image-entrypoint"]

# The default command to run
CMD ["node"]
