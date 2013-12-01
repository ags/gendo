class UserAuthenticationSerializer < ActiveModel::Serializer
  attributes \
    :user_id,
    :access_token
end
