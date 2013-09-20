require "acceptance_spec_helper"

feature "Signing Out" do
  scenario "signing out when signed in" do
    sign_in_as(User.make!)

    click_link "Sign Out"

    expect_to_see "Sign Up"
  end
end
