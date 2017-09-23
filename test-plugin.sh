#!/bin/bash

rm -rf driver
mkdir -p driver/

cd driver
serverless install --url https://github.com/aafrey/openfaas-nodejs --name faas-func

cd ..

cp -r node_modules driver/faas-func/
cp -r faas driver/faas-func/node_modules/serverless-faas

cd driver/faas-func
#node --inspect-brk=0.0.0.0:9229 /home/austin/.nvm/versions/node/v8.4.0/bin/sls package
serverless init


serverless package
serverless deploy
sleep 10
serverless invoke -f hello-serverless
serverless deploy function -f hello-serverless
serverless deploy list
serverless remove
