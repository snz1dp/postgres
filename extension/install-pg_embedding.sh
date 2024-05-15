#!/bin/bash

set -xe

currdir=$(cd `dirname $0`; pwd)

cd $currdir && \
  git clone https://github.com/neondatabase/pg_embedding.git && \
  cd $currdir/pg_embedding && \
  make && make install
