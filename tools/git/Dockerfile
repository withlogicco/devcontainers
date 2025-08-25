FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=bind,source=Aptfile,target=Aptfile \
    apt.sh

ENV TOOL_NAME=git
ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}
RUN mkdir -p ${TOOL_DIR}

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

# Configure and build Git, install into $TOOL_DIR
RUN make configure \
  && ./configure --prefix=$TOOL_DIR --with-openssl --with-curl \
  && make -j"$(nproc)" all \
  && make install

RUN vendor-dependencies.sh $TOOL_DIR

# Provide PATH fallbacks for remote helpers if exec-path isn't set downstream
RUN set -eux; \
  core=$TOOL_DIR/libexec/git-core; \
  for h in git-remote-https git-remote-http; do \
    if [ -x "$core/$h" ] && [ ! -e "$TOOL_DIR/bin/$h" ]; then \
      ln -s "$core/$h" "$TOOL_DIR/bin/$h"; \
    fi; \
  done


FROM base

ENV TOOL_NAME=git
ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}
RUN mkdir -p ${TOOL_DIR}
COPY --from=build $TOOL_DIR $TOOL_DIR
