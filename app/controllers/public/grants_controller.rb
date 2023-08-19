class Public::GrantsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @grant_comment = GrantComment.all
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
    @grant.user_id = current_user.id
    # 投稿ボタンを押下した場合
    if params[:post]
      if @grant.save(context: :publicize)
        redirect_to grant_path(@grant), notice: "投稿成功！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def edit
    @grant = Grant.find(params[:id])
  end

  def update
    @grant= Grant.find(params[:id])
    if @grant.update(grant_params)
      redirect_to grant_path(@grant), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    post_recipe = PostRecipe.find(params[:id])
    post_recipe.destroy
    redirect_to post_recipes_path
  end

private

  def grant_params
    params.require(:grant).permit(:user_id, :name, :background, :body,:application_status)
  end

end
