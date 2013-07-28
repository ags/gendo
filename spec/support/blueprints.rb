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
  started_at { 1370939786.0706801 }
  ended_at   { 1370939787.0706801 }
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

User.blueprint do
  email    { "user#{sn}@blargh.com" }
  password { "password" }
end
