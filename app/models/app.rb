class App < ActiveRecord::Base
  include RetryOnException
  include HasAccessTokens

  belongs_to :user

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

  def self.from_param(param)
    id = param.split("-").first
    where(id: id).first!
  end

  def slug
    "#{id}-#{name.parameterize}"
  end

  def find_or_create_source!(params)
    retry_on_exception(ActiveRecord::RecordNotUnique) do
      sources.where(params).first_or_create!
    end
  end
end
