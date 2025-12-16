class Public::GroupsController < ApplicationController
    before_action :authenticate_member! # ログイン必須
    before_action :ensure_owner, only: [:applications, :approve_application, :reject_application]

  # グループ一覧表示 (検索機能もここに実装)
  def index
    @groups = Group.all.order(created_at: :desc)
    # TODO: 検索機能のロジックを追加
  end

  # 新規グループ作成フォーム
  def new
    @group = Group.new
  end

  # グループ作成実行
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id

    if @group.save
      # グループ作成者を自動で「承認済み」メンバーとして追加
      @group.group_members.create(member_id: current_member.id, status: :approved)
      redirect_to @group, notice: '新しいグループを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @is_member = @group.group_members.approved.exists?(member_id: current_member.id) # 承認済みメンバーか
    @pending_application = @group.group_members.pending.find_by(member_id: current_member.id) # 申請中か
  end

  # ... edit, update アクションを実装 ...

  # 申請一覧表示 (オーナー向け)
def applications
  @group = Group.find(params[:id])
  # 申請中のメンバーのみを取得
  @pending_members = @group.group_members.pending.includes(:member)
end

# 申請の承認
def approve_application
  @group_member = GroupMember.find(params[:group_member_id])
  @group_member.approved! # enum statusをapproved(1)に更新
  redirect_to applications_group_path(@group_member.group), notice: "#{@group_member.member.name} を承認しました。"
end

# 申請の拒否
def reject_application
  @group_member = GroupMember.find(params[:group_member_id])
  @group_member.rejected! # enum statusをrejected(2)に更新
  redirect_to applications_group_path(@group_member.group), notice: "#{@group_member.member.name} の申請を拒否しました。"
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

