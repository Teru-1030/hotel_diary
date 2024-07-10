class UsersController < ApplicationController
  before_action :user_state, only: [:create]
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
     is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "ユーザーの更新が完了しました"
     redirect_to @user
    else
     render :edit
    end
  end
  
  def withdraw
    is_matching_login_user
    @user = User.find(params[:id])
    @user.update(is_deleted: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
    
  
  private

  def user_parmas
    params.require(:user).permit(:name, :profile_image, :self_introduction)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to users_path
    end
  end
  
  
  
  def user_state
    user = User.find_by(email: params[:user][:email])
  return if user.nil?
  return unless user.valid_password?(params[:user][:password])
  if is_active
    userr_state() 
  else
    redirect_to signup_path 
  end

  end
  
end
