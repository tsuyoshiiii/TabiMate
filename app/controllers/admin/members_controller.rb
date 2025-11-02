class Admin::MembersController < ApplicationController
    before_action :authenticate_admin!
    def destroy
        @member = Member.find(params[:id])
        @member.destroy
        redirect_to admin_dashboards_path, notice: 'メンバーを削除しました。'
    end

    def show
        @member = Member.find(params[:id])
    end
end
