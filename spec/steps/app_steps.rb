step "I create a new App named :app_name" do |app_name|
  visit new_app_path
  fill_in "Name", with: app_name
  click_button "Create"
end

# step "I have an App named :app_name" do |name|
#   @app = App.make!(name: app_name)
# end
# 
# step "I visit the App overview page" do
#   visit app_url(@app)
# end
