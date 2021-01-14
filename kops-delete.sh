#!/bin/bash
export AWS_ACCESS_KEY_ID=$(cat ~/Documents/kops-creds | jq -r '.AccessKey.AccessKeyId')
export AWS_SECRET_ACCESS_KEY=$(cat ~/Documents/kops-creds | jq -r '.AccessKey.SecretAccessKey')
export AWS_DEFAULT_REGION=eu-west-1
export ZONES=$(aws ec2 describe-availability-zones --region $AWS_DEFAULT_REGION | jq -r '.AvailabilityZones[].ZoneName' | tr '\n' ',' | tr -d ' ')
ZONES=${ZONES%?}
export NAME=devops23.k8s.local
export BUCKET_NAME=devops23-1608787521
export KOPS_STATE_STORE=s3://$BUCKET_NAME
kops delete cluster --name devops23.k8s.local -y


