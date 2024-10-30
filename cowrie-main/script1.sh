sudo apt install -y qemu-system-x86 qemu-kvm dnsmasq iptables-persistent nmap
sudo usermod -a -G kvm $(whoami)
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved
sudo rm /etc/resolv.conf
sudo bash -c "echo 'nameserver 192.168.3.1' > /etc/resolv.conf"
sudo systemctl start dnsmasq