class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    # ポストの動き
    @post = current_user.posts.new(post_params) 
    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end

    # コメントの動き
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user 
    if @comment.save
      redirect_to @post
    else
      redirect_to @post
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comments = @post.comments
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post,comment).permit(:name, :text,comment)
  end

end
