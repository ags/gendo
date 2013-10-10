class App < ActiveRecord::Base
  include RetryOnException

  belongs_to :user

  has_many :app_access_tokens,
    dependent: :destroy

  has_many :sources,
    dependent: :destroy

  has_many :requests,
    through: :sources

  has_many :bulk_insertables,
    through: :requests

  has_many :n_plus_one_queries,
    through: :requests

  has_many :counter_cacheable_query_sets,
    through: :requests

  has_many :mailer_events,
    through: :requests

  validates :user,
    presence: true

  validates :name,
    presence: true

  def self.from_param!(param)
    id = param.split("-").first
    where(id: id).first!
  end

  def self.with_access_token!(access_token)
    joins(:app_access_tokens).
      where(app_access_tokens: {token: access_token}).
      first!
  end

  def to_param
    "#{id}-#{slug}"
  end

  def name=(name)
    super
    self.slug ||= name.parameterize
  end

  def find_or_create_source!(params)
    retry_on_exception(ActiveRecord::RecordNotUnique) do
      sources.where(params).first_or_create!
    end
  end

  def current_access_token
    app_access_tokens.last
  end
end
