# home-enterprise

## Objective
Run a DR capable self-hosted domain support system across 2 locations

## Key results
1. DNS
1. Email
1. Web

## Initiatives
1. Set up 2 servers
1. Dedicate a file system location on each for home-enterprise
1. Set up bi-directional synchronization of the file system
1. Configure and run DNS on both servers
1. ...

### Server requirements
- Ports for the following services need to be accessible via internet.   
If servers are on a private network(10/8, 172.16/12, 192.168/16), port forwarding needs to be set up on a WAN router.  

|service|ports|description
|---|---|---|
|SSH|22|Secure shell access
|DNS|53|Domain name server
|WEB|80,443|Web server

## Technologies
1. FS
1. VPN in
1. Lsyncd
1. DNS
1. Nginx
1. Let's Encrypt Certs
1. LDAP
1. SMTP
1. IMAP
1. VPN through

