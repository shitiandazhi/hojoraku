class Public::GrantsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :correct_grant, only: [:edit, :update]

  def index
    @grants = Grant.page(params[:page])
    @grant_comments = GrantComment.page(params[:page])
  end

  def show
    @grant = Grant.find(params[:id])
    @grant_comment = GrantComment.new
    @user = @grant.user
  end

  def new
    @grant = Grant.new
  end

 def create
  @grant = Grant.new(grant_params)
  @grant.user = current_user

  if params[:post]
    if @grant.save(context: :publicize)
      redirect_to grant_path(@grant), notice: "投稿成功！"
    else
      flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      puts @grant.errors.full_messages
      render :new
    end
  else
    render :new
  end
 end


  def edit
    @grant = Grant.find(params[:id])
  end

  def update
    @grant = Grant.find(params[:id])
    if @grant.update(grant_params)
      redirect_to grant_path(@grant), notice: "更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @grant = Grant.find(params[:id])
    @grant.destroy
    redirect_to grants_path, notice: "削除しました。"
  end


private

def correct_grant
    @grant = Grant.find(params[:id])
    unless @grant.user.id == current_user.id
        redirect_to grants_path, alert: 'このページへは遷移できません。'
    end
end

def grant_params
  params.require(:grant).permit(:name, :background, :body, :tag_id, :application_status)
end

end