class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = @user.posts.published.order(created_at: :desc).limit(6)
    @following_users = @user.followings
    @follower_users = @user.followers
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end

  def posts
    @user = User.find(params[:id]) 
    if @user == current_user
      @posts = @user.posts.order(created_at: :desc).page(params[:page])
    else
      @posts = @user.posts.published.order(created_at: :desc)
    end
  end

  private

  def user_params
    params.require(:user).permit(:handle_name, :email, :password, :password_confirmation, :profile, :profile_image)
  end
end
