require 'acceptance_spec_helper'

feature "Updating account settings" do
  background do
    sign_in_as User.make!
  end

  scenario "updating email address" do
    visit settings_account_path

    fill_in "Email", with: "shinji@nerv.org"
    click_button "Update"

    expect_to_see "Updated your account"
  end
end
