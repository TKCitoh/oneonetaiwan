class Public::LikesController < Public::ApplicationController
  def create
    post = Post.find(params[:post_id])
    like = current_end_user.likes.new(post_id: post.id)
    like.save
    redirect_to post_path(post), notice: '投稿にいいねしました。:)'
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_end_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to post_path(post), notice: 'いいねを取り消しました。:)'
  end
end
