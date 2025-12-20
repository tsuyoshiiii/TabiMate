class Public::GroupsController < ApplicationController
    before_action :authenticate_member! 
    before_action :ensure_owner, only: [:edit, :update, :applications, :approve_application, :reject_application]

  def index
    if params[:search].present?
    @groups = Group.where('name LIKE ? OR introduction LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
  else
    @groups = Group.all
  end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id

    if @group.save
      @group.group_members.create(member_id: current_member.id, status: :approved)
      redirect_to @group, notice: '新しいグループを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @is_member = @group.group_members.approved.exists?(member_id: current_member.id) 
    @pending_application = @group.group_members.pending.find_by(member_id: current_member.id) 
  end

def applications
  @group = Group.find(params[:id])
  @pending_members = @group.group_members.pending.includes(:member)
end


def approve_application
  @group_member = GroupMember.find(params[:group_member_id])
  @group_member.approved! # enum statusをapproved(1)に更新
  redirect_to applications_group_path(@group_member.group), notice: "#{@group_member.member.name} を承認しました。"
end


def reject_application
  @group_member = GroupMember.find(params[:group_member_id])
  @group_member.rejected! # enum statusをrejected(2)に更新
  redirect_to applications_group_path(@group_member.group), notice: "#{@group_member.member.name} の申請を拒否しました。"
end

def edit
  @group = Group.find(params[:id]) 
end

def update
  @group = Group.find(params[:id])
  if @group.update(group_params)
    redirect_to group_path(@group), notice: 'グループ情報を更新しました。'
  else
    render :edit
  end
end

  private

  def ensure_owner
    if params[:id].present?
      @group = Group.find(params[:id])
    elsif params[:group_member_id].present?
      @group = GroupMember.find(params[:group_member_id]).group
    else
      
      redirect_to root_path, alert: 'アクセスに必要な情報がありません。'
      return
    end
    
    unless @group.owner_id == current_member.id
      redirect_to root_path, alert: 'アクセス権限がありません。'
    end
  end 
    
  def group_params 
    params.require(:group).permit(:name, :introduction) 
  end
end

