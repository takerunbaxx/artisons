class CommentsController < ApplicationController
    

def create 
  post =Post.find(params[:post_id])
  @comment=post.comments.build(comment_params)
  @comment.user_id=current_user.id
  @comment_post = @comment.post
  if @comment.save
    render "comment_list"
  @comment_post.create_notification_comment!(current_user, @comment.id)
  end
end


def destroy
  @comment = Comment.find(params[:id])
  @comment.destroy
  render "comment_list"
end




private
    
def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
    
end

end
