class SqlEvent < ActiveRecord::Base
  belongs_to :transaction

  validates :transaction, presence: true
end
