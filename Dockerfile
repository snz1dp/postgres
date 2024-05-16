FROM postgres:14.10 AS builder

ADD scripts/update-sources.sh /tmp/update-sources.sh

RUN chmod +x /tmp/update-sources.sh \
  && /tmp/update-sources.sh

RUN apt-get update; \
  apt-get install -y wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get update; \
  apt-get install -y \
  make build-essential automake cmake \
  libtool pkg-config xsltproc poxml \
  libxml2 gettext imagemagick \
  libxml2-dev doxygen \
  sqlite3 libsqlite3-dev libtiff-dev \
  libpq5 libpq-dev \
  libcurl4-openssl-dev python3 \
  libprotoc-dev protobuf-compiler \
  libcgal-dev libpcre3-dev

RUN apt-get install -y postgresql-server-dev-14 git

ADD extension/install-postgis.sh /opt/
RUN chmod +x /opt/install-postgis.sh \
  && /opt/install-postgis.sh

ADD extension/install-pg_embedding.sh /opt/
RUN chmod +x /opt/install-pg_embedding.sh \
  && /opt/install-pg_embedding.sh

FROM postgres:14.10

COPY --from=builder /usr/lib/postgresql /usr/lib/postgresql
COPY --from=builder /usr/share/postgresql /usr/share/postgresql
COPY --from=builder /opt/usr/* /usr/
COPY --from=builder /lib/* /lib/

RUN apt-get update; \
  apt-get install -y libcurl4 libtiffxx6

ADD scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
