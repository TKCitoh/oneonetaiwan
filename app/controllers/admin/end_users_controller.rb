class Admin::EndUsersController < ApplicationController
  def index
    @end_users = EndUser.all
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
  end
end
