class PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.member_id = current_member.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to post_path(@post.id)
    else
      @posts = Post.all
      render 'new'
    end
  end


  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])  
    @member = @post.member
  end

  def edit
    @post = Post.find(params[:id])
    member = @post.member
    unless member.id == current_member.id
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post)
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])  
    @post.destroy  
    redirect_to posts_path  
  end

  def index
    if params[:search]
      @posts = Post.where("title LIKE ? OR body LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @posts = Post.all
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
