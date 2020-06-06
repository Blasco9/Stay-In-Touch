class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:id], status: 'pending')

    if @friendship.save
      respond_to do |format|
        format.js {}
      end
    else
      @friendship.errors.messages
    end
  end

  def accept
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id)

    @friendship.status = 'accepted'

    if @friendship.save
      respond_to do |format|
        format.js {}
      end
    else
      @friendship.errors.messages
    end
  end

  def destroy
    @friendship = Friendship.find_by(user_id: params[:id], friend_id: current_user.id) ||
                  Friendship.find_by(user_id: current_user.id, friend_id: params[:id])

    if @friendship.destroy
      respond_to do |format|
        format.js {}
      end
    else
      @friendship.errors.messages
    end
  end
end
