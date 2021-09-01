# B7.4 Практикум

## Terraform

Для начала нужно получить список доступных публичных образов, записать ID нужного образа
```shell
$ yc compute image list --folder-id standard-images 
```

Инициализировать terraform, access_key и secret_key указываются 1 раз при инициализации
```shell
$ terraform init -backend-config="access_key={access_key}" -backend-config="secret_key={secret_key}"
```

Запуск terraform
```shell
$ terraform plan
$ terraform apply
```

Удаление terraform
```shell
$ terraform destroy
```

## Kubectl

На обеих машинах логинимся под root

```shell
$ sudo su -
```

На обеих машинах выключаем файрволл

```shell
$ ufw disable
```

На обеих машинах выключаем swap

```shell
$ swapoff -a; sed -i '/swap/d' /etc/fstab
```

На обеих машинах обновляем настройки sysctl для работы куба

```shell
$ cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
$ sysctl --system
```

На обеих машинах устанавливаем Docker

```shell
$ apt install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
$ add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ apt update
$ apt install -y docker-ce=5:19.03.10~3-0~ubuntu-focal containerd.io
```

На обеих машинах устанавливаем Куб

```shell
$ curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
$ echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
$ apt update && apt install -y kubeadm=1.18.5-00 kubelet=1.18.5-00 kubectl=1.18.5-00
```

Инициализируем мастер ноду, указываем ваш внутренний IP

```shell
$ kubeadm init --apiserver-advertise-address=172.16.16.100 --pod-network-cidr=192.168.0.0/16  --ignore-preflight-errors=all
$ kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f https://docs.projectcalico.org/v3.14/manifests/calico.yaml
```

Получаем команду для подключения к мастер ноде, исполняем её на воркер ноде (второй машине)

```shell
$ kubeadm token create --print-join-command
```

## Kubernetes dashboard

На мастер ноде выполняем

```shell
$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml
```


Редактируем конфиг сервиса kubernetes-dashboard и изменить тип с ClusterIP на LoadBalancer, для яндекс облака обязательно нужно указать внешний IP, иначе зайти в панель не получится

```shell
$ kubectl -n kubernetes-dashboard edit svc kubernetes-dashboard
```

```
spec:
  type: LoadBalancer
  externalIPs:
  - 192.168.0.10
```

Подключиться к панели можно двумя способами:

1. Используя Kubeconfig
2. Через токен

Генерируем токен:

```shell
$ kubectl create serviceaccount dashboard -n default # создаем сервисный аккаунт
$ kubectl create clusterrolebinding dashboard-admin -n default  --clusterrole=cluster-admin  --serviceaccount=default:dashboard # выдаем права
$ kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode # получаем ключ
```

Копируем ключ, открываем в браузере ссылку:

https://178.154.203.34:30722/