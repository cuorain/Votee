class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?





  #   #アカウント登録後のリダイレクト先
  # def after_sign_up_path_for(resource)
  #   user_path(current_user)
  # end

  #アカウント編集後のリダイレクト先
  def after_update_path_for(resource)
    #リダイレクト先のパス
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(scope)
    root_path
  end

  protected

  def configure_permitted_parameters
      added_attrs = [:name, :email, :password, :password_confirmation,
        :sex, :birtyday, :prefecture_code, :image]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

end
