class Public::CommentsController < Public::ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_to post_path(post), notice: "コメントを投稿しました。"
    else
      @error_comment = comment
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @post_tags = @post.tags
      render template: "public/posts/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to post_path(params[:post_id]), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
