FROM node:12

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

# Copy over the entry point so we can modify the user
COPY usr/bin/entry-point /usr/bin/entry-point
RUN chmod +x /usr/bin/entry-point

# The directory to work from
WORKDIR /data

# The volume that can be mounted
VOLUME /data

# Install gosu
RUN set -eux; \
	apt-get update; \
	apt-get install -y gosu; \
	rm -rf /var/lib/apt/lists/*; \
    # verify that the binary works
	gosu nobody true

# Execute the entry point
ENTRYPOINT ["/usr/bin/entry-point"]

# The default command to execute
CMD ["node"]
