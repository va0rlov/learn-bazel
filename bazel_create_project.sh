#!/bin/bash

# Проверка наличия аргумента (названия проекта)
if [ -z "$1" ]; then
  echo "Использование: $0 <название_проекта>"
  exit 1
fi

PROJECT_NAME=$1

# Создание директорий
mkdir -p $PROJECT_NAME/src/main/java
mkdir -p $PROJECT_NAME/src/main/resources
mkdir -p $PROJECT_NAME/src/test/java
mkdir -p $PROJECT_NAME/src/test/resources

# Создание файла WORKSPACE
cat <<EOL > $PROJECT_NAME/WORKSPACE
workspace(name = "$PROJECT_NAME")
EOL

# Создание файла BUILD
cat <<EOL > $PROJECT_NAME/BUILD
java_binary(
    name = "Main",
    srcs = glob(["src/main/java/**/*.java"]),
    main_class = "Main",
)
EOL

# Создание примера класса Main
cat <<EOL > $PROJECT_NAME/src/main/java/Main.java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}
EOL

echo "Проект $PROJECT_NAME успешно создан!"

# Переход в директорию проекта
cd $PROJECT_NAME

# Сборка проекта с помощью Bazel
echo "Сборка проекта..."
bazel build //:Main

# Запуск проекта
echo "Запуск проекта $PROJECT_NAME..."
bazel run //:Main

# Возврат в исходную директорию
cd ..

echo "Проект $PROJECT_NAME успешно запущен!"
