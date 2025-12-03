#!/bin/bash

# UUID de memoria autorizada
UUID_AUTORIZADA="4E21-0000"
CLAVE_CONTENIDO="Clave_Uriel"
USUARIO="inquis1d0r"
HOME_DIR="/home/$USUARIO"
PUNTO_FIJO="/mnt/usb_seguridad"

sudo mkdir -p "$PUNTO_FIJO"

echo "Verificacion de seguridad"

while true; do
    if lsblk -no UUID | grep -q "$UUID_AUTORIZADA"; then
        if ! mountpoint -q "$PUNTO_FIJO"; then
            sudo mount -U "$UUID_AUTORIZADA" "$PUNTO_FIJO" 2>/dev/null
        fi
        
        if [ -f "$PUNTO_FIJO/.key.txt" ] && [ "$(cat "$PUNTO_FIJO/.key.txt")" == "$CLAVE_CONTENIDO" ]; then
            # LLAVE CORRECTA: Quitar el atributo de "solo lectura" 
            sudo chattr -R -i "$HOME_DIR" 2>/dev/null
            echo "Llave detectada: Archivos desbloqueados :)"
        else
            # LLAVE INCORRECTA: Bloquear archivos
            sudo chattr -R +i "$HOME_DIR" 2>/dev/null
            echo "Llave INCORRECTA: Archivos bloqueados :("
        fi
    else
        # SIN USB: Bloqueo inmediato de todos los archivos
        sudo chattr -R +i "$HOME_DIR" 2>/dev/null
        echo "USB Desconectado: Archivos protegidos :|"
    fi
    sleep 3
done