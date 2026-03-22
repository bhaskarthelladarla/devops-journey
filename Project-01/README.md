# Bash script

## Description
This script provides a simple automation solution to gracefully stop and start a services during system reboot or shutdown on RHEL.
Instead of manually running commands or relying on deprecated chkconfig, thisapproach ensures:

 - Service stops safely before shutdown/reboot
 - Service starts automatically after boot

### Components

1. Systemd Unit File

Location: /etc/systemd/system/ArcServices.service

2. Control Script:

Location: /usr/local/bin/Arc_service.sh

### File Details

Systemd Service File

[Unit]
Description=Custom Service Control
DefaultDependencies=no
Before=shutdown.target reboot.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/myservice_control.sh start
ExecStop=/usr/local/bin/myservice_control.sh stop
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target

### Setup

1. Create Script File

vi /usr/local/bin/Arc_service.sh
chmod +x /usr/local/bin/Arc_service.sh

2. Create systemd Service

vi /etc/systemd/system/ArcServices.service

3. Reload stsremd

systemctl daemon-reload

4. Enable Service

systemctl enable Arc_service.sh

5. Start Service

systemctl start Arc_service.sh

### Verification

Check status:

systemctl status ArcServices.service

Expected output:

Active: active (exited)

check logs:

journalctl -u ArcServices.service

 	
