FROM alpine:3.7

RUN \
apk add --no-cache mongodb && \
rm /usr/bin/mongoperf

VOLUME /data/db
EXPOSE 27017

COPY run.sh /root
ENTRYPOINT [ "/root/run.sh" ]
CMD mongod --nojournal
