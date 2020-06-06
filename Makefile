
build:
	go build -o bin/go-dns-proxy .

pkg: build
	mkdir -p dpkg/usr/bin
	cp bin/go-dns-proxy dpkg/usr/bin/dnsproxy
	IAN_DIR=dpkg ian pkg
