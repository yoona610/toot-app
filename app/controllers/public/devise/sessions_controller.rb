# frozen_string_literal: true

class Public::Devise::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  before_action :reject_deleted_user, only: [:create]
  before_action :reject_login_user, only: [:create]

  def after_sign_in_path_for(_resourse)
    user_path(current_user)
  end

  def guest_sign_in
    reset_session
    user = User.guest
    sign_in user
    redirect_to user_path(current_user), notice: 'ゲストユーザーとしてログインしました。'
  end

  def reject_deleted_user
    user = User.find_by(email: params[:user][:email])
    return unless user && (user.valid_password?(params[:user][:password]) && user.is_deleted)

    redirect_to new_user_session_path
    flash[:alert] = 'お客様は退会済みです。申し訳ございませんが、あらためて会員登録をお願いいたします。'
  end

  # 同一ユーザーによる重複ログインを制限
  def reject_login_user
    return unless admin_signed_in?

    sign_out current_user
    sign_out current_admin
  end
end
