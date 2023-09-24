class Admin::GrantsController < ApplicationController
before_action :authenticate_admin!

  def index
   @tags = Tag.all
   @grants = Grant.page(params[:page])
   @grant_comment = GrantComment.page(params[:page])
   @today_grant = @grants.where("created_at >= ?", Date.today.beginning_of_day).count
   @yesterday_grant = @grants.where("created_at >= ? AND created_at < ?", Date.yesterday.beginning_of_day, Date.today.beginning_of_day).count
   @this_week_grant = @grants.where("created_at >= ?", Date.today.beginning_of_week).count
   @last_week_grant = @grants.where("created_at >= ? AND created_at < ?", Date.today.beginning_of_week - 7.days, Date.today.beginning_of_week).count
   @two_weeks_ago_grant = @grants.where("created_at >= ? AND created_at < ?", Date.today.beginning_of_week - 14.days, Date.today.beginning_of_week - 7.days).count
  end

  def show
    @grant = Grant.find(params[:id])
    @grant_comment = GrantComment.all
    @tag = @grant.tag if @grant.tag.present?
  end

   def destroy
    @grant = Grant.find(params[:id])
    @grant.destroy
    redirect_to admin_grants_path, notice: "削除しました。"
   end
end
