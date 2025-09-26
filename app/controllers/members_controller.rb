class MembersController < ApplicationController

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to member_path(@member.id), notice: 'Welcome! You have signed up successfully.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
end
