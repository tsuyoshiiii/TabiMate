class Public::GuestSessionsController < ApplicationController
  
  def create
    member = Member.guest
    
    sign_in member
    
    redirect_to member_path(member), notice: "ゲストユーザーでログインしました。"
  end
end