require 'machinist/active_record'

User.blueprint do
  email    { "user#{sn}@blargh.com" }
  password { "password" }
end

UserAccessToken.blueprint do
  user
  token { sn }
end
