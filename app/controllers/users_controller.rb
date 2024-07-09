class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_parmas)
    redirect_to @user
  end
  
  private

  def user_parmas
    params.require(:user).permit(:name, :profile_image)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
  
  private
  
  def user_state
    user = Customer.find_by(email: params[:customer][:email])
  return if user.nil?
  return unless user.valid_password?(params[:customer][:password])
  if is_active
    userr_state() 
  else
    redirect_to signup_path 
  end

  end
  
end
