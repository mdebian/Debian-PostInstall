#! /bin/sh

#
# Base system configuration
#

# Get the date
DATE=$(date "+%Y%m%d")
# Setup apt sources in France
cp -fv config/sources.list.france /etc/apt/sources.list
# Update the package database and the system
apt update
apt -y upgrade
# Cleanup the packages
apt -y autoremove
apt -y autoclean
# Configure Bash
cp -fv config/bash.bashrc /etc/bash.bashrc
rm -fv /etc/skel/.bashrc
# Remove local bashrc files
mv -fv /root/.bashrc /root/.bashrc.$DATE
for USER in $(ls /home); do
	if [ "$USER" = 'lost+found' ]; then continue; fi
	mv -fv /home/$USER/.bashrc /home/$USER/.bashrc.$DATE
done
# Install VirtualBox guest additions
if whiptail --title "VirtualBox setup" --yesno "Install VirtualBox guest additions ?" --defaultno 10 50; then
	apt install -y --no-install-recommends virtualbox-guest-dkms linux-headers-amd64
fi
# Zero GRUB timeout
if whiptail --title "GRUB setup" --yesno "Zero GRUB timeout ?" --defaultno 10 50; then
	sed -i 's/GRUB_TIMEOUT=.*/GRUB_TIMEOUT=0/' /etc/default/grub
	update-grub
fi
# Choose applications to install
APPLICATIONS=$(whiptail --title "Application installation" --separate-output --checklist \
"Choose additionnal applications to install :" 20 78 16 \
"minicom" "" OFF "tcpdump" "" OFF "mtr-tiny" "" OFF "git" "" OFF \
"iperf" "" OFF "ipcalc" "" OFF "ndisc6" "" OFF "netstat-nat" "" OFF \
"htop" "" OFF "nmap" "" OFF 3>&1 1>&2 2>&3)
# Install selected applications
apt install -y $APPLICATIONS
# Configure selected applications
for APP in $APPLICATIONS; do
	case $APP in
		minicom) cp -fv config/minirc.dfl /etc/minicom/minirc.dfl
		;;
	esac
done
