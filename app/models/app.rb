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

  DoesNotExist = Class.new(Exception)
end
