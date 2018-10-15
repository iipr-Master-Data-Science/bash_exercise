#! /bin/bash

# (1) Hacer una script (kernel.sh) que:
#     · Descargue el kernel de linux más reciente https://git.kernel.org/torvalds/t/linux-4.19-rc6.tar.gz (cuidado, son 150MB)
#     · Que lo descomprima (cuidado, es 1GB)
#     · Que localice todas las scripts de python que contiene este archivo
#     · Que localice aquellas que usan la librería datetime
#     · Que averigue cual es la script de mayor tamaño de éstas
#     · Que muestre únicamente las funciones y clases (con sus métodos) que define
#     · ¿cuál es el nombre de la única script del kernel que hace uso de estas funciones?

# If the first argument is true, attempt to download and extract the file
DOWN_FLAG=$1
down_dir="download_folder"
my_kernel="linux-4.19-rc6"
log_file="log.txt"

if $DOWN_FLAG
then
    if test ! -d ${down_dir}
    then
        mkdir ${down_dir}
    fi
    cd ${down_dir}
    if test -f ${log_file}
    then
        rm ${log_file}
    fi
    touch ${log_file}
    if test ! -f ${my_kernel}.tar.gz
    then
        echo "Downloading ${my_kernel}.tar.gz ..."
        wget https://git.kernel.org/torvalds/t/${my_kernel}.tar.gz &>> ${log_file}
    fi
    if test ! -d ${my_kernel}
    then
        echo "Extracting ${my_kernel}.tar.gz ..."
        tar -xzf ${my_kernel}.tar.gz
        # To save verbose output instead:
        #tar -xzvf ${my_kernel}.tar.gz >> ${log_file}
    fi
else
    echo "Skipping the download and extract steps for ${my_kernel}..."
    cd ${down_dir}
fi

# Find all python scripts
# Among them, the ones that use the lib `datetime`
# Pick the biggest one
FNAME="$(grep -lrE --include=*.py "(import|from) datetime" . | xargs ls -S | head -1)"
echo "The biggest Python script that uses datetime is ${FNAME}"

# Extract structure and save it into a separate file
out_file="structure.txt"
echo "Saving script structure into ${down_dir}/${out_file} ..."
grep -E "^$(printf '\t')*def|^$(printf '\t')*class" ${FNAME} > ${out_file}

# Find the only script that uses it
BNAME=$(basename "${FNAME}" .py)
ZNAME="$(grep -lrE --include=*.py "(import|from) ${BNAME}" .)"
echo "The only script that uses ${BNAME} is ${ZNAME}"

echo "Done."
