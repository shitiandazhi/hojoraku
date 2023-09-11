class Admin::GrantsController < ApplicationController

  def index
    @tags = Tag.all
    @grants = if params[:tag_id].present?
                Grant.joins(:tags).where(tags: { id: params[:tag_id] })
              elsif params[:word].present?
                Grant.where('name LIKE ?', "%#{params[:word]}%")
              else
                Grant.all
              end

   @today_grant = @grants.where("created_at >= ?", Date.today.beginning_of_day).count
   @yesterday_grant = @grants.where("created_at >= ? AND created_at < ?", Date.yesterday.beginning_of_day, Date.today.beginning_of_day).count
   @this_week_grant = @grants.where("created_at >= ?", Date.today.beginning_of_week).count
   @last_week_grant = @grants.where("created_at >= ? AND created_at < ?", Date.today.beginning_of_week - 7.days, Date.today.beginning_of_week).count
   @two_weeks_ago_grant = @grants.where("created_at >= ? AND created_at < ?", Date.today.beginning_of_week - 14.days, Date.today.beginning_of_week - 7.days).count

    @grant_comment = GrantComment.page(params[:page])
    @paginated_grants = @grants.page(params[:page])
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
