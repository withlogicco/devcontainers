FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
	apt-get update &&\
	apt-get install -y --no-install-recommends ca-certificates

ARG TOOLS_ROOT=/opt/tools
ENV TOOLS_ROOT=${TOOLS_ROOT}

ENV DEBIAN_FRONTEND=''

WORKDIR ${TOOLS_ROOT}
CMD ["bash"]