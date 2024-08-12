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
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_parmas)
      flash[:notice] = "理由を保存しました"
     redirect_to admin_memory_path(@user)
    else
     render adomin_dashboards_path
    end
  end
  
  def withdraw
    @user = User.find(params[:id])
    if @user.update(is_deleted: false)
      redirect_to admin_dashboards_path, notice: 'ユーザーを削除しました。'
    else
      render admin_memory_path(@user)
    end
  end
  
  private
  
  def user_parmas
    params.require(:user).permit(:delete_reason)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to admin_dashboards_path , notice: "ゲストユーザーです。"
    end
  end  
  
end

