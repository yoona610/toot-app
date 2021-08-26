class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: [:show, :edit, :update]
  before_action :prohibit_guest_withdraw, only: [:update]

  def index
    @users = User.page(params[:page]).per(12)
    @user_count = User.count
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "会員ステータスを更新しました"
    else
      render :edit, alert: "会員ステータスを更新できませんでした"
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def prohibit_guest_withdraw
    if @user.id == 1
      redirect_to admin_users_path, alert: "ゲスト会員は退会できません。"
    end
  end
end
