FROM golang:latest as build
ADD . /app
WORKDIR /app
RUN go get -d -v google.golang.org/appengine/cmd/aefix
RUN go build -x -o /ga-beacon

FROM ubuntu:latest
COPY --from=build /ga-beacon /usr/bin/ga-beacon
RUN apt-get update && \
    apt-get install -y -q libgo9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ADD . /usr/share/ga-beacon
WORKDIR /usr/share/ga-beacon
EXPOSE 9000
CMD [ "/usr/bin/ga-beacon" ]
