class Admin::GrantsController < ApplicationController

   def index
    @grant_comment = GrantComment.all
    @Tags = Tag.all
     if
      params[:tag_id].present?
      @grants = Grant.where("tag_id LIKE?","%#{params[:tag_id]}%")
     elsif
      params[:word].present?
      @grants = Grant.where('name LIKE ?', "%#{params[:word]}%")
     else
      @grants = Grant.all
    end
   end

   def show
    @grant = Grant.find(params[:id])
    @grant_comment = GrantComment.all
   end
end
