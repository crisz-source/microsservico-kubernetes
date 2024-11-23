#!/bin/bash

# Pega a data atual
CURRENT_DATE=$(date +"%d/%m/%Y %H:%M:%S")

# Exibe o status do Git
echo "== Git Status =="
git status
sleep 3

# Adiciona todos os arquivos alterados
echo "== Git Add =="
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
