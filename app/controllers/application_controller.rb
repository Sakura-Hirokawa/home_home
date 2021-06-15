class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    if resource.class.name == "Admin"
      flash[:success] = "おつかれさまです！ログインしました"
      admin_root_path
    else
      flash[:success] = "おつかれさまです！ログインしました"
      mypage_path(current_user)
    end
  end
  
  def after_sign_out_path_for(resource)
    if resource == :admin
      flash[:danger] = "ログアウトしました"
      new_admin_session_path
    else
      flash[:danger] = "ログアウトしました"
      root_path
    end
  end
  
  # 管理者へのアクセス制限 
  before_action :authenticate_admin!, if: :admin_url
  
  def admin_url
    request.fullpath.include?("/admin")
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :is_deleted])
  end
end
