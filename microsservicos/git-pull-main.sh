#!/bin/bash

# Exibe uma mensagem que esta baixando a atualização da branch
echo "== Git Pull: baixando atualizações da branch main =="

# Executa o pull da branch main
git pull origin main

# Verifica o status após o pull
echo "== Status Atual do Repositório =="
git status

echo "== Git pull feito! =="
