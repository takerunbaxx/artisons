class UsersController < ApplicationController

before_action :require_user_logged_in, except:[:new, :create]
before_action :ensure_current_user, only: [:edit]

def index
  if params[:name].present?
    @users = User.where('name LIKE ?', "%#{params[:name]}%").page(params[:page]).per(25)
  else
    @users = User.all
  end
end


def new
  @user=User.new
end

def create
  @user=User.new(user_params)
  if @user.save
     flash[:success]="Welcome to Artisons! Please login from this page"
     redirect_to login_url
  else
      flash.now[:danger]="Registration failed"
      render :new
  end
end

def show
  @user=User.find(params[:id])
  @followings=@user.followings.order(id: :desc).page(params[:page]).per(25)
  @followers=@user.followers.order(id: :desc).page(params[:page]).per(25)
 if current_user == @user
   @posts=@user.posts_together.order(created_at: :asc).page(params[:page]).per(25)
 else
   @posts=@user.posts.all.page(params[:page]).per(25)
 end
  
end

def edit
  @user=User.find(params[:id])
end

def update
  @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="Your profile is updated"
      redirect_to @user
    else
      flash[:secondary]="Update failed"
      render :edit
    end
end


def likes_list
  @user=User.find(params[:id])
  @likes=@user.likings.order(id: :desc).page(params[:page]).per(25)
end

private

def ensure_current_user
  @user=User.find_by(id: params[:id])
  unless @user == current_user
  redirect_to root_url
  end
end

def user_params
  params.require(:user).permit(:name,:email,:password,:password_confirmation,:bio,:curiosity,:country,:gender,:image, :role )
end


end