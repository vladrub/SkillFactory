# 7 Практическая работа

Копируем конфиги на мастер ноду и выполняем команды

```shell
$ kubectl create -f service.yml
$ kubectl create -f deployment.yaml
```

Если после выполнения команд появляется ошибка `namespaces nginx not found` создаем namespace:

```shell
$ kubectl create ns nginx
```