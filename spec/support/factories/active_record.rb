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
  request
  mailer     { "FooMailer" }
  message_id { "123456789" }
  started_at { Time.now }
  ended_at   { Time.now }
  duration   { 0.1234 }
end

NPlusOneQuery.blueprint do
  request
  culprit_table_name { "posts" }
end

Source.blueprint do
  app
  controller    { "PostsController" }
  action        { "new" }
  method_name   { "GET" }
  format_type   { "*/*" }
end

SqlEvent.blueprint do
  request
  sql        { "SELECT * FROM posts" }
  started_at { Time.now }
  ended_at   { Time.now }
  duration   { 0.1234 }
end

Request.blueprint do
  source
end

Request.blueprint(:with_zero_runtime) do
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