json.user do |json|
  json.partial! 'resource', user: @user

  json.access_token @authentication.access_token
end
