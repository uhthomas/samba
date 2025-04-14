# Samba SMB

Samba is a free software re-implementation of the SMB networking protocol.

[https://wiki.debian.org/Samba](https://wiki.debian.org/Samba)

The container is built with a default configuration which serves the share
`data` from `data`. It can be mounted with:

```sh
❯ sudo mount.cifs -o username=smbuser,password=,uid=1000,gid=2000,forceuid,forcegid //192.168.135.24/data /mnt
```

I don't know if the uid, gid, forceuid and forcegid options are necessary, but
it seems to work.

The configuration can be overridden by mounting a custom configuration file over
the top of the default one at `/etc/samba/smb.conf`. See
[Dockerfile](Dockerfile) for the default configuration.
