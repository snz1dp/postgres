FROM postgres:14.4 AS builder

RUN apt-get update; \
  apt-get install -y wget

RUN echo "deb http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get install -y \
  make build-essential automake cmake \
  libtool pkg-config xsltproc poxml \
  libxml2 gettext imagemagick \
  libpq-dev libxml2-dev doxygen \
  sqlite3 libsqlite3-dev libtiff-dev \
  libcurl4-openssl-dev python3 \
  libprotoc-dev protobuf-compiler \
  libcgal-dev libpcre3-dev

RUN apt-get install -y postgresql-server-dev-14

ADD extension/install-postgis.sh /opt/
RUN chmod +x /opt/install-postgis.sh \
  && /opt/install-postgis.sh

FROM postgres:14.4

COPY --from=builder /usr/lib/postgresql /usr/lib/postgresql
COPY --from=builder /usr/share/postgresql /usr/share/postgresql
COPY --from=builder /opt/usr/* /usr/

RUN apt-get update; \
  apt-get install -y libcurl4 libtiffxx5

ADD scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
