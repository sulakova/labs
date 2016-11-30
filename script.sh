#!/bin/sh
sudo apt-get update
sudo apt-get install cifs-utils npm nodejs -y
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo npm install azure-cli -g

sudo mkdir /mnt/cifs
sudo mount -t cifs //gopas.file.core.windows.net/gopasshare /mnt/cifs -o vers=3.0,username=gopas,password=b5TbhKJYk6lnisoI3+oCH5oVddXMnkap2lV3QsJfoXyLtmmTq88sACxb+v7W8VZp/BRaVPbOYmq9NSgj8D2RUg==,dir_mode=0777,file_mode=0777
cp /mnt/cifs/* /home/*/