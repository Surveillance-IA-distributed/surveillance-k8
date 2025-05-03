#!/bin/bash

echo "=== [1/6] Deteniendo servicios de Kubernetes ==="
sudo systemctl stop kubelet
sudo systemctl stop docker || sudo systemctl stop containerd

echo "=== [2/6] Borrando configuraciones antiguas de kubeadm ==="
sudo kubeadm reset -f

echo "=== [3/6] Eliminando configuraciones de red y datos ==="
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
sudo ipvsadm --clear 2>/dev/null
sudo rm -rf ~/.kube
sudo rm -rf /etc/kubernetes /var/lib/etcd /var/lib/kubelet /opt/cni /etc/cni /var/lib/cni

echo "=== [4/6] Reiniciando el contenedor y kubelet ==="
sudo systemctl daemon-reexec
sudo systemctl restart docker || sudo systemctl restart containerd
sudo systemctl restart kubelet

echo "=== [5/6] Mostrando estado de servicios ==="
sudo systemctl status docker --no-pager || sudo systemctl status containerd --no-pager
sudo systemctl status kubelet --no-pager

#mkdir -p ~/.kube
#sudo cp /etc/kubernetes/admin.conf ~/.kube/config

echo "=== [6/6] Listo. Puedes iniciar el nodo usando 'kubeadm init' o 'kubeadm join' ==="


