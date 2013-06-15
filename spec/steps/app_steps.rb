step "I create a new App named :app_name" do |app_name|
  visit new_app_path
  fill_in "Name", with: app_name
  click_button "Create"
end

step "I have an App named :app_name" do |app_name|
  @app = App.make!(:with_access_token, user: @user, name: app_name)
end

step "the app has Transactions:" do |table|
  table.hashes.each do |hash|
    Transaction.make!(app: @app,
                      controller: hash["Controller"],
                      action:     hash["Action"],
                      db_runtime: hash["DB Runtime"])
  end
end

step "I visit the App overview page" do
  visit app_url(@app)
end
