require 'rails_helper'

RSpec.describe 'Creating a new like', type: :feature do
  let(:user) { User.create(name: 'test_user', email: 'user@gmail.com', password: 'password') }

  before(:each) do
    user.posts.create(content: 'post content')
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

  scenario 'Liking a post' do
    visit root_path
    click_on 'Like!'
    expect(page).to have_content('You liked a post.')
  end

  scenario 'Disliking a post' do
    visit root_path
    click_on 'Like!'
    click_on 'Dislike!'
    expect(page).to have_content('You disliked a post.')
  end
end
