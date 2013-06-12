# GENDO

## Setup

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

``
rake db:migrate
RAILS_ENV=test rake db:migrate
```

### Environment

```
cp sample.env .env
```

### Run!

```
foreman start
```

### Sanity Check

```
rspec
```
