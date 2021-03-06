# home-enterprise

## Objective
Run a resilient self-hosted domain support system across at least two locations

## Key results
1. DNS
1. Web
1. Email
1. VPN in
1. VPN through

## Initiatives
1. Set up two servers
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
  |VPN IN|1194|1194|VPN
  |TOR|N/A|9100|TOR proxy

- Servers need to run docker

Note: Sometimes containers lose outbound connectivity or permissions to access docker mounts. In this case you need to restart the docker daemon.  

### File system
This is where home-enterprise will run.  
Under a server local non-root user create a directory `home-enterprise`.  

        mnt/server-id/
        ├── etc/
        │   ├── bind/
        │   │   ├── named.conf
        │   │   ├── named.conf.options
        │   │   ├── named.conf.zones
        │   │   └── zones/
        │   ├── dkimproxy/
        │   │   ├── dkimproxy_out.conf
        │   ├── letsencrypt/
        │   ├── lsyncd.conf
        │   ├── openldap/
        │   │   └── slapd.conf
        │   ├── openvpn/
        │   │   ├── client/
        │   │   └── server/
        │   │       └── server.conf
        │   ├── ssh/
        │   │   └── sshd_config
        │   └── tor/
        │       └── torrc
        ├── root/
        └── var/
            ├── lib/
            │   └── openldap/
            └── run/
                └── sshd/


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

### DNS
1. For each server's [ip address](https://en.wikipedia.org/wiki/IP_address) set up an individual [name server](https://en.wikipedia.org/wiki/Name_server) entry for your [domain name](https://en.wikipedia.org/wiki/Domain_name) with your [domain name registrar](https://en.wikipedia.org/wiki/Domain_name_registrar).
1. Populate mnt/$(hostname -s)/etc/bind/named.conf.zones with zone configs.
1. Place each zone file into mnt/$(hostname -s)/etc/bind/zones/
1. Each server needs to run `bin/bind_reload_on_change.sh` and `bin/bind_sync_from_others.sh`. Realod on change is needed for certbot dns challenge, and sync from others pulls changes from one server to another.


Note: You may also want to add your internal router's IP as a first name server into /etc/resolv.conf   

### Certificates
export EMAIL=your@email.here
Run `repo/docker-certbot-dns/bin/run.sh` to generate certificates.  
It will attempt to run renewals daily so when the time comes the certs will be updated.  

### TOR
1. Have a TOR proxy on each server - because you can and should value your privacy!
It's running on 9100, so change your SOCKS5 proxy to point to it and make sure DNS is also resolved via TOR to take advantage of .onion domains.

### VPN in
1. Have an incoming VPN running on each server so that you can access internal services. 


### Nginx

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

