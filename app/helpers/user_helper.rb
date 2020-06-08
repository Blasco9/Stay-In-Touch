module UserHelper
  def determine_link(user)
    u = current_user
    if u.friends.include? user
      link_to 'Unfriend', friendship_path(user.id), method: :delete, remote: true
    elsif u.friendship_requests.pluck(:user_id, :friend_id).include? [u.id, user.id]
      link_to 'Pending', friendship_path(user.id), method: :delete, remote: true
    elsif u.friendship_requests.pluck(:user_id, :friend_id).include? [user.id, u.id]
      link_to('Accept', accept_path(user.id), remote: true) +
        link_to('Reject', friendship_path(user.id), method: :delete, remote: true)
    else
      link_to 'Add as Friend', friendships_path(id: user.id), method: :post, remote: true
    end
  end

  def show_friendship_requests(friendships)
    lis = ''

    friendships.each do |f|
      lis += if f.user == current_user
               "<li>#{f.friend.name}#{determine_link f.friend}</li>"
             else
               "<li>#{f.user.name}#{determine_link f.user}</li>"
             end
    end

    lis.html_safe
  end
end
