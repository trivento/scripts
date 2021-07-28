#!/bin/sh -e

# Based on:
# https://github.com/RHsyseng/container-rhel-examples/blob/master/starter-arbitrary-uid/Dockerfile#L40
# forked from:
# https://github.com/030/container-rhel-examples/blob/master/starter-arbitrary-uid/Dockerfile#L40

BASE_BIN=${BASE}/bin
echo "Creating directory: ${BASE_BIN}"
mkdir -p ${BASE_BIN} && \
echo "Moving entrypoint and binary file: '${USERNAME}' to: ${BASE_BIN}"
mv entrypoint.sh ${BASE_BIN} && \
mv $USERNAME ${BASE_BIN} && \
adduser \
    -G root \
    -D \
    -S \
    -h $BASE \
    -s /bin/false \
    -u 9999 \
$USERNAME && \
chown root:root -R $BASE && \
chgrp -R 0 ${BASE} && \
chmod 0050 -R ${BASE} && \
chmod 0070 $BASE && \
chmod 0060 /etc/passwd
