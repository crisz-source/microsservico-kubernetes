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


# Volumes
- Criar volumes para armazenar dados, para isso, criei uma pasta chamada k8s tanto para os volumes e arquivos do kubernetes
- Para que o volume funcione corretamente com o csi-hostpath-sc, será necessário ativar o csi-hostpath-sc do minikube
```bash
# abrindo as listas de addons
minikube addons list

# ativando o driver
minikube addons enable csi-hostpath-driver
```

# Configuranado o banco de dados
- Criei os volumes e configuerei para que eles possam acessar e armazenar dados com os volumes 
- É necessário configurar o service do statefulsets, para que e aplicação consiga acessar o banco de dados através do serviço. 
- Criei uma secret para armazenar informações do banco e foi utilizado o type Opaque, para que não fique tudo aberto igual os configmap
- com tudo configurado, execute para que as configurações funcione corretamente:
```bash
kubectl apply -f k8s/volumes.yml -f k8s/mysql.yml -f k8s/secrets.yml
```

# Subindo a aplicação
- Foi criado um deployment para subir os serviços e adicionei as imagens armazenadas que estão no meu dockerhub, essas imagens sao publicas.
- Criado um configmap para acessar o eureka, ou seja, uma secret para o banco de dados, e configmap para acessar o eureka
- startando os serviços e instalando a dashboard do minikube
```bash
kubectl apply -f k8s/volumes.yml -f k8s/mysql.yml -f k8s/secrets.yml -f k8s/configmap.yml -f k8s/app.yml -f k8s/loadbalancer.yml

# dashboard
minikube dashboard
```

# Acessando a aplicação
- Configurar as portas dos coitainers para que possa acessar o serviço eureka, que vai mostrar quais serviços estão conseguindo se comunicar
- essa modificação foi feita no dockerfile do server, que seria apenas o EXPOSE 8081 que é a porta da aplicação

# LoadBalancer
- Criei um loadbalancer do próprio minikube para acessar a aplicação eureka
- Nele foi definido, o service, nome do service, as portas que o service vai rodar e a porta do container que o serviço vai encaminhar, selecionando com o selector qual deployment vai utilizar o loadbalancer e o tipo do serviço que é loadbalancer.
- inicinado a aplicação e abrindo um tunel no minikube para ter acesso ao eureka
```bash
kubectl apply -f k8s/volumes.yml -f k8s/mysql.yml -f k8s/secrets.yml -f k8s/configmap.yml -f k8s/app.yml -f k8s/loadbalancer.yml

# abrindo tunel
minikube tunnel --bind-address=xxx.xxx.xxx.x

# o --bind-address=xxxxx precisa ser o ip da sua máquina
```

# Conectando a aplicação com o eureka
- Acesse o eureka com endereço informado no --bind-address=xxx neste endereço: xxx.xxx.xxx.x:8081 
- Note que vai abrir uma interface do eureka e vai conseguir observar o que esta rodando



