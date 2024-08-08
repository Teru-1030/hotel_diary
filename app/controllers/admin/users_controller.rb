class Admin::UsersController < ApplicationController
   layout 'admin'
   before_action :authenticate_admin!
   before_action :ensure_guest_user, only: [:show]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
  
  def memory
    @user = User.find(params[:id])
  end  
    
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: false)
    reset_session
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

