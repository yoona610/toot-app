# frozen_string_literal: true

class Admin::Devise::SessionsController < Devise::SessionsController
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
  before_action :reset_status, only: [:create]

  def after_sign_in_path_for(_resourse)
    admin_users_path
  end

  def guest_sign_in
    reset_session
    admin = Admin.guest
    sign_in admin
    redirect_to admin_users_path, notice: 'ゲスト管理者としてログインしました。'
  end

  # 同一ユーザーによる重複ログインを制限
  def reset_status
    return unless user_signed_in?

    sign_out current_user
    sign_out current_admin
  end
end
