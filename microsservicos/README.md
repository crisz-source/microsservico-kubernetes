# Preparando os microsservicos feitos em java para containers
- Criando um Dockerfile, e nesse Dockerfile possui uma imagem base do java 17
- Com o Dockerfile criado, adicionei configurações básicas para o funcionamento do projeto dentro do container
- No Dockerfile, tem uma imagem que é apenas a compilação do projeto, pois quando compila não vai precisar mais do maven, apenas no java.
- Depois da configuração feita em todas as pastas que necessitam da criação das imagens, fiz uma build e adicionei ao meu docker hub de cada uma delas
- Entre no diretório microsservicos e execute:
```bash
# pasta gateway
docker build -t crisdockerz/java-gateway-microsservico:v1 gateway/. #build
docker push crisdockerz/java-gateway-microsservico:v1  # adicionando ao dockerhub



#pasta pagamentos
docker build -t crisdockerz/java-pagamentos-microsservico:v1 pagamentos/. 
docker push crisdockerz/java-pagamentos-microsservico:v1  


#pasta pedidos
docker build -t crisdockerz/java-pedidos-microsservico:v1 pedidos/. 
docker push crisdockerz/java-pedidos-microsservico:v1  


# pasta server
docker build -t crisdockerz/java-server-microsservico:v1 server/. 
docker push crisdockerz/java-server-microsservico:v1  
``` 
- Criei uma shell script para que eu possa commitar, pull da branch de forma automatica e não manual.
- shell para o commit,l comando para executar: ./git-commit-push.sh
- Permissão: **sudo chmod 777 git-commit-push.sh**

```bash
#!/bin/bash

# Pega a data atual
CURRENT_DATE=$(date +"%d/%m/%Y %H:%M:%S")

# Exibe o status do Git
echo "== Git Status =="
git status
sleep 3

# Adiciona todos os arquivos alterados
echo "== Git Add . =="
git add .
sleep 3

# Cria o commit com a data atual como mensagem
echo "== Git Commit =="
git commit -m "$CURRENT_DATE"
sleep 3

# Realiza o push para o branch principal (main)
echo "== Git Push =="
git push origin main
sleep 3 

echo "== Git completo =="


```
- shell para o git pull, ./git-pull-main.sh
- Permissão: **sudo chmod 777 git-pull-main.sh**

```bash
#!/bin/bash

# Exibe uma mensagem que esta baixando a atualização da branch
echo "== Git Pull: baixando atualizações da branch main =="

# Executa o pull da branch main
git pull origin main
sleep 3 

# Verifica o status após o pull
echo "== Status Atual do Repositório =="
git status
sleep 3 

echo "== Git pull feito! =="
```


# Configuranado o banco de dados... em construção
