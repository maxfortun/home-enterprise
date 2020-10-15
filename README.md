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
If servers are on a [private network](https://en.wikipedia.org/wiki/Private_network) (10/8, 172.16/12, 192.168/16), port forwarding needs to be set up on a WAN router.  

  |service|ports|description
  |---|---|---|
  |SSH|22|Secure shell access
  |DNS|53|Domain name server
  |WEB|80,443|Web server

- Servers need to run docker

### File system
This is where home-enterprise will run.  
Under a server local non-root user create a directory `home-enterprise`.  

  /home-enterprise  
    /mnt  
      /etc   
    

#### DNS
1. For each server's [ip address](https://en.wikipedia.org/wiki/IP_address) set up an individual [name server](https://en.wikipedia.org/wiki/Name_server) entry for your [domain name](https://en.wikipedia.org/wiki/Domain_name) with your [domain name registrar](https://en.wikipedia.org/wiki/Domain_name_registrar).


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

