# Oracle Designer Toolkit Terraform Script
This is a terraform script in order to provision Oracle Designer Toolkit using freetier resources on Oracle Cloud Infrastructure.

## Oracle Designer Toolkit
Oracle Designer Toolkit can be download directly from https://github.com/oracle/oci-designer-toolkit.

## Deploy
This script was made to be used on OCI Resource Manager.
Just create a new stack on desire compartment and upload zip file and apply code.
This script takes a few minutes to create the network and compute instance. The application will be installed during the first boot.
After apply job finishes the application deployment will take a few more minutes.

## Following App Deployment
If you would like to follow all Okit deployment process, just access connect to instance using your ssh private key and user opc and execute the following script:

````
sudo su -
tail -20000f /var/log/messages | grep cloud-init
````
