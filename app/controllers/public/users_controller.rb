class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:edit, :show, :update]
  before_action :set_current_user, only: [:unsubscribe, :withdraw]
  before_action :set_correct_user, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "プロフィールを更新しました！"
    else
      render :edit, alert: "プロフィールを更新できませんでした。"
    end
  end

  def unsubscribe
    if @user.id == 2
      redirect_to root_path, alert: "恐れ入りますが、ゲスト会員では退会できません。"
    else
      render :unsubscribe
    end
  end

  def withdraw
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
    flash[:notice] = "ご利用いただき、ありがとうございました。"
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_image_id, :introduction, :is_deleted)
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
