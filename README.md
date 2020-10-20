# home-enterprise

## Objective
Run a resilient self-hosted domain support system across 2 locations

## Key results
1. DNS
1. Web
1. Email

## Initiatives
1. Set up 2 servers
1. Dedicate a file system location on each for home-enterprise
1. Set up bi-directional synchronization of the file system
1. Configure and run DNS on both servers
1. ...

### Server requirements
- Server ports for the services listed below need to be accessible via the internet.   
If servers are on a [private network](https://en.wikipedia.org/wiki/Private_network) (10/8, 172.16/12, 192.168/16), port forwarding needs to be set up on a the internet router.  
For the purposes of the demonstration server ports will be prefixed with 40.

  |service|internet ports|server ports|description
  |---|---|---|---|
  |SSH|22|4022|Secure shell access
  |DNS|53|4053|Domain name server
  |WEB|80,443|4080,40443|Web server

- Servers need to run docker

Note: Sometimes containers lose outbound connectivity or permissions to access docker mounts. In this case you need to restart the docker daemon.  

### File system
This is where home-enterprise will run.  
Under a server local non-root user create a directory `home-enterprise`.  

    mnt
    └── $(hostname -s)
        ├── etc
        │   ├── lsyncd.conf
        │   └── ssh
        │       ├── ssh_host_dsa_key
        │       ├── ssh_host_dsa_key.pub
        │       ├── ssh_host_ecdsa_key
        │       ├── ssh_host_ecdsa_key.pub
        │       ├── ssh_host_ed25519_key
        │       ├── ssh_host_ed25519_key.pub
        │       ├── ssh_host_rsa_key
        │       ├── ssh_host_rsa_key.pub
        │       └── sshd_config
        ├── root
        │   └── .ssh
        │       ├── authorized_keys
        │       ├── id_rsa
        │       ├── id_rsa.pub
        │       └── known_hosts
        └── var
            └── run
                └── sshd

### SSH
This will allow to access `home-enterprise/mnt` file system via ssh. 
It requires a dedicated ssh key pair in `/root/.ssh`.  
```
HOST_MNT="mnt/$(hostname -s)"
[ -d $HOST_MNT/root/.ssh ] || mkdir $HOST_MNT/root/.ssh
chown og-rwx $HOST_MNT/root/.ssh
ssh-keygen -t rsa -b 4096 -f $HOST_MNT/root/.ssh/id_rsa -q -N ""
```
scp $HOST_MNT/root/.ssh/id_rsa.pub to remote host mnt/`remote hostname`/root/.ssh/authorized_keys

### Lsyncd
Lsyncd pushes files as they change from `home-enterprise/mnt` to the remote server.  

#### DNS
1. For each server's [ip address](https://en.wikipedia.org/wiki/IP_address) set up an individual [name server](https://en.wikipedia.org/wiki/Name_server) entry for your [domain name](https://en.wikipedia.org/wiki/Domain_name) with your [domain name registrar](https://en.wikipedia.org/wiki/Domain_name_registrar).


## Technologies
1. FS
1. SSH
1. Lsyncd
1. DNS
1. Nginx
1. Let's Encrypt Certs
1. LDAP
1. SMTP
1. IMAP
1. MYSQL
1. RoundCube Webmail
1. VPN in
1. VPN through

