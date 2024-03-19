#!/bin/bash
# verifica se a pasta .git não existe
if [ ! -d ".git" ]; then
    git init
    git add .gitignore
    git commit -m "add gitignore"
fi

# obtém a última versão de backup e gera a próxima versão
lastVersion=$(cat .sources/backup_lastVersion.txt)
newVersion=$(($lastVersion+1))

# Verifica se o usuário está executando em modo 'sudo' e então salva o nome do usuário
if [ -n "$SUDO_USER" ]; then
	username=$SUDO_USER
else
	username=$(id -un)
fi

# adiciona o arquivo de backup e faz commit
git add *.tar.xz
git commit -m "backup: /home/$username v$newVersion.0"

# salva a nova versão de backup
echo $newVersion > .sources/backup_lastVersion.txt

# executa o script que salva o backup em outro disco
. .sources/save.sh
