#!/usr/bin/env bash
cd
pacman -Syu --noconfirm
pacman -S --noconfirm ruby bash-completion avahi nss-mdns base-devel git vim packer screen screenfetch ethtool iptables openvpn unrar unzip wget htop ntp dosfstools python-pip
gem install rmate
pip install glances
#hostnamectl set-hostname HOSTNAME
echo "hosts: files mdns_minimal [NOTFOUND=return] dns myhostname" > /etc/nsswitch.conf
systemctl enable avahi-daemon.service
systemctl enable ntpd.service
systemctl start ntpd.service
timedatectl set-timezone America/New_York
cp /home/alarm/.bash_profile /home/alarm/.bashrc .
echo "export EDITOR=vim" >> /home/alarm/.bashrc
echo 'export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH' >> /home/alarm/.bashrc
echo "export EDITOR=vim" >> .bashrc
echo 'export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH' >> .bashrc
echo "" >> .bashrc
echo "if [ -f /usr/bin/screenfetch ]; then screenfetch; fi" >> .bashrc
mkdir .ssh
# echo "SSH PUB KEY" > .ssh/authorized_keys
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
systemctl restart sshd
reboot