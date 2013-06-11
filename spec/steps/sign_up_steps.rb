step 'I sign up as:' do |table|
  visit signup_path
  details = table.hashes.first
  fill_in 'Email', with: details['Email']
  fill_in 'Password', with: details['Password']
  click_button 'Sign Up'
end

step 'I should be logged in' do
  expect(page).to have_content('logout')
end
