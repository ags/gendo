class Transaction < ActiveRecord::Base
  validates :controller,
    presence: true

  validates :action,
    presence: true
end
