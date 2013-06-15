class App < ActiveRecord::Base
  belongs_to :user

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

  DoesNotExist = Class.new(Exception)
end
