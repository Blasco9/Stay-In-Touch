require 'rails_helper'

RSpec.describe 'Creating and destroying friendship invitation', type: :feature, js: true do
  let(:user) { User.create(name: 'test_user', email: 'user@gmail.com', password: 'password') }
  let(:friend) { User.create(name: 'friend', email: 'friend@gmail.com', password: 'password') }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'
    click_on 'Sign out'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'friendship request creation from all users page' do
    visit users_path
    click_on 'Add as Friend'
    expect(page).to have_content('PENDING')
  end

  scenario 'friendship request aceptation from all users page' do
    visit users_path
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit users_path
    click_on 'Accept'
    expect(page).to have_content('UNFRIEND')
  end

  scenario 'friendship request rejection from all users page' do
    visit users_path
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit users_path
    click_on 'Reject'
    expect(page).to have_content('ADD AS FRIEND')
  end

  scenario 'friendship request creation from user profile page' do
    visit user_path friend
    click_on 'Add as Friend'
    expect(page).to have_content('PENDING')
  end

  scenario 'friendship request aceptation from user profile page' do
    visit user_path friend
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit user_path friend
    click_on 'Accept'
    expect(page).not_to have_content('ACCEPT', 'REJECT')
  end

  scenario 'friendship request rejection from user profile page' do
    visit user_path friend
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit user_path friend
    click_on 'Reject'
    expect(page).not_to have_content('ACCEPT', 'REJECT')
  end
end
