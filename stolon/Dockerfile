# 参见：
# https://github.com/sorintlab/stolon/blob/master/examples/kubernetes/image/docker/Dockerfile

FROM sorintlab/stolon:master-pg14 AS builder

FROM snz1dp/postgres:14.10

RUN useradd -ms /bin/bash stolon

COPY --from=builder /usr/local/bin/stolon* /usr/local/bin/

RUN chmod +x /usr/local/bin/stolon*
