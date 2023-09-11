class Public::GrantCommentsController < ApplicationController
before_action :authenticate_user!

  def create
    grant = Grant.find(params[:grant_id])
    comment = current_user.grant_comments.new(grant_comment_params)
    comment.grant_id = grant.id
    comment.score = Language.get_data(grant_comment_params[:comment])
    comment.save
    redirect_to grant_path(grant)
  end

  def destroy
    grant_comment = GrantComment.find(params[:id])
    grant = grant_comment.grant # GrantComment に紐づく Grant を取得
    grant_comment.destroy
     redirect_to grant_path(grant) #Grant のパスへリダイレクト
  end

  private

  def grant_comment_params
    params.require(:grant_comment).permit(:comment)
  end

end
