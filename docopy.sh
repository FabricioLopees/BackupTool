# Exclui a última cópia da minha pasta home
rm -r /fabricio

# Faz uma nova cópia
cp -r /home/fabricio/ ./

# Busca qual foi a última versão do backup
lastVersion=$(cat backup_lastVersion.txt)

# Gera a nova versão do commit que será feito
newVersion=$((lastVersion+1))

# Adiciona as mudanças para serem comitadas
git add fabricio-test/

# Faz o commit incluindo a nova versão na mensagem do commit
git commit -m "backup: /home/fabricio v$newVersion.0"
