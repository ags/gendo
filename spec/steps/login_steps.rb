step "I login as:" do |table|
  visit login_path
  details = table.hashes.first
  fill_in 'Email', with: details['Email']
  fill_in 'Password', with: details['Password']
  click_button 'Login'
end
