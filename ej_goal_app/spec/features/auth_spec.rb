require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('New User')
  end
  feature 'signing up a user' do
    user = User.new(name: 'Chipotle', password: 'fajitas')
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in('Name', with: user.name)
      fill_in('Password', with: user.password)
      click_button("Sign Up")
      expect(page).to have_content(user.name)
    end
  end
end

feature 'logging in' do
  user = User.create(name: 'Moe', password: 'burrito')
  scenario 'shows username on the homepage after login' do
    log_in(user)
    expect(page).to have_content(user.name)
  end


end

feature 'logging out' do
  user = User.create(name: 'Moe', password: 'burrito')
  logged_in = user.session_token
  before :each do
    log_in(user)
    log_out(user)
  end

  scenario 'begins with a logged out state' do
    expect(logged_in).not_to eq(user.session_token)
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    expect(page).not_to have_content(user.name)
  end

end
