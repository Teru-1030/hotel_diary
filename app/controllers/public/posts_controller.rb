class Public::PostsController < ApplicationController
  before_action :post_params, only: [:create, :update]
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:new]
  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    puts params[:tag_name]
    puts params.inspect
    tag_names = params["@tag_name"].split(",")
    tags = tag_names.map{ |tag_name| Tag.find_or_initialize_by(name: tag_name) }
    tags.each do |tag|
      if tag.invalid?
        @tag_name = params[:tag_name]
        @post.errors.add(:tags, tag.errors.full_messages.join("\n"))
        return render :edit, status: :unprocessable_entity
      end
    end
    
      @post.tags = tags
      if@post.save
        flash[:notice] = "投稿に成功しました"
        redirect_to posts_path
      else
        @tag_name = params[:tag_name]
        render :new, status: unprocessable_entity
      end
  end
  
  

  def index
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
  end
 
  def tags
    @tags = Tag.all
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
    
  private
  
  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
  
  def is_matching_login_user
    post = Post.find(params[:id])
    unless post.user.id == current_user.id
      redirect_to posts_path
    end
  end
 
  def ensure_guest_user
    if current_user.guest_user?
      redirect_to posts_path , notice: "ゲストユーザーは遷移できません。"
    end
  end  
 
end
