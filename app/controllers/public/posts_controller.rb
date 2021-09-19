class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, except: %i[index new create search]
  before_action :set_category, except: %i[show destroy]
  before_action :set_correct_user, except: %i[index new create show search]

  def index
    @latest_posts = Post.where(is_draft: false).includes(:user).order(created_at: :desc).page(params[:page]).per(8)
  end

  def search
    @word = params[:word]
    @id = Category.find_by(name: @word).id
    @latest_posts = Post.looks(@id).where(is_draft: false).includes(:user).order(created_at: :desc).page(params[:page]).per(8)
    render :index
  end

  # 親モデル.子モデル.buildで子モデルのインスタンス作成
  def new
    @post = Post.new
    @post_ingredients = @post.ingredients.build
    @post_guides = @post.guides.build
  end

  def create
    @post = Post.new(post_params)
    # 投稿ボタンを押下した場合
    if params[:save_post]
      if @post.save(context: :publicize)
        redirect_to post_path(@post), notice: '投稿しました！'
      else
        render :new, alert: '登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください'
      end
    # 下書きボタンを押下した場合
    elsif @post.update(is_draft: true)
      redirect_to user_path(current_user), notice: '投稿を下書き保存しました！'
    else
      render :new, alert: '登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください'
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.includes(:user, :post).where(post_id: params[:id]).order(id: :desc)
    @post.browsing_history(current_user) if user_signed_in?
  end

  def edit; end

  def update
    # 下書きの更新（公開）の場合
    if params[:publicize_draft]
      @post.attributes = post_params.merge(is_draft: false)
      save_post(@post, '下書きの投稿を公開しました！')
    # 公開済み投稿の更新の場合
    elsif params[:update_post]
      @post.attributes = post_params
      save_post(@post, '投稿を更新しました！')
    # 下書きの更新（非公開）の場合
    elsif @post.update(post_params)
      redirect_to user_path(current_user), notice: '下書きを更新しました！'
    else
      render :edit, alert: '更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください'
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_path(current_user), notice: '投稿を削除しました'
    else
      render :edit, alert: '削除できませんでした。お手数ですが、再度お試しください'
    end
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :category_id, :title, :introduction, :post_image, :commentable, :is_draft,
                                 ingredients_attributes: %i[id name shop_name price _destroy],
                                 guides_attributes: %i[id guide_image body _destroy])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_correct_user
    redirect_to root_path unless @post.user == current_user
  end

  def set_category
    @categories = Category.all
  end

  def save_post(post, message)
    if post.save(context: :publicize)
      redirect_to post_path(post.id), notice: message
    else
      post.is_draft = true
      render :edit, alert: '更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください'
    end
  end
end
