# Acessa o nome do usuário
username=$(echo $USER)

# Define o caminho da pasta home
homedir="/home/$username/*"

# cria uma pasta para trabalho temporária
mkdir copydir

# copia a pasta home para dentro da pasta de trabalho temporária
cp -r $homedir copydir/

# acessa a pasta
cd copydir

# cria um tar.xz de todos os arquivos copiados
tar -cJf $username-home-backup.tar.xz ./*

# move o tar.xz para um diretório acima
mv $username-home-backup.tar.xz ../

# sai da pasta temporária
cd ..

# exclui a pasta temporária
sudo rm -r copydir

# executa o script de versionamento
. .sources/versioning.sh
