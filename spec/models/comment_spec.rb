require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'Validations tests' do
    let(:user) { User.create(name: 'test_user', email: 'user@gmail.com', password: 'password') }
    let(:post) { user.posts.new(content: 'post content') }
    let(:comment) { post.comments.new(user_id: user.id, content: 'comment content') }

    it 'comment should be valid if it has some content' do
      expect(comment).to be_valid
    end

    it "comment should be invalid if it doesn't have some content" do
      comment.content = ''
      expect(comment).not_to be_valid
    end

    it 'comment should be invalid if it has content longer than 200 characters' do
      comment.content = 'a' * 201
      expect(comment).not_to be_valid
    end
  end

  context 'Associations tests' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
