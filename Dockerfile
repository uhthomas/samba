FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

RUN apk add samba && \
        addgroup -g 3000 smbgroup && \
        adduser -DH -u 1000 -G smbgroup -s /bin/false smbuser && \
        mkdir -p /data && \
        chown smbuser:smbuser /data && \
        chmod 0775 /data

COPY smb.conf /etc/samba/smb.conf

EXPOSE 445

ENTRYPOINT ["smbd", "--foreground", "--no-process-group", "-s", "/etc/samba/smb.conf"]
