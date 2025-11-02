class Admin::DashboardsController < ApplicationController
    layout 'admin'
    before_action :authenticate_admin!
    def index
        @members = Member.all
    end
end
