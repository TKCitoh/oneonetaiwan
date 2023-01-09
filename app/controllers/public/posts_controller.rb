class Public::PostsController < Public::ApplicationController
  #ゲストのアクセス制限
  before_action :guest_check, except: [:index, :show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.page(params[:page])
    @tag_list=Tag.all
  end

  def edit
    @post = Post.find(params[:id])
    if @post.end_user == current_end_user
      render :edit
    else
      redirect_to post_path(@post)
    end
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
        @old_relations = PostTag.where(post_id: @post.id)
          @old_relations.each do |relation|
            relation.delete
          end
        @post.save_tag(tag_list)
        redirect_to post_path(@post.id), notice: "更新完了しました。"
    else
      render:edit
    end
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    tag_list = params[:tag][:name].split(',')
    if @post.save
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id), notice: "投稿完了しました。"
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @post_tags = @post.tags
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, alart: "投稿を削除しました。"
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end

  private

  def post_params
    params.require(:post).permit(:video, :title, :caption, :image, :address, :latitude, :longitude)
  end

  #ゲストのアクセス制限
  def guest_check
    if current_end_user.email == "ttt@ttt.com"
      redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
    end
  end

end
