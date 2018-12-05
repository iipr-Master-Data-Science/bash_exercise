# bash_exercise
## Ejercicio 1
Hacer una script (`kernel.sh`) que:  
- Descargue el kernel de linux más reciente https://git.kernel.org/torvalds/t/linux-4.19-rc6.tar.gz (cuidado, son 150MB)
- Que lo descomprima (cuidado, es 1GB)
- Que localice todas las scripts de python que contiene este archivo
- Que localice aquellas que usan la librería datetime
- Que averigue cual es la script de mayor tamaño de éstas
- Que muestre únicamente las funciones y clases (con sus métodos) que define
- ¿cuál es el nombre de la única script del kernel que hace uso de estas funciones?

## Ejercicio 2
Hacer una script (`element.sh`) que:
- Descargue el fichero http://swcarpentry.github.io/shell-novice/data/data-shell.zip
- Que lo descomprima
- Que lea los ficheros xml que hay en el directorio `data/elements` y los copie en otro directorio (nuevo) llamado `elements_by_atomic_number`, de forma que los nombres de fichero sean del tipo `008_Oxigen.xml`.
- Que cambie los permisos de estos ficheros para que sean editables por el grupo y para que no los pueda ver ni editar el resto de usuarios.
- Que cree un fichero `tar.gz` con estos ficheros y elimine los ficheros y directorios intermedios.
