FROM postgres:9.6.24

ADD scripts/docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh
