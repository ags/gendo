module HasAccessTokens
  extend ActiveSupport::Concern

  included do
    has_many access_tokens_relation_name,
      dependent: :destroy

    def access_tokens
      __send__(self.class.access_tokens_relation_name)
    end

    def current_access_token
      access_tokens.last
    end
  end

  module ClassMethods
    def access_tokens_relation_name
      :"#{name.downcase}_access_tokens"
    end

    def with_access_token!(access_token)
      # TODO this should check for current token
      joins(access_tokens_relation_name).
        where(access_tokens_relation_name => {token: access_token}).
        first!
    end
  end
end
