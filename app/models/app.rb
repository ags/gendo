class App < ActiveRecord::Base
  belongs_to :user

  has_many :app_access_tokens,
    dependent: :destroy

  has_many :sources,
    dependent: :destroy

  has_many :transactions,
    through: :sources,
    dependent: :destroy

  validates :user,
    presence: true

  validates :name,
    presence: true

  def self.from_param(param)
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

  def current_access_token
    app_access_tokens.last
  end

  def sources_by_median_desc(field, limit: 3)
    sources.
      joins(:transactions).
      group("sources.id").
      order("median(transactions.#{field}) DESC").
      limit(limit)
  end
end
