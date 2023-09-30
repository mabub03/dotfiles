#!/bin/bash
# optional script since seems like system76-scheduler2.0 not actually working well with kde
# this requires rust from rustup tool

bash -ci "$(wget -qO - 'https://shlink.makedeb.org/install')"

git clone 'https://mpr.makedeb.org/just'
cd just
makedeb -si

sudo apt install -y \
  just \
  libclang-dev \
  libpipewire-0.3-dev \
  pkg-config

git clone https://github.com/pop-os/system76-scheduler.git
cd system76-scheduler

just execsnoop=$(which execsnoop-bpfcc) build-release
sudo just sysconfdir=/usr/share install

sudo systemctl enable --now system76-scheduler.service

# kwin sys76 scheduler extension github link:
# https://github.com/maxiberta/kwin-system76-scheduler-integration
cd $HOME/widgets-source
git clone https://github.com/maxiberta/kwin-system76-scheduler-integration.git
cd kwin-system76-scheduler-integration
kpackagetool5 --type=KWin/Script -i .

# activate script via cli instead of system settings -> windows management -> kwin scripts
kcmshell5 kcm_kwin_scripts

# NOTE:maybe add these two scripts as files in a folder and move them to their proper place?
# create dbus proxy to forward messages from session dbus to system bus
sudo touch /usr/local/bin/system76-scheduler-dbus-proxy.sh
sudo bash -c 'cat > /usr/local/bin/system76-scheduler-dbus-proxy.sh' <<-'EOF'
#!/bin/bash
DBUS_SERVICE="com.system76.Scheduler"
DBUS_PATH="/com/system76/Scheduler"
DBUS_INTERFACE="com.system76.Scheduler"
DBUS_METHOD="SetForegroundProcess"
dbus-monitor "destination=$DBUS_SERVICE,path=$DBUS_PATH,interface=$DBUS_INTERFACE,member=$DBUS_METHOD" |
  while true; do
    read method call time sender _ dest serial path interface member
    read type pid
    [ "$member" = "member=$DBUS_METHOD" ] && qdbus --system $DBUS_SERVICE $DBUS_PATH $DBUS_INTERFACE.$DBUS_METHOD $pid
  done
EOF

sudo chmod +x /usr/local/bin/system76-scheduler-dbus-proxy.sh

if [[ ! -f "$HOME/.config/systemd/user/" ]]
then
  mkdir -p $HOME/.config/systemd/user/
fi

# create systemd service to run dbus proxy script automatically on login
touch $HOME/.config/systemd/user/com.system76.Scheduler.dbusproxy.service
bash -c 'cat > ~/.config/systemd/user/com.system76.Scheduler.dbusproxy.service' <<-'EOF'
[Unit]
Description=Forward com.system76.Scheduler session DBus messages to the system bus

[Service]
ExecStart=/usr/local/bin/system76-scheduler-dbus-proxy.sh

[Install]
WantedBy=default.target
EOF

systemctl --user enable --now com.system76.Scheduler.dbusproxy.service
