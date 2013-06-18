step "I create a new App named :app_name" do |app_name|
  visit new_app_path
  fill_in "Name", with: app_name
  click_button "Create"
end
