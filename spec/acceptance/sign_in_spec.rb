require "acceptance_spec_helper"

feature "Signing in" do
  background do
    User.make!(email: "bob@example.com", password: "password")
  end

  scenario "signing in successfully" do
    visit sign_in_path

    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect_to_see "Sign Out"
  end

  scenario "entering the wrong password" do
    visit sign_in_path

    fill_in "Email", with: "bob@example.com"
    fill_in "Password", with: "foobar"
    click_button "Sign In"

    expect_to_see "Incorrect email or password"
  end
end
