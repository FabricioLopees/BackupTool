# BackupTool

Uma ferramenta simples que realiza a cópia do diretório raiz (/) ou da home (/home) e salva em um dispositivo com um único comando.

### Características
- Faz uma cópia da pasta /home ou /
- Cria um pacote comprimido desta cópia em tar.gz
- Salva esta cópia no dispositivo ou partição que for de preferência do usuário;

## Como usar

### CONFIGURANDO

#### 1 - Clone o repositório:

```
    git clone https://github.com/FabricioLopees/BackupTool.git
```

#### 2 - Acesse o repositório clonado:

```
    cd BackupTool/
```

#### 3 - Execute o script `start.sh`

```
    ./start.sh
```

#### 4 - Acesse o arquivo para definir o dispositivo para armazenar os backups

```
    vim ~/.backup/backup-device.txt

```

#### 5 - Defina o dispositivo que será usado para salvar os backups

```
    /dev/sdc3
```

**OBS: /dev/sdc3 é apenas um exemplo, descubra qual é o seu dispositivo.**

### FAZENDO BACKUP

Após realizar uma breve configuração citada acima (apenas da primeira vez), basta executar o comando `bkp` com os parâmetros `--home` para copiar a sua /home ou `--rot` para copiar seu diretório raiz. 

```
    bkp --home
```

OU

```
    bkp --root
```
