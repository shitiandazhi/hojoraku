class Public::UsersController < ApplicationController
 before_action :authenticate_user!, except: [:index]
 before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
     @grants = Grant.where(user_id: @user).order(created_at: :desc).page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user
    if user.update(user_params)
        redirect_to user_path(user)
    else
      flash[:alert] = "プロフィールの更新ができませんでした。入力内容をご確認のうえ再度お試しください"
        redirect_to request.referer
    end
  end

  def withdraw
    @user = User.find(current_user.id)
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
      redirect_to user_path(current_user) , alert: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end

