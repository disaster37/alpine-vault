FROM alpine:3.7
MAINTAINER Sebastien LANGOUREAUX (linuxworkgroup@hotmail.com)

# Application settings
ENV CONFD_PREFIX_KEY="/vault" \
    CONFD_BACKEND="env" \
    CONFD_INTERVAL="60" \
    CONFD_NODES="" \
    S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
    LANG="en_US.utf8" \
    APP_HOME="/opt/vault" \
    APP_VERSION="0.10.4" \
    SCHEDULER_VOLUME="/opt/scheduler" \
    USER=vault \
    GROUP=vault \
    UID=10003 \
    GID=10003 \
    CONTAINER_NAME="alpine-vault" \
    CONTAINER_AUHTOR="Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>" \
    CONTAINER_SUPPORT="https://github.com/disaster37/alpine-vault/issues" \
    APP_WEB="https://www.vaultproject.io"

# Install extra package
RUN apk --update add fping curl bash ca-certificates &&\
    rm -rf /var/cache/apk/*

# Install confd
ENV CONFD_VERSION="0.14.0" \
    CONFD_HOME="/opt/confd"
RUN mkdir -p "${CONFD_HOME}/etc/conf.d" "${CONFD_HOME}/etc/templates" "${CONFD_HOME}/log" "${CONFD_HOME}/bin" &&\
    curl -Lo "${CONFD_HOME}/bin/confd" "https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64" &&\
    chmod +x "${CONFD_HOME}/bin/confd"

# Install s6-overlay
RUN curl -sL https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz \
    | tar -zx -C /




# Install Vault software
RUN \
    mkdir -p ${APP_HOME}/bin ${APP_HOME}/conf ${APP_HOME}/data  && \
    curl https://releases.hashicorp.com/vault/${APP_VERSION}/vault_${APP_VERSION}_linux_amd64.zip -o /tmp/vault.zip &&\
    unzip /tmp/vault.zip -d /tmp &&\
    mv /tmp/vault ${APP_HOME}/bin/ &&\
    rm -rf /tmp/vault* &&\
    addgroup -g ${GID} ${GROUP} && \
    adduser -g "${USER} user" -D -h ${APP_HOME} -G ${GROUP} -s /bin/sh -u ${UID} ${USER}


ADD root /
RUN chown -R ${USER}:${GROUP} ${APP_HOME}


VOLUME ["${APP_HOME}/data"]

EXPOSE 8200

CMD ["/init"]