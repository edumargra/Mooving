#!/bin/bash
set -e
# Script to create a Vue project
#A variable FRONTEND must exit in the working environment and vue must be installed 
if [[ -z "$FRONTEND" ]]; then
    echo "No frontend defined, it won't work..."
    exit 1
fi
echo $FRONTEND
vue create --preset preset_v1.json $FRONTEND
#introduce relaxes rules for lint
#sed -i 's/"rules": {}/"rules": {\n\t\t\t"no-unused-vars": "off",\n\t\t\t"no-multiple-empty-lines": "off"\n\t\t\t}/' $FRONTEND/package.json
#copy frontend source files
\cp -r frontend/bootstrap frontend/src frontend/tests frontend/vue.config.js frontend/public/index.html $FRONTEND
#copy env files
\cp frontend/.env.devops frontend/.env.production frontend/.env.staging frontend/.env.personal $FRONTEND 
#install depencies
cd $FRONTEND
npm config set registry https://registry.npm.taobao.org
npm install --save axios bootstrap-vue vuelidate vue-router flush-promises vue-custom-range-slider vue-browser-geolocation vue2-google-maps
