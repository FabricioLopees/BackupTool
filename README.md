# Sobre o projeto
Um simples conjunto de scripts que realiza o backup da pasta home com um simples comando

### Características
- Faz uma cópia da pasta home;
- Cria um pacote comprimido desta cópia, agrupa os arquivos e economiza espaço em disco;
- Faz o versionamento desta cópia, de maneira que possibilita alterar entre versões diferentes de backup;
- Salva esta cópia no dispositivo / partição que for de preferência do usuário;

### Como usar
1. ##### Configurando o dispositivo que será salvo o backup
    - Execute o script `start.sh` com o comando `./start`.
        - Ele criará em sua `/home` a pasta `Backup-Tool`
        - Este diretório será onde o script trabalhará
    - Acesse o diretório com o comando: `cd ~/Backup-Tool`
    - Dentro da pasta `~/Backup-Tool/.sources` acesse o script `save.sh`
    - Edite a quarta linha do arquivo em `backup_devices=" "`
    - Dentro das aspas adicione o seu dispositivo. Ex: `/dev/sdc3`
    - Salve e feche o arquivo
2. ##### Fazendo o backup
    - Abra o terminal no diretório que se encontra o script `bchome.sh`
    - Volte ao direório Backup-Tool `cd ../`
    - Execute o script com o comando `./bchome.sh`
    - Só aguardar o script realizar o backup!

### Como funciona
Na pasta principal do projeto (`Backup-Tool/`) o script faz uma cópia da pasta home, gera um pacote comprimido dessa cópia em tar.gzip, faz o versionamento do backup com o git, e salva este pacote comprimido e a .git (que armazena o versionamento daquele pacote) em um dispositivo ou partição externa que for de preferência do usuário.

### Por que criei este script
1. Eu estava precisando de fazer backups diários da minha /home e não queria nada muito complexo;
2. Queria colocar alguns conhecimentos em prática;

Resolvi então criar a minha própria ferramenta, uma ferramenta bem simples, e que me proporcionou colocar conhecimentos em prática e aprender mais coisas sobre o assunto.

### O Git como software de versionamento
Mesmo sendo simples, eu tinha em mente em criar uma ferramenta que me possibilitasse, além de fazer o backup, criar versões de backup que me permitisse variar entre um backup que foi feito semana passada e hoje. Como estou aprendendo a usar o Git e gostei muito da ferramenta, decidi utilizar no projeto.
