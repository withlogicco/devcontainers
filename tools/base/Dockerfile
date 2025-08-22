FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
	apt-get update &&\
	apt-get install -y --no-install-recommends ca-certificates

ARG TOOLS_DIR=/opt/tools
ENV TOOLS_DIR=${TOOLS_DIR}
RUN mkdir -p ${TOOLS_DIR}/bin ${TOOLS_DIR}/include ${TOOLS_DIR}/lib ${TOOLS_DIR}/libexec ${TOOLS_DIR}/share

ENV PATH=${TOOLS_DIR}/bin:${PATH}
ENV DEBIAN_FRONTEND=''

CMD ["bash"]