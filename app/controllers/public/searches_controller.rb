class Public::SearchesController < ApplicationController
  # before_action :authenticate_user!
    
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model  == "user"
      @records = User.search_for(@content, @method)
      @records = @records.reject {|user| user.is_active == false || user.is_deleted == false}
    else
      @records = Post.search_for(@content, @method)
    end
  end
  
   
  
end

