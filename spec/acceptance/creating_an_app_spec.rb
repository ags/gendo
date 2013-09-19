require "acceptance_spec_helper"

feature "Creating an App" do
  background do
    sign_in_as(User.make!)
  end

  scenario "creating a new App" do
    visit new_app_path

    fill_in "Name", with: "Shinji"
    click_button "Create"

    expect_to_see "Shinji"
  end

  scenario "entering an invalid name during App creation" do
    visit new_app_path

    fill_in "Name", with: ""
    click_button "Create"

    expect_to_see "Name is too short"
  end
end
