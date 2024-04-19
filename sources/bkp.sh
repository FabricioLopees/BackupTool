#!/bin/bash

# Verifica parâmetro
if [ "$1" == "--home" ] || [ "$1" == "--root" ]; then

	# Verifica se o usuário está executando em modo 'sudo' e então salva o nome do usuário
	if [ -n "$SUDO_USER" ]; then
		username=$SUDO_USER
	else
		username=$(id -un)
	fi

	# Define o diretório alvo para ser copiado
	if [ "$1"  == "--home" ]; then
		bctype="home"
		bctarget="/home/$username"
	else		
		bctype="root"
		bctarget="/"
	fi

	echo "Criando pasta temporária para trabalho..."
	mkdir ~/.backup/copydir/


	echo "Fazendo backup do diretório $bctarget..."
	if [ "$bctype" == "home" ]; then
		# copia a pasta home para dentro da pasta de trabalho temporária exceto a pasta .backup/
		ls $bctarget | grep -v .backup | xargs -I{} cp -r ~/{} ~/.backup/copydir 
	else
		# copia a pasta raiz para dentro da pasta de trabalho temporária exceto a pasta home/
		ls $bctarget | grep -v home | xargs -I{} cp -r /{} ~/.backup/.copydir
	fi

	echo "Cópia finalizada!"

	# acessa a pasta
	cd ~/.backup/copydir

	echo "Empacotando e comprimindo arquivos copiados..."
	# cria um tar.gzip de todos os arquivos copiados
	tar -czf $username-$bctype-backup.tar.gzip ./*

	# move o tar.gzip para um diretório acima
	mv $username-$bctype-backup.tar.gzip ../
	echo "Empacotamento e compressão finalizado!"

	# sai da pasta temporária
	cd ..

	echo "Excluindo pasta temporária..."
	# exclui a pasta temporária
	rm -rf copydir

	# executa o script de versionamento
	. ~/.backup/save.sh $bctype
else
	echo "ERROR!"
	echo "Syntax: bchome [OPTION]"
	echo "Options:"
	echo "	--home : do copy of the /home"
	echo "	--root : do copy of the /"
fi