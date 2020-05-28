class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :requested_friendships, foreign_key: :user_id, class_name: 'Friendship'
  has_many :requested_friends, through: :requested_friendships, source: :user
  has_many :friendships_requests, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :requesting_friends, through: :friendships_requests, source: :user
end
