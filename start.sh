#!/bin/bash

#start-services

sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --cri-socket unix:///var/run/cri-dockerd.sock

mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config
export KUBECONFIG=~/.kube/config
sudo chown $(whoami):$(whoami) ~/.kube/config

