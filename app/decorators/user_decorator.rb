class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_url(size=36)
    require 'digest/md5'
    "https://www.gravatar.com/avatar/%s.jpg?s=%d&d=%s" % [
      Digest::MD5.hexdigest(email),
      size,
      'mm',
    ]
  end
end
