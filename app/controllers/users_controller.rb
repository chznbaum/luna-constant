class UsersController < ApplicationController
  before_action :authenticate_user!
  access all: [], user: [], helper: :all, site_admin: :all

  def index
    @users = User.all.order("created_at ASC").page(params[:page]).per(12)
  end

end