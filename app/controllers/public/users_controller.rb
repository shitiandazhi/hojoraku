class Public::UsersController < ApplicationController
 before_action :is_matching_login_user, only: [:show, :edit, :update, :withdraw]
  def show
    is_matching_login_user
    @user = User.find(params[:id])

  end

  def edit
    is_matching_login_user
    @user = current_user
  end

  def update
    is_matching_login_user
    user = current_user
    user.update(user_params)
    redirect_to user_path
  end

  def withdraw
    is_matching_login_user
    @user = User.find(current_user.id)
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:email, :name, :company_from, :name_kana, :company_number, :post_code, :address, :phonenumber, :is_deleted )
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end

