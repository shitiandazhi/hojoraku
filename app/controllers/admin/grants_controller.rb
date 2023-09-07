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

    @today_grant = @grants.created_today
    @yesterday_grant = @grants.created_yesterday
    @this_week_grant = @grants.created_this_week
    @last_week_grant = @grants.created_last_week

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
