FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    apt-get update &&\
    apt-get install -y --no-install-recommends \
    libz-dev zlib1g-dev libssl-dev \
    libcurl4-openssl-dev libexpat1-dev libpcre2-dev \
    gettext rsync perl xz-utils

WORKDIR /tmp

# Fetch and extract Git source
ARG GIT_VERSION=2.51.0
RUN curl -fsSL -o git.tar.xz https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.xz \
  && tar -xJf git.tar.xz \
  && rm git.tar.xz

WORKDIR /tmp/git-${GIT_VERSION}

# Ensure installed binaries prefer ../lib at runtime (self-contained without env vars)
# Include both one- and two-level ups to cover bin and libexec/git-core
# Note: escape $ for Dockerfile so linker sees $ORIGIN.
ENV LDFLAGS="-Wl,-rpath,'\$$ORIGIN/../lib:\$$ORIGIN/../../lib'"

# Configure and build Git, install into $TOOLS_DIR
RUN make configure \
  && ./configure --prefix=$TOOLS_DIR --with-openssl --with-curl \
  && make -j"$(nproc)" all \
  && make install

RUN vendor-dependencies.sh

# Provide PATH fallbacks for remote helpers if exec-path isn't set downstream
RUN set -eux; \
  core=$TOOLS_DIR/libexec/git-core; \
  for h in git-remote-https git-remote-http; do \
    if [ -x "$core/$h" ] && [ ! -e "$TOOLS_DIR/bin/$h" ]; then \
      ln -s "$core/$h" "$TOOLS_DIR/bin/$h"; \
    fi; \
  done

# Wrap git to set GIT_EXEC_PATH relative to the binary when not provided
RUN mv $TOOLS_DIR/bin/git $TOOLS_DIR/bin/git.original
COPY wrapper/git $TOOLS_DIR/bin/git
RUN chmod +x $TOOLS_DIR/bin/git


FROM base

COPY --from=build $TOOLS_DIR $TOOLS_DIR
