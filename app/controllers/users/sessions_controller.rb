class Users::SessionsController < Devise::SessionsController
    

 def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
 end
  
  protected

  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == true))
        flash[:notice] = "退会済みです"
        redirect_to new_user_registration
      else
      flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
end
