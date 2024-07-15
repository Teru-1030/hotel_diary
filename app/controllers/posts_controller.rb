class PostsController < ApplicationController
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
    post.destroy
    redirect_to posts_path
  end
    
  
 def post_params
    params.require(:post).permit(:title, :image, :body)
 end
  
end
