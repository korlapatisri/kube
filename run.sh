#!/bin/bash
terraform init
terraform apply  

# Generate kubeconfig and configmap for adding worker nodes
terraform output kubeconfig > ./kubeconfig
terraform output config_map_aws_auth > ./config_map_aws_auth.yaml

# Apply configmap for worker nodes to join the cluster
export KUBECONFIG=./kubeconfig
kubectl apply -f ./config_map_aws_auth.yaml
kubectl get nodes --watch
kubectl create -f example/hello-kubernetes.yml
kubectl get all