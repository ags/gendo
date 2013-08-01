require "machinist/active_record"

App.blueprint do
  user
  name { "Shinji Ikari" }
end

App.blueprint(:with_access_token) do
  app_access_tokens { [AppAccessToken.make!] }
end

AppAccessToken.blueprint do
  app
  token { sn }
end

MailerEvent.blueprint do
  transaction
  mailer     { "FooMailer" }
  message_id { "123456789" }
  started_at { Time.now }
  ended_at   { Time.now }
  duration   { 0.1234 }
end

NPlusOneQuery.blueprint do
  transaction
  culprit_table_name { "posts" }
end

Source.blueprint do
  app
  controller    { "PostsController" }
  action        { "new" }
  method_name   { "GET" }
  format_type   { "*/*" }
end

Transaction.blueprint do
  source
end

Transaction.blueprint(:with_zero_runtime) do
  db_runtime   { 0 }
  view_runtime { 0 }
  duration     { 0 }
  started_at   { Time.now }
  ended_at     { Time.now }
end

User.blueprint do
  email    { "user#{sn}@blargh.com" }
  password { "password" }
end

def transaction_payload_hash
  {
    path:           '/posts/new',
    status:         200,
    started_at:     1370939786.0706801,
    ended_at:       1370939787.0706801,
    db_runtime:     0.1234,
    view_runtime:   0.4567,
    duration:       1.98,
    shinji_version: "0.0.1",
    framework:      "Rails 5.0.0",
    source: {
      controller:   'PostsController',
      action:       'new',
      format_type:  '*/*',
      method_name:  'GET',
    },
    sql_events: [
      {
        sql:          "SELECT * FROM users WHERE id = '1'",
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        duration:     0.321,
      }
    ],
    view_events: [
      {
        identifier:   '/foo/bar.html.erb',
        started_at:   1370939786.0706801,
        ended_at:     1370939787.0706801,
        duration:     0.321,
      }
    ],
    mailer_events: [
      {
        mailer:     "FooMailer",
        message_id: "4f5b5491f1774_181b23fc3d4434d38138e5@mba.local.mail",
        started_at: 1370939788.0706801,
        ended_at:   1370939789.0706801,
        duration:   0.321,
      }
    ]
  }
end
