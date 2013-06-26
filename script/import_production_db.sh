#!/usr/bin/env bash

# tell heroku to backup, deleting the oldest manual backup if needed
heroku pgbackups:capture --expire &&

# download the backup
curl -o tmp/production_db.sql `heroku pgbackups:url` &&

# import backup into db
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U gendo -d gendo tmp/production_db.sql
