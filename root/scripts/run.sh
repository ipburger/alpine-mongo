#!/bin/sh
# Docker entrypoint (pid 1), run as root
[ "$1" == "mongod" ] || exec "$@" || exit $?

#Repair the database before anything
mongod --repair

# Make sure that database is owned by user mongodb
chown -R mongodb /data/db

# Drop root privilege (no way back), exec provided command as user mongodb
cmd=exec; for i; do cmd="$cmd '$i'"; done

if [ "$1" == "mongod" ]; then
  exec su -s /bin/sh -c "$cmd" mongodb & mongo localhost:27017 --quiet --eval \
       "use admin; db.createUser({ user: 'admin', pwd: '${MONGO_ADMIN_PWD}', roles: [{ role: 'userAdminAnyDatabase', 'dbAdminAnyDatabase', 'readWriteAnyDatabase', db: 'admin' }] })" & \
       mongo localhost:27017 --username admin --password ${MONGO_ADMIN_KEY} --quiet --eval \
       "use pritunl; db.createUser({ user: 'pritunl', pwd: '${PRITUNL_USER_PWD}', roles: [{role: 'dbOwner', db: 'pritunl'}]})"
else
  exec su -s /bin/sh -c "$cmd" mongodb
fi
