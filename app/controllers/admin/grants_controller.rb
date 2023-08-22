class Admin::GrantsController < ApplicationController
  def index
    @grant_comment = GrantComment.all
    @tags = Tag.all
    if params[:tag_id].present?
      # Tagモデルのidを使用するのが適切です。また、LIKE演算子のパターンが間違っていましたので修正しました。
      @grants = Grant.joins(:tags).where(tags: { id: params[:tag_id] })
    elsif params[:word].present?
      @grants = Grant.where('name LIKE ?', "%#{params[:word]}%")
    else
      @grants = Grant.all
    end
  end

  def show
    @grant = Grant.find(params[:id])
    @grant_comment = GrantComment.all
    @tag = @grant.tag if @grant.tag.present?
  end
end