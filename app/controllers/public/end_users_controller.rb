class Public::EndUsersController < ApplicationController
  def show
    @end_user = current_end_user
  end

  def edit
    @end_user = current_end_user
  end

  def update
    end_user = current_end_user
    end_user.update(end_user_params)
    redirect_to end_users_my_page
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    end_user = current_end_user
    end_user.update(is_deleted :true)
    reset_session
    redirect_to root_path
  end

  def likes
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end
end
