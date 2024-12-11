class ApplicationController < ActionController::Base
  # ストロングパラメータの設定
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_up_path_for(resource)
    user_path(current_user)
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:handle_name, :profile_image, :profile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:handle_name, :profile_image, :profile])
  end
end
