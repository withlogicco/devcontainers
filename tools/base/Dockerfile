FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update &&\
	apt-get install -y --no-install-recommends ca-certificates &&\
	rm -rf /var/lib/apt/lists/*

ARG TOOLS_DIR=/opt/tools
ENV TOOLS_DIR=${TOOLS_DIR}
RUN mkdir -p ${TOOLS_DIR}/bin ${TOOLS_DIR}/include ${TOOLS_DIR}/lib ${TOOLS_DIR}/libexec ${TOOLS_DIR}/share

ENV PATH=${TOOLS_DIR}/bin:${PATH}
ENV DEBIAN_FRONTEND=''

CMD ["bash"]