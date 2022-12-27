class Public::EndUsersController < ApplicationController
  before_action :set_end_user, only: [:likes]

  def show
    @end_user = current_end_user
    @posts = @end_user.posts
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
    likes = Like.where(end_user_id: @end_user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :email)
  end

  def set_end_user
    @end_user = current_end_user
  end
end
