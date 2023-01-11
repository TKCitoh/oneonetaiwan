class Admin::EndUsersController < Admin::ApplicationController
  before_action :guest_check, only: [:edit]

  def index
    @end_users = EndUser.all
  end

  def show
    @end_user = EndUser.find(params[:id])
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user), notice: "更新完了しました。"
    else
      render :edit
    end
  end

  private
  def end_user_params
    params.require(:end_user).permit(:name, :email, :is_deleted)
  end

  def guest_check
    @end_user = EndUser.find(params[:id])
    if @end_user.email == 'ttt@ttt.com'
      redirect_to admin_end_users_path, alert: "ゲストユーザー情報は編集できません。"
    end
  end
end
