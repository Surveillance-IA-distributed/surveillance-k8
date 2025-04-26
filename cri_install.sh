
git clone https://github.com/Mirantis/cri-dockerd.git
cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
sudo install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
sudo cp -a packaging/systemd/* /etc/systemd/system/

FILE="/etc/systemd/system/cri-docker.service"

# Verificamos si el archivo existe
if [[ -f "$FILE" ]]; then
  echo "Editando $FILE..."
  sudo sed -i 's|^ExecStart=/usr/bin/cri-dockerd|ExecStart=/usr/local/bin/cri-dockerd|' "$FILE"
  echo "Edición completada."
else
  echo "Archivo $FILE no encontrado."
fi

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable cri-docker.service
sudo systemctl enable --now cri-docker.socket
