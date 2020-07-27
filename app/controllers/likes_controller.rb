class LikesController < ApplicationController
  
  def create
    @post=Post.find(params[:post_id])
    current_user.like(@post)
    @post.create_notification_like!(current_user)
    respond_to do |format|
      format.html {redirect_to likes_user_url(current_user.id), flash: {success: 'Liked!'} }
      format.js  end
  end

  def destroy
    @post=Post.find(params[:post_id])
    current_user.unlike(@post)
    respond_to do |format|
      format.html {redirect_to likes_user_url(current_user.id), flash: {secondary: 'Unliked!'} }
      format.js  end
  end
end
