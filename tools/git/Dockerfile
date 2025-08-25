FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	  --mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=bind,source=Aptfile,target=Aptfile \
    apt.sh

ENV TOOL_NAME=git

ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}
RUN mkdir -p ${TOOL_DIR}

ENV BUILDER_DIR=${TOOLS_ROOT}/builders/${TOOL_NAME}
RUN mkdir -p ${BUILDER_DIR}

ENV BUILDER_WORK_DIR=${BUILDER_DIR}/work
RUN mkdir -p ${BUILDER_WORK_DIR}
WORKDIR ${BUILDER_WORK_DIR}

ENV BUILDER_ENV_FILE=${BUILDER_WORK_DIR}/.env
RUN touch ${BUILDER_ENV_FILE}

ENV BUILDER_BIN_DIR=${BUILDER_DIR}/bin
RUN mkdir -p ${BUILDER_BIN_DIR}
COPY --chmod=0755 ./builder/bin/* ${BUILDER_BIN_DIR}/

ARG GIT_VERSION=2.51.0
RUN echo "GIT_VERSION=${GIT_VERSION} >> ${BUILDER_ENV_FILE}"

RUN ${BUILDER_BIN_DIR}/0-configure.sh
RUN ${BUILDER_BIN_DIR}/1-download.sh
RUN ${BUILDER_BIN_DIR}/2-install.sh

RUN vendor-dependencies.sh ${TOOL_DIR}

FROM base

ENV TOOL_NAME=git
ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}

COPY --from=build ${TOOL_DIR} ${TOOL_DIR}
COPY --chmod=0755 ./tool/setup.sh ${TOOL_DIR}/setup.sh
