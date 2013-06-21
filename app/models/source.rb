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
    TransactionStats.new(transactions, :db_runtime)
  end

  def view
    TransactionStats.new(transactions, :view_runtime)
  end

  def duration
    TransactionStats.new(transactions, :duration)
  end

  class TransactionStats < Struct.new(:transactions, :attribute)
    def median
      # using #first here attempts to do a LIMIT
      @_median ||= transactions.
        select("median(#{attribute}) AS median")[0].median
    end

    def min
      @_min ||= transactions.order(attribute).limit(1).first
    end

    def max
      @_max ||= transactions.order("#{attribute} DESC").limit(1).first
    end
  end
end
