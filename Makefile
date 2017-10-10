.PHONY: all build test

all: build

test:
	go get google.golang.org/appengine/cmd/aefix
	go build

build:
	docker pull golang:latest
	docker build -t ernestas/ga-beacon:latest .
