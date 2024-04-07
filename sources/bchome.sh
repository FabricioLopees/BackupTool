#!/bin/bash

# Verifica se o usuário está executando em modo 'sudo' e então salva o nome do usuário
if [ -n "$SUDO_USER" ]; then
	username=$SUDO_USER
else
	username=$(id -un)
fi

# Define o caminho da pasta home
homedir="/home/$username"

echo "Criando pasta temporária para trabalho..."
mkdir copydir/


echo "Fazendo backup do diretório $homedir..."
# copia a pasta home para dentro da pasta de trabalho temporária exceto a pasta Backup-Tool/
ls $homedir | grep -v Backup-Tool | xargs -I{} cp -r ../{} copydir 
echo "Cópia finalizada!"

# acessa a pasta
cd copydir

echo "Empacotando e comprimindo arquivos copiados..."
# cria um tar.gzip de todos os arquivos copiados
tar -czf $username-home-backup.tar.gzip ./*

# move o tar.gzip para um diretório acima
mv $username-home-backup.tar.gzip ../
echo "Empacotamento e compressão finalizado!"

# sai da pasta temporária
cd ..

echo "Excluindo pasta temporária..."
# exclui a pasta temporária
rm -rf copydir

# executa o script de versionamento
. .sources/versioning.sh