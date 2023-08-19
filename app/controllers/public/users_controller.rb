class Public::UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])

  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    user.update(user_params)
    redirect_to user_path
  end

  def withdraw

  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :email, :name, :company_from, :name_kana, :company_number, :post_code, :address, :phonenumber, :is_deleted )
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end

