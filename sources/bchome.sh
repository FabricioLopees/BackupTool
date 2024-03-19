#!/bin/bash

# Verifica se o usuário está executando em modo 'sudo' e então salva o nome do usuário
if [ -n "$SUDO_USER" ]; then
	username=$SUDO_USER
else
	username=$(id -un)
fi

# Define o caminho da pasta home
homedir="/home/$username"

# cria uma pasta para trabalho temporária
mkdir -v copydir

# copia a pasta home para dentro da pasta de trabalho temporária exceto a pasta Backup-Tool/
find $homedir -mindepth 1 -maxdepth 1 -type d ! -name "Backup-Tool" -exec cp -rv {} copydir/ \;

# acessa a pasta
cd copydir

# cria um tar.xz de todos os arquivos copiados
tar -cJvf $username-home-backup.tar.xz ./*

# move o tar.xz para um diretório acima
mv -v $username-home-backup.tar.xz ../

# sai da pasta temporária
cd ..

# exclui a pasta temporária
sudo rm -rv copydir

# executa o script de versionamento
. .sources/versioning.sh
