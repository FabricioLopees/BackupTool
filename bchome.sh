# Define o caminho para a pasta home
homedir=""

# Define a url do repositório remoto
remote_repo=""
# ----------------------------------------------------------------------
# Cria um diretório temporário para colocar a cópia da home
mkdir ./backup/copia

# Faz uma nova cópia
cp -r $homedir ./backup/copia

# Salva o nome da pasta copiada
homename=$(ls ./backup/copia/)

# Gera um pacote TAR comprimido em GZIP de todos os arquivos presentes na pasta copiada
tar -czf ./backup/$homename-home-backup.tar.gz ./backup/copia/$homename/*

# Remove a pasta de cópia temporária
sudo rm -r ./backup/copia

# Busca qual foi a última versão do backup
lastVersion=$(cat ./sources/backup_lastVersion.txt)

# Gera a nova versão do commit que será feito
newVersion=$(($lastVersion+1))

if [ ! -d "./.git" ]; then
	# Inicia o git
	git init > ./sources/gitlog.txt
	
	# Adiciona o repositório remoto
	git remote add origin $remote_repo >> ./sources/gitlog.txt
fi

# Adiciona as mudanças para serem comitadas
git add ./backup >> ./sources/gitlog.txt

# Faz o commit incluindo a nova versão na mensagem do commit
git commit -m "backup: /home/$homename v$newVersion.0" >> ./sources/gitlog.txt

# Manda o novo backup para o repositório remoto
git push origin main >> ./sources/gitlog.txt

# Atualiza a versão do backup salvo no arquivo
echo $newVersion > ./sources/backup_lastVersion.txt

echo "Backup do diretório /home/$homename feito!"
