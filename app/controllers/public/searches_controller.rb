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
      @records = Post.search_for(@content, @method).where("status = 0 OR (status = 1 AND user_id = ?)", current_user.id).page(params[:page])
    end
  end
  
   
  
end

