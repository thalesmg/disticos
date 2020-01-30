% Dhall para Kubernetes
% Thales Macedo Garitezi
% 2020-01-29


# Rascunho

https://christine.website/blog/dhall-kubernetes-2020-01-25

# Problema

# Dhall em Produção

[Acessado em 2020-01-29](https://docs.dhall-lang.org/discussions/Dhall-in-production.html)

- Advanced Telematic Systems GmbH
- AlasConnect
- Awake Security
- Cachix
- CircuitHub
- Coralogix

##

- Earnest Research
- Formation
- IOHK
- Kos Media, LLC
- KSF Media
- Mira Networks
- NoRedInk

# Dhall

- Modularidade.
- Evita repetições.
- Não tem efeitos arbitrários.

## Modularidade

```{.dhall}
let mkDeployment
    : Dados → kubernetes.Deployment.Type
    =   λ(dados : Dados)
      → kubernetes.Deployment::{ ... }
```

### Parâmetros para o manifesto

```{.dhall}
-- dadosProd.dhall

{ env = "prod"
, replicas = 2
, app = "bifrost"
, image = env:CI_REGISTRY_IMAGE as Text
, version = env:CI_COMMIT_REF_NAME as Text
, mixEnv = "prod"
, address = "bifrost-prod.saopaulo.kube.xerpa.com.br"
}

-- dadosStaging.dhall tem a mesma estrutura
```

### Produzindo manifestos

```{.shell}
dhall-to-yaml <<< './mkDeployment.dhall ./dadosProd.dhall'
dhall-to-yaml <<< './mkDeployment.dhall ./dadosStaging.dhall'
```

## Evitando repetições

```{.dhall .number-lines}
let envKeys = ["prod-bifrost-database", ...]

let mkSecretRef
    : Text → kubernetes.EnvFromSource.Type
    =   λ(envKey : Text)
      → kubernetes.EnvFromSource::{
        , secretRef =
            { name =
                Some
                  "${dados.env}-${dados.app}-${envKey}"
            , optional = Some False
            }
        }
```

###

```{.dhall .number-lines}
in  List/map
      Text
      kubernetes.EnvFromSource.Type
      mkSecretRef
      envKeys
```

### Resultado

```{.yaml .number-lines}
envFrom:
- secretRef:
    name: "prod-bifrost-database"
    optional: false
- secretRef:
    name: "prod-bifrost-rabbitmq"
    optional: false
- secretRef:
    name: "prod-bifrost-appsignal"
    optional: false
- secretRef:
    name: "prod-bifrost-logstash"
    optional: false
- secretRef:
    name: "prod-bifrost-firebase"
    optional: false
- secretRef:
    name: "prod-bifrost-fitbank"
    optional: false
- secretRef:
    name: "prod-bifrost-env"
    optional: false
- secretRef:
    name: "prod-bifrost-btg"
    optional: false
```

# Alternativas

- [CUE](https://github.com/cuelang/cue/blob/master/doc/tutorial/kubernetes/README.md)
  - Não tem os schemas prontos: precisa fazer manualmente.
- [Helm](https://helm.sh/)
  - Pressupõe que seu template ou `values.yml` esteja correto.
- [Kustomize](https://kustomize.io/)
  - Faz substituições _type safe_ de variáveis, mas não garante que o
    manifesto resultante é válido.
- [Kubeval](https://kubeval.instrumenta.dev/)
  - Valida o schema e os tipos das chaves, mas não permite que sejam
    criados _templating_.
- [Jsonnet](https://jsonnet.org/), [ytt](https://get-ytt.io/)
  - Apenas templating, sem validação.

##

Usar uma combinação de Kustomize + Kubeval ?

##

Nenhuma das alternativas permite modularidade / uso de funções para
não nos repetirmos.
