class Admin::DashboardsController < ApplicationController
    before_action :authenticate_admin!
    def index
        @members = Member.all
    end
end
