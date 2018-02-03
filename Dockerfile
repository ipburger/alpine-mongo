FROM alpine:3.7

RUN \
apk update && apk add mongodb && \
rm /usr/bin/mongoperf && \
apk del --progress --purge && rm -rf /var/cache/apk/*

VOLUME /data/db
EXPOSE 27017

COPY run.sh /root
ENTRYPOINT [ "/root/run.sh" ]
CMD [ "--nojournal" ]
