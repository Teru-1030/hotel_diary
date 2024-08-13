class Public::CommentsController < ApplicationController
  
  before_action :ensure_guest_user, only: [:create]
  
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to post_path(post)
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメント削除しました"
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
  def ensure_guest_user
     post = Post.find(params[:post_id])
    if current_user.guest_user?
      redirect_to post_path(post) , notice: "ゲストユーザーはコメント投稿できません。"
    end
  end  

end
