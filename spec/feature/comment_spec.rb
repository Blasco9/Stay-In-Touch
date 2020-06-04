require 'rails_helper'

RSpec.describe 'Creating a new comment', type: :feature do
  let(:user) { User.create(name: 'test_user', email: 'user@gmail.com', password: 'password') }

  before(:each) do
    user.posts.create(content: 'post content')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'valid creation' do
    visit root_path
    fill_in placeholder: 'Add new Comment', with: 'Testing comment creation'
    click_on 'Comment'
    expect(page).to have_content('Comment was successfully created.')
  end

  scenario 'invalid creation' do
    visit root_path
    click_on 'Comment'
    expect(page).to have_content("Content can't be blank")
  end
end
