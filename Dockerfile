FROM alpine:3.23.2@sha256:865b95f46d98cf867a156fe4a135ad3fe50d2056aa3f25ed31662dff6da4eb62

RUN apk add samba && \
        addgroup -g 2000 smbgroup && \
        adduser -DH -u 1000 -G smbgroup -s /bin/false smbuser && \
        mkdir -p /data && \
        chown smbuser:smbgroup /data && \
        chmod 0775 /data

COPY smb.conf /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
