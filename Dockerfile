FROM alpine:3.21.3@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c

RUN apt-get update && apt-get install -y samba && rm -rf /var/lib/apt/lists/*

RUN useradd -M -s /bin/false smbuser

COPY smb.conf /etc/samba/smb.conf

RUN mkdir -p /data && \
        chown smbuser:smbuser /data && \
        chmod 0775 /data

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
