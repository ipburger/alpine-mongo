FROM alpine:3.7

ARG MONGO_ADMIN_PWD
ARG PRITUNL_USER_PWD
ENV MONGO_ADMIN_PWD=${MONGO_ADMIN_PWD} \
    PRITUNL_USER_PWD=${PRITUNL_USER_PWD}

RUN \
apk update && apk add mongodb && \
rm /usr/bin/mongoperf && \
apk del --progress --purge && rm -rf /var/cache/apk/*

COPY ./root /

VOLUME /data/db
EXPOSE 27017

ENTRYPOINT [ "/scripts/run.sh" ]
CMD [ "mongod", "--nojournal" ]
