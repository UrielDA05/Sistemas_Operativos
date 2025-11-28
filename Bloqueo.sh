#!/bin/bash

# UUID de la memoria
UUID_AUTORIZADA="4E21-0000"

# Compara todos los UUID detectados hasta que encuentre el que coincida
if lsblk -no UUID | grep -q "^$UUID_AUTORIZADA$"; then
    echo "Acceso permitido"
else
    echo "Acceso denegado"
    
fi
