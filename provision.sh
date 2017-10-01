#!/usr/bin/env bash

amaConfDir="/etc/amaterasu"
mesosInstalled=`yum list instaled mesos`
marathonInstalled=`yum list instaled marathon`
zookeeperInstalled=`yum list instaled zookeeper`
zookeeperServerInstalled=`yum list instaled zookeeper-server`
internalIp=`python aws_tools.py private_ip master`
noPkg="Error: No matching Packages to list"
origHome=/home/`logname`

echo "Preparing configuration"
if [ ! -f ${amaConfDir}/hosts.bak ]; then
  cp /etc/hosts ${amaConfDir}/hosts.bak
fi
echo "hosts file backed up in ${amaConfDir}/hosts.bak"

if [ ! -f ${amaConfDir}/mesos.bak ]; then
  cp /etc/default/mesos ${amaConfDir}/mesos.bak
fi
echo "Mesos config file backed up in ${amaConfDir}/mesos.bak"

sudo cp ${amaConfDir}/hosts.bak /etc/hosts
echo "Restored hosts file to original state"

sudo cp ${amaConfDir}/mesos.bak /etc/default/mesos
echo "Restored mesos config to original state"

echo "Setting up the hosts file"
echo "${internalIp} node1" >> /etc/hosts

if [ ${mesosInstalled} -eq ${noPkg} ] || [ ${marathonInstalled} -eq ${noPkg} ]; then
  echo "installing mesos and marathon"
  echo "----------------------------"
  rpm -Uvh http://repos.mesosphere.com/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
  yum -y install mesos marathon
else
  echo "mesos and marathon already installed"
fi

echo "IP=${internalIp}" >> /etc/default/mesos
sudo rm -f /etc/mesos/ip
sudo rm -f /etc/mesos-master/hostname
echo "${internalIp}" >> /etc/mesos/ip
echo "${internalIp}" >> /etc/mesos-master/hostname

sudo echo "export LIBPROCESS_IP=${internalIp}" >> ${origHome}/.bashrc
sudo echo "export SPARK_LOCAL_IP=${internalIp}" >> ${origHome}/.bashrc

source ${origHome}/.bashrc
#setting the --no-switch_user flag for mesos slave
sudo chmod 777 -R /etc/mesos-slave/
touch /etc/mesos-slave/?no-switch_user

if [ ${zookeeperInstalled} -eq ${noPkg} ] || [ ${zookeeperServerInstalled} -eq ${noPkg} ]; then
  echo "installing zookeeper"
  echo "--------------------"

  rpm -Uvh http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
  yum -y install zookeeper zookeeper-server
else
  echo "zookeeper and zookeeper-server already installed"
fi

sudo -u zookeeper zookeeper-server-initialize --myid=1
service zookeeper-server start

echo "Starting mesos"
echo "--------------"

service mesos-master start
service mesos-slave start
