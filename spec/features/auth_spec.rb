require 'rails_helper'

feature 'the signup process' do
  background :each do
    visit new_user_path
  end
  scenario 'has a new user page' do
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content('Username')
      expect(page).to have_content('Password')
    end
    scenario 'redirects to user\'s show page' do
      fill_in 'Username', with: 'Rishabh'
      fill_in 'Password', with: 'password'
      click_button 'Create User'

      user = User.find_by(username: 'Rishabh')
      expect(current_url).to eq(user_url(user))
    end
  end
end

feature 'logging in' do

  background :each do
    User.create(username: 'Rishabh', password: 'password')
    visit new_session_path
  end
  scenario 'shows username on the homepage after login' do
    fill_in 'Username', with: 'Rishabh'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'

    expect(page).to have_content('Rishabh')
    user = User.find_by(username: 'Rishabh')
    expect(current_url).to eq(user_url(user))
  end

end

feature 'logging out' do
  background :each do
    User.create(username: 'Rishabh', password: 'password')
    visit new_session_path
    save_and_open_page
    fill_in 'Username', with: 'Rishabh'
    fill_in 'Password', with: 'password'
    click_button 'Sign In'
  end
  scenario 'begins with a logged out state' do
    expect(page).to have_button('Sign Out')
    save_and_open_page
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    click_button 'Sign Out'
    expect(page).not_to have_content('Rishabh')
    save_and_open_page
  end

end
