class Admin::GrantsController < ApplicationController

   def index
    @grant_comment = GrantComment.all
    @tags = Tag.all
    if params[:tag_id].present?
      @grants = Grant.where("grant_id LIKE ?", "%#{params[:grant_id]}%")
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