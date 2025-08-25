# syntax=docker.io/docker/dockerfile-upstream:1.14.0-labs

FROM builder AS build

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
	--mount=type=cache,target=/var/lib/apt/lists,sharing=locked \
    --mount=type=bind,source=Aptfile,target=Aptfile \
    apt.sh

ARG NODE_VERSION=22.18.0

ENV TOOL_NAME=node

ENV TOOL_DIR=${TOOLS_ROOT}/${TOOL_NAME}
RUN mkdir -p ${TOOL_DIR}

ENV BUILDER_DIR=${TOOLS_ROOT}/builders/${TOOL_NAME}
RUN mkdir -p ${BUILDER_DIR}

ENV BUILDER_ENV_FILE=${BUILDER_DIR}/.env
RUN touch ${BUILDER_ENV_FILE}

COPY --chmod=0755 ./builder/* ${BUILDER_DIR}/
RUN ls -la ${BUILDER_DIR}
RUN ${BUILDER_DIR}/0-configure.sh
RUN ${BUILDER_DIR}/1-install.sh

# Vendor non-glibc shared libraries
RUN vendor-dependencies.sh ${TOOL_DIR}

FROM base

ENV TOOL_NAME=node
ENV TOOL_DIR=${TOOLS_ROOT}/node

COPY --from=build ${TOOL_DIR} ${TOOL_DIR}
COPY --chmod=0755 ./tool/setup.sh ${TOOL_DIR}/setup.sh
