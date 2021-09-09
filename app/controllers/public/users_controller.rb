class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: %i[edit show update]
  before_action :set_current_user, only: %i[unsubscribe withdraw]
  before_action :set_correct_user, only: %i[edit update]

  def show
    @user_posts = Post.where(user_id: @user, is_draft: false).order(created_at: :desc).page(params[:posts_page]).per(8)
    @liked_posts = Post.includes(:user).joins(:likes).where(is_draft: false,
                                                            'likes.user_id': @user.id).order('likes.created_at': 'DESC').page(params[:liked_page]).per(8)
    @saved_posts = Post.includes(:user).joins(:bookmarks).where(is_draft: false,
                                                                'bookmarks.user_id': @user.id).order('bookmarks.created_at': 'DESC').page(params[:saved_page]).per(8)
    @draft_posts = Post.where(user_id: @user, is_draft: true).order(created_at: :desc).page(params[:draft_page]).per(8)
    @browsed_posts = Post.includes(:user).joins(:histories).where(is_draft: false,'histories.user_id': @user.id).order('histories.created_at': 'DESC').page(params[:browsed_page]).per(8)
    @following_users = @user.following_user
    @follower_users = @user.follower_user
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: 'プロフィールを更新しました！'
    else
      render :edit, alert: 'プロフィールを更新できませんでした。'
    end
  end

  def unsubscribe
    if @user.id == 1
      redirect_to root_path, alert: '恐れ入りますが、ゲスト会員では退会できません。'
    else
      render :unsubscribe
    end
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = 'ご利用いただき、ありがとうございました。'
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_user.page(params[:page]).per(20)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user.page(params[:page]).per(20)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image, :introduction, :is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
  end

  def set_correct_user
    redirect_to root_path unless @user == current_user
  end
end
