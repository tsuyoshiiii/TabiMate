class Public::MembersController < ApplicationController

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_path(@member.id)
    else
      render :new
    end
  end

  def index
    @members = Member.all
    @member = current_member
  end

  def show
    @member = Member.find(params[:id])
    @posts = @member.posts
    @post = @member.posts.order(created_at: :desc).first
  end

  def edit
    @member = Member.find(params[:id])
    unless @member.id == current_member.id
      redirect_to member_path(current_member)
    else
      @member = Member.find(params[:id])
    end
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_without_current_password(member_params)
      flash[:notice] = "You have updated member successfully."
      redirect_to member_path(@member)
    else
      render :edit
    end
  end

  def destroy
    @member = Member.find(params[:id]) 
    @member.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to root_path
  end

  

  private

  def member_params
    params.require(:member).permit(:name, :introduction, :profile_image)
  end

end
