class Admin::GroupsController < ApplicationController
    before_action :authenticate_admin! 

  def index
    @groups = Group.all.includes(:owner).order(created_at: :desc)
  end

  # グループの削除
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to admin_groups_path, notice: "グループ「#{@group.name}」を削除しました。"
  end
end
