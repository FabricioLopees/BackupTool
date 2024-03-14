# coloque entre os parenteses o dispositivo onde será feito o backup
# exemplo: /dev/sdc3

backup_device=""

# ======================================

# captura o UUID do dispositivo
uuid=$(lsblk -o UUID $backup_device | grep -v UUID);

# salva o nome do usuário
username=$(echo $USER)
# salva o nome do pc
machine=$(uname -n)

# monta o dispositivo
udisksctl mount -b $backup_device

# define o caminho do dispositivo montado
backup_device_path="/run/media/$username/$uuid/"

# verifica se não esxiste os diretórios de backup no dispositivo
if [ ! -d "$backup_device_path/backup" ]; then
    # cria as pastas necessárias para fazer o backup
    mkdir $backup_device_path/backup/
    mkdir $backup_device_path/backup/$machine/
    mkdir $backup_device_path/backup/$machine/home_backup/

    # cria uma pasta para colocar backup anterior
    mkdir $backup_device_path/backup/$machine/home_backup/.old_backup
fi

# define o caminho para ser colocado os arquivos de backup
backup_path=$backup_device_path/backup/$machine/home_backup/

# move o backup antigo do dispositivo para a pasta .old_backup
if [ -f "$backup_path/$username-home-backup.tar.xz" ]; then
    mv $backup_path/$username-home-backup.tar.xz $backup_path/$username-home-backup-OLD.tar.xz
    mv $backup_path/$username-home-backup-OLD.tar.xz $backup_path/.old_backup/

    if [ -d "$backup_path/.old_backup/.git" ]; then
        sudo rm -r $backup_path/.old_backup/.git/
    fi

    mv $backup_path/.git $backup_path/.old_backup/
fi

# copia para dentro do dispositvo o arquivo de backup
cp -r $username-home-backup.tar.xz $backup_path/
# copia a .git que armazena o versionamento do backup
cp -r .git/ $backup_path

# desmonta o dispositivo
udisksctl unmount -b $backup_device

echo "BACKUP /home/$username/ DONE!"