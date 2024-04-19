#!/bin/bash

# define o dispositivo para salvar o backup
backup_device=$(cat ~/.backup/backup-device.txt)

if [ ! "$backup_device" ]; then
    echo "ERROR!"
    echo "Backup device not defined!"
else
    # captura o UUID do dispositivo
    uuid=$(lsblk -o UUID $backup_device | grep -v UUID);

    # salva o nome do pc
    machine=$(uname -n)

    # monta o dispositivo
    udisksctl mount -b $backup_device > /dev/null
    echo "Montando dispositivo $backup_device..."
    echo "Salvando backup no dispositivo $backup_device..."

    # define o caminho do dispositivo montado
    backup_device_path="/run/media/$username/$uuid"

    # verifica se não esxiste os diretórios de backup no dispositivo
    if [ ! -d "$backup_device_path/backup" ]; then
        # cria as pastas necessárias para fazer o backup
        mkdir $backup_device_path/backup/
        mkdir $backup_device_path/backup/$machine/
    fi

    # define o caminho para ser colocado os arquivos de backup
    backup_path=$backup_device_path/backup/$machine/

    # remove backup anterior se existir
    if [ -f "$backup_path/$username-$bctype-backup.tar.gzip" ]; then
        rm -f $backup_path/$username-$bctype-backup.tar.gzip
    fi

    # copia para dentro do dispositvo o arquivo de backup
    cp ~/.backup/$username-$bctype-backup.tar.gzip $backup_path/

    # desmonta o dispositivo
    udisksctl unmount -b $backup_device > /dev/null
    echo "Desmontando dispositivo..."

    rm -r ~/.backup/$username-$bctype-backup.tar.gzip

    # echo "BACKUP REALIZADO COM SUCESSO!"
fi