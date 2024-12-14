class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def publish
    @post.draft?
    @post.update(status: "published") 
    redirect_to @post
  end

  def index
    @posts = Post.published.order(created_at: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user 
    @recent_posts = @user.posts.order(created_at: :desc).limit(6)
    @comments = @post.comments.includes(:user)
    @keyword = params[:keyword]
  end

  def posts
    @posts = @user.posts.order(created_at: :desc)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def confirm
    @drafts = Post.where(status: "draft").order(created_at: :desc)
  end

  def update
    post = Post.find(params[:id])
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def search
    @categories = Category.all
    @posts = Post.none
    
    # 検索キーワードがあれば条件を追加
    if params[:keyword].present? || params[:category_id].present?
      @posts = Post.published
      @posts = @posts.where("name LIKE ? OR text LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
      @posts = @posts.where(category_id: params[:category_id]) if params[:category_id].present?
      @posts = @posts.order(created_at: :desc).page(params[:page])
    end
    
      # カテゴリが選択されていれば条件を追加
    if params[:category_id].present?
      @posts = @posts.where(category_id: params[:category_id])
    end
    
      # 並び順とページネーションを追加
    @posts = @posts.order(created_at: :desc).page(params[:page])
    
      # キーワードをビューに渡す
    @keyword = params[:keyword]
    end    


  private
  def post_params
    params.require(:post).permit(:name, :text, :image, :status)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
