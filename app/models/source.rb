class Source < ActiveRecord::Base
  belongs_to :app

  has_many :transactions,
    dependent: :destroy

  has_many :sql_events,
    through: :transactions

  has_many :view_events,
    through: :transactions

  has_many :mailer_events,
    through: :transactions

  has_many :n_plus_one_queries,
    through: :transactions

  validates :app,
    presence: true

  validates :controller,
    presence: true

  validates :action,
    presence: true

  validates :method_name,
    presence: true

  validates :format_type,
    presence: true

  def self.from_param!(param)
    id, name = param.split("-")
    where(id: id).first!
  end

  def to_param
    "#{id}-#{name}"
  end

  def name
    "#{controller}##{action}"
  end

  def latest_transactions(limit: nil)
    transactions.order(created_at: :desc).limit(limit)
  end
end
