#!/bin/bash

# Configuració
IMAGE_NAME="ubuntu24-xfce-vnc"
CONTAINER_NAME="dockerfileGUI"
VNC_PORT=5901
SSH_PORT=2222

# Neteja
cleanup() {
    echo "Parant container..."
    docker stop $CONTAINER_NAME >/dev/null 2>&1 || true
    echo "Eliminant container..."
    docker rm $CONTAINER_NAME >/dev/null 2>&1 || true
}

# Imatge
echo "Construint imatge Docker..."
docker build -t $IMAGE_NAME -f dockerfileGUI . || {
    echo "Error al fer la imatge"
    exit 1
}

cleanup

# EXecutar container
echo "Iniciant container..."
docker run -d \
    -p $VNC_PORT:5901 \
    -p $SSH_PORT:22 \
    --name $CONTAINER_NAME \
    $IMAGE_NAME \
    /bin/bash -c "
    # VNC
    chown -R docker:docker /home/docker
    su - docker -c 'vncserver :1 -geometry 1280x800 -depth 24'
    
    # SSH
    service ssh start
    
    # keepalive container
    echo 'Serveis actius: VNC(5901) y SSH(22)'
    tail -f /dev/null
    " || {
    echo "Error engegant el container"
    cleanup
    exit 1
}

# info
echo -e "\n CONTENIDOR ENGEGAT"
echo "======"
echo "VNC:"
echo "  Host: localhost"
echo "  Port: $VNC_PORT"
echo "  Contrasenya: password"
echo ""
echo "SSH:"
echo "  Host: localhost"
echo "  Port: $SSH_PORT"
echo "  Usuari: docker"
echo "  Contrasenyaa: password"
echo ""
echo "Per parar: docker stop $CONTAINER_NAME"
echo "=========="

# Tonrar shell
echo "Contenedor iniciat"
exit 0
