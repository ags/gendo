GENDO
-----

Setup
=====

### Environment

```
cp sample.env .env
```

### Gems

```
bundle
```

### DB

```
createuser gendo
createdb --owner=gendo gendo
createdb --owner=gendo gendo_test
```

```
rake db:migrate
RAILS_ENV=test rake db:migrate
```

### Run!

```
foreman start
```

### Sanity Check

```
rspec
```
