class Public::EndUsersController < Public::ApplicationController
  before_action :set_end_user, only: [:likes]
  before_action :guest_check

  def show
    @end_user = current_end_user
    @posts = @end_user.posts.page(params[:page])
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user
    if @end_user.update(end_user_params)
      redirect_to end_users_my_page_path, notice: "更新完了しました。"
    else
      render :edit
    end
  end

  def unsubscribe
    @end_user = current_end_user
  end

  def withdraw
    end_user = current_end_user
    end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path, alart: "退会しました。"
  end

  def likes
    post_ids = Like.where(end_user_id: @end_user.id).pluck(:post_id)
    @posts = Post.where(id: post_ids).page(params[:page])
  end

  private
    def end_user_params
      params.require(:end_user).permit(:name, :email, :profile_image)
    end

    def set_end_user
      @end_user = current_end_user
    end

    def guest_check
      if current_end_user.email == "ttt@ttt.com"
        redirect_to root_path, notice: "このページを見るには会員登録が必要です。"
      end
    end
end
