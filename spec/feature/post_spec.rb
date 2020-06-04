require 'rails_helper'

RSpec.describe 'Creating a new post', type: :feature do
  let(:user) { User.create(name: 'test_user', email: 'user@gmail.com', password: 'password') }

  before(:each) do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'valid creation' do
    visit root_path
    fill_in 'Content', with: 'Testing post creation'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'invalid creation' do
    visit root_path
    click_on 'Save'
    expect(page).to have_content("Post could not be saved. Content can't be blank")
  end
end