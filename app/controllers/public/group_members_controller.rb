class Public::GroupMembersController < ApplicationController
    before_action :authenticate_member!

  def create
    @group = Group.find(params[:group_id])
    @group_member = @group.group_members.new(member_id: current_member.id, status: :pending)

    if @group_member.save
      redirect_to @group, notice: 'グループへの参加を申請しました。承認をお待ちください。'
    else
      redirect_to @group, alert: '申請に失敗しました。'
    end
  end


  def destroy
    @group = Group.find(params[:group_id])
    @group_member = @group.group_members.find_by(member_id: current_member.id)

    if @group_member.destroy
      redirect_to @group, notice: 'グループから脱退しました。'
    else
      redirect_to @group, alert: '脱退に失敗しました。'
    end
  end
end
