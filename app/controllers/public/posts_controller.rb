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
        redirect_to choice_path(@post)
      else
        @tag_name = params[:tag_name]
        render :new
      end
  end
  
  

  def index
    if params[:tag_id].present?
      @posts = Tag.find(params[:tag_id]).posts.where("status = 0 OR (status = 1 AND user_id = ?)", current_user.id)
    else
      @posts = Post.where("status = 0 OR (status = 1 AND user_id = ?)", current_user.id)
    end
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
     @tag_name = @post.tags.pluck(:name).join(",")
  end
  
  def update
    @post = Post.find(params[:id])
    tag_names = params[:@tag_name].split(",")
    tags = tag_names.map{ |tag_name| Tag.find_or_create_by(name: tag_name) }
    tags.each do |tag|
      if tag.invalid?
        @tag_name = params[:tag_name]
        @post.errors.add(tags, tag.errors.full_messages.joim("\n") )
        return render :edit, status: :unprocessable_entity
      end
    end
    
    if @post.update(post_params) && @post.update!(tags: tags)
      flash[:notice] = "編集に成功しました"
      redirect_to post_path(@post.id)  
    else
      @tag_name = params[:tag_name]
      render :edit,status: :unprocessable_entity
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
  
  def release
    post = Post.find(params[:id])
    post.released! unless post.released?
    flash[:notice] = "投稿を公開しました"
    redirect_to request.referer
  end

  def nonrelease
    post = Post.find(params[:id])
    post.nonreleased! unless post.nonreleased?
    flash[:notice] = "投稿を非公開にしました"
    redirect_to request.referer
  end  
  
  def choice
    @post = Post.find(params[:id])
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
