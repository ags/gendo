class ViewEvent < ActiveRecord::Base
  belongs_to :transaction

  validates :transaction, presence: true

  validates :identifier, presence: true
end
