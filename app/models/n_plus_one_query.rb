class NPlusOneQuery < ActiveRecord::Base
  belongs_to :transaction

  validates :transaction,
    presence: true

  validates :culprit_table_name,
    presence: true
end
