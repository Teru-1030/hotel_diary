class SessionsController < ApplicationController
    before_action :reject_user, only: [:create]

  protected

  def reject_user
    byebug
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == true))
        flash[:notice] = "退会済みです"
        redirect_to root_path
      else
      flash[:notice] = "項目を入力してください"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end
end
