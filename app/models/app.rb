class App < ActiveRecord::Base
  belongs_to :user

  has_many :app_access_tokens,
    dependent: :destroy

  has_many :transactions,
    dependent: :destroy

  validates :user,
    presence: true

  validates :name,
    presence: true

  def self.from_param(param)
    id = param.split("-").first
    where(id: id).first || raise(DoesNotExist)
  end

  def self.with_access_token!(access_token)
    joins(:app_access_tokens).
      where(app_access_tokens: {token: access_token}).
      first || raise(DoesNotExist)
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

  def latest_transactions
    transactions.
      select("DISTINCT ON (controller, action) *").
      order("controller, action, created_at DESC")
  end

  def transactions_with_source(source)
    controller, action = source.to_s.split("#")
    transactions.where(controller: controller, action: action)
  end

  def sources_by_median_desc(field, limit: 3)
    sources = transactions.
      select("controller || '#' || action AS name, median(#{field})").
      group(:controller, :action).
      order("median DESC").
      limit(limit)
    sources.map { |source| Source.new(self, source.name) }
  end

  DoesNotExist = Class.new(Exception)
end
