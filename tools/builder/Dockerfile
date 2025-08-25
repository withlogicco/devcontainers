FROM base

ENV DEBIAN_FRONTEND=noninteractive

COPY --chmod=0755 apt.sh /usr/local/bin

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=bind,source=Aptfile,target=Aptfile \
    apt.sh

COPY --chmod=0755 vendor-dependencies.sh /usr/local/bin