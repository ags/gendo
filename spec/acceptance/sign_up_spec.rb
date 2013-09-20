require "acceptance_spec_helper"

feature "Signing Up" do
  scenario "signing up as a new user" do
    visit signup_path

    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password"
    click_button 'Sign Up'

    expect_to_see "Sign Out"
  end

  scenario "signing up with invalid details" do
    visit signup_path

    fill_in "Email", with: "bob"
    fill_in "Password", with: "password"
    click_button 'Sign Up'

    expect_to_see "Email doesn't look right"
  end
end
