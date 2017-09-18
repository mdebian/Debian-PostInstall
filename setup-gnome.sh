#! /bin/sh

#
# Remove unnecessary applications in Gnome
# Setup Gnome Shell desktop
#

# Remove unwanted applications
apt purge --yes --autoremove gnome-games gnome-contacts gnome-documents gnome-photos \
transmission-common gnome-weather gnome-orca gnome-online-accounts gnome-online-miners \
gnome-calendar gnome-maps gnome-music gnome-sushi polari evolution gnome-dictionary \
cheese rhythmbox totem gnome-getting-started-docs gnome-sound-recorder simple-scan \
gnome-clocks reportbug seahorse gnome-software synaptic gnome-disk-utility gnome-logs \
gnome-characters gnome-color-manager gnome-font-viewer gnome-user-guide gnome-accessibility-themes \
gnome-orca gnome-online-accounts baobab tracker avahi-daemon yelp file-roller \
shotwell brasero

# Setup Joy theme
update-alternatives --set desktop-theme /usr/share/desktop-base/joy-theme
update-alternatives --set desktop-grub /usr/share/desktop-base/joy-theme/grub/grub-16x9.png
update-alternatives --set desktop-background.xml /usr/share/desktop-base/joy-theme/wallpaper/gnome-background.xml
update-alternatives --set desktop-background /usr/share/desktop-base/joy-theme/wallpaper/contents/images/1920x1200.svg
update-alternatives --set desktop-login-background /usr/share/desktop-base/joy-theme/login/background.svg
dpkg-reconfigure desktop-base

# Setup Gnome Shell
cp -fv config/gnome.conf /usr/share/glib-2.0/schemas/20_debian_postinstall.gschema.override
glib-compile-schemas /usr/share/glib-2.0/schemas
