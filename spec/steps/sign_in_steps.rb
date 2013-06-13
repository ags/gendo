step "I sign in as:" do |table|
  visit sign_in_path
  details = table.hashes.first
  fill_in 'Email', with: details['Email']
  fill_in 'Password', with: details['Password']
  click_button 'Login'
end
