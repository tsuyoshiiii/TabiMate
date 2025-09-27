class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to posts_path
    else
      @posts = Post.all
      render 'index'
    end
  end


  def index
    @posts = Post.all
  end

  def show
  end

  def edit
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
