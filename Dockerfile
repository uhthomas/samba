FROM alpine:3.24.3@sha256:b3413572228e34bd1c9245f5565e6cd127005655e8a7899aef33d8e83255c9e6

RUN apk add samba && \
        addgroup -g 2000 smbgroup && \
        adduser -DH -u 1000 -G smbgroup -s /bin/false smbuser && \
        mkdir -p /data && \
        chown smbuser:smbgroup /data && \
        chmod 0775 /data

COPY smb.conf /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
