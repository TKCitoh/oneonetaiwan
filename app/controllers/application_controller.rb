class ApplicationController < ActionController::Base
  #ログイン前のアクセス制限
  before_action :authenticate_end_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
