#Spustit
1.	Prihláste sa na https://portal.azure.com
2.	Vytvorte vzorový Linux VM:

Menu „New“ -> “Virtual Machines” -> “Ubuntu Server 16.04 LTS”

Deployment Model: Resource Manager

Name = <vase_meno_bez_diakritiky>vm
User name = <vase_meno_bez_diakritiky>
Password = heslo, ktorým sa budete prihlasovat do VM
Resource Group – new: “CLI”

Size -> View All -> F2

Stiahnut script.sh z http://aka.ms/gopas – použiť v:
Settings ->  Extensions -> New Resource For Linux: “Custom Script for Linux” -> Add Extension -> Create -> 

ostatné ponechať predvolené

potvrdiť Ok a následne Create.

3.	Menu “Resource Groups” -> “CLI” -> choose Linux server -> Boot Diagnostics

4.	Menu “Resource Groups” -> “CLI” -> choose Linux server -> mouse over Public IP -> Click to Copy. 

5.	Connect to this IP address using your SSH clinet and authentication information provided in step 2.

6.	Login to Azure CLI: [skrip](cli.sh)

7.	Set the Azure Resource Manager mode : “azure config mode arm”
8.	Edit file /etc/waagent.conf:
a.	change parameter ResourceDisk.Format=n to „y“
b.	change parameter ResourceDisk.SwapSizeMB=0 na „2000“
Restart VM and check swap space using  „free“
Use “df” to see temporary disk attached (/dev/sdb1)  pomocou „df“

9.	Create „backups“ container on storage account of your choice. Insert your AZURE_NAME a AZURE_KEY into blob_backup.sh file and run it. The script creates a local file and copies it into container „backups“


