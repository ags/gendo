step 'I sign up as:' do |table|
  visit signup_path
  details = table.hashes.first
  fill_in 'Email', with: details['Email']
  fill_in 'Password', with: details['Password']
  click_button 'Sign Up'
end
