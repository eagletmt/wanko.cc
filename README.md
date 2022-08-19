# wanko.cc

## Setup
Install Zola.
https://www.getzola.org/

## Develop
```
% zola serve
```

## Deploy
```sh
% zola build
% aws s3 sync --delete public/ s3://wanko-cc/
% aws cloudfront create-invalidation --distribution-id E3A3CSEHUOVIZZ --paths '/*'
```
