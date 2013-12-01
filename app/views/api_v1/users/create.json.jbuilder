json.user do |json|
  json.partial! 'resource', user: @user
end

json.authentication do |json|
  json.partial! '/api_v1/authentications/resource',
    authentication: @authentication
end
