class Public::PostsController < ApplicationController
  #ゲストのアクセス制限
  before_action :guest_check, except: [:index, :show]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
    redirect_to post_path(current_end_user)
    else
    render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def search
    @post = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end

  private

  def post_params
    params.require(:post).permit(:image, :video, :title, :caption, :name)
  end

  #ゲストのアクセス制限
  def guest_check
    if current_end_user == EndUser.find(1)
      redirect_to root_path,notice: "このページを見るには会員登録が必要です。"
    end
  end

end
