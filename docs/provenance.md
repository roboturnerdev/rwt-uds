# Excalidraw artifact provenance

## Package release

- UDS package version: `0.18.1-uds.0`
- Upstream application version: `v0.18.1`
- Upstream repository: `https://github.com/excalidraw/excalidraw`
- Upstream source commit: `a2ec2889babf7d2295469c6d90ebe77fae57df84`
- Package image: `ghcr.io/roboturnerdev/excalidraw:0.18.1-upstream.0`

## Build process

The image is built from the exact upstream `v0.18.1` Git tag.

```bash
git clone https://github.com/excalidraw/excalidraw.git
git checkout a2ec2889babf7d2295469c6d90ebe77fae57df84
git rev-parse HEAD

docker build \
  --label org.opencontainers.image.source=https://github.com/excalidraw/excalidraw \
  --label org.opencontainers.image.version=0.18.1 \
  --label org.opencontainers.image.revision=a2ec2889babf7d2295469c6d90ebe77fae57df84 \
  --tag ghcr.io/roboturnerdev/excalidraw:0.18.1-upstream.0 \
  .