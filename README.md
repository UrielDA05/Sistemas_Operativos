# Examen U4

## Inicializacion del codigo

Para la ejecucion del codigo es necesario acceder a la carpeta y conceder permisos
de la siguiente manera
 
* 'cd Sistemas_Operativos'
* 'chmod +x Bloqueo.sh
* './Bloqueo.sh

## Funcionamiento

Al ejecutar el script monitore cada 3 segundos si se encuentra la llave con la memoria, 
en caso de que no, modifica los archivos para solo lectura, permitiendo introducir la memoria y
detectarla en tiempo real, una vez detectada permite escritura tambien, en caso de que vuelva a retirar 
la memoria regresa a solo lectura, esta en constante monitoreo