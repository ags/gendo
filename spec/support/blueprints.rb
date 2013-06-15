require "machinist/active_record"

User.blueprint do
  email    { "user#{sn}@blargh.com" }
  password { "password" }
end

UserAccessToken.blueprint do
  user
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
