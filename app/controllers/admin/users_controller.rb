class Admin::UsersController < ApplicationController
   before_action :authenticate_admin!
   before_action :ensure_guest_user, only: [:show]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
  end
  
  private
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to admin_dashboards_path , notice: "ゲストユーザーです。"
    end
  end  
  
end

