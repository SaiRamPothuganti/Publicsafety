## import the .par  files into your IntegrationCloud Instance (in package section)

## There are total 8 Integrations which are used in this demo. and  .par file is a single package file which imports all 8 integrations.


Spin-up the Integration Cloud Instance with 1 Message pack 
(please refer : https://www.oracle.com/webfolder/technetwork/tutorials/obe/cloud/ic/ProvisioningFirstInstance/provision-new-instance.html )

## goto integrations -> packages -> click on import (top right) -> select the .par file (download into your local directory)

- Again go back to Connections and Add your Connection Details for your SaiADW Connector with your ADW Credentials (servicename, wallet file , wallet file password, username & password )

- for wionode connector please refer to the image "wionode" and url is https://us.wio.seeed.io/v1/node/  no Security Policy 

- for PS_Trigger connetor , please edit -> test -> save -> close

- when you are done with the above steps, please goto integrations tab and activate all the 8 Integrations
