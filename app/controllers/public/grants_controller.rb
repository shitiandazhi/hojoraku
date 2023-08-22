class Public::GrantsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @grants = Grant.all
    @grant_comments = GrantComment.all
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
    @grant.user = current_user # user_id を直接代入する代わりに関連をセットする
    if params[:post]
      if @grant.save(context: :publicize)
        redirect_to grant_path(@grant), notice: "投稿成功！"
      else
        flash.now[:alert] = "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
        render :new
      end
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
    @grant = Grant.find(params[:id]) # 変数名修正
    @grant.destroy
    redirect_to grants_path, notice: "削除しました。"
  end

  private

  def grant_params
    params.require(:grant).permit(:name, :background, :body, :application_status) # user_id を permit 対象から削除
  end
end