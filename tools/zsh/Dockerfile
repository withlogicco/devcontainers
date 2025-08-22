FROM builder AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
    apt-get install -y --no-install-recommends \
    git libncurses-dev libpcre2-dev libssl-dev &&\
    rm -rf /var/lib/apt/lists/*

ARG ZSH_VERSION=5.9

WORKDIR /tmp

# Fetch and build zsh from source
RUN curl -fsSL -o zsh.tar.xz https://sourceforge.net/projects/zsh/files/zsh/${ZSH_VERSION}/zsh-${ZSH_VERSION}.tar.xz/download \
  && tar -xJf zsh.tar.xz \
  && rm zsh.tar.xz

WORKDIR /tmp/zsh-${ZSH_VERSION}

# Configure to install into $TOOLS_DIR
RUN ./Util/preconfig \
  && ./configure --prefix=$TOOLS_DIR --enable-multibyte --with-tcsetpgrp \
  && make -j"$(nproc)" \
  && make install

# Install Oh My Zsh to $TOOLS_DIR/share/oh-my-zsh
RUN git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git $TOOLS_DIR/share/oh-my-zsh \
  && cp $TOOLS_DIR/share/oh-my-zsh/templates/zshrc.zsh-template $TOOLS_DIR/share/oh-my-zsh/.zshrc

# Vendor non-glibc shared libraries into $TOOLS_DIR/lib
RUN vendor-dependencies.sh

FROM base

COPY --from=build $TOOLS_DIR $TOOLS_DIR

CMD ["$TOOLS_DIR/bin/zsh"]
