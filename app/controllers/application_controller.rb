class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :sign_out_user, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

# 管理者がユーザーを退会させた際に、サインアウトする
  def sign_out_user
    sign_out_and_redirect(current_user) if current_user.is_deleted == true
  end
end
