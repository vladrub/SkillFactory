## Install docker

```
cd docker
ansible-playbook playbook.yml -l localhost
```

## Install mysql

```
cd mysql
ansible-playbook playbook.yml -l localhost
```

## Run nginx

```
cd container1
ansible-playbook playbook.yml -l localhost
```

## Run create user

```
cd user
ssh-keygen
ansible-vault encrypt --ask-vault-pass id_rsa.pub
ansible-playbook --ask-vault-pass playbook.yml -l remote
```

## Postfix

```
cd postfix
ansible-playbook playbook.yml --tags init -l remote # Установка
ansible-playbook playbook.yml --tags drop -l remote # Удаление
```