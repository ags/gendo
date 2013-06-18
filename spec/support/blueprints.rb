require "machinist/active_record"

User.blueprint do
  email    { "user#{sn}@blargh.com" }
  password { "password" }
end

AppAccessToken.blueprint do
  app
  token { sn }
end

Transaction.blueprint do
  source
end

Source.blueprint do
  app
  controller    { "PostsController" }
  action        { "new" }
  method_name   { "GET" }
  format_type   { "*/*" }
end

App.blueprint do
  user
  name { "Shinji Ikari" }
end

App.blueprint(:with_access_token) do
  app_access_tokens { [AppAccessToken.make!] }
end
