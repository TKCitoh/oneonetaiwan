class Admin::CommentsController < Admin::ApplicationController
  def index
    end_user_id = params[:end_user_id]
    @comments = Comment.where(end_user_id: end_user_id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, alart: "削除しました。"
  end
end
