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
  app
  controller { "PostsController" }
  action     { "new" }
end

App.blueprint do
  user
  name { "Shinji Ikari" }
end

App.blueprint(:with_access_token) do
  app_access_tokens { [AppAccessToken.make!] }
end
