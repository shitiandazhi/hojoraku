class Admin::GrantCommentsController < ApplicationController
before_action :authenticate_admin!

   def destroy
    GrantComment.find(params[:id]).destroy
    redirect_to admin_grant_path(params[:grant_id])
   end

  private

  def grant_comment_params
    params.require(:grant_comment).permit(:comment)
  end
end
