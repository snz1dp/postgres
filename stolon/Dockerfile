FROM sorintlab/stolon:master-pg14 AS builder

FROM snz1.cn/database/postgres:14.10

RUN useradd -ms /bin/bash stolon

COPY --from=builder /usr/local/bin/stolon* /usr/local/bin/

RUN chmod +x /usr/local/bin/stolon*
