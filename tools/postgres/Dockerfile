FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update &&\
	apt-get install -y --no-install-recommends \
		 flex bison libreadline-dev zlib1g-dev libssl-dev libicu-dev \
		 libxml2-dev libxslt1-dev uuid-dev libzstd-dev

ARG PG_MAJOR=17
ARG PG_VERSION=17.4

WORKDIR /tmp

# Fetch and extract PostgreSQL source
RUN curl -fsSL -o postgresql.tar.gz https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.gz \
	&& tar -xzf postgresql.tar.gz \
	&& rm postgresql.tar.gz

WORKDIR /tmp/postgresql-${PG_VERSION}

# Ensure installed binaries prefer ../lib at runtime (self-contained without env vars)
# Note: escape $ for Dockerfile so linker sees $ORIGIN.
ENV LDFLAGS="-Wl,-rpath,'\$$ORIGIN/../lib'"

# Configure to install under $TOOLS_DIR and enable useful client features
RUN ./configure \
	--prefix=$TOOLS_DIR \
	  --with-openssl \
	  --with-icu \
	  --with-libxml \
	  --with-libxslt \
	  --without-ldap

# Build and install only libpq and client binaries (psql, pg_dump, etc.)
RUN make -C src/interfaces/libpq all && make -C src/interfaces/libpq install
RUN make -C src/bin all && make -C src/bin install

RUN vendor-dependencies.sh

FROM base

COPY --from=build $TOOLS_DIR $TOOLS_DIR
