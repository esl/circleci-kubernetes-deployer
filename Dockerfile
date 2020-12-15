FROM docker:19.03.11

ARG helm_version=v3.3.0
ARG helm_hash=ff4ac230b73a15d66770a65a037b07e08ccbce6833fbd03a5b84f06464efea45
ARG gcloud_version=320.0.0

WORKDIR /build

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/google-cloud-sdk/bin

RUN apk update --no-cache && apk add --no-cache --update jsonnet curl python3 bash git openssh-client make \
  && echo "${helm_hash}  helm-${helm_version}-linux-amd64.tar.gz" > helm-${helm_version}-linux-amd64.tar.gz.sha256sum \
  && curl https://get.helm.sh/helm-${helm_version}-linux-amd64.tar.gz -O \
  && sha256sum -c helm-${helm_version}-linux-amd64.tar.gz.sha256sum || ( echo "bad download" && exit 1 ) \
  && tar zxvf helm-${helm_version}-linux-amd64.tar.gz \
  && mv linux-amd64/helm /usr/local/bin/ \
  && curl -s https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${gcloud_version}-linux-x86_64.tar.gz -O \
  && tar zxf google-cloud-sdk-${gcloud_version}-linux-x86_64.tar.gz \
  && cp -pr google-cloud-sdk / \
  && rm -f /google-cloud-sdk/bin/anthoscli \
  && gcloud config set disable_usage_reporting true \
  && gcloud components install --quiet kubectl \
  && rm -rf /build

RUN curl -Lo /usr/bin/tk https://github.com/grafana/tanka/releases/latest/download/tk-linux-amd64 \
  && curl -Lo /usr/bin/jb https://github.com/jsonnet-bundler/jsonnet-bundler/releases/latest/download/jb-linux-amd64 \
  && chmod +x /usr/bin/tk \
  && chmod +x /usr/bin/jb
