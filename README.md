# DNS Proxy

A simple DNS proxy written in go based on [github.com/miekg/dns](https://github.com/miekg/dns)

## How to use it

## Docker

```shell
$ docker run -p 53:53/udp katakonst/go-dns-proxy:latest -use-outbound -json-config='{
    "defaultDns": "8.8.8.8:53",
    "servers": {
        "google.com" : "8.8.8.8:53"
    },
    "domains": {
        "test.com" : "8.8.8.8"
    }
}'
```

## Download executables

[Download](https://github.com/katakonst/go-dns-proxy/releases)

## Debian Package

This uses the [go-ian](https://github.com/penguinpowernz/go-ian) utility to build the package. The
latest version can be installed as a debian package from [the releases page](https://github.com/penguinpowernz/go-ian/releases).

To build the debian package just run the following:

```
make pkg
```

You will then find a debian package created in `dpkg/pkg`.  Once you have installed it
then you can start it as a service like so:

```
sudo systemctl enable dnsproxy
sudo systemctl start dnsproxy
```

You can then edit the config file at `/etc/dnsproxy.json`, however you will need to restart
the server to pickup changes to this file.

You will probably have to disable any `/etc/resolv.conf` managers you have installed and
create a very simple `/etc/resolv.conf` file:

```
nameserver 127.0.0.1
```

This is because the DNS Proxy daemon needs to use port 53 to be picked up by resolv.conf and
some resolv.conf managers will run on port 53 themselves.

## Go get

```shell
$ go get github.com/katakonst/go-dns-proxy
$ go-dns-proxy -use-outbound -json-config='{
    "defaultDns": "8.8.8.8:53",
    "servers": {
        "google.com" : "8.8.8.8:53"
    },
    "domains": {
        "test.com" : "8.8.8.8"
    }
}'
```

## Arguments

```
	-file		 config filename
	-log-level	 log level(info,error or discard)
	-expiration      cache expiration time in seconds
	-use-outbound	 use outbound address as host for server
        -config-json     configs as json
```

## Config file format

```json
{
    "host": "192.168.1.4:53",
    "defaultDns": "8.8.8.8:53",
    "servers": {
        "google.com" : "8.8.8.8:53"
    },
    "domains": {
        ".*.com" : "8.8.8.8"
    }
}
```


## TODO

- [ ] live config file reloading