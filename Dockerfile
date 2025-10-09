FROM alpine:3.22.2@sha256:4b7ce07002c69e8f3d704a9c5d6fd3053be500b7f1c69fc0d80990c2ad8dd412

RUN apk add samba && \
        addgroup -g 2000 smbgroup && \
        adduser -DH -u 1000 -G smbgroup -s /bin/false smbuser && \
        mkdir -p /data && \
        chown smbuser:smbgroup /data && \
        chmod 0775 /data

COPY smb.conf /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
