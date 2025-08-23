FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
   apt-get update &&\
    apt-get install -y --no-install-recommends \
    git libncurses-dev libpcre2-dev libssl-dev

ENV TOOL_NAME=zsh
ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}
RUN mkdir -p ${TOOL_DIR}

ARG ZSH_VERSION=5.9

WORKDIR /tmp

# Fetch and build zsh from source
RUN curl -fsSL -o zsh.tar.xz https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz/download \
  && tar -xJf zsh.tar.xz \
  && rm zsh.tar.xz

WORKDIR /tmp/zsh-${ZSH_VERSION}

# Configure to install into $TOOL_DIR
RUN ./Util/preconfig \
  && ./configure --prefix=${TOOL_DIR} --enable-multibyte --with-tcsetpgrp \
  && make -j"$(nproc)" \
  && make install

# Install Oh My Zsh to $TOOL_DIR/share/oh-my-zsh
RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git ${TOOL_DIR}/share/oh-my-zsh \
  && cp ${TOOL_DIR}/share/oh-my-zsh/templates/zshrc.zsh-template ${TOOL_DIR}/share/oh-my-zsh/.zshrc

# Vendor non-glibc shared libraries into $TOOL_DIR/lib
RUN vendor-dependencies.sh ${TOOL_DIR}

FROM base

COPY --from=build ${TOOLS_ROOT} ${TOOLS_ROOT}
