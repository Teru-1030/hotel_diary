# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
    before_action :reject_user, only: [:create]
    
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
end
