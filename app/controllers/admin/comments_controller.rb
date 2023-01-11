class Admin::CommentsController < Admin::ApplicationController
  def index
    @comments = Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, alart: "削除しました。"
  end
end
