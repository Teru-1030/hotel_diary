# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reject_user, only: [:create]
  
  def after_sign_in_path_for(resource)
    about_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
    
def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to about_path, notice: "guestuserでログインしました。"
end
  
  protected

  def reject_user
    #byebug
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        flash[:notice] = "退会済みです"
        redirect_to new_user_session_path
      else
      flash[:notice] = "パスワードが違います"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
  
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
end
