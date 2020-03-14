# wanko.cc

## Setup
```sh
yarn install
```

## Develop
```
yarn run develop
```

## Deploy
```sh
yarn run cleean && yarn run build && aws s3 sync --delete public/ s3://wanko-cc/
```
