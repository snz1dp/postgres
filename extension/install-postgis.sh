#!/bin/bash

set -xe

currdir=$(cd `dirname $0`; pwd)

POSTGIS_VERSION=${POSTGIS_VERSION:-3.3.1}
GEOS_VERSION=${GEOS_VERSION:-3.11.0}
SFCGAL_VERSION=${SFCGAL:-1.4.1}
GDAL_VERSION=${GDAL_VERSION:-3.5.3}
PROJ_VERSION=${PROJ_VERSION:-9.1.0}
PROTOBUF_VERSION=${PROTOBUF_VERSION:-1.4.1}
JSONC_VERSION=${JSONC_VERSION:-0.16-20220414}

# download geos
wget https://github.com/libgeos/geos/archive/refs/tags/${GEOS_VERSION}.tar.gz -O ${currdir}/geos-${GEOS_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/geos-${GEOS_VERSION}.tar.gz \
  && rm -rf ${currdir}/geos-${GEOS_VERSION}.tar.gz \
  && mv ${currdir}/geos-${GEOS_VERSION} ${currdir}/geos

# build geos
cd ${currdir}/geos && cmake -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_DOCUMENTATION=off \
    -DCMAKE_INSTALL_PREFIX=/opt/usr/local . \
    && make && make install

# download PROJ
wget https://github.com/OSGeo/PROJ/archive/refs/tags/${PROJ_VERSION}.tar.gz -O ${currdir}/PROJ-${PROJ_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/PROJ-${PROJ_VERSION}.tar.gz \
  && rm -rf ${currdir}/PROJ-${PROJ_VERSION}.tar.gz \
  && mv ${currdir}/PROJ-${PROJ_VERSION} ${currdir}/PROJ

# build PROJ
cd ${currdir}/PROJ && cmake -DCMAKE_INSTALL_PREFIX=/opt/usr/local -DCMAKE_BUILD_TYPE=Release . \
  && cmake --build . --target install

# download protobuf-c
wget https://github.com/protobuf-c/protobuf-c/archive/refs/tags/v${PROTOBUF_VERSION}.tar.gz -O ${currdir}/protobuf-c-${PROTOBUF_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/protobuf-c-${PROTOBUF_VERSION}.tar.gz \
  && rm -rf ${currdir}/protobuf-c-${PROTOBUF_VERSION}.tar.gz \
  && mv ${currdir}/protobuf-c-${PROTOBUF_VERSION} ${currdir}/protobuf-c

# build protobuf-c
cd ${currdir}/protobuf-c && ./autogen.sh && ./configure --prefix=/opt/usr/local && make && make install

# download gdal
wget https://github.com/OSGeo/gdal/archive/refs/tags/v${GDAL_VERSION}.tar.gz -O ${currdir}/gdal-${GDAL_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/gdal-${GDAL_VERSION}.tar.gz \
  && rm -rf ${currdir}/gdal-${GDAL_VERSION}.tar.gz \
  && mv ${currdir}/gdal-${GDAL_VERSION} ${currdir}/gdal

# build gdal
cd ${currdir}/gdal && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/usr/local . \
  && make -f Makefile && make -f Makefile install

# download SFCGAL
wget https://gitlab.com/Oslandia/SFCGAL/-/archive/v${SFCGAL_VERSION}/SFCGAL-v${SFCGAL_VERSION}.tar.gz -O ${currdir}/SFCGAL-${SFCGAL_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/SFCGAL-${SFCGAL_VERSION}.tar.gz \
  && rm -rf ${currdir}/SFCGAL-${SFCGAL_VERSION}.tar.gz \
  && mv ${currdir}/SFCGAL-v${SFCGAL_VERSION} ${currdir}/SFCGAL

# build SFCGAL
cd ${currdir}/SFCGAL \
  && sed -i s/"CGAL 5.3 COMPONENTS"/"CGAL 5.2 COMPONENTS"/g CMakeLists.txt \
  && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/usr/local . \
  && make && make install

# download json-c
wget https://github.com/json-c/json-c/archive/refs/tags/json-c-${JSONC_VERSION}.tar.gz -O ${currdir}/json-c-${JSONC_VERSION}.tar.gz
cd ${currdir} && tar xzvf json-c-${JSONC_VERSION}.tar.gz \
  && rm -rf ${currdir}/json-c-${JSONC_VERSION}.tar.gz \
  && mv ${currdir}/json-c-json-c-${JSONC_VERSION} ${currdir}/json-c

# build json-c
cd ${currdir}/json-c && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/usr/local . \
  make && make install

# download postgis
wget http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz -O ${currdir}/postgis-${POSTGIS_VERSION}.tar.gz
cd ${currdir} && tar xzvf ${currdir}/postgis-${POSTGIS_VERSION}.tar.gz \
  && rm -rf ${currdir}/postgis-${POSTGIS_VERSION}.tar.gz \
  && mv ${currdir}/postgis-${POSTGIS_VERSION} ${currdir}/postgis

export PATH=$PATH:/opt/usr/local/bin
export LD_LIBRARY_PATH=/opt/usr/local/lib

# build postgis
cd ${currdir}/postgis \
  && ./configure --prefix=/opt/usr/local --with-protobuf-inc=/opt/usr/local/include \
  --with-protobuf-lib=/opt/usr/local/lib --with-projdir=/opt/usr/local \
  && make && make install
