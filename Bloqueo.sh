#!/bin/bash

# UUID de memoria principal
UUID_AUTORIZADA="4E21-0000"

CLAVE_CONTENIDO="Clave_Uriel"
USUARIO="inquis1d0r"
HOME_DIR="/home/$USUARIO"
PUNTO_FIJO="/mnt/usb_seguridad"

sudo mkdir -p "$PUNTO_FIJO"
echo "Verificación manual de llave USB"

# Función para verificar USB
verificar_usb_manual() {
    if lsblk -no UUID | grep -qi "$UUID_AUTORIZADA"; then
        if sudo mount -U "$UUID_AUTORIZADA" "$PUNTO_FIJO" 2>/dev/null; then
            if [ -f "$PUNTO_FIJO/.key.txt" ] && [ "$(cat "$PUNTO_FIJO/.key.txt")" == "$CLAVE_CONTENIDO" ]; then
                echo "Llave correcta detectada. Acceso permitido."
                return 0
            else
                echo "Llave incorrecta."
                return 1
            fi
        else
            echo "Error al montar USB."
            return 1
        fi
    else
        echo "USB no detectada."
        return 1
    fi
}
# Lógica principal
if verificar_usb_manual; then
    echo "Verificación exitosa. Puedes continuar usando el sistema."
else
    echo "Verificación fallida. Bloqueando archivos"
    sudo chattr -R +i "$HOME_DIR" 2>/dev/null  # Bloquea archivos
    echo "Sistema parcialmente bloqueado. Inserta la USB correcta para continuar."
    # Bucle de espera 
    while true; do
        sleep 5
        if verificar_usb_manual; then
            sudo chattr -R -i "$HOME_DIR" 2>/dev/null  # Desbloquea si se inserta
            echo "Acceso restaurado."
            break
        fi
    done
fi