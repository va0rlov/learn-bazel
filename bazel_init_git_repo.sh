#!/bin/bash

# Проверка наличия аргумента (URL удаленного репозитория)
if [ -z "$1" ]; then
  echo "Использование: $0 <URL_удаленного_репозитория>"
  exit 1
fi

REMOTE_URL=$1

# Инициализация Git-репозитория
echo "Инициализация Git-репозитория..."
git init

# Создание .gitignore
echo "Создание .gitignore..."
cat <<EOL > .gitignore
# Bazel
bazel-*/

# IDEs
.idea/
*.iml
*.ipr
*.iws

# OS
.DS_Store
EOL

# Добавление файлов в Git
echo "Добавление файлов в Git..."
git add .

# Создание коммита
echo "Создание коммита 'initial commit'..."
git commit -m "initial commit"

# Добавление удаленного репозитория
echo "Добавление удаленного репозитория $REMOTE_URL..."
git remote add origin $REMOTE_URL

# Пуш в удаленный репозиторий
echo "Пуш в удаленный репозиторий..."
git push -u origin master

echo "Git-репозиторий успешно инициализирован и запушен в $REMOTE_URL!"
