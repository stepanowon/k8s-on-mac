#!/usr/bin/env bash

set -euo pipefail

# 방화벽 끄기
ufw disable

# 업데이트
apt update
#apt upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade

# swap off 및 재부팅시에도 swap을 off하도록 서비스로 등록
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

cat <<EOF | sudo tee /etc/rc.local
#!/bin/bash
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
exit 0
EOF

chmod +x /etc/rc.local

echo -e "[Install]" >> /lib/systemd/system/rc-local.service
echo -e "WantedBy=multi-user.target" >> /lib/systemd/system/rc-local.service

systemctl enable rc-local.service
systemctl start rc-local.service

# 시간서버 설정
apt-get install ntp -y
systemctl restart ntp

netplan apply

echo "### 기본 설정 완료 - default-config.sh "