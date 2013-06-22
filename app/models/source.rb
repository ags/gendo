class Source < ActiveRecord::Base
  belongs_to :app

  has_many :transactions

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

  def db
    Gendo::TransactionStats.new(transactions, :db_runtime)
  end

  def view
    Gendo::TransactionStats.new(transactions, :view_runtime)
  end

  def duration
    Gendo::TransactionStats.new(transactions, :duration)
  end
end
