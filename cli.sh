export GRP="openslavaCLI"
export LOC="northeurope"
azure group create -n $GRP -l $LOC

export STORAGE1="osstandard"$RANDOM
azure storage account create -g $GRP -l $LOC --sku-name LRS  $STORAGE1 --kind Storage

export IPNAME="pubip1"
#azure network public-ip create -g $GRP -n $IPNAME -l $LOC --domain-name-label "alargowslb" -a static -i 4
azure network public-ip create -g $GRP -n $IPNAME -l $LOC -a static -i 4
export LBNAME="oslb"
azure network lb create -g $GRP $LBNAME $LOC
azure network lb frontend-ip create -g $GRP $LBNAME "Frontendpool" -i $IPNAME 
export BACKENDPOOL=`azure network lb address-pool create -g $GRP $LBNAME "Backendpool" --json | python3 -c "import sys, json; print(json.load(sys.stdin)['id'])"`
export NAT1=`azure network lb inbound-nat-rule create -g $GRP --lb-name $LBNAME --name sshadb1 --protocol TCP --frontend-port 45223 --backend-port 22 --json | python3 -c "import sys, json; print(json.load(sys.stdin)['id'])"`
export NAT2=`azure network lb inbound-nat-rule create -g $GRP --lb-name $LBNAME --name sshadb2 --protocol TCP --frontend-port 45224 --backend-port 22 --json | python3 -c "import sys, json; print(json.load(sys.stdin)['id'])"`
echo NAT2-----------------------  $NAT2

export VNET="osvnet"
export SUBNET="ossubnet"
azure network vnet create $GRP $VNET -l $LOC -a 10.1.0.0/16
azure network vnet subnet create $GRP $VNET $SUBNET -a 10.1.1.0/24
export NIC1="nic1-db"
export NIC2="nic2-db"
azure network nic create -g $GRP -n $NIC1 --private-ip-address 10.1.1.4 --subnet-name $SUBNET --subnet-vnet-name $VNET -l $LOC --lb-address-pool-ids $BACKENDPOOL --lb-inbound-nat-rule-ids $NAT1
azure network nic create -g $GRP -n $NIC2 --private-ip-address 10.1.1.5 --subnet-name $SUBNET --subnet-vnet-name $VNET -l $LOC --lb-address-pool-ids $BACKENDPOOL --lb-inbound-nat-rule-ids $NAT2
export NSGNAME="NSG-FrontEnd"
azure network nsg create -g $GRP -l $LOC -n $NSGNAME
azure network nsg rule create -g $GRP -a $NSGNAME -n "ssh" -c Allow -p Tcp -r Inbound -y 100 -f Internet -o 22 -e VirtualNetwork -u 22
azure network nsg rule create -g $GRP -a $NSGNAME -n "http" -c Allow -p Tcp -r Inbound -y 110 -f Internet -o 80 -e VirtualNetwork -u 22
azure network vnet subnet set -g $GRP -e $VNET -n $SUBNET -o $NSGNAME

export AVAILSETNAME="haset1"
azure availset create $GRP $AVAILSETNAME $LOC

export VM1="db1"
export VM2="db2"
azure vm create -g $GRP -n $VM1 -l $LOC --vnet-name $VNET --vnet-subnet-name $SUBNET --nic-name $NIC1 --storage-account-name $STORAGE1 --os-type Linux  --vm-size Standard_D1_v2  -Q Debian -u azureuser --availset-name $AVAILSETNAME --admin-password nsua83#s02S
azure vm create -g $GRP -n $VM2 -l $LOC --vnet-name $VNET --vnet-subnet-name $SUBNET --nic-name $NIC2 --storage-account-name $STORAGE1 --os-type Linux  --vm-size Standard_D1_v2  -Q Debian -u azureuser --availset-name $AVAILSETNAME --admin-password nsua83#s02S
azure vm disk attach-new --host-caching None $GRP $VM1 100 161013_disk1.vhdx

azure network lb rule create $GRP $LBNAME "lbrulehttp" -p tcp -f 80 -b 80 -t "Frontendpool" -o "Backendpool"
azure network lb probe create -g $GRP  -l $LBNAME -n "healthprobehttp" -p "http" -o 80 -f / -i 15 -c 4
azure network lb show $GRP $LBNAME

