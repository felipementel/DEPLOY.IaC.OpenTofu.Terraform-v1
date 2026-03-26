![banner](./docs/banner.png)

# DEPLOY.IaC.OpenTofu.Terraform-v1

Infraestrutura como código (IaC) para provisionamento de recursos no Azure utilizando OpenTofu/Terraform.

## Links úteis

- [Tipos](https://developer.hashicorp.com/terraform/language/expressions/types)
- [Providers](https://registry.terraform.io/)

## Pré-requisitos

- [OpenTofu](https://opentofu.org/) >= 1.11.1
- Azure CLI
- Service Principal com permissão de Contributor

## Configuração do Service Principal

```bash
az ad sp create-for-rbac \
  --role="Contributor" \
  --scopes="/subscriptions/<SUBSCRIPTION_ID>" \
  --display-name OpenTofu-CanalDEPLOY-v1
```

O seu retorno sera bem proximo a esse JSON:

```json
{
  "appId": "43866c19-9b21-42342-3123-fiuwf",
  "displayName": "OpenTofu-CanalDEPLOY-v1",
  "password": "bay8Q!.dedwed",
  "tenant": "5ec0b457-334c-3434-545345-31231"
}
```

O comando retorna um JSON com as credenciais. Copie os valores para o arquivo `src/credentials/azure.tfvars`:

| Campo JSON     | Variável no tfvars    |
|----------------|-----------------------|
| `appId`        | `arm_client_id`       |
| `password`     | `arm_client_secret`   |
| `tenant`       | `arm_tenant_id`       |
| `subscription` | `arm_subscription_id` |

## Comandos

### Inicializar

```powershell
tofu init
```

### Formatar

```powershell
tofu -chdir="." fmt -recursive
```

### Validar

```powershell
tofu validate
```

### Planejar

```powershell
tofu plan `
  -var-file="credentials/azure.tfvars" `
  -var-file="credentials/github.tfvars" `
  -var-file="environments/dev/dev.tfvars"
```

### Aplicar

```powershell
tofu apply `
  -var-file="credentials/azure.tfvars" `
  -var-file="credentials/github.tfvars" `
  -var-file="environments/dev/dev.tfvars" `
  -auto-approve
```

## Estrutura do projeto

```
src/
├── main.tf                  # Providers, locals e módulos
├── variables.tf             # Variáveis globais
├── outputs.tf               # Outputs globais
├── credentials/             # Arquivos de credenciais (não versionados)
│   ├── azure.tfvars
│   └── github.tfvars
├── environments/            # Variáveis por ambiente
│   └── dev/
│       └── dev.tfvars
└── modules/                 # Módulos reutilizáveis
    └── resource_group/
```
