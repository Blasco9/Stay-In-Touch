class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, -> { where(status: 'accepted') }
  has_many :friends, through: :friendships

  def friendship_requests
    Friendship.where("(user_id = #{id} OR friend_id = #{id}) AND status = 'pending'").take
  end
end
