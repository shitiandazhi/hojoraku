class Admin::UsersController < ApplicationController
  def show
     @user = User.find(params[:id])
  end

  def edit

  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path
  end

  private

   def user_params
    params.require(:user).permit(:profile_image, :email, :name, :company_from, :name_kana, :company_number, :post_code, :address, :phonenumber, :is_deleted )
   end

end
