class FriendshipsController < ApplicationController
  def create
    puts params
    @friendship = Friendship.new(user_id: current_user.id, friend_id: params[:id], status: 'pending')

    if @friendship.save
      respond_to do |format|  
        format.js { }
      end 
    else
      @friendship.errors.messages
    end
  end

  def accept
    @friendship = Friendship.where("user_id = ? AND friend_id = ?", params[:id].to_i, current_user.id).take

    @friendship.status = 'accepted'

    if @friendship.save
      respond_to do |format|  
        format.js { }
      end 
    else
      @friendship.errors.messages
    end
  end

  def destroy
    @friendship = current_user.requested_friendships.find_by(friend_id: params[:id]) ||
                  current_user.friendships_requests.find_by(user_id: params[:id])

    if @friendship.destroy
      respond_to do |format|  
        format.js { }
      end 
    else
      @friendship.errors.messages
    end
  end
end
