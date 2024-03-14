# Acessa o nome do usuário
username=$(echo $USER)

# Define o caminho da pasta home
homedir="/home/$username/"

# cria uma pasta para trabalho temporária
mkdir -v copydir

# copia a pasta home para dentro da pasta de trabalho temporária exceto a pasta backup-tool/
find $homedir -mindepth 1 -maxdepth 1 -type d ! -name "backup-tool" -exec cp -rv {} copydir/ \;

# acessa a pasta
cd -v copydir

# cria um tar.xz de todos os arquivos copiados
tar -cJvf $username-home-backup.tar.xz ./*

# move o tar.xz para um diretório acima
mv -v $username-home-backup.tar.xz ../

# sai da pasta temporária
cd -v ..

# exclui a pasta temporária
sudo rm -rv copydir

# executa o script de versionamento
. .sources/versioning.sh
