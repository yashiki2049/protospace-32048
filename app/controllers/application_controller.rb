class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #  deviseのコントローラーには書き込めないのでアドレスとパスワード以外はここで記載
  #  configure_permitted_parametersという名前は慣性

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ,:profile, :occupation, :position])
  end
end
