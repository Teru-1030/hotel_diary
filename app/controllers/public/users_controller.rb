class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit,:update, :show, :likes]
  before_action :ensure_active_user, only: [:show]
  before_action :set_user, only: [:likes]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_parmas)
     flash[:notice] = "ユーザーの更新が完了しました"
     redirect_to @user
    else
     render :edit
    end
  end
  
  def withdraw
    @user = User.find(params[:id])
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end
  
  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end
  
  
  private

  def user_parmas
    params.require(:user).permit(:name, :profile_image, :self_introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end 
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to request.referer , notice: "ゲストユーザーのため遷移できません。"
    end
  end  
  
  def ensure_active_user
    @user = User.find(params[:id])
    unless @user.active_for_authentication?
      redirect_to request.referer , notice: "退会済みユーザーのため遷移できません。"
    end
  end  
  
  def set_user
    @user = User.find(params[:id])
  end  
  
end
