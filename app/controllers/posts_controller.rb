class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params)
    post.save
    redirect_to post_pash(post.id)
  end

  def index
  end

  def show
  end

  def edit
  end
end
