# Defense Unicorns UDS Test

## Demo

- demo went fine
  - custom user in task file easy to understand (edit bash script, zarf variables, sensitive values)
  - keycloak group, sso to Grafana and keycloak admin with mfa worked one shot
  - sso to podinfo wowee
  - great out of the box experience, clear config areas, excellent documentation

## Excalidraw Test

- want to add my own uds package
  - put podinfo-demo away in a folder
- zarf yaml schema vs maru yaml schema
- uds package requirements (DU engineer mandatory)
- used package template and replace/renamed things
- create local excalidraw chart (no upstream)
  - `mkdir -p charts && cd charts && helm create excalidraw`
- replace templates everywhere
- 


### Build

uds run create

### Deploy

uds run deploy

### Test

uds run test