#!/usr/bin/env bash

echo "Setting up the hosts file"
echo "192.168.33.10 node1" >> /etc/hosts

echo "installin mesos and marathon"
echo "----------------------------"

rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
yum -y install mesos marathon
echo "IP=192.168.33.10" >> /etc/default/mesos

echo "installing zookeeper"
echo "--------------------"

rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
yum -y install zookeeper zookeeper-server

sudo -u zookeeper zookeeper-server-initialize --myid=1
service zookeeper-server start

echo "Starting mesos"
echo "--------------"

service mesos-master start
service mesos-slave start