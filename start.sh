# incia o diretorio para trabalho
mkdir ~/.backup

# copia os arquivos e scripts para este diretório
cp -r sources/* ~/.backup

# copia o script de backup para dentro de um diretório executável
mv ~/.backup/bkp.sh ~/.backup/bkp
cp ~/.backup/bkp ~/.local/bin/

source ~/.bashrc

echo "Diretório .backup inicializado!"