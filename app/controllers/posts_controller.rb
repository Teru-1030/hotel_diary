class PostsController < ApplicationController
  before_action :post_params, only: [:create, :update]
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
   if@post.save
     flash[:notice] = "投稿に成功しました"
    redirect_to posts_path
   else
     render :new
   end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
     @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
   if @post.update(post_params)
     flash[:notice] = "編集に成功しました"
    redirect_to post_path(@post.id)  
   else
     render :edit
   end
  end
  
  def destroy
    post = Post.find(params[:id])
   if post.destroy
     flash[:notice] = "投稿を削除しました"
    redirect_to posts_path
   else
     render :edit
   end
  end
    
  
 def post_params
    params.require(:post).permit(:title, :image, :body)
 end
  
 def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
 end
 
end
