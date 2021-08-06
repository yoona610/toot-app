class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, except: [:index, :new, :create]
  before_action :set_correct_user, except: [:index, :new, :create]

  def index
    @latest_posts = Post.page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to post_path(@post), notice: "投稿しました！"
    else
      render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: "投稿を更新しました"
    else
      render :edit, alert: "変更できませんでした。お手数ですが、再度お試しください"
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_path(current_user), notice: "投稿を削除しました"
    else
      render :edit, alert: "削除できませんでした。お手数ですが、再度お試しください"
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :introduction, :post_image_id, :is_draft)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_correct_user
    redirect_to root_path unless @post.user == current_user
  end
end
