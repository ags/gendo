class AccountsController < ApplicationController
  before_action :assert_authenticated!

  def settings
    render locals: {user: current_user}
  end
end
