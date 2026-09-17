#!/bin/bash

set -e

dnf update -y

dnf install -y git

curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -

dnf install -y nodejs

mkdir -p /opt/technova

cd /opt/technova

git clone https://github.com/grazykkj/unifaat-devops-portfolio

cd /opt/technova/unifaat-devops-portfolio/aula-02

npm install

nohup npm start > /var/log/technova-api.log 2>&1 &
