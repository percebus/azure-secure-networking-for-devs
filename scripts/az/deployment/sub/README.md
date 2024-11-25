# azure-secure-networking-for-devs

## scripts

### Setup

#### env

[Check `env/README.md`](../../../../env/README.md) for setting up the environment.

#### bicep

```bash
$> az bicep install
```

For context and additional information, [check `bicep/README.md`](../../../../bicep/README.md) for setting `bicep`.

### az deployment sub

These scripts are meant to Create, Show and Delete deployments at the subscription level.

```bash
$> bash scripts/az/deployment/sub/(create|show|delete).sh {deployment-name} ({bicep-folder})
```

#### Create

```bash
$> bash scripts/az/deployment/sub/create.sh {deployment-name} {bicep-folder}
```

i.e.

```bash
$> bash scripts/az/deployment/sub/create.sh azure-secure-networking-for-devs-module01 bicep/01
```

<!-- prettier-ignore-start -->
> [!IMPORTANT]
> `DRY_RUN` makes it run `what-if` instead of `create`
<!-- prettier-ignore-end -->

#### Show

```bash
$> bash scripts/az/deployment/sub/show.sh {deployment-name}
```

i.e.

```bash
$> bash scripts/az/deployment/sub/show.sh azure-secure-networking-for-devs-module01
```

#### Delete

```bash
$> bash scripts/az/deployment/sub/delete.sh {deployment-name}
```

i.e.

```bash
$> bash scripts/az/deployment/sub/delete.sh azure-secure-networking-for-devs-module01
```

## Resources

- [az deployment](https://learn.microsoft.com/en-us/cli/azure/deployment?view=azure-cli-latest)
- [az deployment sub](https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest#az-deployment-sub)
