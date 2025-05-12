#!/bin/bash

# Iniciar DBus
service dbus start

# Permisos per X11
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Iniciar servidor VNC
vncserver :1 -geometry $RESOLUTION -depth 24 && \
tail -F /root/.vnc/*.log &

# Iniciar SSH
/usr/sbin/sshd -D
