FROM golang:latest as build
ADD . /app
WORKDIR /app
ENV GOHOME /usr/local/go/src/appengine
RUN mkdir -p ${GOHOME} && \
    go get -d -v ./... && \
    ls -alh ${GOHOME}/ && \
    go build -x -o /ga-beacon

FROM ubuntu:latest
COPY --from=build /ga-beacon /usr/bin/ga-beacon
RUN apt-get update && \
    apt-get install -y -q libgo9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ADD . /usr/share/ga-beacon
WORKDIR /usr/share/ga-beacon
EXPOSE 9001
CMD [ "/usr/bin/ga-beacon" ]
