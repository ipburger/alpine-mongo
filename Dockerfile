FROM alpine:3.6

RUN \
apk add --no-cache mongodb && \
rm /usr/bin/mongoperf

#Disable mongodb journaling
RUN echo 'nojournal=true' >> /etc/mongod.conf

VOLUME /data/db

EXPOSE 27017

CMD mongod --repair && mongod --nojournal