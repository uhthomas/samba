FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y samba && rm -rf /var/lib/apt/lists/*

RUN useradd -M -s /bin/false smbuser

RUN mkdir -p /etc/samba/ && \
        echo "[global]\n\
        workgroup = WORKGROUP\n\
        security = user\n\
        map to guest = Bad User\n\
        guest account = smbuser\n\
        load printers = no\n\
        disable spoolss = yes\n\
        smb ports = 445\n\
        \n\
        [data]\n\
        path = /data\n\
        browseable = yes\n\
        writable = yes\n\
        guest ok = yes\n\
        force user = smbuser\n\
        create mask = 0775\n\
        directory mask = 0775" > /etc/samba/smb.conf

RUN mkdir -p /data && \
        chown smbuser:smbuser /data && \
        chmod 0775 /data

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
