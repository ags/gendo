require "spec_helper"

require "capybara/rspec"
require "capybara/rails"

def sign_in_as(user)
  visit sign_in_as_path(user_id: user.id)
end

def expect_to_see(content)
  expect(page).to have_content(content)
end
