class Source < ActiveRecord::Base
  belongs_to :app

  has_many :requests,
    dependent: :destroy

  has_many :sql_events,
    through: :requests

  has_many :view_events,
    through: :requests

  has_many :mailer_events,
    through: :requests

  has_many :n_plus_one_queries,
    through: :requests

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

  def latest_requests(limit: nil)
    requests.order(created_at: :desc).limit(limit)
  end

  def latest_n_plus_one_query
    n_plus_one_queries.order(:created_at).last
  end

  def median_request_duration_by_day
    requests.
      group("DATE(created_at)").
      select("DATE(created_at) AS date, median(duration) AS duration")
  end
end
