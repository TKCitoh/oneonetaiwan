class Admin::PostsController < Admin::ApplicationController
  def index
    end_user_id = params[:end_user_id]
    @posts = Post.where(end_user_id: end_user_id).page(params[:page])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, alart: "削除しました。"
  end
end
