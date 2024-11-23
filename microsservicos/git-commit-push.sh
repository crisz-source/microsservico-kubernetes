#!/bin/bash

# Pega a data atual
CURRENT_DATE=$(date +"%d/%m/%Y %H:%M:%S")

# Exibe o status do Git
echo "== Git Status =="
git status

# Adiciona todos os arquivos alterados
echo "== Git Add =="
git add .

# Cria o commit com a data atual como mensagem
echo "== Git Commit =="
git commit -m "$CURRENT_DATE"

# Realiza o push para o branch principal (main)
echo "== Git Push =="
git push origin main

echo "== Git completo =="
