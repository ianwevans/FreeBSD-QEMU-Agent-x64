# install all required binaries
pkg install -y gettext-runtime git glib gmake pkgconf python37

# update the port tree
portsnap auto

# use qemu41 instead 
mv /usr/ports/emulators/qemu /usr/ports/emulators/qemu42 && ln -s /usr/ports/emulators/qemu41 /usr/ports/emulators/qemu

# download the qemu-guest-agent source and compile/install it
git clone https://github.com/aborche/qemu-guest-agent.git /usr/ports/emulators/qemu-guest-agent
cd /usr/ports/emulators/qemu-guest-agent
make install clean

# restore the port tree
rm /usr/ports/emulators/qemu && mv /usr/ports/emulators/qemu42 /usr/ports/emulators/qemu

# enable the guest agent in rc.conf
sysrc qemu_guest_agent_enable="YES"
sysrc qemu_guest_agent_flags="-d -v -l /var/log/qemu-ga.log"

# load the VirtIO console and make it permanent
kldload virtio_console
echo 'virtio_console_load="YES"' >> /boot/loader.conf

# start the guest agent
service qemu-guest-agent start
