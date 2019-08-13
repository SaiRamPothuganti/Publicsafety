#!/bin/bash

# Original source: https://gist.github.com/recursivecodes/9d4c3ae2e176933cb2a99dbbf25c34b4
# Details of how to set up a tenancy to run FaaS: https://blogs.oracle.com/developers/oracle-functions:-serverless-on-oracle-cloud-developers-guide-to-getting-started-quickly

# This script requires a lot of careful watching to make sure it actually runs properly.
# Don't expect the subnet creation process to go right the first time; you'll
# most likely have to go create the subnets, internet gateway, and security
# lists by hand in the console.

# set variables
OCI_FN_TENANCY=orasenatdpltintegration01
OCI_FN_HOME_REGION=us-ashburn-1
OCI_FN_FN_REGION=us-phoenix-1
OCI_FN_USER_NAME=Burlington-faas-user
OCI_FN_GROUP_NAME=Burlington-faas-group
OCI_FN_COMPARTMENT_NAME=BurlingtonHub:BurlingtonFaaS
OCI_FN_POLICY_NAME=Burlington-faas-policy
OCI_FN_VCN_NAME=Burlington-faas-vcn
OCI_FN_VCN_CIDR_BLOCK=10.0.0.0/16
OCI_FN_SUBNET_1_NAME=faas-subnet-1
OCI_FN_SUBNET_2_NAME=faas-subnet-2
OCI_FN_SUBNET_3_NAME=faas-subnet-3
OCI_FN_SUBNET_1_AD=UWQV:PHX-AD-1
OCI_FN_SUBNET_2_AD=UWQV:PHX-AD-2
OCI_FN_SUBNET_3_AD=UWQV:PHX-AD-3
OCI_FN_VCN_SUBNET_1_CIDR_BLOCK=10.0.1.0/24
OCI_FN_VCN_SUBNET_2_CIDR_BLOCK=10.0.2.0/24
OCI_FN_VCN_SUBNET_3_CIDR_BLOCK=10.0.3.0/24
OCI_FN_INTERNET_GATEWAY_NAME=Burlington-faas-IG

# create compartment:
#OCI_FN_COMPARTMENT_ID=$(oci iam compartment create --name ${OCI_FN_COMPARTMENT_NAME} --description "Compartment to demo FaaS for Public Safety 2.0 - Burlington" --region ${OCI_FN_HOME_REGION} --query "data.id" --raw-output)
OCI_FN_COMPARTMENT_ID='ocid1.compartment.oc1..aaaaaaaahjxjfscmmatqr6bqcmc6lgcfjowiupkdubtchs4wc5murelwfc6q'
echo Created compartment ${OCI_FN_COMPARTMENT_NAME} with ID ${OCI_FN_COMPARTMENT_ID}

# create group
OCI_FN_GROUP_ID=$(oci iam group create --name ${OCI_FN_GROUP_NAME} --description "A group for Burlington FaaS users" --region ${OCI_FN_HOME_REGION} --query "data.id" --raw-output)
echo Created group ${OCI_FN_GROUP_NAME} with ID ${OCI_FN_GROUP_ID}

# create user:
OCI_FN_USER_ID=$(oci iam user create --name ${OCI_FN_USER_NAME} --description "A Burlington user for the FaaS service" --region ${OCI_FN_HOME_REGION} --query "data.id" --raw-output)
echo Created user ${OCI_FN_USER_NAME} with ID ${OCI_FN_USER_ID}

# create user auth token (for docker login):
OCI_FN_USER_AUTH_TOKEN=$(oci iam auth-token create --user-id ${OCI_FN_USER_ID} --description "auth token for ${OCI_FN_USER_NAME}" --region ${OCI_FN_HOME_REGION} --query "data.token" --raw-output)
echo Created Auth Token.  Remember this token, it can not be retrieved in the future: "${OCI_FN_USER_AUTH_TOKEN}"

# add user to group:
OCI_FN_USER_GROUP_ID=$(oci iam group add-user --group-id ${OCI_FN_GROUP_ID} --user-id ${OCI_FN_USER_ID} --region ${OCI_FN_HOME_REGION} --raw-output --query "data.id")
echo Added user ${OCI_FN_USER_NAME} to group ${OCI_FN_GROUP_NAME}

# create group policy:
STATEMENTS="[\"Allow group "${OCI_FN_GROUP_NAME}" to manage repos in tenancy\", \"Allow service FaaS to read repos in tenancy\", \"Allow group "${OCI_FN_GROUP_NAME}" to manage functions-family in compartment "${OCI_FN_COMPARTMENT_NAME}"\", \"Allow group "${OCI_FN_GROUP_NAME}" to manage vnics in compartment "${OCI_FN_COMPARTMENT_NAME}"\", \"Allow group "${OCI_FN_GROUP_NAME}" to inspect subnets in compartment "${OCI_FN_COMPARTMENT_NAME}"\", \"Allow service FaaS to use virtual-network-family in compartment "${OCI_FN_COMPARTMENT_NAME}"\"]"

# If you have to create the policy by hand, here's what it should say:
# 
# Allow group Burlington-faas-group to manage repos in tenancy
# Allow service FaaS to read repos in tenancy
# Allow group Burlington-faas-group to manage functions-family in compartment BurlingtonHub:BurlingtonFaaS
# Allow group Burlington-faas-group to manage vnics in compartment BurlingtonHub:BurlingtonFaaS
# Allow group Burlington-faas-group to inspect subnets in compartment BurlingtonHub:BurlingtonFaaS
# Allow service FaaS to use virtual-network-family in compartment BurlingtonHub:BurlingtonFaaS

echo $STATEMENTS > statements.json
OCI_FN_POLICY_ID=$(oci iam policy create --name ${OCI_FN_POLICY_NAME} --description "A policy for the group ${OCI_FN_GROUP_NAME}" --statements file://`pwd`/statements.json --region ${OCI_FN_HOME_REGION} --raw-output --query "data.id" --wait-for-state ACTIVE --wait-interval-seconds 3)
echo Created policy ${OCI_FN_POLICY_NAME}.  Use the command: \'oci iam policy get --policy-id "${OCI_FN_POLICY_ID}"\' if you want to view the policy.

# create VCN:
echo Creating VCN.  This may take a few seconds...
n=0
until [ $n -ge 6 ]
do
    OCI_FN_VCN_ID=$(oci network vcn create --cidr-block ${OCI_FN_VCN_CIDR_BLOCK} --compartment-id ${OCI_FN_COMPARTMENT_ID} --display-name ${OCI_FN_VCN_NAME} --query "data.id" --raw-output) && break
    n=$[$n+1]
    echo [create failed, trying again in 10 seconds...]
    sleep 10
done

if [ $n -eq 6 ]; then
    fail "Could not create VCN, exiting script!"
else
    OCI_FN_VCN_ROUTE_TABLE_ID=$(oci network vcn get --vcn-id ${OCI_FN_VCN_ID} --query 'data."default-route-table-id"' --raw-output)
    OCI_FN_VCN_SECURITY_LIST_ID=$(oci network vcn get --vcn-id ${OCI_FN_VCN_ID} --query 'data."default-security-list-id"' --raw-output)
    echo Created VCN ${OCI_FN_VCN_NAME} with ID ${OCI_FN_VCN_ID}
fi

# create subnets:
OCI_SUBNET_1=$(oci network subnet create --display-name ${OCI_FN_SUBNET_1_NAME} --availability-domain ${OCI_FN_SUBNET_1_AD} --cidr-block "${OCI_FN_VCN_SUBNET_1_CIDR_BLOCK}" --compartment-id ${OCI_FN_COMPARTMENT_ID} --vcn-id ${OCI_FN_VCN_ID} --query 'data.id' --raw-output)
OCI_SUBNET_2=$(oci network subnet create --display-name ${OCI_FN_SUBNET_2_NAME} --availability-domain ${OCI_FN_SUBNET_2_AD} --cidr-block "${OCI_FN_VCN_SUBNET_2_CIDR_BLOCK}" --compartment-id ${OCI_FN_COMPARTMENT_ID} --vcn-id ${OCI_FN_VCN_ID} --query 'data.id' --raw-output)
OCI_SUBNET_3=$(oci network subnet create --display-name ${OCI_FN_SUBNET_3_NAME} --availability-domain ${OCI_FN_SUBNET_3_AD} --cidr-block "${OCI_FN_VCN_SUBNET_3_CIDR_BLOCK}" --compartment-id ${OCI_FN_COMPARTMENT_ID} --vcn-id ${OCI_FN_VCN_ID} --query 'data.id' --raw-output)
echo Created subnets: ${OCI_FN_SUBNET_1_NAME}, ${OCI_FN_SUBNET_2_NAME}, ${OCI_FN_SUBNET_3_NAME}

# create internet gateway:
OCI_FN_INTERNET_GATEWAY_ID=$(oci network internet-gateway create --display-name ${OCI_FN_INTERNET_GATEWAY_NAME} --is-enabled true --compartment-id ${OCI_FN_COMPARTMENT_ID} --vcn-id ${OCI_FN_VCN_ID} --query 'data.id' --raw-output)
echo Created internet gateway ${OCI_FN_INTERNET_GATEWAY_NAME} with ID ${OCI_FN_INTERNET_GATEWAY_ID}

# update default route table: (rule allows all internet traffic to hit the internet gateway we just created)
ROUTE_RULES="[{\"cidrBlock\":\"0.0.0.0/0\",\"networkEntityId\":\""${OCI_FN_INTERNET_GATEWAY_ID}"\"}]"
echo $ROUTE_RULES > route-rules.json
OCI_ROUTE_TABLE_UPDATE=$(oci network route-table update --rt-id ${OCI_FN_VCN_ROUTE_TABLE_ID} --route-rules file://`pwd`/route-rules.json --force)
echo Updated default route table for VCN to allow traffic to internet gateway

# update default security listOCI_SECURITY_LIST_UPDATE=$(oci network security-list update --security-list-id ${OCI_FN_VCN_SECURITY_LIST_ID} --ingress-security-rules '[{"source": "0.0.0.0/0", "protocol": "6", "isStateless": false, "tcpOptions": {"destinationPortRange": {"max": 80, "min": 80}, "sourcePortRange": {"max": 80, "min": 80}}}]' --force)
echo Updated default security list to open port 80 for all subnets in VCN
printf "\nRemember to save the generated auth token:\n\n"${OCI_FN_USER_AUTH_TOKEN}"\n\nThis token is used for Docker login, with the username "${OCI_FN_TENANCY}"/"${OCI_FN_USER_NAME}"."
printf "\nYour new compartment ID is "${OCI_FN_COMPARTMENT_ID}"\n"
printf "Your subnet IDs are:\n\n"${OCI_FN_SUBNET_1_NAME}": "${OCI_SUBNET_1}"\n"${OCI_FN_SUBNET_2_NAME}": "${OCI_SUBNET_2}"\n"${OCI_FN_SUBNET_3_NAME}":"${OCI_SUBNET_3}"\n"
printf "\nUse these subnets for your Fn applications."
printf "\nYour user ID is: "${OCI_FN_USER_ID}
printf "\nYou can use the following profile section to modify your OCI CLI config for use with Fn (you'll need to generate a key and populate the necessary key related items):\n"
printf "[faas]\n"
printf "user="${OCI_FN_USER_ID}"\n"
printf "fingerprint=<public-key-fingerprint>\n"
printf "key_file=<private-key-pem-file>\n"
printf "tenancy="${OCI_FN_TENANCY}"\n"
printf "region="${OCI_FN_FN_REGION}"\n"
printf "pass_phrase=<passphrase>""\n"

printf "\nOCI Fn Config Complete.  Your tenancy is now set up to use Fn."
rm statements.json >/dev/null 2>&1
rm route-rules.json >/dev/null 2>&1
