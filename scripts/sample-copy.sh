#!/usr/bin/env bash

set -euo pipefail

mkdir -p /home/user1/vagrant/conf
mkdir -p /home/user1/vagrant/scripts

cp -r /vagrant/conf /home/user1/vagrant/
cp -r /vagrant/scripts /home/user1/vagrant/

chown -R user1:user1 /home/user1/vagrant
echo "### 샘플 예제 복사"
