#! /bin/bash

# (2) Hacer una script (element.sh) que:
#     · Descargue el fichero http://swcarpentry.github.io/shell-novice/data/data-shell.zip
#     · Que lo descomprima
#     · Que lea los ficheros xml que hay en el directorio data/elements y los copie en otro directorio (nuevo) llamado elements_by_atomic_number, de forma que los nombres de fichero sean del tipo 008_Oxigen.xml.
#     · Que cambie los permisos de estos ficheros para que sean editables por el grupo y para que no los pueda ver ni editar el resto de usuarios.
#     · Que cree un fichero tar.gz con estos ficheros y elimine los ficheros y directorios intermedios.

# If the first argument is true, attempt to download and extract the file
DOWN_FLAG=$1
down_dir="download_folder"
my_data="data-shell"
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
    if test ! -f ${my_data}.zip
    then
        echo "Downloading ${my_data}.zip ..."
        wget http://swcarpentry.github.io/shell-novice/data/${my_data}.zip &>> ${log_file}
    fi
    if test ! -d ${my_data}
    then
        echo "Extracting ${my_data}.zip ..."
        unzip ${my_data}.zip &>> ${log_file}
    fi
else
    echo "Skipping the download and extract steps for ${my_data}..."
    cd ${down_dir}
fi

# Create new folder to copy the modified files
cd ./data-shell/data/elements
new_fold="elements_by_atomic_number"
if test ! -d ../${new_fold}
then
    mkdir ../${new_fold}
fi

# Move files changing the names as specified, and change permissions
echo "Copying files and changing names and permissions..."
for file in ./*.xml
do
      #cat $file | grep -o -P '(?<=<atomic-number>).*(?=</atomic-number>)'
      el_name="$(sed -n 's|<element name="\([a-zA-Z]\+\)"/>|\1|p' $file)"
      n_atom="$(sed -n 's|  <atomic-number>\([0-9]\+\)</atomic-number>|\1|p' $file)"
      cp ${file} ../${new_fold}/`printf %03d $n_atom`_${el_name}.xml
      chmod 660 ../${new_fold}/`printf %03d $n_atom`_${el_name}.xml
done

# Pack results
echo "Creating tar.gz file with results..."
ZFILE="elements_modified"
tar -cvzf ../${ZFILE}.tar.gz -C ../${new_fold} . &>> ../../../${log_file}

echo "Done."
