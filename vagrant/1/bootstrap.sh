#!/usr/bin/env bash

cp /vagrant/data/sources.list /etc/apt

apt-get update

sudo apt-get install -y openjdk-7-jdk gate

rm -rf /home/vagrant/.ssh
mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chown -R vagrant.vagrant /home/vagrant/.ssh
cat /vagrant/data/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
