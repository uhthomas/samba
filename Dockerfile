FROM alpine:3.24.2@sha256:294b683cb724975bec92580e1e685676bd4b50bda910ddb8c51d4cabeaec77e6

RUN apk add samba && \
        addgroup -g 2000 smbgroup && \
        adduser -DH -u 1000 -G smbgroup -s /bin/false smbuser && \
        mkdir -p /data && \
        chown smbuser:smbgroup /data && \
        chmod 0775 /data

COPY smb.conf /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
