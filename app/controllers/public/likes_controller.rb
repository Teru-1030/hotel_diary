class Public::LikesController < ApplicationController
  before_action :ensure_guest_user, only: [:create, :destroy]
  
  def create
    post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: post.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post_id: post.id)
    like.destroy
    redirect_to request.referer
  end
  
  private
  
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to request.referer, notice: "ゲストユーザーはいいねできません。"
    end
  end    

end
