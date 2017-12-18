FROM golang:latest as build
ADD . /app
WORKDIR /app
ENV GOHOME /usr/local/go/src/appengine
RUN mkdir -p ${GOHOME} && \
    go build -x -o /stand-alone

FROM ubuntu:latest
COPY --from=build /stand-alone /usr/bin/ga-beacon
RUN apt-get update && \
    apt-get install -y -q libgo9 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ADD . /usr/share/ga-beacon
WORKDIR /usr/share/ga-beacon
EXPOSE 9001
CMD [ "/usr/bin/ga-beacon" ]
