step "there is a User:" do |table|
  details = table.hashes.first
  User.make!(email: details["Email"], password: details["Password"])
end
