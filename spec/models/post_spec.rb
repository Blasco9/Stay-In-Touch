require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Validations tests' do
    let(:user) { User.new(name: 'test_user', email: 'user@gmail.com', password: 'password') }
    let(:post) { user.posts.new(content: 'post content') }

    it 'post should be valid if it has some content' do
      expect(post).to be_valid
    end

    it "post should be invalid if it doesn't have some content" do
      post.content = ''
      expect(post).not_to be_valid
    end

    it "post should be invalid if it has content longer than 1000 characters" do
      post.content = 'a'*1001
      expect(post).not_to be_valid
    end
  end

  context 'Associations tests' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
