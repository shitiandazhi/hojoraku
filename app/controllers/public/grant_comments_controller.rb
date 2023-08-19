class Public::GrantCommentsController < ApplicationController
before_action :authenticate_user!

  def create
    grant = Grant.find(params[:grant_id])
    comment = current_user.grant_comments.new(grant_comment_params)
    comment.grant_id = grant.id
    comment.save
    redirect_to grant_path(grant)
  end

  def destroy
    Grant.find(params[:id]).destroy
    redirect_to grant_path(params[:grant_id])
  end

  private

  def grant_comment_params
    params.require(:grant_comment).permit(:comment)
  end

end
