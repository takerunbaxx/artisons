class PostsController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :ensure_current_user, only: [:edit, :destroy]
  
def index
  @posts=current_user.posts.all.order(created_at: :asc).page(params[:page]).per(25)
  count(current_user)
end

def new
  @post=Post.new
end

def show
  @post=Post.find(params[:id])
  @comment=Comment.new
  @comments = @post.comments.order(created_at: :asc).page(params[:page]).per(25)
end


def create
 @post=current_user.posts.build(post_params)
 if @post.save
   flash[:success]="New one's just been posted!"
   redirect_to user_url(current_user.id)
   else
    @posts = current_user.posts_together.order(created_at: :asc).page(params[:page]).per(25)
    flash.now[:secondary] = 'Your posting failed!'
    render :new
 end
end

def edit
  @post=Post.find(params[:id])
end

def update
 @post=current_user.posts.find(params[:id])
 if @post.update(post_params)
   flash[:success]="Your post is updated!"
   redirect_to user_url(current_user.id)
 end
end

def destroy
  @post.destroy    
  flash[:danger]="Deleted the article"
  redirect_back(fallback_location: posts_path)
end

private

def post_params
  params.require(:post).permit(:title,:content,:category,:outline,:post_image_name)
end

def ensure_current_user
  @post=current_user.posts.find_by(id: params[:id])
  unless @post
  redirect_to root_url
  end
end

end
