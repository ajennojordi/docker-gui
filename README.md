# Entorn docker amb GUI XCFE, VNC, VSCode i Python

#Requisits previs
-Docker instal·lat
-VirtualBox (per redirecció de ports en cas necessari)
-Client VNC (Remmina, TigerVNC, etc.)

##Construir la imatge

```bash
docker build -t ubuntu-gui .


#Informació bàsica

-usuari: docker
-contrasenya: password
-port SSH: 2222
-port VNC: 5901
