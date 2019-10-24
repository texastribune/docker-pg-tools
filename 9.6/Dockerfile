FROM debian:buster

RUN apt-get -qq update \
  && apt-get -q install -y curl python-pip python-dev wget gnupg \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -

ENV PG_MAJOR 9.6

ARG CLOUD_SDK_VERSION=268.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

RUN apt-get update && apt-get install -y \
  lsb-release

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN echo 'deb http://deb.debian.org/debian/ sid main' >> /etc/apt/sources.list && \
  export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
  echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
  curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

RUN apt-get update && apt-get install -y \
  postgresql-client-$PG_MAJOR \
  google-cloud-sdk=${CLOUD_SDK_VERSION}-0 \
  --no-install-recommends && rm -rf /var/lib/apt/lists/*

#RUN pip install setuptools && pip install awscli postdoc
RUN pip install awscli postdoc

ADD . /app

ENTRYPOINT ["/bin/bash"]
