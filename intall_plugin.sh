mkdir -p /opt/cni/bin
curl -Lo /tmp/cni-plugins.tgz https://github.com/containernetworking/plugins/releases/download/v1.4.0/cni-plugins-linux-amd64-v1.4.0.tgz
tar -C /opt/cni/bin -xzf /tmp/cni-plugins.tgz
