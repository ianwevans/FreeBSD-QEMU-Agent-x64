
# Run a portsnap
portsnap fetch && portsnap extract

# Run the following to install the agent
cd /usr/ports/emulators/qemu/ && make fetch-recursive
git clone https://github.com/aborche/qemu-guest-agent.git /usr/ports/emulators/qemu-guest-agent
cd /usr/ports/emulators/qemu-guest-agent && make install
echo 'qemu_guest_agent_enable="YES"' >> /etc/rc.conf
echo 'qemu_guest_agent_flags="-d -v -l /var/log/qemu-ga.log"' >> /etc/rc.conf
echo 'virtio_console_load="YES"' >> /boot/loader.conf
kldload virtio_console
service qemu_guest_agent start
