#! /bin/sh

#
# Configure system banners, and apt sources
#

# Configure system banners
cp -fv config/issue /etc/issue
cp -fv config/issue.net /etc/issue.net
: > /etc/motd

# Configure SSH server banner
sed -i 's/^#Banner/Banner/' /etc/ssh/sshd_config

# Setup apt sources to use our local mirror
if whiptail --title "APT setup" --yesno "Use local mirror server ?" --defaultno 10 50; then
	cp -fv config/sources.list.iut /etc/apt/sources.list
	apt update
fi

# Setup CNTLM for authentication with our local proxy server
if whiptail --title "CNTLM setup" --yesno "Use local proxy server ?" --defaultno 10 50; then
	# Install CNTLM package
	apt update
	apt install -y cntlm
	# Disable CNTLM service
	systemctl stop cntlm
	systemctl disable cntlm
	# Configure CNTLM
	sed -i 's/^Username/#Username/' /etc/cntlm.conf
	sed -i 's/^Domain/#Domain/' /etc/cntlm.conf
	sed -i 's/^Password/#Password/' /etc/cntlm.conf
	sed -i 's/^Proxy/#Proxy/' /etc/cntlm.conf
	cat config/cntlm.conf >> /etc/cntlm.conf
	# Copy the scripts to start and stop the local proxy
	cp -fv config/proxy-start /usr/local/bin/
	cp -fv config/proxy-stop /usr/local/bin/
fi
