# Run this script as root.
cat > '/etc/rc.local' <<EOF
#!/bin/bash
# Add NAT interface for qemu vm.
ip link add br0 type bridge
ip addr add 192.168.122.1/24 dev br0
ip link set br0 up
systemctl restart dnsmasq
sysctl -w net.ipv4.ip_forward=1
iptables-save > /etc/iptables/rules.v4
exit 0
EOF
systemctl restart rc-local
iptables -t nat -A PREROUTING -i br0 -s 192.168.122.0/24 -p udp --dport 53 -j DNAT --to 140.113.1.1:53
iptables -t nat -A POSTROUTING -o enp0s3 -s 192.168.122.0/24 -j MASQUERADE
iptables-save > /etc/iptables/rules.v4
cat >> /etc/dnsmasq.conf <<EOF
interface=br0
dhcp-range=192.168.122.2,192.168.122.254,12h
EOF
systemctl restart dnsmasq
