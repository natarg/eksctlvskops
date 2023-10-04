#!/bin/bash

vpc_id=$(aws eks describe-cluster \
    --name kubesight-aws-cni \
    --query "cluster.resourcesVpcConfig.vpcId" --region us-west-2 \
    --output text)
cidr_range=$(aws ec2 describe-vpcs \
    --vpc-ids $vpc_id \
    --query "Vpcs[].CidrBlock" \
    --output text \
    --region us-west-2)



# security_group_id=$(aws ec2 create-security-group \
#     --group-name kubesight-aws-cni-efs-sg \
#     --description "kubesight-aws-cni-efs-sg" \
#     --vpc-id $vpc_id \
#     --region us-west-2 \
#     --output text)

security_group_id=sg-0fe3cfa7ce7736f7c

# aws ec2 authorize-security-group-ingress \
#     --group-id $security_group_id \
#     --protocol tcp \
#     --port 2049 \
#     --region us-west-2 \
#     --cidr $cidr_range

# file_system_id=$(aws efs create-file-system \
#     --performance-mode generalPurpose \
#     --query 'FileSystemId' \
#     --region us-west-2 \
#     --output text)

file_system_id=fs-0e8ef96798eeff2ee

aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$vpc_id" \
    --region us-west-2 \
    --query 'Subnets[*].{SubnetId: SubnetId,AvailabilityZone: AvailabilityZone,CidrBlock: CidrBlock}' \
    --output table

echo "$vpc_id,$cidr_range,$security_group_id,$file_system_id"

subnet_id_1=subnet-0eac47fa66e8042fc
subnet_id_2=subnet-0396ae76ba2b414e8
subnet_id_3=subnet-0acb4684c6c693040
subnet_id_4=subnet-0d81870a0c59bd112
subnet_id_5=subnet-0e1064675e3b1d89a
subnet_id_6=subnet-0c0615fbf17c34de3

subnet_ids=("subnet-0eac47fa66e8042fc" "subnet-0396ae76ba2b414e8" "subnet-0acb4684c6c693040" "subnet-0d81870a0c59bd112" "subnet-0e1064675e3b1d89a" "subnet-0c0615fbf17c34de3" )

for element in "${subnet_ids[@]}"
do
    aws efs create-mount-target \
     --file-system-id $file_system_id \
     --subnet-id $element \
     --region us-west-2 \
     --security-groups $security_group_id
done

