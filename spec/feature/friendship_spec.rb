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

  scenario 'friendship request creation' do
    visit users_path
    click_on 'Add as Friend'
    expect(page).to have_content('Pending')
  end

  scenario 'friendship request aceptation' do
    visit users_path
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit users_path
    click_on 'Accept'
    expect(page).to have_content('Unfriend')
  end

  scenario 'friendship request rejection' do
    visit users_path
    click_on 'Add as Friend'
    click_on 'Sign out'

    fill_in 'Email', with: friend.email
    fill_in 'Password', with: friend.password
    click_button 'Log in'

    visit users_path
    click_on 'Reject'
    expect(page).to have_content('Add As Friend')
  end
end
