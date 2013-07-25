#!/usr/bin/env bash

# Environment variables
cp sample.env .env &&

# Gems
bundle &&

# DB Setup
createuser gendo &&
createdb --owner=gendo gendo &&
createdb --owner=gendo gendo_test &&

rake db:migrate &&

RAILS_ENV=test rake db:migrate
