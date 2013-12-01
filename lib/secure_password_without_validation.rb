require "bcrypt"

# This is ActiveModel::SecurePassword with validations and
# MassAssignmentSecurity nonsense stripped out. It depends on
# ActiveModel::SecurePassword::InstanceMethodsOnActivation.
module SecurePasswordWithoutValidation
  extend ActiveSupport::Concern

  # Adds methods to set and authenticate against a BCrypt password.
  # This mechanism requires you to have a password_digest attribute.
  #
  # Validations for presence of password, confirmation of password (using
  # a "password_confirmation" attribute) are automatically added.
  # You can add more validations by hand if need be.
  #
  # You need to add bcrypt-ruby (~> 3.0.0) to Gemfile:
  #
  #   gem "bcrypt-ruby", "~> 3.0.0"
  #
  # Example using Active Record (which automatically includes ActiveModel::SecurePassword):
  #
  #   # Schema: User(name:string, password_digest:string)
  #   class User < ActiveRecord::Base
  #     include SecurePasswordWithoutValidation
  #   end
  #
  #   user = User.new(:name => "david", :password => "")
  #   user.save                                                      # => true
  #   user.password = "mUc3m00RsqyRe"
  #   user.save                                                      # => true
  #   user.authenticate("notright")                                  # => false
  #   user.authenticate("mUc3m00RsqyRe")                             # => user
  #   User.find_by_name("david").try(:authenticate, "notright")      # => nil
  #   User.find_by_name("david").try(:authenticate, "mUc3m00RsqyRe") # => user
  #
  included do
    attr_reader :password
    include ActiveModel::SecurePassword::InstanceMethodsOnActivation
  end

end
