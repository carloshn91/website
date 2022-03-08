<h1 align="center">Olá :D</h1>

## Instalação

```sh
cd infrastructure/terraform ; terraform init
```

## Aplicando

```sh
cd infrastructure/terraform ; terraform apply --auto-approve
```

## Adicionando contexto do cluster criado

```bash
aws eks --region us-east-1 update-kubeconfig --name test-k8s
```
