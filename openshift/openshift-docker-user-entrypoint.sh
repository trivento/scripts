#!/bin/sh -e

if [ "$1" == "${USERNAME}" ]; then
  if [ -w /etc/passwd ]; then
    USER_ID=9999
    USERNAME=$(cat /etc/passwd | grep $USER_ID | sed -e "s|^\([a-z0-9-]\+\):.*$|\1|")
    echo "USER_ID: ${USER_ID}. USERNAME: ${USERNAME}"

    sed -e "s|x:${USER_ID}:0|x:$(id -u):0|" /etc/passwd > /tmp/passwdXYZ
    cat /tmp/passwdXYZ > /etc/passwd
    
    export HOME="${BASE}"
    export USER="${USERNAME}"

    echo "HOME: ${HOME}"
    echo "PATH: ${PATH}"
    echo "USER: ${USER}"
    echo "WHOAMI: $(whoami)"
    echo "USER_ID and GROUP: $(id)"
  else
    echo "cannot update user id"
    exit 1
  fi
fi
exec "$@"
