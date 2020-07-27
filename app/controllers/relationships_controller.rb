class RelationshipsController < ApplicationController
  
  def create
    @user=User.find(params[:follow_id])
    current_user.follow(@user)
   @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html {redirect_to followings_user_url(current_user.id), flash: {success: 'Followed!'} }
      format.js  end

  end

  def destroy
    @user=User.find(params[:follow_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_to followings_user_url(current_user.id), flash: {secondary: 'Unfollowed!'} }
      format.js  end
  end

end
