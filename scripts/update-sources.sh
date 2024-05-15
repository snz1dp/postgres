#!/usr/bin/env bash
set -Eeo pipefail

cat>/etc/apt/sources.list.d/debian.sources<<EOF
Types: deb
# http://snapshot.debian.org/archive/debian/20240130T194419Z
URIs: http://mirrors.tuna.tsinghua.edu.cn/debian
Suites: bookworm bookworm-updates
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg

Types: deb
# http://snapshot.debian.org/archive/debian-security/20240130T194419Z
URIs: http://mirrors.tuna.tsinghua.edu.cn/debian-security
Suites: bookworm-security
Components: main
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF
