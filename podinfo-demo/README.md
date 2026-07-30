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
- build basic excalidraw helm chart
  - pepr enforcing securitycontext
    - add temporary writable fs for nginx
    - working mvp helm chart for excalidraw
- now uds package config chart
  - flush out "application" style helm chart to wrap config
  - separates app chart from uds package config
- components and flavor distinction
  - only.flavor restricts
  - if component has no flavor it is always included
  - use flavor to label a meaningful distribution
  - example if there is a specific hardened version once securityContext is working fully
- `uds run dev`
  - the bundle creates the `.tar.zst` with chart version information, but the tool looks for it without that name
  - had to change bundle name to `chart-version-uds-bundle-version-flavorname`
- the zarf management of the package wraps plenty of health checking, config validation, logging, and QoL much desired.
- the istio image wasnt present so i reran the uds run default to restore cluster state
- verbose logging, clear errors
- package produced a bad state where image tag wasnt available in the local registry

## Notes

- Zarf
  - packages and transports software
- UDS Package
  - workload integration with UDS Core platform
- UDS Core
  - shared platform services
  - owns Istio, Ambient Mesh / mTLS, Keycloak, Authservice, UDS Operator, Prom, Grafana, Loki, Pepr, Runtime Security, Backups (Velero), Portal
- UDS Bundle
  - combine packages and environment config

- the `chart/` dir is what makes this excalidraw a UDS Package
  - expose this service through the gateway
  - apply SSO (authservice layer since no native OIDC)
  - network policies
  - monitoring with grafana and prometheus


### Day 2 Fixes

- make these aligned:
  - source release
    - `zarf.yaml`
      - match Github release tag to digest
      - complete UDS/Zarf package release
  - container image
    - digest based instead of latest
    - `zarf.yaml` components.images
    - `charts/excalidraw/values.yaml` image.repository + image.digest
  - helm app version
    - `charts/excalidraw/Chart.yaml`
      - match appVersion to Github relase tag not digest
  - uds package version
    - `bundle/uds-bundle.yaml` packages.ref
    - `0.18.1-uds.0-upstream` <appVersion>-<uds-version>-<flavor>
- provenance.md
  - describe artifact source
  - describe build process
- align `bundle/uds-bundle.yaml` version
  - 3 version concepts: bundle version, package reference, runner task name
  - bundle file says ref 0.18.1-uds.0-upstream
    - `metadata.version: dev` version of the bundle artifact itself
      - names the output `uds-bundle-excalidraw-test-amd64-dev.tar.zst`
    - `packages.ref: 0.18.1-uds.0-upstream` tell UDS which Zarf package to put inside the bundle
      - `zarf-package-excalidraw-amd64-0.18.0-uds.0-upstream.tar.zst`
  - UDS Common workflow uses dev the main dev branch represent an unreleased build
    - actual release version is declared in `releaser.yaml`
      - `releaser.yaml` flavors.version <version>-uds.0
      - development source uses dev, release process uses real version
      - UDS Common tasks are designed around this model
      - bundle packages.ref must point to a package that exists
      - use dev everywhere (package bundle and ref) if using the full release pipeline
      - if i add excalidraw package to a bundle for a customer, the bundle has a separate version unique to the customer (i.e 1.0.0), and the package within can still version excalidraw at (0.18.1-uds.0)
- sbom gen
  - `uds zarf package inspect sbom "$PACKAGE" --output .artifacts/sbom`

#### Todo's

- make a hardened flavor able to run in security context
  - non-root, read-only root fs, drop all cap, no privilege escalation, unprivileged high port for http web server
  - build custom image
    - `node:22-alpine@sha256<digest>` find one of these
    - 101:101
    - create non-root nginx config
      - listen on high port (8080 or something)
    - test locally and inspect, try exec
  - publish and pin hardened digest image
  - update helm chart service targetPort
  - update UDS config values
  - restore securityContext configurations everywhere
  - add a flavor to the roof zarf
  - compare both zarf packages via inspect and validate images and config
- helm template required fields for error handling
  - uds config chart
- document SSO disablement
- document network changes
  - default allow list is for a static frontend with no egress
  - package can be extended for dependencies based on `additionalNetworkAllow`
  - and what adding it means
-


### Commands

```bash
# no cluster
uds run default

# existing cluster
uds run dev

# extra useful commands

uds zarf package list

uds zarf package remove [name]

# keycloak make a user
uds zarf connect keycloak

# retrieve admin password from k8s secret
# change to uds realm
# add doug to UDS Core/Admin
# login to excalidraw.uds.dev

```