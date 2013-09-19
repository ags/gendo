class SqlEvent < ActiveRecord::Base
  belongs_to :request

  validates :request,
    presence: true

  def cached?
    name == 'CACHED'
  end
end
