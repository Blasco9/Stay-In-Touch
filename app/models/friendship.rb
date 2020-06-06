class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_update do |f|
    Friendship.create(user_id: f.friend_id, friend_id: f.user_id, status: 'accepted')
  end

  after_destroy do |f|
    friendship = Friendship.find_by(user_id: f.friend_id, friend_id: f.user_id)
    friendship.destroy unless friendship.nil?
  end
end
