#!/bin/bash

# Iniciar DBus
service dbus start

# Configurar entorn de display
export DISPLAY=:1
export RESOLUTION=1920x1080x24

# Permisos per X11
mkdir -p /tmp/.X11-unix
chmod 1777 /tmp/.X11-unix

# Iniciar XFCE
Xvfb :1 -screen 0 $RESOLUTION &
sleep 2
startxfce4 &

# Configurar VNC
x11vnc -display :1 -forever -shared -rfbauth /root/.vnc/passwd -rfbport 5901 > /var/log/x11vnc.log 2>&1 &

# Iniciar SSH
/usr/sbin/sshd -D
