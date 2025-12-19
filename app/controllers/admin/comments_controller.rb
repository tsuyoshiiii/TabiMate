class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = ::PostComment.includes(:member, :post).all.order(created_at: :desc)
  end

  def destroy
    @comment = ::PostComment.find(params[:id])
    if @comment.destroy
      redirect_to admin_comments_path, notice: 'コメントを不適切と判断し、削除しました。'
    else
      redirect_to admin_comments_path, alert: '削除に失敗しました。'
    end
  end
end
