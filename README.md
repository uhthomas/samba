# Samba SMB

Samba is a free software re-implementation of the SMB networking protocol.

[https://wiki.debian.org/Samba](https://wiki.debian.org/Samba)

The container is built with a default configuration which serves the share
`data` from `data`. It can be mounted with:

```sh
❯ sudo mount.cifs -o guest,uid=$(id -u),gid=$(id -g) //192.168.135.24/data /mnt
```

The user must be run with uid 1000 and gid 3000, with the fs group 2000.

Kubernetes security context:

```cue
securityContext: {
        capabilities: drop: ["ALL"]
        readOnlyRootFilesystem:   true
        allowPrivilegeEscalation: false
}
```

Kubernetes pod security context:

```cue
securityContext: {
        runAsUser:           1000
        runAsGroup:          3000
        runAsNonRoot:        true
        fsGroup:             2000
        fsGroupChangePolicy: v1.#FSGroupChangeOnRootMismatch
        seccompProfile: type: v1.#SeccompProfileTypeRuntimeDefault
}
```

The configuration can be overridden by mounting a custom configuration file over
the top of the default one at `/etc/samba/smb.conf`. See
[Dockerfile](Dockerfile) for the default configuration.
